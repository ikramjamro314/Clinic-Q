import 'package:clinic_q/features/auth/presentation/auth_providers.dart';
import 'package:clinic_q/features/clinic/presentation/clinic_providers.dart';
import 'package:clinic_q/features/doctor/presentation/doctor_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/error/exception_mapper.dart';
import 'home_state.dart';

class HomeNotifier extends Notifier<HomeState> {
  @override
  HomeState build() {
    final currentUser = ref.watch(authRepositoryProvider).getCurrentUser();
    String initialName = '';
    if (currentUser != null) {
      if (currentUser.firstName != null &&
          currentUser.firstName!.trim().isNotEmpty) {
        initialName = currentUser.firstName!.trim();
      } else if (currentUser.email.isNotEmpty) {
        initialName = currentUser.email.split('@').first;
      }
    }

    // Schedule initial fetch after notifier is built
    Future.microtask(_loadHomeData);
    return HomeState(isLoading: true, userName: initialName);
  }

  Future<void> _loadHomeData() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      bool isFromCache = false;
      final currentUser = ref.read(authRepositoryProvider).getCurrentUser();
      String name = state.userName.isNotEmpty ? state.userName : 'User';

      try {
        final profile = await ref.read(authRepositoryProvider).getProfile();
        if (profile.name.trim().isNotEmpty) {
          name = profile.name.trim().split(' ').first;
        }
        if (profile.isFromCache) {
          isFromCache = true;
        }
      } catch (e) {
        final profileState = ref.read(authProfileSyncNotifierProvider);
        if (profileState.name.trim().isNotEmpty) {
          name = profileState.name.trim().split(' ').first;
        } else if (currentUser != null &&
            currentUser.firstName != null &&
            currentUser.firstName!.trim().isNotEmpty) {
          name = currentUser.firstName!.trim();
        } else if (currentUser != null && currentUser.email.isNotEmpty) {
          name = currentUser.email.split('@').first;
        }
      }

      final banner = await fetchActiveAppointmentBanner();
      
      final docRepo = ref.read(doctorRepositoryProvider);
      final clinicRepo = ref.read(clinicRepositoryProvider);

      final docEntities = await docRepo.getInterestedDoctors();
      final clinicEntities = await clinicRepo.getAllClinics();

      if (docEntities.any((d) => d.isFromCache) || clinicEntities.any((c) => c.isFromCache)) {
        isFromCache = true;
      }

      final doctors = docEntities.map((doc) => DoctorItem(
        id: doc.id,
        name: doc.name,
        specialty: doc.specialty,
        rating: doc.rating,
        avatarUrl: doc.photoUrl,
        isAvailable: doc.isAvailable,
      )).toList();

      final clinics = clinicEntities.take(3).map((clinic) => ClinicItem(
        id: clinic.id,
        name: clinic.name,
        address: clinic.address,
        imageUrl: clinic.imageUrl,
        rating: clinic.rating,
      )).toList();

      state = state.copyWith(
        isLoading: false,
        userName: name,
        bannerData: banner,
        doctors: doctors,
        clinics: clinics,
        isFromCache: isFromCache,
      );
    } catch (e) {
      final appEx = mapErrorToException(e);
      state = state.copyWith(
        isLoading: false,
        errorMessage: appEx.message,
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
