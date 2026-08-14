import '../../domain/entities/clinic_entity.dart';
import '../../domain/repositories/clinic_repository.dart';
import '../services/clinic_api_service.dart';

class ClinicRepositoryImpl implements ClinicRepository {
  final ClinicApiService _service;

  ClinicRepositoryImpl(this._service);

  @override
  Future<List<ClinicEntity>> getAllClinics({
    String? city,
    String? specialty,
    String? search,
  }) async {
    return await _service.getAllClinics(
      city: city,
      specialty: specialty,
      search: search,
    );
  }

  @override
  Future<ClinicEntity?> getClinicById(String id) async {
    return await _service.getClinicById(id);
  }
}

