import 'package:clinic_q/features/doctor/domain/entities/specialty_entity.dart';

import '../../domain/entities/doctor_entity.dart';
import '../../domain/repositories/doctor_repository.dart';
import '../services/doctor_api_service.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorApiService _apiService;

  DoctorRepositoryImpl(this._apiService);

  @override
  Future<List<DoctorEntity>> getInterestedDoctors() async {
    return await _apiService.getInterestedDoctors();
  }

  @override
  Future<List<DoctorEntity>> getAllDoctors({
    String? query,
    Map<String, dynamic>? filters,
  }) async {
    final specialization = filters?['specialization'] as String? ?? filters?['specialty'] as String?;
    final clinicId = filters?['clinicId'] as String? ?? filters?['clinic_id'] as String?;
    return await _apiService.getAllDoctors(
      clinicId: clinicId,
      specialization: specialization,
      search: query,
    );
  }

  @override
  Future<DoctorEntity?> getDoctorById(String id) async {
    return await _apiService.getDoctorById(id);
  }

  @override
  Future<List<SpecialtyEntity>> getSpecialties() async {
    return await _apiService.getSpecialties();
  }

  @override
  Future<List<DoctorEntity>> getDoctorsByClinic(String clinicId) async {
    return await _apiService.getDoctorsByClinic(clinicId);
  }
}

