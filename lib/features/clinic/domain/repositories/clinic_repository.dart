import 'package:clinic_q/features/clinic/domain/entities/clinic_entity.dart';

abstract class ClinicRepository {
  /// Fetches a list of all clinics, optionally filtered by a search query.
  Future<List<ClinicEntity>> getAllClinics({String? query});

  /// Fetches a single clinic by ID
  Future<ClinicEntity?> getClinicById(String id);
}
