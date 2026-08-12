import '../../domain/entities/clinic_entity.dart';
import '../../domain/repositories/clinic_repository.dart';
import '../services/supabase_clinic_service.dart';

class ClinicRepositoryImpl implements ClinicRepository {
  final SupabaseClinicService _service;

  ClinicRepositoryImpl(this._service);

  @override
  Future<List<ClinicEntity>> getAllClinics({String? query}) async {
    // Service returns List<ClinicModel>, which extends ClinicEntity
    return await _service.getAllClinics(query: query);
  }

  @override
  Future<ClinicEntity?> getClinicById(String id) async {
    return await _service.getClinicById(id);
  }
}
