import 'package:clinic_q/core/network/api_response.dart';
import 'package:dio/dio.dart';
import '../models/clinic_model.dart';

class ClinicApiService {
  final Dio _dio;

  ClinicApiService(this._dio);

  /// Fetches a list of clinics with optional filters
  Future<List<ClinicModel>> getAllClinics({
    String? city,
    String? specialty,
    String? search,
  }) async {
    final queryParams = <String, dynamic>{};
    if (city != null && city.trim().isNotEmpty) {
      queryParams['city'] = city.trim();
    }
    if (specialty != null && specialty.trim().isNotEmpty) {
      queryParams['specialty'] = specialty.trim();
    }
    if (search != null && search.trim().isNotEmpty) {
      queryParams['search'] = search.trim();
    }

    final response = await _dio.get(
      '/api/patient/clinics',
      queryParameters: queryParams,
    );

    final rawData = ApiResponse.process(response.data);
    if (rawData is List) {
      return rawData
          .map((json) => ClinicModel.fromJson(json as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Fetches a single clinic by its unique identifier
  Future<ClinicModel?> getClinicById(String id) async {
    final response = await _dio.get('/api/patient/clinics/$id');
    final rawData = ApiResponse.process(response.data);
    if (rawData != null) {
      return ClinicModel.fromJson(rawData as Map<String, dynamic>);
    }
    return null;
  }
}
