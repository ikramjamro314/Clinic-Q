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
import '../../domain/entities/queue_preview.dart';
import '../../domain/repositories/tracking_repository.dart';
import '../../domain/repositories/appointment_repository.dart';
import '../local/tracking_local_data_source.dart';
import '../services/tracking_api_service.dart';
import '../models/tracking_snapshot_model.dart';

class TrackingRepositoryImpl implements TrackingRepository {
  final TrackingApiService _apiService;
  final TrackingLocalDataSource _localDataSource;
  final AppointmentRepository _appointmentRepo;

  TrackingRepositoryImpl(
    this._apiService,
    this._localDataSource,
    this._appointmentRepo,
  );

  @override
  Stream<TrackingSnapshot> getLiveTrackingStream(String tokenId) {
    final controller = StreamController<TrackingSnapshot>();
    IO.Socket? socket;
    TrackingSnapshot? currentSnapshot;

    Future<void> connect() async {
      try {
        // Fetch authoritative latest data from REST API immediately
        try {
          currentSnapshot = await getLiveTracking(tokenId);
          if (!controller.isClosed && currentSnapshot != null) {
            debugPrint('[TrackingWS] Emitting initial REST API snapshot');
            controller.add(currentSnapshot!);
          }
        } catch (e) {
          debugPrint('[TrackingWS] Initial REST API fetch failed: $e');
          if (!controller.isClosed) {
            controller.addError(e);
          }
        }

        final session = Supabase.instance.client.auth.currentSession;
        final token = session?.accessToken;

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

        final onDataReceived = (data) async {
          debugPrint('[TrackingWS] Received real-time update event: $data');
          try {
            if (data is Map<String, dynamic>) {
              // Extract currentTokenNumber from the WebSocket event payload
              final rawCurrentToken = data['currentTokenNumber'] ?? data['currentlyServing'] ?? data['currentToken'];
              
              if (rawCurrentToken != null && currentSnapshot != null) {
                final newCurrentToken = int.tryParse(rawCurrentToken.toString()) ?? 0;
                
                // Recalculate patient ahead and ETA on the fly
                int newPatientsAhead = currentSnapshot!.yourTokenNumber - newCurrentToken;
                if (newPatientsAhead < 0) newPatientsAhead = 0;
                int newEstWait = newPatientsAhead * 10; // 10 minutes per patient ahead

                currentSnapshot = currentSnapshot!.copyWith(
                  currentTokenNumber: newCurrentToken,
                  patientsAheadCount: newPatientsAhead,
                  estimatedWaitMinutes: newEstWait,
                  lastSyncedAt: DateTime.now(),
                );

                debugPrint(
                  '[TrackingWS] Reactive Socket Update — currentToken=$newCurrentToken, ahead=$newPatientsAhead, estWait=${newEstWait}min',
                );

                if (!controller.isClosed) {
                  controller.add(currentSnapshot!);
                }
                return;
              }
            }

            // Fallback: Fetch the authoritative latest tracking state from the API
            final snapshot = await getLiveTracking(tokenId);
            currentSnapshot = snapshot;
            if (!controller.isClosed) {
              controller.add(snapshot);
            }
          } catch (e) {
            debugPrint(
              '[TrackingWS] Error updating snapshot on real-time event: $e',
            );
            if (!controller.isClosed) {
              controller.addError(e);
            }
          }
        };

        socket!.onConnect((_) async {
          debugPrint('[TrackingWS] Connected to WebSocket server');
          socket!.emit('join:token', tokenId);
          
          // Resolve doctorId in the background so it doesn't block initial connection & emit
          _localDataSource.getDoctorIdByTokenId(tokenId).then((cachedDoctorId) async {
            String? docId = cachedDoctorId;
            if (docId == null) {
              docId = await _apiService.getDoctorIdForToken(tokenId);
            }
            if (docId != null && docId.isNotEmpty && socket != null && socket!.connected) {
              debugPrint('[TrackingWS] Joining doctor room: $docId');
              socket!.emit('join:doctor', docId);
            }
          }).catchError((e) {
            debugPrint('[TrackingWS] Background doctorId resolve failed: $e');
          });

          await onDataReceived('initial');
        });

        // Align backend event listeners
        socket!.on('token:created', onDataReceived);
        socket!.on('queue:updated', onDataReceived);
        socket!.on('ETA_UPDATED', onDataReceived);

        socket!.onDisconnect((_) {
          debugPrint('[TrackingWS] Disconnected from server');
        });

        socket!.onConnectError((err) {
          debugPrint('[TrackingWS] Connect Error: $err');
          if (!controller.isClosed) {
            controller.addError(
              NetworkException('WebSocket connection error: $err'),
            );
          }
        });

        socket!.onError((err) {
          debugPrint('[TrackingWS] Error: $err');
          if (!controller.isClosed) {
            controller.addError(UnknownException('WebSocket error: $err'));
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
    try {
      final networkSnapshot = await _apiService.getLiveTracking(tokenId);
      debugPrint(
        '[Tracking] LIVE update — currentToken=${networkSnapshot.currentTokenNumber}, yourToken=${networkSnapshot.yourTokenNumber}, aheadOfYou=${networkSnapshot.patientsAheadCount}, eta=${networkSnapshot.estimatedWaitMinutes}min',
      );
      return networkSnapshot;
    } catch (error) {
      final appEx = mapErrorToException(error);
      debugPrint('[Tracking] Network request failed: ${appEx.message}');
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

  @override
  Stream<QueuePreview> getDoctorQueueStream(String doctorId, String clinicId) {
    final controller = StreamController<QueuePreview>();
    IO.Socket? socket;

    Future<void> connect() async {
      try {
        final session = Supabase.instance.client.auth.currentSession;
        final token = session?.accessToken;

        final rawSocketUrl =
            dotenv.env['SOCKET_URL'] ?? 'https://smart-q-drqx-seven.vercel.app';
        var socketUrl = rawSocketUrl.trim();
        if (socketUrl.endsWith('/')) {
          socketUrl = socketUrl.substring(0, socketUrl.length - 1);
        }

        final uri = Uri.parse(socketUrl);
        if (socketUrl.contains(':0')) {
          socketUrl = socketUrl.replaceAll(':0', '');
        }

        final host = uri.host;
        final scheme = uri.scheme;

        if (!socketUrl.substring(scheme.length + 3).contains(':')) {
          if (scheme == 'https') {
            socketUrl = '$scheme://$host:443';
          } else if (scheme == 'http') {
            socketUrl = '$scheme://$host:80';
          }
        }

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
          debugPrint('[DoctorQueueWS] Connected to WebSocket server');
          socket!.emit('join:doctor', doctorId);
          socket!.emit('join:clinic', clinicId);
        });

        final onDataReceived = (data) async {
          debugPrint('[DoctorQueueWS] Received real-time update event: $data');
          try {
            final preview = await _appointmentRepo.getQueuePreview(
              doctorId: doctorId,
              clinicId: clinicId,
            );
            if (!controller.isClosed) {
              controller.add(preview);
            }
          } catch (e) {
            debugPrint('[DoctorQueueWS] Error fetching live queue preview: $e');
          }
        };

        // Trigger initial fetch when connected
        await onDataReceived('initial');

        socket!.on('queue:updated', onDataReceived);
        socket!.on('token:created', onDataReceived);
        socket!.on('ETA_UPDATED', onDataReceived);

        socket!.onDisconnect((_) {
          debugPrint('[DoctorQueueWS] Disconnected from server');
        });

        socket!.onConnectError((err) {
          debugPrint('[DoctorQueueWS] Connect Error: $err');
        });

        socket!.onError((err) {
          debugPrint('[DoctorQueueWS] Error: $err');
        });
      } catch (e) {
        debugPrint('[DoctorQueueWS] Connection setup failed: $e');
      }
    }

    connect();

    controller.onCancel = () {
      debugPrint(
        '[DoctorQueueWS] Subscription cancelled, cleaning up listeners',
      );
      socket?.clearListeners();
      socket?.disconnect();
      socket?.dispose();
    };

    return controller.stream;
  }
}
