import 'package:clinic_q/features/doctor/presentation/viewmodels/doctor_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../core/widgets/buttons/bookmark_button.dart';
import '../../../../core/widgets/feedback/skeleton_box.dart';
import '../../../../core/widgets/feedback/clinicq_error_widget.dart';
import '../../../ratings/presentation/widgets/review_card.dart';
import '../../domain/entities/doctor_entity.dart';
import '../doctor_providers.dart';
import '../viewmodels/doctor_profile_view_model.dart';
import '../widgets/doctor_hero_card.dart';
import '../widgets/doctor_metrics_grid.dart';
import '../widgets/doctor_schedule_card.dart';
import '../widgets/doctor_booking_bottom_bar.dart';

class DoctorProfileScreen extends ConsumerWidget {
  final String doctorId;

  const DoctorProfileScreen({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(doctorProfileViewModelProvider(doctorId));

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      appBar: AppBar(
        backgroundColor: ClinicQColors.appBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Center(
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: ClinicQColors.cardBorder, width: 1.2),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 16,
                  color: ClinicQColors.textPrimary,
                ),
                onPressed: () => context.pop(),
              ),
            ),
          ),
        ),
        title: const Text(
          'Doctor Details',
          style: TextStyle(
            color: ClinicQColors.textPrimary,
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: ClinicQColors.cardBorder, width: 1.2),
            ),
            alignment: Alignment.center,
            child: BookmarkButton(entityId: doctorId, entityType: 'doctor'),
          ),
        ],
      ),
      body: SafeArea(
        child: profileState.isLoading
            ? _buildSkeletonLoading()
            : profileState.errorMessage != null || profileState.doctor == null
            ? Center(
                child: ClinicQErrorWidget(
                  message: profileState.errorMessage ?? 'Doctor not found.',
                  onRetry: () => ref
                      .read(doctorProfileViewModelProvider(doctorId).notifier)
                      .refresh(),
                ),
              )
            : _buildDoctorDetails(context, profileState.doctor!, profileState),
      ),
      bottomNavigationBar: profileState.doctor != null
          ? DoctorBookingBottomBar(doctor: profileState.doctor!)
          : null,
    );
  }

  Widget _buildDoctorDetails(
    BuildContext context,
    DoctorEntity doctor,
    DoctorProfileState profileState,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Hero Doctor Profile Card
          DoctorHeroCard(doctor: doctor),
          const SizedBox(height: 16),

          // 2. 4 Quick Metric Cards
          DoctorMetricsGrid(doctor: doctor),
          const SizedBox(height: 20),

          // 3. Schedule & Timings Card with Working Days
          DoctorScheduleCard(doctor: doctor),
          const SizedBox(height: 20),

          // 4. About Doctor Section
          const Text(
            'About Doctor',
            style: TextStyle(
              color: ClinicQColors.textPrimary,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: ClinicQColors.cardBorder, width: 1.2),
            ),
            child: Text(
              doctor.about != null && doctor.about!.isNotEmpty
                  ? '${doctor.name} is a qualified ${doctor.specialty} with ${doctor.experience ?? 10} years of clinical experience. Specializing in ${doctor.specialty.toLowerCase()} care and patient management at ${doctor.clinicName}.'
                  : '${doctor.name} is an experienced ${doctor.specialty} providing compassionate care and consultations at ${doctor.clinicName}.',
              style: const TextStyle(
                color: ClinicQColors.textSecondary,
                fontSize: 13.5,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // 5. Patient Reviews Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Patient Reviews',
                style: TextStyle(
                  color: ClinicQColors.textPrimary,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.push('/reviews/$doctorId');
                },
                child: const Text(
                  'See All',
                  style: TextStyle(
                    color: ClinicQColors.primaryTeal,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (profileState.topReviews.isNotEmpty)
            SizedBox(
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: profileState.topReviews.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 280,
                    child: ReviewCard(
                      review: profileState.topReviews[index],
                      maxLines: 2,
                    ),
                  );
                },
              ),
            )
          else
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ClinicQColors.cardBorder),
              ),
              child: const Text(
                'No reviews yet for this doctor.',
                style: TextStyle(
                  color: ClinicQColors.textTertiary,
                  fontSize: 13,
                ),
              ),
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSkeletonLoading() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SkeletonBox(width: 86, height: 86, borderRadius: 20),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SkeletonBox(width: 160, height: 20),
                    SizedBox(height: 8),
                    SkeletonBox(width: 100, height: 14),
                    SizedBox(height: 8),
                    SkeletonBox(width: 80, height: 14),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: const [
              Expanded(
                child: SkeletonBox(
                  width: double.infinity,
                  height: 54,
                  borderRadius: 16,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: SkeletonBox(
                  width: double.infinity,
                  height: 54,
                  borderRadius: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              Expanded(
                child: SkeletonBox(
                  width: double.infinity,
                  height: 54,
                  borderRadius: 16,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: SkeletonBox(
                  width: double.infinity,
                  height: 54,
                  borderRadius: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const SkeletonBox(
            width: double.infinity,
            height: 140,
            borderRadius: 22,
          ),
          const SizedBox(height: 20),
          const SkeletonBox(width: 120, height: 18),
          const SizedBox(height: 10),
          const SkeletonBox(
            width: double.infinity,
            height: 80,
            borderRadius: 18,
          ),
        ],
      ),
    );
  }
}
