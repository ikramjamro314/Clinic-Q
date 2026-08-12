import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../clinic_providers.dart';
import 'clinic_state.dart';

class ClinicNotifier extends Notifier<ClinicState> {
  @override
  ClinicState build() {
    // Initial fetch on build
    Future.microtask(_loadInitialData);
    return const ClinicState(isLoading: true);
  }

  Future<void> _loadInitialData() async {
    state = state.copyWith(isLoading: true).clearError();

    try {
      final repository = ref.read(clinicRepositoryProvider);
      
      final all = await repository.getAllClinics();

      state = state.copyWith(
        isLoading: false,
        clinics: all,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: 'Failed to load clinics: $e');
    }
  }

  Future<void> searchClinics(String query) async {
    state = state.copyWith(searchQuery: query, isLoading: true).clearError();

    try {
      final repository = ref.read(clinicRepositoryProvider);
      
      final all = await repository.getAllClinics(query: query);

      state = state.copyWith(
        isLoading: false,
        clinics: all,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: 'Search failed: $e');
    }
  }

  Future<void> refresh() async {
    await _loadInitialData();
  }
}
