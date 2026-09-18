import 'package:clinic_q/app/theme/clinic_q_colors.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/review_entity.dart';

class ReviewCard extends StatelessWidget {
  final ReviewEntity review;
  final int? maxLines;

  const ReviewCard({super.key, required this.review, this.maxLines});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ClinicQColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: ClinicQColors.cardShadow,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 48,
                  height: 48,
                  color: ClinicQColors.dividerLight,
                  child: const Icon(
                    Icons.person,
                    color: ClinicQColors.iconSecondary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          review.reviewerName,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: ClinicQColors.starFilled,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              review.rating.toString(),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: ClinicQColors.textSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      review.timeAgo,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: ClinicQColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review.text,
            maxLines: maxLines,
            overflow: maxLines != null ? TextOverflow.ellipsis : null,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: ClinicQColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
