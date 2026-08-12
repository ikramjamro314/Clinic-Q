import 'package:clinic_q/features/doctor/domain/entities/doctor_entity.dart';
import 'package:clinic_q/features/doctor/domain/entities/specialty_entity.dart';

abstract class DoctorRepository {
  /// Fetches specialties
  Future<List<SpecialtyEntity>> getSpecialties();

  /// Fetches doctors marked as "interested" or featured.
  Future<List<DoctorEntity>> getInterestedDoctors();

  /// Fetches a list of all doctors, optionally filtered by a search query or other filters.
  Future<List<DoctorEntity>> getAllDoctors({
    String? query,
    Map<String, dynamic>? filters,
  });

  /// Fetches a single doctor by ID.
  Future<DoctorEntity?> getDoctorById(String id);

  /// Fetches doctors for a specific clinic.
  Future<List<DoctorEntity>> getDoctorsByClinic(String clinicId);
}
