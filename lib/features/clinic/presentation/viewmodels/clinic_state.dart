import 'package:flutter/foundation.dart';
import '../../domain/entities/clinic_entity.dart';

@immutable
class ClinicState {
  final bool isLoading;
  final String? errorMessage;
  final List<ClinicEntity> clinics;
  final String searchQuery;
  final String? city;
  final String? specialty;
  final bool isFromCache;

  const ClinicState({
    this.isLoading = false,
    this.errorMessage,
    this.clinics = const [],
    this.searchQuery = '',
    this.city,
    this.specialty,
    this.isFromCache = false,
  });

  ClinicState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<ClinicEntity>? clinics,
    String? searchQuery,
    String? city,
    String? specialty,
    bool? isFromCache,
  }) {
    return ClinicState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      clinics: clinics ?? this.clinics,
      searchQuery: searchQuery ?? this.searchQuery,
      city: city ?? this.city,
      specialty: specialty ?? this.specialty,
      isFromCache: isFromCache ?? this.isFromCache,
    );
  }

  ClinicState clearError() {
    return ClinicState(
      isLoading: isLoading,
      errorMessage: null,
      clinics: clinics,
      searchQuery: searchQuery,
      city: city,
      specialty: specialty,
      isFromCache: isFromCache,
    );
  }
}
