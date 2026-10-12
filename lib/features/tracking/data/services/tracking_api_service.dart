import 'package:dio/dio.dart';
import '../../../../core/network/api_response.dart';
import '../models/tracking_snapshot_model.dart';
import '../../domain/entities/token.dart';
import '../models/token_model.dart';

class TrackingApiService {
  final Dio _dio;

  TrackingApiService(this._dio);

  Future<TrackingSnapshotModel> getLiveTracking(String tokenId, {String? userId}) async {
    // 1. Get Doctor ID and the token's own authoritative status in one call.
    //    The token status matters when the token no longer appears in the
    //    live queue list (e.g. it was cancelled and removed) — otherwise we
    //    would fall back to the queue-level status and keep showing "waiting".
    String? doctorId;
    String? tokenOwnStatus;
    try {
      final tokenDetails = await _getTokenDetails(tokenId);
      doctorId = tokenDetails?['doctorId'] as String? ?? tokenDetails?['doctor_id'] as String?;
      tokenOwnStatus = tokenDetails?['status'] as String?;
    } catch (e) {
      print('[Tracking] Error fetching doctor ID for token in getLiveTracking: $e');
    }

    if (doctorId != null && doctorId.isNotEmpty) {
      try {
        final response = await _dio.get('/api/patient/queue/live/$doctorId');
        print('[Tracking] RAW getLiveTracking (live queue) response: ${response.data}');
        
        final rawData = ApiResponse.process(response.data);
        if (rawData is Map<String, dynamic>) {
          // Parse the live queue response
          final currentToken = rawData['currentTokenNumber'] as int? ?? 0;

          // Find our token details from the token list
          final tokenListRaw = rawData['tokens'] ?? rawData['fullTokenList'];
          Map<String, dynamic>? myTokenJson;

          final List<Token> fullTokens = [];
          if (tokenListRaw is List) {
            for (final item in tokenListRaw) {
              if (item is Map<String, dynamic>) {
                final tModel = TokenModel.fromJson(item);
                fullTokens.add(tModel);

                final id = item['id'] as String? ?? item['tokenId'] as String?;
                if (id == tokenId) {
                  myTokenJson = item;
                }
              }
            }
          }

          final isQueueActive = rawData['isQueueActive'] as bool? ?? false;
          final isQueuePaused = rawData['isQueuePaused'] as bool? ?? false;

          final queueStatus = rawData['queueStatus'] as String? ?? rawData['queue_status'] as String?;
          final isPaused = isQueuePaused ||
              (queueStatus != null && queueStatus.toUpperCase() == 'PAUSED') ||
              rawData['status'] == 'paused' ||
              rawData['isPaused'] == true;

          int yourToken = 0;
          int patientsAhead = 0;
          int? estWait;
          String statusVal = isPaused ? 'paused' : 'waiting';

          if (myTokenJson != null) {
            yourToken = myTokenJson['tokenNumber'] as int? ??
                myTokenJson['yourTokenNumber'] as int? ?? 0;
            patientsAhead = myTokenJson['patientsAheadCount'] as int? ??
                myTokenJson['tokensAhead'] as int? ?? 0;
            estWait = isPaused
                ? null
                : (myTokenJson['estimatedWaitMinutes'] as int? ??
                    myTokenJson['estimated_wait_minutes'] as int?);
            statusVal = myTokenJson['status'] as String? ?? tokenOwnStatus ?? (isPaused ? 'paused' : 'waiting');
          } else {
            yourToken = rawData['yourTokenNumber'] as int? ??
                rawData['tokenNumber'] as int? ?? 0;
            patientsAhead = rawData['patientsAheadCount'] as int? ??
                rawData['tokensAhead'] as int? ?? 0;
            estWait = isPaused
                ? null
                : (rawData['estimatedWaitMinutes'] as int? ??
                    rawData['estimated_wait_minutes'] as int?);
            // Token is missing from the live queue list — it may have been
            // cancelled/removed. Prefer the token's own status over the
            // queue-level status so cancelled tokens don't look "waiting".
            statusVal = tokenOwnStatus ?? rawData['status'] as String? ?? (isPaused ? 'paused' : 'waiting');
          }

          final maxLimit = rawData['maxTokensPerDay'] as int? ?? rawData['dailyTokenCap'] as int?;
          final activeTokenIdVal = rawData['activeTokenId'] as String? ?? rawData['active_token_id'] as String?;
          final estTime = rawData['estimatedTime'] as String? ?? rawData['estimated_time'] as String?;

          // Compute estimated waiting/ahead if not supplied by backend and queue is NOT paused
          if (!isPaused) {
            if (patientsAhead == 0 && yourToken > currentToken && currentToken > 0) {
              patientsAhead = yourToken - currentToken - 1;
              if (patientsAhead < 0) patientsAhead = 0;
            }
            if (estWait == null && patientsAhead > 0) {
              estWait = patientsAhead * 10; // Default 10 mins per patient ahead
            }
          }

          return TrackingSnapshotModel(
            tokenId: tokenId,
            currentTokenNumber: currentToken,
            yourTokenNumber: yourToken,
            patientsAheadCount: patientsAhead,
            estimatedWaitMinutes: estWait,
            status: statusVal,
            lastSyncedAt: DateTime.now(),
            fullTokenList: fullTokens,
            maxTokens: maxLimit,
            queueStatus: queueStatus,
            estimatedTime: estTime,
            activeTokenId: activeTokenIdVal,
            isQueueActive: isQueueActive,
            isQueuePaused: isQueuePaused,
          );
        }
      } catch (e) {
        print('[Tracking] Failed to get live tracking from doctor queue endpoint: $e. Falling back to token endpoint.');
      }
    }

    // Fallback: Fetch directly from token details endpoint
    final queryParameters = <String, dynamic>{};
    if (userId != null) queryParameters['userId'] = userId;

    final response = await _dio.get(
      '/api/patient/tokens/$tokenId',
      queryParameters: queryParameters,
    );

    // Print the raw response body as requested
    print('[Tracking] RAW getLiveTracking (token fallback) response: ${response.data}');

    final rawData = ApiResponse.process(response.data);
    return TrackingSnapshotModel.fromJson(rawData as Map<String, dynamic>, tokenId);
  }

  Future<Map<String, dynamic>?> _getTokenDetails(String tokenId) async {
    try {
      final response = await _dio.get('/api/patient/tokens/$tokenId');
      final rawData = ApiResponse.process(response.data);
      if (rawData is Map<String, dynamic>) {
        return rawData;
      }
    } catch (e) {
      print('[TrackingApiService] Error fetching token details: $e');
    }
    return null;
  }

  Future<String?> getDoctorIdForToken(String tokenId) async {
    final details = await _getTokenDetails(tokenId);
    return details?['doctorId'] as String? ?? details?['doctor_id'] as String?;
  }

  Future<String?> getClinicIdForToken(String tokenId) async {
    try {
      final response = await _dio.get('/api/patient/tokens/$tokenId');
      final rawData = ApiResponse.process(response.data);
      if (rawData is Map<String, dynamic>) {
        return rawData['clinicId'] as String? ?? rawData['clinic_id'] as String?;
      }
    } catch (e) {
      print('[TrackingApiService] Error fetching clinic ID: $e');
    }
    return null;
  }
}
