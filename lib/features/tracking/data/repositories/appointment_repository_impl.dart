import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart' as d;
import '../../../../core/error/app_exception.dart';
import '../../../../core/error/exception_mapper.dart';
import '../../../../core/local/app_database.dart';
import '../../../doctor/domain/repositories/doctor_repository.dart';
import '../../domain/entities/token.dart';
import '../../domain/entities/queue_preview.dart';
import '../../domain/repositories/appointment_repository.dart';
import '../local/tokens_local_data_source.dart';
import '../services/appointment_api_service.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentApiService _apiService;
  final TokensLocalDataSource _localDataSource;
  final DoctorRepository _doctorRepository;

  AppointmentRepositoryImpl(
    this._apiService,
    this._localDataSource,
    this._doctorRepository,
  );

  @override
  Future<Token> createToken({
    required String doctorId,
    required String clinicId,
    required String userId,
    String? notes,
  }) async {
    debugPrint(
      '[Appointment] Booking token — doctorId=$doctorId, clinicId=$clinicId',
    );
    try {
      final networkToken = await _apiService.createToken(
        doctorId: doctorId,
        clinicId: clinicId,
        userId: userId,
        notes: notes,
      );
      debugPrint(
        '[Appointment] Token booked successfully — id=${networkToken.id}',
      );

      // Upsert newly booked token to cache
      await _localDataSource.upsertTokens([_toDriftCompanion(networkToken)]);

      return networkToken;
    } catch (e) {
      final appEx = mapErrorToException(e);
      debugPrint('[Appointment] Booking failed — ${appEx.message}');
      throw appEx;
    }
  }

  @override
  Future<List<Token>> getTokens({
    String? doctorId,
    String? clinicId,
    String? userId,
  }) async {
    final cachedRows = await _localDataSource.getCachedTokens();

    try {
      final networkTokens = await _apiService.getTokens(
        doctorId: doctorId,
        clinicId: clinicId,
        userId: userId,
      );

      final companions = networkTokens
          .map((t) => _toDriftCompanion(t))
          .toList();
      await _localDataSource.upsertTokens(companions);

      debugPrint(
        '[Appointment] Fetched ${networkTokens.length} tokens from NETWORK',
      );
      return networkTokens;
    } catch (error) {
      final appEx = mapErrorToException(error);
      debugPrint(
        '[Appointment] NETWORK failed — falling back to CACHE: ${appEx.message}',
      );

      if (cachedRows.isNotEmpty) {
        var cachedEntities = cachedRows.map((r) => _fromDriftData(r)).toList();

        // Apply client-side filters if passed
        if (doctorId != null) {
          cachedEntities = cachedEntities
              .where((t) => t.doctorId == doctorId)
              .toList();
        }
        if (clinicId != null) {
          cachedEntities = cachedEntities
              .where((t) => t.clinicId == clinicId)
              .toList();
        }
        if (userId != null) {
          cachedEntities = cachedEntities
              .where((t) => t.userId == userId)
              .toList();
        }

        final flagged = cachedEntities
            .map(
              (t) => t.copyWith(isFromCache: true, cacheError: appEx.message),
            )
            .toList();
        final cachedAtTime = cachedRows.first.cachedAt.toIso8601String();
        debugPrint(
          '[Appointment] Returned ${flagged.length} tokens from CACHE (cachedAt: $cachedAtTime)',
        );
        return flagged;
      }
      throw appEx;
    }
  }

  @override
  Future<void> cancelToken(String id) async {
    debugPrint('[Appointment] Cancel requested — tokenId=$id');
    try {
      await _apiService.cancelToken(id);
      debugPrint('[Appointment] Token cancelled successfully');

      // Update local cache status
      final cachedRows = await _localDataSource.getCachedTokens();
      final target = cachedRows.firstWhere((r) => r.id == id);
      await _localDataSource.upsertTokens([
        _toDriftCompanion(_fromDriftData(target).copyWith(status: 'cancelled')),
      ]);
    } catch (e) {
      final appEx = mapErrorToException(e);
      debugPrint('[Appointment] Cancel failed — ${appEx.message}');
      throw appEx;
    }
  }

  @override
  Future<QueuePreview> getQueuePreview({
    required String doctorId,
    required String clinicId,
  }) async {
    final tokens = await getTokens(doctorId: doctorId, clinicId: clinicId);
    final todayStr = DateTime.now().toIso8601String().substring(0, 10);

    final todayTokens = tokens.where((t) {
      if (t.createdAt == null) return false;
      return t.createdAt!.startsWith(todayStr);
    }).toList();

    final patientsAheadCount = todayTokens.where((t) {
      return t.status != 'completed' && t.status != 'cancelled';
    }).length;

    int nowServingNumber = 1;
    final activeTokens = todayTokens
        .where(
          (t) =>
              t.status == 'active' ||
              t.status == 'in-progress' ||
              t.status == 'serving',
        )
        .toList();
    if (activeTokens.isNotEmpty) {
      activeTokens.sort(
        (a, b) => (a.tokenNumber ?? 0).compareTo(b.tokenNumber ?? 0),
      );
      nowServingNumber = activeTokens.first.tokenNumber ?? 1;
    } else {
      final completedTokens = todayTokens
          .where((t) => t.status == 'completed')
          .toList();
      if (completedTokens.isNotEmpty) {
        completedTokens.sort(
          (a, b) => (a.tokenNumber ?? 0).compareTo(b.tokenNumber ?? 0),
        );
        nowServingNumber = completedTokens.last.tokenNumber ?? 1;
      } else {
        final waitingTokens = todayTokens
            .where((t) => t.status == 'waiting' || t.status == 'upcoming')
            .toList();
        if (waitingTokens.isNotEmpty) {
          waitingTokens.sort(
            (a, b) => (a.tokenNumber ?? 0).compareTo(b.tokenNumber ?? 0),
          );
          nowServingNumber = (waitingTokens.first.tokenNumber ?? 2) - 1;
          if (nowServingNumber < 1) nowServingNumber = 1;
        }
      }
    }

    int nextTokenNumber = 1;
    if (todayTokens.isNotEmpty) {
      final maxToken = todayTokens
          .map((t) => t.tokenNumber ?? 0)
          .fold<int>(0, (max, val) => val > max ? val : max);
      nextTokenNumber = maxToken + 1;
    }

    final doctor = await _doctorRepository.getDoctorById(doctorId);
    final avgDuration = doctor?.durationMinutes ?? 10;
    final estimatedWaitMinutes = patientsAheadCount * avgDuration;

    debugPrint(
      '[Appointment] Queue preview — ahead=$patientsAheadCount, nowServing=#$nowServingNumber, next=#$nextTokenNumber, estWait=${estimatedWaitMinutes}min',
    );

    return QueuePreview(
      nextTokenNumber: nextTokenNumber,
      nowServingNumber: nowServingNumber,
      patientsAheadCount: patientsAheadCount,
      estimatedWaitMinutes: estimatedWaitMinutes,
    );
  }

  TokensTableCompanion _toDriftCompanion(Token entity) {
    return TokensTableCompanion(
      id: d.Value(entity.id),
      doctorId: d.Value(entity.doctorId),
      clinicId: d.Value(entity.clinicId),
      userId: d.Value(entity.userId),
      notes: d.Value(entity.notes),
      status: d.Value(entity.status),
      tokenNumber: d.Value(entity.tokenNumber),
      createdAt: d.Value(entity.createdAt),
      cachedAt: d.Value(DateTime.now()),
    );
  }

  Token _fromDriftData(TokensTableData r) {
    return Token(
      id: r.id,
      doctorId: r.doctorId,
      clinicId: r.clinicId,
      userId: r.userId,
      notes: r.notes,
      status: r.status,
      tokenNumber: r.tokenNumber,
      createdAt: r.createdAt,
    );
  }
}
