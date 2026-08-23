import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart' as d;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/app_exception.dart';
import '../../../../core/error/exception_mapper.dart';
import '../../../../core/local/app_database.dart';
import '../../domain/entities/tracking_snapshot.dart';
import '../../domain/repositories/tracking_repository.dart';
import '../local/tracking_local_data_source.dart';
import '../services/tracking_api_service.dart';
import '../models/tracking_snapshot_model.dart';

class TrackingRepositoryImpl implements TrackingRepository {
  final TrackingApiService _apiService;
  final TrackingLocalDataSource _localDataSource;

  TrackingRepositoryImpl(this._apiService, this._localDataSource);

  @override
  Stream<TrackingSnapshot> getLiveTrackingStream(String tokenId) {
    final controller = StreamController<TrackingSnapshot>();
    IO.Socket? socket;

    Future<void> connect() async {
      try {
        final session = Supabase.instance.client.auth.currentSession;
        final token = session?.accessToken;

        // Fetch doctor ID from cache or API fallback
        String? doctorId = await _localDataSource.getDoctorIdByTokenId(tokenId);
        if (doctorId == null) {
          debugPrint('[TrackingWS] doctorId not in database cache, fetching from API fallback');
          doctorId = await _apiService.getDoctorIdForToken(tokenId);
        }

        socket = IO.io(
          'https://smart-q-dun.vercel.app',
          IO.OptionBuilder()
              .setTransports(['websocket'])
              .setAuth({'token': token})
              .setExtraHeaders({'Authorization': 'Bearer $token'})
              .enableAutoConnect()
              .build(),
        );

        socket!.onConnect((_) {
          debugPrint('[TrackingWS] Connected to WebSocket server');
          socket!.emit('join', tokenId);
          socket!.emit('subscribe', tokenId);
          if (doctorId != null && doctorId.isNotEmpty) {
            debugPrint('[TrackingWS] Joining doctor room: $doctorId');
            socket!.emit('join:doctor', doctorId);
          } else {
            debugPrint('[TrackingWS] WARNING: Cannot join doctor room - doctorId is null/empty');
          }
        });

        final onDataReceived = (data) async {
          debugPrint('[TrackingWS] Received real-time update: $data');
          try {
            if (data is Map<String, dynamic>) {
              final cached = await _localDataSource.getCachedSnapshot(tokenId);
              
              final id = data['tokenId'] as String? ?? 
                         data['id'] as String? ?? 
                         data['token_id'] as String? ?? 
                         tokenId;
              final currentToken = data['currentTokenNumber'] as int? ?? 
                                   data['currentToken'] as int? ?? 
                                   data['current_token'] as int? ?? 
                                   cached?.currentTokenNumber ?? 
                                   0;
              final yourToken = data['yourTokenNumber'] as int? ?? 
                               data['yourToken'] as int? ?? 
                               data['tokenNumber'] as int? ?? 
                               data['token_number'] as int? ?? 
                               cached?.yourTokenNumber ?? 
                               0;
              final patientsAhead = data['patientsAheadCount'] as int? ?? 
                                    data['patientsAhead'] as int? ?? 
                                    data['patients_ahead'] as int? ?? 
                                    cached?.patientsAheadCount ?? 
                                    0;
              final estWait = data['estimatedWaitMinutes'] as int? ?? 
                              data['estimatedWaitTime'] as int? ?? 
                              data['estimated_wait'] as int? ?? 
                              data['estimatedWait'] as int? ?? 
                              cached?.estimatedWaitMinutes ?? 
                              0;
              final statusVal = data['status'] as String? ?? 
                                cached?.status ?? 
                                'waiting';

              final parsed = TrackingSnapshotModel(
                tokenId: id,
                currentTokenNumber: currentToken,
                yourTokenNumber: yourToken,
                patientsAheadCount: patientsAhead,
                estimatedWaitMinutes: estWait,
                status: statusVal,
                lastSyncedAt: DateTime.now(),
              );

              await _localDataSource.upsertSnapshot(_toDriftCompanion(parsed));
              if (!controller.isClosed) {
                controller.add(parsed);
              }
            }
          } catch (e) {
            debugPrint('[TrackingWS] Error parsing message: $e');
          }
        };

        // Listen to tracking, queue, and token events
        socket!.on('tracking', onDataReceived);
        socket!.on('queue-update', onDataReceived);
        socket!.on('token-update', onDataReceived);

        // SRS Event Names:
        socket!.on('ETA_UPDATED', onDataReceived);
        socket!.on('TOKEN_CALLED', onDataReceived);
        
        socket!.on('TOKEN_COMPLETED', (data) async {
          debugPrint('[TrackingWS] Received TOKEN_COMPLETED event: $data');
          try {
            final cached = await _localDataSource.getCachedSnapshot(tokenId);
            final parsed = TrackingSnapshotModel(
              tokenId: tokenId,
              currentTokenNumber: cached?.currentTokenNumber ?? 0,
              yourTokenNumber: cached?.yourTokenNumber ?? 0,
              patientsAheadCount: 0,
              estimatedWaitMinutes: 0,
              status: 'completed',
              lastSyncedAt: DateTime.now(),
            );
            await _localDataSource.upsertSnapshot(_toDriftCompanion(parsed));
            if (!controller.isClosed) {
              controller.add(parsed);
            }
          } catch (e) {
            debugPrint('[TrackingWS] Error handling TOKEN_COMPLETED: $e');
          }
        });

        socket!.on('QUEUE_STARTED', (data) async {
          debugPrint('[TrackingWS] Received QUEUE_STARTED event: $data');
          try {
            final cached = await _localDataSource.getCachedSnapshot(tokenId);
            final parsed = TrackingSnapshotModel(
              tokenId: tokenId,
              currentTokenNumber: cached?.currentTokenNumber ?? 0,
              yourTokenNumber: cached?.yourTokenNumber ?? 0,
              patientsAheadCount: cached?.patientsAheadCount ?? 0,
              estimatedWaitMinutes: cached?.estimatedWaitMinutes ?? 0,
              status: 'active',
              lastSyncedAt: DateTime.now(),
            );
            await _localDataSource.upsertSnapshot(_toDriftCompanion(parsed));
            if (!controller.isClosed) {
              controller.add(parsed);
            }
          } catch (e) {
            debugPrint('[TrackingWS] Error handling QUEUE_STARTED: $e');
          }
        });

        socket!.on('QUEUE_PAUSED', (data) async {
          debugPrint('[TrackingWS] Received QUEUE_PAUSED event: $data');
          try {
            final cached = await _localDataSource.getCachedSnapshot(tokenId);
            final parsed = TrackingSnapshotModel(
              tokenId: tokenId,
              currentTokenNumber: cached?.currentTokenNumber ?? 0,
              yourTokenNumber: cached?.yourTokenNumber ?? 0,
              patientsAheadCount: cached?.patientsAheadCount ?? 0,
              estimatedWaitMinutes: cached?.estimatedWaitMinutes ?? 0,
              status: 'paused',
              lastSyncedAt: DateTime.now(),
            );
            await _localDataSource.upsertSnapshot(_toDriftCompanion(parsed));
            if (!controller.isClosed) {
              controller.add(parsed);
            }
          } catch (e) {
            debugPrint('[TrackingWS] Error handling QUEUE_PAUSED: $e');
          }
        });

        socket!.onDisconnect((_) async {
          debugPrint('[TrackingWS] Disconnected from server');
          final cached = await _localDataSource.getCachedSnapshot(tokenId);
          if (cached != null && !controller.isClosed) {
            controller.add(_fromDriftData(cached).copyWith(isFromCache: true, isStale: true));
          }
        });

        socket!.onError((err) {
          debugPrint('[TrackingWS] Error: $err');
        });
      } catch (e) {
        debugPrint('[TrackingWS] Connection setup failed: $e');
        controller.addError(e);
      }
    }

    connect();

    controller.onCancel = () {
      debugPrint('[TrackingWS] Subscription cancelled, closing socket');
      socket?.disconnect();
      socket?.dispose();
    };

    return controller.stream;
  }

