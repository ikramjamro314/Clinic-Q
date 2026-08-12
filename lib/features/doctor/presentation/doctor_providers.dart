import 'package:clinic_q/features/doctor/presentation/viewmodels/doctor_profile_state.dart';
import 'package:clinic_q/features/doctor/presentation/viewmodels/doctor_profile_view_model.dart';
import 'package:clinic_q/features/doctor/presentation/viewmodels/filter_state.dart';
import 'package:clinic_q/features/doctor/presentation/viewmodels/filter_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/presentation/auth_providers.dart';
import '../data/repositories/doctor_repository_impl.dart';
import '../data/services/supabase_doctor_service.dart';
import '../domain/repositories/doctor_repository.dart';
import 'viewmodels/doctor_state.dart';
import 'viewmodels/doctor_view_model.dart';

final supabaseDoctorServiceProvider = Provider<SupabaseDoctorService>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return SupabaseDoctorService(client);
});

final doctorRepositoryProvider = Provider<DoctorRepository>((ref) {
  final service = ref.watch(supabaseDoctorServiceProvider);
  return DoctorRepositoryImpl(service);
});

final doctorViewModelProvider = NotifierProvider<DoctorNotifier, DoctorState>(
  DoctorNotifier.new,
);

// Family provider to load a specific doctor profile based on ID
final doctorProfileViewModelProvider = NotifierProvider.family<
    DoctorProfileViewModel, DoctorProfileState, String>(
  DoctorProfileViewModel.new,
);

final filterViewModelProvider = NotifierProvider<FilterViewModel, FilterState>(
  FilterViewModel.new,
);
