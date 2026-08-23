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
    String? notes,
  }) async {
    final body = {
      'doctorId': doctorId,
      'clinicId': clinicId,
      'userId': userId,
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

  Future<void> cancelToken(String id) async {
    final response = await _dio.patch(
      '/api/patient/tokens/$id/cancel',
    );
    ApiResponse.process(response.data);
  }
}
