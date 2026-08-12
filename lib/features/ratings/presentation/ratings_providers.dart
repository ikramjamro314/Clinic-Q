import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/ratings_repository_impl.dart';
import '../domain/repositories/ratings_repository.dart';
import 'viewmodels/reviews_state.dart';
import 'viewmodels/reviews_view_model.dart';

final ratingsRepositoryProvider = Provider<RatingsRepository>((ref) {
  return RatingsRepositoryImpl();
});

final reviewsViewModelProvider =
    NotifierProvider.family<ReviewsViewModel, ReviewsState, String>(
      ReviewsViewModel.new,
    );
