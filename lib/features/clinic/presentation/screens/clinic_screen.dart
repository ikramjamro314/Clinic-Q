import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../core/theme/clinic_q_colors.dart';
import '../../../../core/widgets/inputs/clinicq_text_field.dart';
import '../../../../core/widgets/feedback/clinicq_loader.dart';
import '../../../../core/widgets/feedback/clinicq_error_widget.dart';
import '../../../home/presentation/widgets/home_bottom_nav_bar.dart';
import '../../../home/presentation/widgets/home_section_header.dart';
import '../../../../core/widgets/feedback/offline_banner.dart';
import '../clinic_providers.dart';
import '../widgets/clinic_list_card.dart';

import '../widgets/clinic_card_skeleton.dart';

class ClinicScreen extends ConsumerStatefulWidget {
  const ClinicScreen({super.key});

  @override
  ConsumerState<ClinicScreen> createState() => _ClinicScreenState();
}

class _ClinicScreenState extends ConsumerState<ClinicScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clinicState = ref.watch(clinicViewModelProvider);
    final clinicNotifier = ref.read(clinicViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      appBar: AppBar(
        backgroundColor: ClinicQColors.appBackground,
        elevation: 0,
        automaticallyImplyLeading: false, // No back button
        title: const Text(
          'Find Clinics',
          style: TextStyle(
            color: ClinicQColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          if (clinicState.isFromCache)
            OfflineBanner(message: clinicState.errorMessage),
          Expanded(
            child: clinicState.isLoading && clinicState.clinics.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 12.0,
                    ),
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) => const ClinicCardSkeleton(),
                    ),
                  )
                : clinicState.errorMessage != null && clinicState.clinics.isEmpty
                    ? Center(
                        child: ClinicQErrorWidget(
                          message: clinicState.errorMessage!,
                          onRetry: () => clinicNotifier.refresh(),
                        ),
                      )
                    : SafeArea(
                        child: RefreshIndicator(
                          onRefresh: () async => clinicNotifier.refresh(),
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
                                  onChanged: clinicNotifier.searchClinics,
                                  onSuffixIconPressed: () {
                                    _searchController.clear();
                                    clinicNotifier.searchClinics('');
                                  },
                                  suffixIcon: _searchController.text.isNotEmpty
                                      ? Icons.close_rounded
                                      : null,
                                ),

                                const SizedBox(height: 24),

                                // Main clinics list
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: clinicState.clinics.length,
                                  itemBuilder: (context, index) {
                                    final clinic = clinicState.clinics[index];
                                    return ClinicListCard(
                                      clinic: clinic,
                                      onTap: () {
                                        context.push(
                                          AppRoutes.clinicViewWithId(clinicId: clinic.id),
                                        );
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
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: 0, // 0 is Clinics tab
        onTap: (index) {
          if (index == 2) {
            context.go(AppRoutes.home);
          } else if (index == 1) {
            context.go(AppRoutes.doctors);
          } else if (index == 4) {
            context.go(AppRoutes.profile);
          }
        },
      ),
    );
  }
}
