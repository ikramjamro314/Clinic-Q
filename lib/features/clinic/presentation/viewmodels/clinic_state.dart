import 'package:flutter/foundation.dart';
import '../../domain/entities/clinic_entity.dart';

@immutable
class ClinicState {
  final bool isLoading;
  final String? errorMessage;
  final List<ClinicEntity> clinics;
  final String searchQuery;

  const ClinicState({
    this.isLoading = false,
    this.errorMessage,
    this.clinics = const [],
    this.searchQuery = '',
  });

  ClinicState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<ClinicEntity>? clinics,
    String? searchQuery,
  }) {
    return ClinicState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      clinics: clinics ?? this.clinics,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  ClinicState clearError() {
    return ClinicState(
      isLoading: isLoading,
      errorMessage: null,
      clinics: clinics,
      searchQuery: searchQuery,
    );
  }
}
