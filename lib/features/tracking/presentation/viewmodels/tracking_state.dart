import '../../domain/entities/tracking_snapshot.dart';

class TrackingState {
  final TrackingSnapshot? snapshot;
  final bool isLoading;
  final String? errorMessage;
  final bool isFromCache;
  final bool isStale;
  final int feedbackRating;
  final String feedbackText;
  final bool isFeedbackSubmitting;
  final bool isFeedbackSubmitted;

  const TrackingState({
    this.snapshot,
    this.isLoading = false,
    this.errorMessage,
    this.isFromCache = false,
    this.isStale = false,
    this.feedbackRating = 5,
    this.feedbackText = '',
    this.isFeedbackSubmitting = false,
    this.isFeedbackSubmitted = false,
  });

  TrackingState copyWith({
    TrackingSnapshot? snapshot,
    bool? isLoading,
    String? errorMessage,
    bool? isFromCache,
    bool? isStale,
    int? feedbackRating,
    String? feedbackText,
    bool? isFeedbackSubmitting,
    bool? isFeedbackSubmitted,
  }) {
    return TrackingState(
      snapshot: snapshot ?? this.snapshot,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isFromCache: isFromCache ?? this.isFromCache,
      isStale: isStale ?? this.isStale,
      feedbackRating: feedbackRating ?? this.feedbackRating,
      feedbackText: feedbackText ?? this.feedbackText,
      isFeedbackSubmitting: isFeedbackSubmitting ?? this.isFeedbackSubmitting,
      isFeedbackSubmitted: isFeedbackSubmitted ?? this.isFeedbackSubmitted,
    );
  }
}
