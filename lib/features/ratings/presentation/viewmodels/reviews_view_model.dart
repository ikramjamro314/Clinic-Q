import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../ratings_providers.dart';
import 'reviews_state.dart';

class ReviewsViewModel extends Notifier<ReviewsState> {
  ReviewsViewModel(this.doctorId);

  final String doctorId;

  @override
  ReviewsState build() {
    Future.microtask(_loadReviews);
    return const ReviewsState(isLoading: true);
  }

  Future<void> _loadReviews() async {
    state = state.copyWith(isLoading: true).clearError();
    try {
      final repository = ref.read(ratingsRepositoryProvider);
      final reviews = await repository.getReviewsFor(doctorId: doctorId);

      state = state.copyWith(
        isLoading: false,
        reviews: reviews,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load reviews: $e',
      );
    }
  }
}
