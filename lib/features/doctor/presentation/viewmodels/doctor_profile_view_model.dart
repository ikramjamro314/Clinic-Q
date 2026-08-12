import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../doctor_providers.dart';
import 'doctor_profile_state.dart';
import '../../../ratings/presentation/ratings_providers.dart';

class DoctorProfileViewModel extends Notifier<DoctorProfileState> {
  DoctorProfileViewModel(this.doctorId);
  final String doctorId;

  @override
  DoctorProfileState build() {
    Future.microtask(() => _loadDoctorData(doctorId));
    return const DoctorProfileState(isLoading: true);
  }

  Future<void> _loadDoctorData(String doctorId) async {
    state = state.copyWith(isLoading: true).clearError();
    try {
      final repository = ref.read(doctorRepositoryProvider);

      // Fetch doctor details
      final doctor = await repository.getDoctorById(doctorId);

      if (doctor == null) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Doctor not found.',
        );
        return;
      }

      // Fetch reviews using the ratings repository
      final ratingsRepository = ref.read(ratingsRepositoryProvider);
      final reviews = await ratingsRepository.getReviewsFor(
        doctorId: doctorId,
      );

      state = state.copyWith(
        isLoading: false,
        doctor: doctor,
        topReviews: reviews.take(2).toList(),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load doctor profile: $e',
      );
    }
  }
}
