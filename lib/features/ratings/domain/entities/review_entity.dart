class ReviewEntity {
  final String id;
  final String reviewerName;
  final String? reviewerPhotoUrl;
  final double rating;
  final String timeAgo;
  final String text;

  const ReviewEntity({
    required this.id,
    required this.reviewerName,
    this.reviewerPhotoUrl,
    required this.rating,
    required this.timeAgo,
    required this.text,
  });
}
