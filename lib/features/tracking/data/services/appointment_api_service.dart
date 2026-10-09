import 'package:dio/dio.dart';
import '../../../../core/network/api_response.dart';
import '../models/token_model.dart';

class AppointmentApiService {
  final Dio _dio;

  AppointmentApiService(this._dio);

  Future<TokenModel> createToken({
    required String doctorId,
    required String clinicId,
    required String userId,
    String? appointmentDate,
    bool? isFuture,
    String? notes,
  }) async {
    bool calculatedIsFuture = isFuture ?? false;
    if (isFuture == null && appointmentDate != null) {
      try {
        final parsed = DateTime.parse(appointmentDate);
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        final appDate = DateTime(parsed.year, parsed.month, parsed.day);
        calculatedIsFuture = appDate.isAfter(today);
      } catch (_) {}
    }

    final body = {
      'doctorId': doctorId,
      'clinicId': clinicId,
      'userId': userId,
      'isFuture': calculatedIsFuture,
      if (appointmentDate != null) 'appointmentDate': appointmentDate,
      if (notes != null) 'notes': notes,
    };

    final response = await _dio.post(
      '/api/patient/tokens',
      data: body,
    );

    final rawData = ApiResponse.process(response.data);
    return TokenModel.fromJson(rawData as Map<String, dynamic>);
  }

  Future<List<TokenModel>> getTokens({
    String? doctorId,
    String? clinicId,
    String? userId,
  }) async {
    final queryParameters = <String, dynamic>{};
    if (doctorId != null) queryParameters['doctorId'] = doctorId;
    if (clinicId != null) queryParameters['clinicId'] = clinicId;
    if (userId != null) queryParameters['userId'] = userId;

    final response = await _dio.get(
      '/api/patient/tokens',
      queryParameters: queryParameters,
    );

    // Print the raw response body as requested
    print('[Appointment] RAW getTokens response: ${response.data}');

    final rawData = ApiResponse.process(response.data);
    if (rawData is List) {
      return rawData
          .map((json) => TokenModel.fromJson(json as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<Map<String, dynamic>?> getLiveQueue(String doctorId) async {
    try {
      final response = await _dio.get(
        '/api/patient/queue/live/$doctorId',
      );
      print('[Appointment] RAW getLiveQueue response: ${response.data}');
      final rawData = ApiResponse.process(response.data);
      if (rawData is Map<String, dynamic>) {
        return rawData;
      }
    } catch (e) {
      print('[Appointment] Error fetching live queue for doctorId=$doctorId: $e');
      rethrow;
    }
    return null;
  }

  Future<void> cancelToken(String id) async {
    try {
      final response = await _dio.patch(
        '/api/patient/tokens/$id/cancel',
      );
      ApiResponse.process(response.data);
    } catch (e) {
      try {
        final response = await _dio.put(
          '/api/patient/tokens/$id/cancel',
        );
        ApiResponse.process(response.data);
      } catch (_) {
        final response = await _dio.post(
          '/api/patient/tokens/$id/cancel',
        );
        ApiResponse.process(response.data);
      }
    }
  }
}
