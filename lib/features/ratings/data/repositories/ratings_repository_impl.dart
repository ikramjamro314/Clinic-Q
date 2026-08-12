import 'package:clinic_q/features/ratings/data/mock_ratings_service.dart';
import 'package:clinic_q/features/ratings/domain/entities/review_entity.dart';
import 'package:clinic_q/features/ratings/domain/repositories/ratings_repository.dart';

class RatingsRepositoryImpl implements RatingsRepository {
  @override
  Future<List<ReviewEntity>> getReviewsFor({
    required String doctorId,
  }) async {
    return await MockRatingsService.getReviewsFor(
      doctorId: doctorId,
    );
  }
}
