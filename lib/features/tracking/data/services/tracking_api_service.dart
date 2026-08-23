import 'package:dio/dio.dart';
import '../../../../core/network/api_response.dart';
import '../models/tracking_snapshot_model.dart';

class TrackingApiService {
  final Dio _dio;

  TrackingApiService(this._dio);

  Future<TrackingSnapshotModel> getLiveTracking(String tokenId, {String? userId}) async {
    final queryParameters = <String, dynamic>{};
    if (userId != null) queryParameters['userId'] = userId;

    final response = await _dio.get(
      '/api/patient/tokens/$tokenId',
      queryParameters: queryParameters,
    );

    // Print the raw response body as requested
    print('[Tracking] RAW getLiveTracking response: ${response.data}');

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
}
