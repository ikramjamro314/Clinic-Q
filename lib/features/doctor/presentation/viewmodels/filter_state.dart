import 'package:flutter/foundation.dart';
import '../../domain/entities/specialty_entity.dart';

@immutable
class FilterState {
  final bool isLoading;
  final String? errorMessage;
  final List<SpecialtyEntity> specialties;
  final Set<String> selectedSpecialtyIds;

  const FilterState({
    this.isLoading = false,
    this.errorMessage,
    this.specialties = const [],
    this.selectedSpecialtyIds = const {},
  });

  FilterState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<SpecialtyEntity>? specialties,
    Set<String>? selectedSpecialtyIds,
  }) {
    return FilterState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      specialties: specialties ?? this.specialties,
      selectedSpecialtyIds: selectedSpecialtyIds ?? this.selectedSpecialtyIds,
    );
  }

  FilterState clearError() {
    return FilterState(
      isLoading: isLoading,
      errorMessage: null,
      specialties: specialties,
      selectedSpecialtyIds: selectedSpecialtyIds,
    );
  }
}
