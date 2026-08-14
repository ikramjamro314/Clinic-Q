import 'package:clinic_q/features/auth/presentation/auth_providers.dart';
import 'package:clinic_q/features/clinic/presentation/clinic_providers.dart';
import 'package:clinic_q/features/doctor/presentation/doctor_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_state.dart';

class HomeNotifier extends Notifier<HomeState> {
  @override
  HomeState build() {
    // Schedule initial fetch after notifier is built
    Future.microtask(_loadHomeData);
    return const HomeState(isLoading: true, userName: '');
  }

  Future<void> _loadHomeData() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      String name = 'User';
      try {
        final profile = await ref.read(authRepositoryProvider).getProfile();
        if (profile.name.trim().isNotEmpty) {
          name = profile.name.trim().split(' ').first;
        }
      } catch (e) {
        final profileState = ref.read(profileViewModelProvider);
        final currentUser = ref.read(authRepositoryProvider).getCurrentUser();
        if (profileState.name.trim().isNotEmpty) {
          name = profileState.name.trim().split(' ').first;
        } else if (currentUser != null &&
            currentUser.firstName != null &&
            currentUser.firstName!.trim().isNotEmpty) {
          name = currentUser.firstName!.trim();
        }
      }

      final banner = await fetchActiveAppointmentBanner();
      final doctors = await fetchTopDoctors();
      final clinics = await fetchTopClinics();

      state = state.copyWith(
        isLoading: false,
        userName: name,
        bannerData: banner,
        doctors: doctors,
        clinics: clinics,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load home content: $e',
      );
    }
  }

  /// TODO: Replace with appointment feature's getActiveAppointment() or promo banner method
  Future<HomeBannerData> fetchActiveAppointmentBanner() async {
    // Mock/stub response for banner
    await Future.delayed(const Duration(milliseconds: 100));
    return const HomeBannerData(
      badgeText: 'Trusted doctor on your schedule 🤝',
      title: 'Consult A Doctor\n— Book Today!',
      patientCountText: '30.000+\nHappy Patients',
    );
  }

  /// Fetches top doctors from the database via DoctorRepository.
  Future<List<DoctorItem>> fetchTopDoctors() async {
    final repository = ref.read(doctorRepositoryProvider);
    final entities = await repository.getInterestedDoctors();
    return entities
        .map(
          (doc) => DoctorItem(
            id: doc.id,
            name: doc.name,
            specialty: doc.specialty,
            rating: doc.rating,
            avatarUrl: doc.photoUrl,
            isAvailable: doc.isAvailable,
          ),
        )
        .toList();
  }

  /// Fetches top clinics from the database via ClinicRepository.
  Future<List<ClinicItem>> fetchTopClinics() async {
    final repository = ref.read(clinicRepositoryProvider);
    final entities = await repository.getAllClinics();
    final topEntities = entities.take(3).toList();
    return topEntities
        .map(
          (clinic) => ClinicItem(
            id: clinic.id,
            name: clinic.name,
            address: clinic.address,
            imageUrl: clinic.imageUrl,
            rating: clinic.rating,
          ),
        )
        .toList();
  }

  void selectTab(int index) {
    state = state.copyWith(selectedNavIndex: index);
  }

  void refresh() {
    _loadHomeData();
  }
}
