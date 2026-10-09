import 'package:clinic_q/core/network/api_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/specialty_entity.dart';
import '../models/doctor_model.dart';
import '../models/available_date_model.dart';

class DoctorApiService {
  final Dio _dio;

  DoctorApiService(this._dio);

  IconData _getIconForSpecialty(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('dent') || lower.contains('tooth')) {
      return Icons.masks_outlined;
    }
    if (lower.contains('cardio') || lower.contains('heart')) {
      return Icons.favorite_border;
    }
    if (lower.contains('eye') || lower.contains('ophthalm')) {
      return Icons.remove_red_eye_outlined;
    }
    if (lower.contains('pediatr') || lower.contains('child')) {
      return Icons.child_care;
    }
    if (lower.contains('neuro') || lower.contains('brain')) {
      return Icons.psychology_outlined;
    }
    if (lower.contains('infect') || lower.contains('virus')) {
      return Icons.coronavirus_outlined;
    }
    return Icons.medical_services_outlined;
  }

  /// Dynamically extracts unique specialties from the list of all doctors.
  Future<List<SpecialtyEntity>> getSpecialties() async {
    try {
      final doctors = await getAllDoctors();
      final uniqueSpecialties = <String>{};
      for (final doc in doctors) {
        if (doc.specialty.trim().isNotEmpty) {
          uniqueSpecialties.add(doc.specialty.trim());
        }
      }

      int index = 1;
      return uniqueSpecialties.map((name) {
        return SpecialtyEntity(
          id: (index++).toString(),
          name: name,
          iconReference: _getIconForSpecialty(name),
        );
      }).toList();
    } catch (_) {
      // Fallback in case of API request failure during onboarding/filtering
      return const [
        SpecialtyEntity(
          id: '1',
          name: 'Toothcare',
          iconReference: Icons.masks_outlined,
        ),
        SpecialtyEntity(
          id: '2',
          name: 'Cardiology',
          iconReference: Icons.favorite_border,
        ),
        SpecialtyEntity(
          id: '3',
          name: 'Eye',
          iconReference: Icons.remove_red_eye_outlined,
        ),
        SpecialtyEntity(
          id: '4',
          name: 'Pediatrics',
          iconReference: Icons.child_care,
        ),
        SpecialtyEntity(
          id: '5',
          name: 'Neurology',
          iconReference: Icons.psychology_outlined,
        ),
        SpecialtyEntity(
          id: '6',
          name: 'Infectious',
          iconReference: Icons.coronavirus_outlined,
        ),
      ];
    }
  }

  /// Fetches a list of all doctors from the real Node API, supporting query params
  Future<List<DoctorModel>> getAllDoctors({
    String? clinicId,
    String? specialization,
    String? search,
  }) async {
    final queryParams = <String, dynamic>{};
    if (clinicId != null && clinicId.trim().isNotEmpty) {
      queryParams['clinicId'] = clinicId.trim();
    }
    if (specialization != null && specialization.trim().isNotEmpty) {
      queryParams['specialization'] = specialization.trim();
    }
    if (search != null && search.trim().isNotEmpty) {
      queryParams['search'] = search.trim();
    }

    final response = await _dio.get(
      '/api/patient/doctors',
      queryParameters: queryParams,
    );

    final rawData = ApiResponse.process(response.data);
    if (rawData is List) {
      return rawData
          .map((json) => DoctorModel.fromJson(json as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Fetches a single doctor by its unique identifier
  Future<DoctorModel?> getDoctorById(String id) async {
    final response = await _dio.get('/api/patient/doctors/$id');
    final rawData = ApiResponse.process(response.data);
    if (rawData != null) {
      return DoctorModel.fromJson(rawData as Map<String, dynamic>);
    }
    return null;
  }

  /// Fetches featured or top doctors sorted by rating in descending order
  Future<List<DoctorModel>> getInterestedDoctors() async {
    final doctors = await getAllDoctors();
    final sorted = List<DoctorModel>.from(doctors)
      ..sort((a, b) => b.rating.compareTo(a.rating));
    final highRated = sorted.where((doc) => doc.rating >= 4.5).toList();
    if (highRated.isNotEmpty) return highRated.take(10).toList();
    return sorted.take(5).toList();
  }

  /// Fetches doctors for a specific clinic
  Future<List<DoctorModel>> getDoctorsByClinic(String clinicId) async {
    return await getAllDoctors(clinicId: clinicId);
  }

  /// Fetches the next available working dates for a doctor (looping from tomorrow, up to 3 working days)
  Future<List<AvailableDateModel>> getAvailableDates(String doctorId) async {
    final response = await _dio.get('/api/patient/doctors/$doctorId/available-dates');
    final rawData = ApiResponse.process(response.data);
    if (rawData is List) {
      return rawData
          .map((json) => AvailableDateModel.fromJson(json as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
}
