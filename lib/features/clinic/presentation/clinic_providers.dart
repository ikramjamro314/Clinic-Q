import 'package:clinic_q/features/clinic/domain/entities/clinic_entity.dart';
import 'package:clinic_q/features/clinic/presentation/viewmodels/select_doctor_view_model.dart';
import 'package:clinic_q/features/doctor/domain/entities/doctor_entity.dart';
import 'package:clinic_q/features/doctor/presentation/doctor_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/clinic_repository_impl.dart';
import '../domain/repositories/clinic_repository.dart';
import 'viewmodels/clinic_state.dart';
import 'viewmodels/clinic_view_model.dart';
import '../../../core/network/dio_client.dart';
import '../data/services/clinic_api_service.dart';

import '../../../core/local/app_database.dart';
import '../data/local/clinic_local_data_source.dart';

final clinicLocalDataSourceProvider = Provider<ClinicLocalDataSource>((ref) {
  final db = ref.watch(databaseProvider);
  return ClinicLocalDataSource(db);
});

final clinicApiServiceProvider = Provider<ClinicApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ClinicApiService(dio);
});

final clinicRepositoryProvider = Provider<ClinicRepository>((ref) {
  final service = ref.watch(clinicApiServiceProvider);
  final localDataSource = ref.watch(clinicLocalDataSourceProvider);
  return ClinicRepositoryImpl(service, localDataSource);
});

final clinicViewModelProvider = NotifierProvider<ClinicNotifier, ClinicState>(
  ClinicNotifier.new,
);

final clinicDetailsProvider = FutureProvider.family<ClinicEntity?, String>((
  ref,
  clinicId,
) async {
  final repository = ref.watch(clinicRepositoryProvider);
  return await repository.getClinicById(clinicId, forceRefresh: true);
});

final selectDoctorViewModelProvider =
    NotifierProvider.autoDispose.family<SelectDoctorNotifier, SelectDoctorState, String>(
      SelectDoctorNotifier.new,
    );

final clinicDoctorsProvider = FutureProvider.family<List<DoctorEntity>, String>(
  (ref, clinicId) async {
    final repository = ref.watch(doctorRepositoryProvider);
    return await repository.getDoctorsByClinic(clinicId, forceRefresh: true);
  },
);
