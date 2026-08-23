import '../../domain/entities/tracking_snapshot.dart';

class TrackingState {
  final TrackingSnapshot? snapshot;
  final bool isLoading;
  final String? errorMessage;
  final bool isFromCache;
  final bool isStale;

  const TrackingState({
    this.snapshot,
    this.isLoading = false,
    this.errorMessage,
    this.isFromCache = false,
    this.isStale = false,
  });

  TrackingState copyWith({
    TrackingSnapshot? snapshot,
    bool? isLoading,
    String? errorMessage,
    bool? isFromCache,
    bool? isStale,
  }) {
    return TrackingState(
      snapshot: snapshot ?? this.snapshot,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isFromCache: isFromCache ?? this.isFromCache,
      isStale: isStale ?? this.isStale,
    );
  }
}
