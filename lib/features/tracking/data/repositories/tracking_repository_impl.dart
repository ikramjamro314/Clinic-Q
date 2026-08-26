import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart' as d;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
          debugPrint(
            '[TrackingWS] doctorId not in database cache, fetching from API fallback',
          );
          doctorId = await _apiService.getDoctorIdForToken(tokenId);
        }

        final rawSocketUrl =
            dotenv.env['SOCKET_URL'] ?? 'https://smart-q-drqx-seven.vercel.app';

        var socketUrl = rawSocketUrl.trim();
        if (socketUrl.endsWith('/')) {
          socketUrl = socketUrl.substring(0, socketUrl.length - 1);
        }

        final uri = Uri.parse(socketUrl);
        // Remove any accidental :0 from the URL
        if (socketUrl.contains(':0')) {
          socketUrl = socketUrl.replaceAll(':0', '');
        }

        // Explicitly append the default ports to bypass socket_io_client's :0 parser bug
        final host = uri.host;
        final scheme = uri.scheme;
        final port = uri.port;

        // If the URL has no explicit port, format it to include the default port
        if (!socketUrl.substring(scheme.length + 3).contains(':')) {
          if (scheme == 'https') {
            socketUrl = '$scheme://$host:443';
          } else if (scheme == 'http') {
            socketUrl = '$scheme://$host:80';
          }
        }

        debugPrint(
          '[TrackingWS] Connecting with rawSocketUrl: $rawSocketUrl, cleaned & formatted with port: $socketUrl',
        );

        socket = IO.io(
          socketUrl,
          IO.OptionBuilder()
              .setTransports(['websocket'])
              .setAuth({'token': token})
              .setExtraHeaders({'Authorization': 'Bearer $token'})
              .enableAutoConnect()
              .setReconnectionDelay(2000)
              .setReconnectionDelayMax(10000)
              .setReconnectionAttempts(10)
              .build(),
        );

        socket!.onConnect((_) {
          debugPrint('[TrackingWS] Connected to WebSocket server');
          socket!.emit('join:token', tokenId);
          if (doctorId != null && doctorId.isNotEmpty) {
            debugPrint('[TrackingWS] Joining doctor room: $doctorId');
            socket!.emit('join:doctor', doctorId);
          }
        });

        final onDataReceived = (data) async {
          debugPrint('[TrackingWS] Received real-time update event: $data');
          try {
            // Fetch the authoritative latest tracking state from the API
            final snapshot = await getLiveTracking(tokenId);
            if (!controller.isClosed) {
              controller.add(snapshot);
            }
          } catch (e) {
            debugPrint(
              '[TrackingWS] Error updating snapshot on real-time event: $e',
            );
          }
        };

        // Align backend event listeners
        socket!.on('token:created', onDataReceived);
        socket!.on('queue:updated', onDataReceived);
        socket!.on('ETA_UPDATED', onDataReceived);

        socket!.onDisconnect((_) async {
          debugPrint('[TrackingWS] Disconnected from server');
          final cached = await _localDataSource.getCachedSnapshot(tokenId);
          if (cached != null && !controller.isClosed) {
            controller.add(
              _fromDriftData(cached).copyWith(isFromCache: true, isStale: true),
            );
          }
        });

        socket!.onConnectError((err) async {
          debugPrint('[TrackingWS] Connect Error: $err');
          final cached = await _localDataSource.getCachedSnapshot(tokenId);
          if (!controller.isClosed) {
            if (cached != null) {
              controller.add(
                _fromDriftData(
                  cached,
                ).copyWith(isFromCache: true, isStale: true),
              );
            } else {
              controller.addError(
                NetworkException('WebSocket connection error: $err'),
              );
            }
          }
        });

        socket!.onError((err) async {
          debugPrint('[TrackingWS] Error: $err');
          final cached = await _localDataSource.getCachedSnapshot(tokenId);
          if (!controller.isClosed) {
            if (cached != null) {
              controller.add(
                _fromDriftData(
                  cached,
                ).copyWith(isFromCache: true, isStale: true),
              );
            } else {
              controller.addError(UnknownException('WebSocket error: $err'));
            }
          }
        });
      } catch (e) {
        debugPrint('[TrackingWS] Connection setup failed: $e');
        if (!controller.isClosed) {
          controller.addError(UnknownException(e.toString()));
        }
      }
    }

    connect();

    controller.onCancel = () {
      debugPrint(
        '[TrackingWS] Subscription cancelled, cleaning up listeners and closing socket',
      );
      socket?.clearListeners();
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

      debugPrint(
        '[Tracking] LIVE update — currentToken=${networkSnapshot.currentTokenNumber}, yourToken=${networkSnapshot.yourTokenNumber}, aheadOfYou=${networkSnapshot.patientsAheadCount}, eta=${networkSnapshot.estimatedWaitMinutes}min',
      );
      return networkSnapshot;
    } catch (error) {
      final appEx = mapErrorToException(error);

      if (cached != null) {
        debugPrint(
          '[Tracking] NETWORK failed — ${appEx.message} — showing CACHED snapshot from ${cached.lastSyncedAt}',
        );
        return _fromDriftData(
          cached,
        ).copyWith(isFromCache: true, isStale: true);
      }

      debugPrint(
        '[Tracking] No cached snapshot available — showing error state',
      );
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
