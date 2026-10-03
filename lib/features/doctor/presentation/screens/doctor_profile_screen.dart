import 'package:clinic_q/features/doctor/presentation/doctor_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../core/widgets/buttons/clinicq_button.dart';
import '../../../../core/widgets/buttons/bookmark_button.dart';
import '../../../../core/widgets/feedback/skeleton_box.dart';
import '../../../../core/widgets/feedback/clinicq_error_widget.dart';
import '../../../ratings/presentation/widgets/review_card.dart';
import '../viewmodels/doctor_profile_view_model.dart';
import '../widgets/doctor_profile_header.dart';
import '../../../profile/data/local/interest_local_data_source.dart';

class DoctorProfileScreen extends ConsumerWidget {
  final String doctorId;

  const DoctorProfileScreen({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(doctorProfileViewModelProvider(doctorId));
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      appBar: AppBar(
        backgroundColor: ClinicQColors.appBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ClinicQColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: BookmarkButton(entityId: doctorId, entityType: 'doctor'),
          ),
        ],
      ),
      body: SafeArea(
        child: profileState.isLoading
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SkeletonBox(
                          width: 90,
                          height: 90,
                          borderRadius: 45,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SkeletonBox(width: 160, height: 18),
                              const SizedBox(height: 8),
                              const SkeletonBox(width: 120, height: 12),
                              const SizedBox(height: 8),
                              const SkeletonBox(width: 80, height: 12),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    const SkeletonBox(width: 100, height: 16),
                    const SizedBox(height: 12),
                    const SkeletonBox(width: double.infinity, height: 100),
                    const SizedBox(height: 32),
                    const SkeletonBox(width: 120, height: 16),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        3,
                        (index) => const SkeletonBox(width: 90, height: 40),
                      ),
                    ),
                  ],
                ),
              )
            : profileState.errorMessage != null || profileState.doctor == null
            ? Center(
                child: ClinicQErrorWidget(
                  message: profileState.errorMessage ?? 'Doctor not found.',
                  onRetry: () =>
                      ref.read(doctorProfileViewModelProvider(doctorId).notifier).refresh(),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 12.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DoctorProfileHeader(doctor: profileState.doctor!),
                          const SizedBox(height: 24),
                          Text(
                            'About',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ClinicQColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                profileState.doctor!.about ??
                                    'No additional information available.',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: ClinicQColors.textSecondary,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Reviews',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: ClinicQColors.textPrimary,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.push('/reviews/$doctorId');
                                },
                                child: Text(
                                  'See All',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: ClinicQColors.primaryBlue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (profileState.topReviews.isNotEmpty)
                            SizedBox(
                              height: 160,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: profileState.topReviews.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 16),
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    width: 300,
                                    child: ReviewCard(
                                      review: profileState.topReviews[index],
                                      maxLines: 2,
                                    ),
                                  );
                                },
                              ),
                            )
                          else
                            const Text('No reviews yet.'),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: ClinicQButton(
                      label: 'Book an appointment',
                      gradient: ClinicQColors.gradientPrimary,
                      onPressed: () {
                        final clinicId = profileState.doctor?.clinicId ?? '';
                        context.push(
                          '/booking/confirm?doctorId=$doctorId&clinicId=$clinicId',
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
