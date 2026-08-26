import 'package:dio/dio.dart';
import '../../../../core/network/api_response.dart';
import '../models/tracking_snapshot_model.dart';

class TrackingApiService {
  final Dio _dio;

  TrackingApiService(this._dio);

  Future<TrackingSnapshotModel> getLiveTracking(String tokenId, {String? userId}) async {
    // 1. Get Doctor ID for this token
    String? doctorId;
    try {
      doctorId = await getDoctorIdForToken(tokenId);
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
          final currentToken = rawData['currentTokenNumber'] as int? ??
              rawData['currentlyServingTokenNumber'] as int? ??
              rawData['currentlyServing'] as int? ??
              rawData['currentToken'] as int? ??
              rawData['current_token'] as int? ?? 0;
              
          // Find our token details from the token list
          final tokenListRaw = rawData['fullTokenList'] ?? rawData['tokens'] ?? rawData['tokenList'];
          Map<String, dynamic>? myTokenJson;
          if (tokenListRaw is List) {
            for (final item in tokenListRaw) {
              if (item is Map<String, dynamic>) {
                final id = item['tokenId'] as String? ?? item['id'] as String? ?? item['token_id'] as String?;
                if (id == tokenId) {
                  myTokenJson = item;
                  break;
                }
              }
            }
          }

          int yourToken = 0;
          int patientsAhead = 0;
          int estWait = 0;
          String statusVal = 'waiting';

          if (myTokenJson != null) {
            yourToken = myTokenJson['yourTokenNumber'] as int? ??
                myTokenJson['yourToken'] as int? ??
                myTokenJson['tokenNumber'] as int? ??
                myTokenJson['token_number'] as int? ?? 0;
                
            patientsAhead = myTokenJson['patientsAheadCount'] as int? ??
                myTokenJson['patientsAhead'] as int? ??
                myTokenJson['patients_ahead'] as int? ?? 0;
                
            estWait = myTokenJson['estimatedWaitMinutes'] as int? ??
                myTokenJson['estimatedWaitTime'] as int? ??
                myTokenJson['estimated_wait'] as int? ??
                myTokenJson['estimatedWait'] as int? ?? 0;
                
            statusVal = myTokenJson['status'] as String? ?? 'waiting';
          } else {
            // Check top level
            yourToken = rawData['yourTokenNumber'] as int? ?? rawData['yourToken'] as int? ?? 0;
            patientsAhead = rawData['patientsAheadCount'] as int? ?? rawData['patientsAhead'] as int? ?? 0;
            estWait = rawData['estimatedWaitMinutes'] as int? ?? rawData['estimatedWaitTime'] as int? ?? 0;
            statusVal = rawData['status'] as String? ?? 'waiting';
          }

          // Compute fallbacks if necessary
          if (patientsAhead == 0 && yourToken > currentToken && currentToken > 0) {
            patientsAhead = yourToken - currentToken - 1;
            if (patientsAhead < 0) patientsAhead = 0;
          }
          if (estWait == 0 && patientsAhead > 0) {
            estWait = patientsAhead * 10; // Default 10 mins per patient ahead
          }

          return TrackingSnapshotModel(
            tokenId: tokenId,
            currentTokenNumber: currentToken,
            yourTokenNumber: yourToken,
            patientsAheadCount: patientsAhead,
            estimatedWaitMinutes: estWait,
            status: statusVal,
            lastSyncedAt: DateTime.now(),
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

  Future<String?> getDoctorIdForToken(String tokenId) async {
    try {
      final response = await _dio.get('/api/patient/tokens/$tokenId');
      final rawData = ApiResponse.process(response.data);
      if (rawData is Map<String, dynamic>) {
        return rawData['doctorId'] as String? ?? rawData['doctor_id'] as String?;
      }
    } catch (e) {
      print('[TrackingApiService] Error fetching doctor ID: $e');
    }
    return null;
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
