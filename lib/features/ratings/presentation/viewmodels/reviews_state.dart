import 'package:flutter/foundation.dart';
import '../../domain/entities/review_entity.dart';

@immutable
class ReviewsState {
  final bool isLoading;
  final String? errorMessage;
  final List<ReviewEntity> reviews;

  const ReviewsState({
    this.isLoading = false,
    this.errorMessage,
    this.reviews = const [],
  });

  ReviewsState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<ReviewEntity>? reviews,
  }) {
    return ReviewsState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      reviews: reviews ?? this.reviews,
    );
  }

  ReviewsState clearError() {
    return ReviewsState(
      isLoading: isLoading,
      errorMessage: null,
      reviews: reviews,
    );
  }
}
