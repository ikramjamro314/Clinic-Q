import 'package:clinic_q/features/doctor/presentation/widgets/all_doctor_card.dart';
import 'package:clinic_q/features/doctor/presentation/widgets/doctor_banner.dart';
import 'package:clinic_q/features/tracking/presentation/screens/tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../core/widgets/inputs/clinicq_text_field.dart';
import '../../../../core/widgets/feedback/clinicq_loader.dart';
import '../../../../core/widgets/feedback/clinicq_error_widget.dart';
import '../../../../core/widgets/feedback/offline_banner.dart';
import '../../../home/presentation/widgets/home_bottom_nav_bar.dart';
import '../../../home/presentation/widgets/home_doctor_card.dart';
import '../../../home/presentation/widgets/home_section_header.dart';
import '../../../home/presentation/viewmodels/home_state.dart';
import '../../../../core/widgets/feedback/skeleton_box.dart';
import '../widgets/doctor_card_skeleton.dart';
import '../doctor_providers.dart';

class DoctorScreen extends ConsumerStatefulWidget {
  const DoctorScreen({super.key});

  @override
  ConsumerState<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends ConsumerState<DoctorScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(_onSearchFocusChange);
    _searchController.addListener(_onSearchTextChange);
  }

  @override
  void dispose() {
    _searchFocusNode.removeListener(_onSearchFocusChange);
    _searchController.removeListener(_onSearchTextChange);
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchFocusChange() {
    if (mounted) setState(() {});
  }

  void _onSearchTextChange() {
    if (mounted) setState(() {});
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
          'Find Doctors',
          style: TextStyle(
            color: ClinicQColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.tune_rounded,
              color: ClinicQColors.primaryTeal,
            ),
            onPressed: () {
              context.push(AppRoutes.doctorFilter);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          if (doctorState.isFromCache)
            OfflineBanner(message: doctorState.errorMessage),
          Expanded(
            child: doctorState.isLoading &&
                    doctorState.allDoctors.isEmpty &&
                    _searchController.text.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 12.0,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SkeletonBox(
                            width: double.infinity,
                            height: 48,
                            borderRadius: 16,
                          ),
                          const SizedBox(height: 24),
                          const SkeletonBox(
                            width: double.infinity,
                            height: 150,
                            borderRadius: 20,
                          ),
                          const SizedBox(height: 24),
                          const SkeletonBox(width: 150, height: 18),
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
                          const SkeletonBox(width: 120, height: 18),
                          const SizedBox(height: 14),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 4,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) =>
                                const AllDoctorCardSkeleton(),
                          ),
                        ],
                      ),
                    ),
                  )
                : doctorState.errorMessage != null &&
                        doctorState.allDoctors.isEmpty &&
                        _searchController.text.isEmpty
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
                                  focusNode: _searchFocusNode,
                                  hintText: 'Search doctors...',
                                  prefixIcon: Icons.search_rounded,
                                  isPill: false,
                                  borderRadius: 16,
                                  fillColor: Colors.white,
                                  onChanged: doctorNotifier.searchDoctors,
                                  onSuffixIconPressed: () {
                                    _searchController.clear();
                                    doctorNotifier.searchDoctors('');
                                  },
                                  suffixIcon: _searchController.text.isNotEmpty
                                      ? Icons.close_rounded
                                      : null,
                                ),

                                // Collapsible banner on search
                                AnimatedCrossFade(
                                  firstChild: Column(
                                    children: const [
                                      SizedBox(height: 20),
                                      DoctorBanner(),
                                    ],
                                  ),
                                  secondChild: const SizedBox.shrink(),
                                  crossFadeState: (_searchFocusNode.hasFocus ||
                                          _searchController.text.isNotEmpty)
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                                  duration: const Duration(milliseconds: 250),
                                  sizeCurve: Curves.easeInOut,
                                ),

                                const SizedBox(height: 20),

                                // All Doctors Section Header
                                const HomeSectionHeader(
                                  title: 'All Doctors',
                                  showAction: false,
                                ),
                                const SizedBox(height: 14),

                                // Doctors List / Loading / Empty state
                                if (doctorState.isLoading &&
                                    doctorState.allDoctors.isEmpty)
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: 4,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 12),
                                    itemBuilder: (context, index) =>
                                        const AllDoctorCardSkeleton(),
                                  )
                                else if (doctorState.allDoctors.isEmpty)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 40.0,
                                    ),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.search_off_rounded,
                                            size: 48,
                                            color: ClinicQColors.textSecondary
                                                .withOpacity(0.5),
                                          ),
                                          const SizedBox(height: 12),
                                          const Text(
                                            'No doctors found',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  ClinicQColors.textSecondary,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Try searching with a different keyword',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: ClinicQColors.textSecondary
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                else
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: doctorState.allDoctors.length,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 12),
                                    itemBuilder: (context, index) {
                                      final doc =
                                          doctorState.allDoctors[index];
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
          ),
        ],
      ),
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: 1, // 1 is Doctors tab
        onTap: (index) {
          if (index == 0) {
            context.go(AppRoutes.clinics);
          } else if (index == 2) {
            context.go(AppRoutes.home);
          } else if (index == 3) {
            final activeToken = ref.read(activeTokenLookupProvider).value;
            context.go('/tracking/${activeToken?.id ?? "none"}');
          } else if (index == 4) {
            context.go(AppRoutes.profile);
          }
        },
      ),
    );
  }
}
