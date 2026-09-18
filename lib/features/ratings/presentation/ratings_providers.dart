import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/ratings_repository_impl.dart';
import '../domain/repositories/ratings_repository.dart';
import 'viewmodels/reviews_state.dart';
import 'viewmodels/reviews_view_model.dart';

import '../../../../core/network/dio_client.dart';

final ratingsRepositoryProvider = Provider<RatingsRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return RatingsRepositoryImpl(dio);
});

final reviewsViewModelProvider =
    NotifierProvider.family<ReviewsViewModel, ReviewsState, String>(
      ReviewsViewModel.new,
    );
