import 'package:clinic_q/features/ratings/domain/entities/review_entity.dart';

abstract class RatingsRepository {
  Future<List<ReviewEntity>> getReviewsFor({
    required String doctorId,
  });
}
