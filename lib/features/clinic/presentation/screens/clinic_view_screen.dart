import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/app_routes.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../core/widgets/feedback/clinicq_loader.dart';
import '../../../../core/widgets/feedback/clinicq_error_widget.dart';
import '../../../../core/widgets/feedback/skeleton_box.dart';
import '../../../../core/widgets/buttons/bookmark_button.dart';
import '../clinic_providers.dart';
import '../viewmodels/select_doctor_view_model.dart';
import '../widgets/clinic_doctor_card.dart';
import '../../../profile/data/local/interest_local_data_source.dart';

class ClinicViewScreen extends ConsumerWidget {
  final String clinicId;

  const ClinicViewScreen({super.key, required this.clinicId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clinicAsync = ref.watch(clinicDetailsProvider(clinicId));
    final doctorsAsync = ref.watch(clinicDoctorsProvider(clinicId));

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      body: clinicAsync.when(
        loading: () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SkeletonBox(
                width: double.infinity,
                height: 250,
                borderRadius: 0,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SkeletonBox(width: 250, height: 24),
                    const SizedBox(height: 12),
                    const SkeletonBox(width: 150, height: 16),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        3,
                        (index) => const SkeletonBox(width: 90, height: 36),
                      ),
                    ),
                    const SizedBox(height: 28),
                    const SkeletonBox(width: 100, height: 18),
                    const SizedBox(height: 12),
                    const SkeletonBox(width: double.infinity, height: 80),
                  ],
                ),
              ),
            ],
          ),
        ),
        error: (err, stack) => Center(
          child: ClinicQErrorWidget(
            message: err.toString(),
            onRetry: () => ref.refresh(clinicDetailsProvider(clinicId)),
          ),
        ),
        data: (clinic) {
          if (clinic == null) {
            return const Center(child: Text('Clinic not found'));
          }

          return CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                stretch: true,
                backgroundColor: ClinicQColors.appBackground,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    top: 8.0,
                    bottom: 8.0,
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: ClinicQColors.textPrimary,
                        size: 20,
                      ),
                      onPressed: () => context.pop(),
                    ),
                  ),
                ),
                actions: [
                  // Bookmark Button
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: BookmarkButton(
                        entityId: clinicId,
                        entityType: 'clinic',
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 16.0,
                      top: 8.0,
                      bottom: 8.0,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(
                          Icons.share,
                          color: ClinicQColors.textPrimary,
                          size: 20,
                        ),
                        onPressed: () {
                          // TODO: Share logic
                        },
                      ),
                    ),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(24),
                  child: Container(
                    height: 24,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: ClinicQColors.cardBackground,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                    StretchMode.fadeTitle,
                  ],
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: ClinicQColors.secondaryBackground,
                          image:
                              clinic.imageUrl != null &&
                                  clinic.imageUrl!.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(clinic.imageUrl!),
                                  fit: BoxFit.cover,
                                )
                              : const DecorationImage(
                                  image: NetworkImage(
                                    'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?q=80&w=2053&auto=format&fit=crop',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      if (clinic.imageUrl == null || clinic.imageUrl!.isEmpty)
                        const Center(
                          child: Icon(
                            Icons.apartment_rounded,
                            color: ClinicQColors.iconDisabled,
                            size: 64,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    color: ClinicQColors.cardBackground,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              clinic.name,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: ClinicQColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        ClinicQColors.availableBadgeBackground,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    clinic.specialtyTag,
                                    style: const TextStyle(
                                      color: ClinicQColors.availableBadgeText,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Icon(
                                  Icons.circle,
                                  size: 8,
                                  color: clinic.isOpen
                                      ? ClinicQColors.primaryTeal
                                      : Colors.red,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  clinic.isOpen ? 'Open Now' : 'Closed',
                                  style: TextStyle(
                                    color: clinic.isOpen
                                        ? ClinicQColors.primaryTeal
                                        : Colors.red,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: ClinicQColors.starFilled,
                                  size: 20,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  clinic.rating.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: ClinicQColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  'Rating',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: ClinicQColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _buildInfoRow(
                              Icons.location_on_outlined,
                              clinic.address,
                            ),
                            const SizedBox(height: 12),
                            _buildInfoRow(
                              Icons.access_time,
                              clinic.openingHours,
                            ),
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () async {
                                final uri = Uri.parse('tel:${clinic.phone}');
                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(uri);
                                }
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.phone_outlined,
                                    size: 20,
                                    color: ClinicQColors.textSecondary,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    clinic.phone,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: ClinicQColors.textLink,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Stats Row
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildStatTile(clinic.patientCount, 'Patient'),
                            _buildStatTile(
                              clinic.specialistCount,
                              'Specialist',
                            ),
                            _buildStatTile(
                              clinic.yearsExperience,
                              'Experience',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Our Doctors Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Our Doctors',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: ClinicQColors.textPrimary,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.push(
                                  AppRoutes.selectDoctorWithId(
                                    clinicId: clinic.id,
                                  ),
                                );
                              },
                              child: const Text(
                                'View All',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: ClinicQColors.textLink,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Doctors List (Horizontal)
                      SizedBox(
                        height: 260,
                        child: doctorsAsync.when(
                          loading: () => const Center(child: ClinicQLoader()),
                          error: (err, stack) => const Center(
                            child: Text('Failed to load doctors'),
                          ),
                          data: (doctors) {
                            if (doctors.isEmpty) {
                              return const Center(
                                child: Text('No doctors found'),
                              );
                            }
                            return ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemCount: doctors.length,
                              itemBuilder: (context, index) {
                                final doctor = doctors[index];
                                return ClinicDoctorCard(
                                  doctor: doctor,
                                  onBookTap: () {
                                    // TODO: proceed to booking
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: ClinicQColors.textSecondary),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ClinicQColors.textSecondary,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatTile(String value, String label) {
    return Container(
      width: 100, // compact size
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: ClinicQColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: ClinicQColors.cardShadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ClinicQColors.textLink,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: ClinicQColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
