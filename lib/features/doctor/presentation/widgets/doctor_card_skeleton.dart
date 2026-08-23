import 'package:flutter/material.dart';
import '../../../../core/widgets/feedback/skeleton_box.dart';
import '../../../../core/theme/clinic_q_colors.dart';

class AllDoctorCardSkeleton extends StatelessWidget {
  const AllDoctorCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ClinicQColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ClinicQColors.cardBorder, width: 1),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Photo placeholder
          SkeletonBox(width: 80, height: 80, borderRadius: 12),
          SizedBox(width: 16),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonBox(width: 150, height: 16),
                SizedBox(height: 6),
                SkeletonBox(width: 100, height: 12),
                SizedBox(height: 8),
                Row(
                  children: [
                    SkeletonBox(width: 40, height: 12),
                    SizedBox(width: 16),
                    SkeletonBox(width: 80, height: 12),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeDoctorCardSkeleton extends StatelessWidget {
  const HomeDoctorCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
        color: ClinicQColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ClinicQColors.cardBorder, width: 1),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonBox(width: double.infinity, height: 85, borderRadius: 16),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonBox(width: 100, height: 12),
                SizedBox(height: 6),
                SkeletonBox(width: 70, height: 10),
                SizedBox(height: 12),
                SkeletonBox(width: 40, height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
