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
  final bool isFromCache;

  const DoctorState({
    this.isLoading = false,
    this.errorMessage,
    this.interestedDoctors = const [],
    this.allDoctors = const [],
    this.searchQuery = '',
    this.filters = const {},
    this.isFromCache = false,
  });

  DoctorState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<DoctorEntity>? interestedDoctors,
    List<DoctorEntity>? allDoctors,
    String? searchQuery,
    Map<String, dynamic>? filters,
    bool? isFromCache,
  }) {
    return DoctorState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      interestedDoctors: interestedDoctors ?? this.interestedDoctors,
      allDoctors: allDoctors ?? this.allDoctors,
      searchQuery: searchQuery ?? this.searchQuery,
      filters: filters ?? this.filters,
      isFromCache: isFromCache ?? this.isFromCache,
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
      isFromCache: isFromCache,
    );
  }
}
