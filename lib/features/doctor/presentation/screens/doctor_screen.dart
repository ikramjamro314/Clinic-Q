import 'package:clinic_q/features/doctor/presentation/widgets/all_doctor_card.dart';
import 'package:clinic_q/features/doctor/presentation/widgets/doctor_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../core/theme/clinic_q_colors.dart';
import '../../../../core/widgets/inputs/clinicq_text_field.dart';
import '../../../../core/widgets/feedback/clinicq_loader.dart';
import '../../../../core/widgets/feedback/clinicq_error_widget.dart';
import '../../../home/presentation/widgets/home_bottom_nav_bar.dart';
import '../../../home/presentation/widgets/home_doctor_card.dart';
import '../../../home/presentation/widgets/home_section_header.dart';
import '../../../home/presentation/viewmodels/home_state.dart';
import '../doctor_providers.dart';

class DoctorScreen extends ConsumerStatefulWidget {
  const DoctorScreen({super.key});

  @override
  ConsumerState<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends ConsumerState<DoctorScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final doctorState = ref.watch(doctorViewModelProvider);
    final doctorNotifier = ref.read(doctorViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      appBar: AppBar(
        backgroundColor: ClinicQColors.appBackground,
        elevation: 0,
        automaticallyImplyLeading: false, // No back button
        title: const Text(
          'Find doctors',
          style: TextStyle(
            color: ClinicQColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ClinicQColors.dividerMedium),
              ),
              child: const Icon(
                Icons.tune_rounded,
                color: ClinicQColors.textPrimary,
                size: 20,
              ),
            ),
            onPressed: () {
              context.push(AppRoutes.doctorFilter);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: doctorState.isLoading && doctorState.allDoctors.isEmpty
          ? const Center(child: ClinicQLoader())
          : doctorState.errorMessage != null && doctorState.allDoctors.isEmpty
          ? Center(
              child: ClinicQErrorWidget(
                message: doctorState.errorMessage!,
                onRetry: () => doctorNotifier.refresh(),
              ),
            )
          : SafeArea(
              child: RefreshIndicator(
                onRefresh: () async => doctorNotifier.refresh(),
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
                      // Search field
                      ClinicQTextField(
                        controller: _searchController,
                        hintText: 'Search',
                        prefixIcon: Icons.search_rounded,
                        isPill: false,
                        borderRadius: 16,
                        fillColor: Colors.white,
                        onSuffixIconPressed: () {
                          _searchController.clear();
                          doctorNotifier.searchDoctors('');
                        },
                        suffixIcon: _searchController.text.isNotEmpty
                            ? Icons.close_rounded
                            : null,
                      ),

                      const SizedBox(height: 24),

                      // Upcoming Appointments Banner
                      const DoctorBanner(),

                      const SizedBox(height: 24),

                      // All Doctors
                      const HomeSectionHeader(
                        title: 'All Doctors',
                        showAction: false, // Hide "See All"
                      ),
                      const SizedBox(height: 14),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: doctorState.allDoctors.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final doc = doctorState.allDoctors[index];
                          return AllDoctorCard(
                            doctor: doc,
                            onTap: () {
                              context.push('/doctors/${doc.id}');
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
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: 1, // 1 is Doctors tab
        onTap: (index) {
          if (index == 0) {
            context.go(AppRoutes.clinics);
          } else if (index == 2) {
            context.go(AppRoutes.home);
          }
          // TODO: handle other routes later
        },
      ),
    );
  }
}
