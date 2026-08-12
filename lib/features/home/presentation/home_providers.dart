import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'viewmodels/home_state.dart';
import 'viewmodels/home_view_model.dart';

// TODO: Replace with actual Doctor feature providers when implemented
final homeDoctorFeatureProvider = Provider.autoDispose((ref) {
  // Wire in doctor repository / service provider when available
  return null;
});

// TODO: Replace with actual Clinic feature providers when implemented
final homeClinicFeatureProvider = Provider.autoDispose((ref) {
  // Wire in clinic repository / service provider when available
  return null;
});

// TODO: Replace with actual Appointment feature providers when implemented
final homeAppointmentFeatureProvider = Provider.autoDispose((ref) {
  // Wire in appointment repository / service provider when available
  return null;
});

/// Main Home Notifier provider
final homeViewModelProvider = NotifierProvider<HomeNotifier, HomeState>(
  HomeNotifier.new,
);

/// Derived providers for clean UI consumption
final homeBannerProvider = Provider.autoDispose<HomeBannerData?>((ref) {
  return ref.watch(homeViewModelProvider).bannerData;
});

final topDoctorsProvider = Provider.autoDispose<List<DoctorItem>>((ref) {
  return ref.watch(homeViewModelProvider).doctors;
});

final topClinicsProvider = Provider.autoDispose<List<ClinicItem>>((ref) {
  return ref.watch(homeViewModelProvider).clinics;
});

final selectedNavIndexProvider = Provider.autoDispose<int>((ref) {
  return ref.watch(homeViewModelProvider).selectedNavIndex;
});

final homeLoadingProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(homeViewModelProvider).isLoading;
});
