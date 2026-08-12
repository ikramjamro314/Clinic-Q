import 'package:clinic_q/features/home/presentation/widgets/home_section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/clinic_q_colors.dart';
import '../../../../core/widgets/feedback/clinicq_loader.dart';
import '../../../../core/widgets/feedback/clinicq_error_widget.dart';
import '../home_providers.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_header.dart';
import '../widgets/home_banner.dart';
import '../widgets/home_quick_actions.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/app_routes.dart';
import '../widgets/home_doctor_card.dart';
import '../widgets/home_clinic_card.dart';
import '../widgets/home_bottom_nav_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);
    final homeNotifier = ref.read(homeViewModelProvider.notifier);

    if (homeState.isLoading && homeState.bannerData == null) {
      return const Scaffold(
        backgroundColor: ClinicQColors.appBackground,
        body: Center(child: ClinicQLoader()),
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
        onProfileTap: () {},
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => homeNotifier.refresh(),
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

                // Top promo / appointment banner card
                HomeBanner(
                  bannerData: homeState.bannerData,
                  onTap: () {
                    context.go(AppRoutes.doctors);
                  },
                ),

                const SizedBox(height: 24),

                // Row of 4 quick action buttons
                HomeQuickActions(
                  onBookApptTap: () {},
                  onMyRecordsTap: () {},
                  onFindClinicTap: () {},
                  onSupportTap: () {},
                ),

                const SizedBox(height: 28),

                // Interested Doctors section
                HomeSectionHeader(
                  title: 'Interested Doctors',
                  onActionTap: () {
                    context.go(AppRoutes.doctors);
                  },
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 165,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: homeState.doctors.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final doctor = homeState.doctors[index];
                      return HomeDoctorCard(
                        doctor: doctor,
                        onTap: () {
                          context.push('/doctors/${doctor.id}');
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 28),

                // Top Hospitals / Clinics section
                HomeSectionHeader(title: 'Top Clinics', onActionTap: () {
                  context.go(AppRoutes.clinics);
                }),
                const SizedBox(height: 14),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: homeState.clinics.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final clinic = homeState.clinics[index];
                    return HomeClinicCard(clinic: clinic, onTap: () {});
                  },
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),

      // Pixel-matched Bottom Navigation Bar
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: homeState.selectedNavIndex,
        onTap: (index) {
          if (index == 0) {
            context.go(AppRoutes.clinics);
          } else if (index == 1) {
            context.go(AppRoutes.doctors);
          } else {
            homeNotifier.selectTab(index);
          }
        },
      ),
    );
  }
}
