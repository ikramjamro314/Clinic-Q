import 'package:clinic_q/features/clinic/presentation/widgets/clinic_card_skeleton.dart';
import 'package:clinic_q/features/doctor/presentation/widgets/doctor_card_skeleton.dart';
import 'package:clinic_q/features/home/presentation/widgets/home_section_header.dart';
import 'package:clinic_q/features/tracking/presentation/screens/tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../core/widgets/feedback/clinicq_loader.dart';
import '../../../../core/widgets/feedback/clinicq_error_widget.dart';
import '../home_providers.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_header.dart';
import '../widgets/home_banner.dart';
import '../widgets/home_active_token_banner.dart';
import '../widgets/home_quick_actions.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/app_routes.dart';
import '../widgets/home_doctor_card.dart';
import '../widgets/home_clinic_card.dart';
import '../widgets/home_bottom_nav_bar.dart';

import '../../../../core/widgets/feedback/offline_banner.dart';

import '../../../../core/widgets/feedback/skeleton_box.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);
    final homeNotifier = ref.read(homeViewModelProvider.notifier);
    final activeToken = ref.watch(activeTokenLookupProvider).value;

    if (homeState.isLoading && homeState.bannerData == null) {
      return Scaffold(
        backgroundColor: ClinicQColors.appBackground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 12.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SkeletonBox(width: 60, height: 12),
                          const SizedBox(height: 6),
                          const SkeletonBox(width: 140, height: 20),
                        ],
                      ),
                      const SkeletonBox(
                        width: 40,
                        height: 40,
                        borderRadius: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const SkeletonBox(
                    width: double.infinity,
                    height: 150,
                    borderRadius: 16,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      4,
                      (index) => const SkeletonBox(
                        width: 70,
                        height: 75,
                        borderRadius: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const SkeletonBox(width: 110, height: 18),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 170,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 14),
                      itemBuilder: (context, index) =>
                          const HomeDoctorCardSkeleton(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const SkeletonBox(width: 110, height: 18),
                  const SizedBox(height: 14),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) => const ClinicCardSkeleton(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (homeState.errorMessage != null && homeState.bannerData == null) {
      return Scaffold(
        backgroundColor: ClinicQColors.appBackground,
        body: Center(
          child: ClinicQErrorWidget(
            message: homeState.errorMessage!,
            onRetry: () => homeNotifier.refresh(),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      // Fixed sticky App Bar at top of Home Screen
      appBar: HomeAppBar(
        userName: homeState.userName,
        onNotificationTap: () {},
        onProfileTap: () {
          context.go(AppRoutes.profile);
        },
      ),
      body: Column(
        children: [
          if (homeState.isFromCache)
            OfflineBanner(message: homeState.errorMessage),
          Expanded(
            child: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(activeTokenLookupProvider);
                  homeNotifier.refresh();
                },
                color: ClinicQColors.primaryTeal,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 12.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User greeting section
                      HomeHeader(userName: homeState.userName),

                      const SizedBox(height: 20),

                      // Doctor Consultation or Active Tracking Banner
                      if (activeToken != null)
                        HomeActiveTokenBanner(
                          token: activeToken,
                          onTap: () =>
                              context.push('/tracking/${activeToken.id}'),
                        )
                      else if (homeState.bannerData != null)
                        HomeBanner(bannerData: homeState.bannerData!),

                      const SizedBox(height: 20),

                      // Quick action layout (Clinics/Doctors navigation tiles)
                      HomeQuickActions(
                        onFindClinicTap: () => context.push(AppRoutes.clinics),
                        onMyRecordsTap: () =>
                            context.push(AppRoutes.appointmentHistory),
                        onSupportTap: () =>
                            context.push(AppRoutes.profileTermsAndPolicy),
                      ),

                      const SizedBox(height: 24),

                      // Top Doctor list section header
                      HomeSectionHeader(
                        title: 'Top Doctor',
                        onActionTap: () => context.go(AppRoutes.doctors),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 170,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: homeState.doctors.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 14),
                          itemBuilder: (context, index) {
                            final doc = homeState.doctors[index];
                            return HomeDoctorCard(
                              doctor: doc,
                              onTap: () {
                                context.push('/doctors/${doc.id}');
                              },
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Top Hospitals/Clinics list section header
                      HomeSectionHeader(
                        title: 'Top Clinics',
                        onActionTap: () => context.go(AppRoutes.clinics),
                      ),
                      const SizedBox(height: 14),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: homeState.clinics.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final clinic = homeState.clinics[index];
                          return HomeClinicCard(
                            clinic: clinic,
                            onTap: () {
                              context.push('${AppRoutes.clinics}/${clinic.id}');
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // Pixel-matched Bottom Navigation Bar
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: homeState.selectedNavIndex,
        onTap: (index) {
          if (index == 0) {
            context.go(AppRoutes.clinics);
          } else if (index == 1) {
            context.go(AppRoutes.doctors);
          } else if (index == 2) {
            context.go(AppRoutes.home);
          } else if (index == 3) {
            final activeToken = ref.read(activeTokenLookupProvider).value;
            context.go('/tracking/${activeToken?.id ?? "none"}');
          } else if (index == 4) {
            context.go(AppRoutes.profile);
          } else {
            homeNotifier.selectTab(index);
          }
        },
      ),
    );
  }
}
