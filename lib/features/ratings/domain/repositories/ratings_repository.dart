import 'package:clinic_q/features/ratings/domain/entities/review_entity.dart';

abstract class RatingsRepository {
  Future<List<ReviewEntity>> getReviewsFor({
    required String doctorId,
  });

  Future<void> submitFeedback({
    required String doctorId,
    required String clinicId,
    required int stars,
    required String review,
    required String userId,
  });
}
