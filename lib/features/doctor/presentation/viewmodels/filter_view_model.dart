import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../doctor_providers.dart';
import 'filter_state.dart';

class FilterViewModel extends Notifier<FilterState> {
  @override
  FilterState build() {
    Future.microtask(_loadSpecialties);
    return const FilterState(isLoading: true);
  }

  Future<void> _loadSpecialties() async {
    state = state.copyWith(isLoading: true).clearError();
    try {
      final repository = ref.read(doctorRepositoryProvider);
      final specialties = await repository.getSpecialties();
      state = state.copyWith(isLoading: false, specialties: specialties);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load specialties: $e',
      );
    }
  }

  void toggleSpecialty(String id) {
    final updatedSet = Set<String>.from(state.selectedSpecialtyIds);
    if (updatedSet.contains(id)) {
      updatedSet.remove(id);
    } else {
      updatedSet.add(id);
    }
    state = state.copyWith(selectedSpecialtyIds: updatedSet);
  }

  void clearFilters() {
    state = state.copyWith(selectedSpecialtyIds: const {});
  }
}