  @override
  Future<TrackingSnapshot> getLiveTracking(String tokenId) async {
    final cached = await _localDataSource.getCachedSnapshot(tokenId);

    try {
      final networkSnapshot = await _apiService.getLiveTracking(tokenId);
      
      // Overwrite cache for this token
      await _localDataSource.upsertSnapshot(_toDriftCompanion(networkSnapshot));
      
      debugPrint('[Tracking] LIVE update — currentToken=${networkSnapshot.currentTokenNumber}, yourToken=${networkSnapshot.yourTokenNumber}, aheadOfYou=${networkSnapshot.patientsAheadCount}, eta=${networkSnapshot.estimatedWaitMinutes}min');
      return networkSnapshot;
    } catch (error) {
      final appEx = mapErrorToException(error);
      
      if (cached != null) {
        debugPrint('[Tracking] NETWORK failed — ${appEx.message} — showing CACHED snapshot from ${cached.lastSyncedAt}');
        return _fromDriftData(cached).copyWith(
          isFromCache: true,
          isStale: true,
        );
      }
      
      debugPrint('[Tracking] No cached snapshot available — showing error state');
      throw appEx;
    }
  }

  TrackingCacheTableCompanion _toDriftCompanion(TrackingSnapshot entity) {
    return TrackingCacheTableCompanion(
      tokenId: d.Value(entity.tokenId),
      currentTokenNumber: d.Value(entity.currentTokenNumber),
      yourTokenNumber: d.Value(entity.yourTokenNumber),
      patientsAheadCount: d.Value(entity.patientsAheadCount),
      estimatedWaitMinutes: d.Value(entity.estimatedWaitMinutes),
      status: d.Value(entity.status),
      lastSyncedAt: d.Value(entity.lastSyncedAt),
      isFromCache: d.Value(entity.isFromCache),
      isStale: d.Value(entity.isStale),
    );
  }

  TrackingSnapshot _fromDriftData(TrackingCacheTableData r) {
    return TrackingSnapshot(
      tokenId: r.tokenId,
      currentTokenNumber: r.currentTokenNumber ?? 0,
      yourTokenNumber: r.yourTokenNumber ?? 0,
      patientsAheadCount: r.patientsAheadCount ?? 0,
      estimatedWaitMinutes: r.estimatedWaitMinutes ?? 0,
      status: r.status ?? 'waiting',
      lastSyncedAt: r.lastSyncedAt,
      isFromCache: r.isFromCache,
      isStale: r.isStale,
    );
  }
}
