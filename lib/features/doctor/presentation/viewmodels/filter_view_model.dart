import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../doctor_providers.dart';
import 'filter_state.dart';

class FilterViewModel extends Notifier<FilterState> {
  @override
  FilterState build() {
    Future.microtask(_loadSpecialtiesAndSync);
    return const FilterState(isLoading: true);
  }

  Future<void> _loadSpecialtiesAndSync() async {
    state = state.copyWith(isLoading: true).clearError();
    try {
      final repository = ref.read(doctorRepositoryProvider);
      final specialties = await repository.getSpecialties();

      // Read active filters from doctorViewModelProvider
      final activeFilters = ref.read(doctorViewModelProvider).filters;
      final activeNames =
          (activeFilters['specialties'] as List<String>?) ??
          (activeFilters['specialization'] != null
              ? [activeFilters['specialization'] as String]
              : <String>[]);

      final initialSelectedIds = <String>{};
      for (final spec in specialties) {
        if (activeNames.any(
          (n) => n.toLowerCase() == spec.name.toLowerCase(),
        )) {
          initialSelectedIds.add(spec.id);
        }
      }

      state = state.copyWith(
        isLoading: false,
        specialties: specialties,
        selectedSpecialtyIds: initialSelectedIds,
      );
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
