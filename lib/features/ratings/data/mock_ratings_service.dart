import 'package:flutter/material.dart';

import '../domain/entities/review_entity.dart';

class MockRatingsService {
  /// TODO: replace with ratings feature's actual service call
  /// Fetches reviews for a given entity (like a doctor)
  static Future<List<ReviewEntity>> getReviewsFor({
    required String doctorId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      const ReviewEntity(
        id: 'r1',
        reviewerName: 'John Corner',
        reviewerPhotoUrl: 'https://i.pravatar.cc/150?u=j',
        rating: 4.5,
        timeAgo: '1 day ago',
        text: 'Many thanks to Dr. Hashimoto! He is professional, competent doctor. The doctor has strengths in examining and treating Parkinson\'s and neurological diseases related to movement disorders such as mouth distortion, eyelid twitching, listing, hemiplegia...',
      ),
      const ReviewEntity(
        id: 'r2',
        reviewerName: 'Elsa Christina',
        reviewerPhotoUrl: 'https://i.pravatar.cc/150?u=e',
        rating: 4.5,
        timeAgo: '2 day ago',
        text: 'Dr. Hashimoto is the best. He really cares about his patients.',
      ),
      const ReviewEntity(
        id: 'r3',
        reviewerName: 'Kim Angel',
        reviewerPhotoUrl: 'https://i.pravatar.cc/150?u=k',
        rating: 4.5,
        timeAgo: '5 day ago',
        text: 'Dr. Hashimoto is a good doctor, I suffer from chronic headaches, and after being treated by him I feel much better, thank you very much!',
      ),
    ];
  }
}
