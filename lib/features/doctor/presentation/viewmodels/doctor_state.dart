import 'package:flutter/foundation.dart';
import '../../domain/entities/doctor_entity.dart';

@immutable
class DoctorState {
  final bool isLoading;
  final String? errorMessage;
  final List<DoctorEntity> interestedDoctors;
  final List<DoctorEntity> allDoctors;
  final String searchQuery;
  final Map<String, dynamic> filters;

  const DoctorState({
    this.isLoading = false,
    this.errorMessage,
    this.interestedDoctors = const [],
    this.allDoctors = const [],
    this.searchQuery = '',
    this.filters = const {},
  });

  DoctorState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<DoctorEntity>? interestedDoctors,
    List<DoctorEntity>? allDoctors,
    String? searchQuery,
    Map<String, dynamic>? filters,
  }) {
    return DoctorState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      interestedDoctors: interestedDoctors ?? this.interestedDoctors,
      allDoctors: allDoctors ?? this.allDoctors,
      searchQuery: searchQuery ?? this.searchQuery,
      filters: filters ?? this.filters,
    );
  }
  
  DoctorState clearError() {
    return DoctorState(
      isLoading: isLoading,
      errorMessage: null,
      interestedDoctors: interestedDoctors,
      allDoctors: allDoctors,
      searchQuery: searchQuery,
      filters: filters,
    );
  }
}
