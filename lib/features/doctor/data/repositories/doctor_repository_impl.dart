import 'package:clinic_q/features/doctor/domain/entities/specialty_entity.dart';

import '../../domain/entities/doctor_entity.dart';
import '../../domain/repositories/doctor_repository.dart';
import '../services/supabase_doctor_service.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final SupabaseDoctorService _supabaseService;

  DoctorRepositoryImpl(this._supabaseService);

  @override
  Future<List<DoctorEntity>> getInterestedDoctors() async {
    return await _supabaseService.getInterestedDoctors();
  }

  @override
  Future<List<DoctorEntity>> getAllDoctors({
    String? query,
    Map<String, dynamic>? filters,
  }) async {
    return await _supabaseService.getAllDoctors(query: query, filters: filters);
  }

  @override
  Future<DoctorEntity?> getDoctorById(String id) async {
    return await _supabaseService.getDoctorById(id);
  }

  @override
  Future<List<SpecialtyEntity>> getSpecialties() async {
    return await _supabaseService.getSpecialties();
  }

  @override
  Future<List<DoctorEntity>> getDoctorsByClinic(String clinicId) async {
    return await _supabaseService.getDoctorsByClinic(clinicId);
  }
}
