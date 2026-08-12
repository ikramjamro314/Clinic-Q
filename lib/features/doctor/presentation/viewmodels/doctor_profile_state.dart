import 'package:flutter/foundation.dart';
import '../../domain/entities/doctor_entity.dart';
import '../../../ratings/domain/entities/review_entity.dart';

@immutable
class DoctorProfileState {
  final bool isLoading;
  final String? errorMessage;
  final DoctorEntity? doctor;
  final List<ReviewEntity> topReviews;

  const DoctorProfileState({
    this.isLoading = false,
    this.errorMessage,
    this.doctor,
    this.topReviews = const [],
  });

  DoctorProfileState copyWith({
    bool? isLoading,
    String? errorMessage,
    DoctorEntity? doctor,
    List<ReviewEntity>? topReviews,
  }) {
    return DoctorProfileState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      doctor: doctor ?? this.doctor,
      topReviews: topReviews ?? this.topReviews,
    );
  }

  DoctorProfileState clearError() {
    return DoctorProfileState(
      isLoading: isLoading,
      errorMessage: null,
      doctor: doctor,
      topReviews: topReviews,
    );
  }
}
