import 'package:flutter/material.dart';
import '../../../../core/widgets/feedback/skeleton_box.dart';
import '../../../../app/theme/clinic_q_colors.dart';

class ClinicCardSkeleton extends StatelessWidget {
  const ClinicCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: ClinicQColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ClinicQColors.cardBorder, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Image placeholder
          const SkeletonBox(
            width: double.infinity,
            height: 140,
            borderRadius: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const SkeletonBox(width: 200, height: 18),
                const SizedBox(height: 12),
                // Rating and tags
                const Row(
                  children: [
                    SkeletonBox(width: 50, height: 12),
                    SizedBox(width: 12),
                    SkeletonBox(width: 80, height: 12),
                  ],
                ),
                const SizedBox(height: 16),
                // Location info
                const Row(
                  children: [
                    SkeletonBox(width: 16, height: 16, borderRadius: 8),
                    SizedBox(width: 8),
                    SkeletonBox(width: 150, height: 12),
                  ],
                ),
                const SizedBox(height: 16),
                // Stats row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    3,
                    (index) => const SkeletonBox(width: 70, height: 28),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
