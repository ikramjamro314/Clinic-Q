import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:clinic_q/features/ratings/domain/entities/review_entity.dart';
import 'package:clinic_q/features/ratings/domain/repositories/ratings_repository.dart';

class RatingsRepositoryImpl implements RatingsRepository {
  final Dio _dio;

  RatingsRepositoryImpl(this._dio);

  @override
  Future<List<ReviewEntity>> getReviewsFor({
    required String doctorId,
  }) async {
    try {
      final response = await _dio.get('/api/patient/doctors/$doctorId/ratings');
      final rawData = response.data;
      debugPrint('[Ratings] RAW getReviewsFor response: $rawData');

      var reviewsListRaw = rawData;
      if (rawData is Map<String, dynamic>) {
        final data = rawData['data'] ?? rawData;
        if (data is Map<String, dynamic>) {
          reviewsListRaw = data['reviews'] ?? data['ratings'] ?? [];
        } else if (data is List) {
          reviewsListRaw = data;
        }
      }

      final List<ReviewEntity> reviews = [];
      if (reviewsListRaw is List) {
        for (final item in reviewsListRaw) {
          if (item is Map<String, dynamic>) {
            reviews.add(_fromBackendJson(item));
          }
        }
      }
      return reviews;
    } catch (e) {
      debugPrint('[Ratings] getReviewsFor failed: $e');
      return [];
    }
  }

  @override
  Future<void> submitFeedback({
    required String doctorId,
    required String clinicId,
    required int stars,
    required String review,
    required String userId,
  }) async {
    try {
      final response = await _dio.post(
        '/api/patient/ratings',
        data: {
          'doctorId': doctorId,
          'clinicId': clinicId,
          'stars': stars,
          'review': review,
          'userId': userId,
        },
      );
      debugPrint('[Ratings] submitFeedback response: ${response.data}');
    } catch (e) {
      debugPrint('[Ratings] submitFeedback failed: $e');
      rethrow;
    }
  }

  ReviewEntity _fromBackendJson(Map<String, dynamic> json) {
    final stars = json['stars'] as num? ?? json['rating'] as num? ?? 5.0;
    final patient = json['patient'] as Map<String, dynamic>?;
    final patientName = patient != null ? (patient['name'] as String?) : null;

    return ReviewEntity(
      id: json['id'] as String? ?? '',
      reviewerName: patientName ?? json['patientName'] as String? ?? json['reviewerName'] as String? ?? 'Anonymous Patient',
      reviewerPhotoUrl: patient != null ? (patient['photoUrl'] as String? ?? patient['photo_url'] as String?) : null,
      rating: stars.toDouble(),
      timeAgo: _formatTimeAgo(json['createdAt'] as String? ?? json['created_at'] as String?),
      text: json['review'] as String? ?? json['text'] as String? ?? '',
    );
  }

  String _formatTimeAgo(String? dateStr) {
    if (dateStr == null) return 'Recent';
    try {
      final dt = DateTime.parse(dateStr).toLocal();
      final diff = DateTime.now().difference(dt);
      if (diff.inDays > 365) return '${(diff.inDays / 365).floor()}y ago';
      if (diff.inDays > 30) return '${(diff.inDays / 30).floor()}mo ago';
      if (diff.inDays > 0) return '${diff.inDays}d ago';
      if (diff.inHours > 0) return '${diff.inHours}h ago';
      if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
      return 'Just now';
    } catch (_) {
      return 'Recent';
    }
  }
}
