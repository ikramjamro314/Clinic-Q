import 'package:clinic_q/features/doctor/presentation/doctor_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/clinic_q_colors.dart';
import '../../../../core/widgets/buttons/clinicq_button.dart';
import '../../../ratings/presentation/widgets/review_card.dart';
import '../viewmodels/doctor_profile_view_model.dart';
import '../widgets/doctor_profile_header.dart';

class DoctorProfileScreen extends ConsumerWidget {
  final String doctorId;

  const DoctorProfileScreen({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(doctorProfileViewModelProvider(doctorId));
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: ClinicQColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: ClinicQColors.secondaryBackground,
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
            child: IconButton(
              icon: const Icon(
                Icons.bookmark_border,
                color: ClinicQColors.textPrimary,
              ),
              onPressed: () {
                // TODO: Handle bookmarking
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: profileState.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: ClinicQColors.primaryTeal,
                ),
              )
            : profileState.errorMessage != null || profileState.doctor == null
            ? Center(
                child: Text(profileState.errorMessage ?? 'Doctor not found.'),
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
                        // TODO: Navigate to booking flow
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
