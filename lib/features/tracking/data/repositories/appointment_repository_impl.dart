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
    String? appointmentDate,
    bool? isFuture,
    String? notes,
  }) async {
    debugPrint(
      '[Appointment] Booking token — doctorId=$doctorId, clinicId=$clinicId, appointmentDate=$appointmentDate, isFuture=$isFuture',
    );
    try {
      final networkToken = await _apiService.createToken(
        doctorId: doctorId,
        clinicId: clinicId,
        userId: userId,
        appointmentDate: appointmentDate,
        isFuture: isFuture,
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

      List<Token> filteredTokens = (userId != null && userId.isNotEmpty)
          ? networkTokens
              .where((t) => t.userId == userId)
              .toList()
          : networkTokens;

      debugPrint(
        '[Appointment] Fetched ${filteredTokens.length} tokens from NETWORK',
      );
      return filteredTokens;
    } catch (error) {
      final appEx = mapErrorToException(error);
      debugPrint(
        '[Appointment] NETWORK failed — falling back to CACHE: ${appEx.message}',
      );

      if (cachedRows.isNotEmpty) {
        var cachedEntities = cachedRows.map((r) => _fromDriftData(r)).toList();

        // Apply client-side filters if passed
        if (doctorId != null && doctorId.isNotEmpty) {
          cachedEntities = cachedEntities
              .where((t) => t.doctorId == doctorId)
              .toList();
        }
        if (clinicId != null && clinicId.isNotEmpty) {
          cachedEntities = cachedEntities
              .where((t) => t.clinicId == clinicId)
              .toList();
        }
        if (userId != null && userId.isNotEmpty) {
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
      debugPrint('[Appointment] Token cancelled on server successfully');
    } catch (e) {
      debugPrint('[Appointment] API cancel failed — proceeding with local cache cancel: $e');
    } finally {
      try {
        final cachedRows = await _localDataSource.getCachedTokens();
        final targetIndex = cachedRows.indexWhere((r) => r.id == id);
        if (targetIndex != -1) {
          final target = cachedRows[targetIndex];
          await _localDataSource.upsertTokens([
            _toDriftCompanion(_fromDriftData(target).copyWith(status: 'cancelled')),
          ]);
        }
      } catch (cacheError) {
        debugPrint('[Appointment] Local cache cancel update failed: $cacheError');
      }
    }
  }

  @override
  Future<QueuePreview> getQueuePreview({
    required String doctorId,
    required String clinicId,
  }) async {
    final doctor = await _doctorRepository.getDoctorById(doctorId);
    final avgDuration = doctor?.durationMinutes ?? 10;

    // 1. First fetch real-time live queue snapshot from /api/patient/queue/live/{doctorId}
    try {
      final liveData = await _apiService.getLiveQueue(doctorId);
      if (liveData != null) {
        final currentTokenNumber = liveData['currentTokenNumber'] as int? ?? 0;
        final totalWaiting = liveData['totalWaiting'] as int? ?? 0;
        final totalTokensToday = liveData['totalTokensToday'] as int? ?? 0;
        final tokensRaw = liveData['tokens'];

        int nextTokenNumber = totalTokensToday + 1;
        if (tokensRaw is List && tokensRaw.isNotEmpty) {
          int maxNum = 0;
          for (final t in tokensRaw) {
            if (t is Map<String, dynamic>) {
              final num = t['tokenNumber'] as int? ?? 0;
              if (num > maxNum) maxNum = num;
            }
          }
          if (maxNum >= nextTokenNumber) {
            nextTokenNumber = maxNum + 1;
          }
        }

        final estimatedWaitMinutes = totalWaiting * avgDuration;

        debugPrint(
          '[Appointment] Real-time Live Queue preview — currentToken=#$currentTokenNumber, next=#$nextTokenNumber, waiting=$totalWaiting, estWait=${estimatedWaitMinutes}min',
        );

        return QueuePreview(
          nextTokenNumber: nextTokenNumber,
          nowServingNumber: currentTokenNumber,
          patientsAheadCount: totalWaiting,
          estimatedWaitMinutes: estimatedWaitMinutes,
        );
      }
    } catch (e) {
      debugPrint(
        '[Appointment] Live queue endpoint failed, falling back to tokens list calculation: $e',
      );
    }

    // 2. Fallback: Calculate from tokens list
    final tokens = await getTokens(doctorId: doctorId, clinicId: clinicId);
    final todayStr = DateTime.now().toIso8601String().substring(0, 10);

    final todayTokens = tokens.where((t) {
      if (t.createdAt == null) return false;
      return t.createdAt!.startsWith(todayStr);
    }).toList();

    final patientsAheadCount = todayTokens.where((t) {
      return t.status != 'completed' && t.status != 'cancelled';
    }).length;

    int nowServingNumber = 0;
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
      nowServingNumber = activeTokens.first.tokenNumber ?? 0;
    } else {
      final completedTokens = todayTokens
          .where((t) => t.status == 'completed')
          .toList();
      if (completedTokens.isNotEmpty) {
        completedTokens.sort(
          (a, b) => (a.tokenNumber ?? 0).compareTo(b.tokenNumber ?? 0),
        );
        nowServingNumber = completedTokens.last.tokenNumber ?? 0;
      }
    }

    int nextTokenNumber = 1;
    if (todayTokens.isNotEmpty) {
      final maxToken = todayTokens
          .map((t) => t.tokenNumber ?? 0)
          .fold<int>(0, (max, val) => val > max ? val : max);
      nextTokenNumber = maxToken + 1;
    }

    final estimatedWaitMinutes = patientsAheadCount * avgDuration;

    debugPrint(
      '[Appointment] Fallback Queue preview — ahead=$patientsAheadCount, nowServing=#$nowServingNumber, next=#$nextTokenNumber, estWait=${estimatedWaitMinutes}min',
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

  @override
  Future<void> deleteToken(String id) async {
    debugPrint('[Appointment] Deleting token locally from cache — id=$id');
    try {
      await _localDataSource.deleteToken(id);
    } catch (e) {
      debugPrint('[Appointment] Failed to delete token from local cache: $e');
      rethrow;
    }
  }
}
