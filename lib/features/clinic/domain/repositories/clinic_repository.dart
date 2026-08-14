import 'package:clinic_q/features/clinic/domain/entities/clinic_entity.dart';

abstract class ClinicRepository {
  /// Fetches a list of all clinics, optionally filtered by city, specialty, and search query.
  Future<List<ClinicEntity>> getAllClinics({
    String? city,
    String? specialty,
    String? search,
  });

  /// Fetches a single clinic by ID
  Future<ClinicEntity?> getClinicById(String id);
}

