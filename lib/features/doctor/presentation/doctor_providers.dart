import 'package:clinic_q/features/doctor/presentation/viewmodels/doctor_profile_state.dart';
import 'package:clinic_q/features/doctor/presentation/viewmodels/doctor_profile_view_model.dart';
import 'package:clinic_q/features/doctor/presentation/viewmodels/filter_state.dart';
import 'package:clinic_q/features/doctor/presentation/viewmodels/filter_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/entities/available_date_entity.dart';

import '../data/repositories/doctor_repository_impl.dart';
import '../domain/repositories/doctor_repository.dart';
import 'viewmodels/doctor_state.dart';
import 'viewmodels/doctor_view_model.dart';

import '../../../core/network/dio_client.dart';
import '../data/services/doctor_api_service.dart';

import '../../clinic/presentation/clinic_providers.dart';
import '../../../core/local/app_database.dart';
import '../data/local/doctor_local_data_source.dart';

final doctorLocalDataSourceProvider = Provider<DoctorLocalDataSource>((ref) {
  final db = ref.watch(databaseProvider);
  return DoctorLocalDataSource(db);
});

final doctorApiServiceProvider = Provider<DoctorApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return DoctorApiService(dio);
});

final doctorRepositoryProvider = Provider<DoctorRepository>((ref) {
  final service = ref.watch(doctorApiServiceProvider);
  final localDataSource = ref.watch(doctorLocalDataSourceProvider);
  final clinicLocalDataSource = ref.watch(clinicLocalDataSourceProvider);
  return DoctorRepositoryImpl(service, localDataSource, clinicLocalDataSource);
});

final doctorViewModelProvider = NotifierProvider<DoctorNotifier, DoctorState>(
  DoctorNotifier.new,
);

// Family provider to load a specific doctor profile based on ID
final doctorProfileViewModelProvider = NotifierProvider.family<
    DoctorProfileViewModel, DoctorProfileState, String>(
  DoctorProfileViewModel.new,
);

final filterViewModelProvider =
    NotifierProvider.autoDispose<FilterViewModel, FilterState>(
  FilterViewModel.new,
);

final doctorAvailableDatesProvider =
    FutureProvider.family<List<AvailableDateEntity>, String>((ref, doctorId) async {
  return ref.watch(doctorRepositoryProvider).getAvailableDates(doctorId);
});
