import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../doctor_providers.dart';
import 'doctor_state.dart';

class DoctorNotifier extends Notifier<DoctorState> {
  @override
  DoctorState build() {
    // Initial fetch on build
    Future.microtask(_loadInitialData);
    return const DoctorState(isLoading: true);
  }

  Future<void> _loadInitialData() async {
    state = state.copyWith(isLoading: true).clearError();

    try {
      final repository = ref.read(doctorRepositoryProvider);
      
      final interested = await repository.getInterestedDoctors();
      final all = await repository.getAllDoctors();

      state = state.copyWith(
        isLoading: false,
        interestedDoctors: interested,
        allDoctors: all,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: 'Failed to load doctors: $e');
    }
  }

  Future<void> searchDoctors(String query) async {
    state = state.copyWith(searchQuery: query, isLoading: true).clearError();

    try {
      final repository = ref.read(doctorRepositoryProvider);
      
      final all = await repository.getAllDoctors(query: query, filters: state.filters);

      state = state.copyWith(
        isLoading: false,
        allDoctors: all,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: 'Search failed: $e');
    }
  }

  Future<void> applyFilters(Map<String, dynamic> filters) async {
    state = state.copyWith(filters: filters, isLoading: true).clearError();

    try {
      final repository = ref.read(doctorRepositoryProvider);
      
      final all = await repository.getAllDoctors(query: state.searchQuery, filters: filters);

      state = state.copyWith(
        isLoading: false,
        allDoctors: all,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: 'Filtering failed: $e');
    }
  }

  Future<void> refresh() async {
    await _loadInitialData();
  }
}
