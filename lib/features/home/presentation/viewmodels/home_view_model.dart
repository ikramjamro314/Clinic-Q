import 'package:clinic_q/features/auth/presentation/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_state.dart';

class HomeNotifier extends Notifier<HomeState> {
  @override
  HomeState build() {
    final profileState = ref.watch(profileViewModelProvider);
    final currentUser = ref.watch(authRepositoryProvider).getCurrentUser();

    String name = 'User';
    if (profileState.name.trim().isNotEmpty) {
      name = profileState.name.trim().split(' ').first;
    } else if (currentUser != null &&
        currentUser.firstName != null &&
        currentUser.firstName!.trim().isNotEmpty) {
      name = currentUser.firstName!.trim();
    }

    // Schedule initial fetch after notifier is built
    Future.microtask(_loadHomeData);
    return HomeState(isLoading: true, userName: name);
  }

  Future<void> _loadHomeData() async {
    final profileState = ref.read(profileViewModelProvider);
    final currentUser = ref.read(authRepositoryProvider).getCurrentUser();

    String name = 'User';
    if (profileState.name.trim().isNotEmpty) {
      name = profileState.name.trim().split(' ').first;
    } else if (currentUser != null &&
        currentUser.firstName != null &&
        currentUser.firstName!.trim().isNotEmpty) {
      name = currentUser.firstName!.trim();
    }

    state = state.copyWith(isLoading: true, errorMessage: null, userName: name);

    try {
      final banner = await fetchActiveAppointmentBanner();
      final doctors = await fetchTopDoctors();
      final clinics = await fetchTopClinics();

      state = state.copyWith(
        isLoading: false,
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

  /// TODO: Replace with doctor feature's getTopDoctors() method
  Future<List<DoctorItem>> fetchTopDoctors() async {
    // Mock/stub response for interested doctors list
    await Future.delayed(const Duration(milliseconds: 100));
    return const [
      DoctorItem(
        id: 'doc_1',
        name: 'Dr. Anthony',
        specialty: 'Obstetrics',
        rating: 4.5,
      ),
      DoctorItem(
        id: 'doc_2',
        name: 'Dr. Nguyen',
        specialty: 'Dermatology',
        rating: 4.8,
      ),
      DoctorItem(
        id: 'doc_3',
        name: 'Dr. Patel',
        specialty: 'Cardiology',
        rating: 4.9,
      ),
    ];
  }

  /// TODO: Replace with clinic feature's getTopClinics() / getTopHospitals() method
  Future<List<ClinicItem>> fetchTopClinics() async {
    // Mock/stub response for top hospitals/clinics
    await Future.delayed(const Duration(milliseconds: 100));
    return const [
      ClinicItem(
        id: 'clinic_1',
        name: 'Mayo Clinic',
        address: '200 First St, MN',
        rating: 4.9,
      ),
      ClinicItem(
        id: 'clinic_2',
        name: 'Cleveland Clinic',
        address: '9500 Euclid Ave, OH',
        rating: 4.8,
      ),
      ClinicItem(
        id: 'clinic_3',
        name: 'Johns Hopkins Hospital',
        address: '1800 Orleans St, MD',
        rating: 4.7,
      ),
    ];
  }

  void selectTab(int index) {
    state = state.copyWith(selectedNavIndex: index);
  }

  void refresh() {
    _loadHomeData();
  }
}
