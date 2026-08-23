import 'package:clinic_q/features/profile/presentation/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/app_routes.dart';
import '../../../../core/theme/clinic_q_colors.dart';
import '../../../../core/widgets/feedback/skeleton_box.dart';
import '../../../doctor/presentation/widgets/all_doctor_card.dart';
import '../../../clinic/presentation/widgets/clinic_list_card.dart';

class InterestListScreen extends ConsumerStatefulWidget {
  const InterestListScreen({super.key});

  @override
  ConsumerState<InterestListScreen> createState() => _InterestListScreenState();
}

class _InterestListScreenState extends ConsumerState<InterestListScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    final activeTab = ref.read(interestListViewModelProvider).activeTabIndex;
    _pageController = PageController(initialPage: activeTab);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(interestListViewModelProvider);
    final notifier = ref.read(interestListViewModelProvider.notifier);
    final theme = Theme.of(context);
    final showDoctors = state.activeTabIndex == 0;

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      appBar: AppBar(
        title: Text(
          'Interest List',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: ClinicQColors.textPrimary,
          ),
        ),
        backgroundColor: ClinicQColors.cardBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ClinicQColors.textPrimary,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Segmented tab control (Pill selectors)
            Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: ClinicQColors.secondaryBackground,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _TabPill(
                      label: 'Doctor',
                      isActive: showDoctors,
                      onTap: () {
                        notifier.setActiveTab(0);
                        _pageController.animateToPage(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: _TabPill(
                      label: 'Clinic',
                      isActive: !showDoctors,
                      onTap: () {
                        notifier.setActiveTab(1);
                        _pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Main PageView content area
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  notifier.setActiveTab(index);
                },
                children: [
                  _buildDoctorPage(context, state, theme),
                  _buildHospitalPage(context, state, theme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorPage(
    BuildContext context,
    InterestListState state,
    ThemeData theme,
  ) {
    if (state.isLoading && state.doctors.isEmpty) {
      return _buildSkeletonList();
    }

    if (state.doctors.isEmpty) {
      return _buildEmptyState(
        theme,
        message: "You haven't followed any doctors yet",
        subMessage: 'Choose the best doctor for you.',
        icon: Icons.medical_services_outlined,
        route: AppRoutes.doctors,
        buttonLabel: 'Find doctors',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      itemCount: state.doctors.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final doctor = state.doctors[index];
        return AllDoctorCard(
          doctor: doctor,
          onTap: () => context.push('/doctors/${doctor.id}'),
        );
      },
    );
  }

  Widget _buildHospitalPage(
    BuildContext context,
    InterestListState state,
    ThemeData theme,
  ) {
    if (state.isLoading && state.clinics.isEmpty) {
      return _buildSkeletonList();
    }

    if (state.clinics.isEmpty) {
      return _buildEmptyState(
        theme,
        message: "You haven't followed any hospitals yet",
        subMessage: 'Find nearby clinics & premium hospitals.',
        icon: Icons.apartment_outlined,
        route: AppRoutes.clinics,
        buttonLabel: 'Find hospital',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      itemCount: state.clinics.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final clinic = state.clinics[index];
        return ClinicListCard(
          clinic: clinic,
          onTap: () => context.push('/clinics/${clinic.id}'),
        );
      },
    );
  }

  Widget _buildSkeletonList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      itemCount: 3,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SkeletonBox(
          width: double.infinity,
          height: 110,
          borderRadius: 16,
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    ThemeData theme, {
    required String message,
    required String subMessage,
    required IconData icon,
    required String route,
    required String buttonLabel,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 70, color: ClinicQColors.textTertiary),
            const SizedBox(height: 20),
            Text(
              message,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: ClinicQColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              subMessage,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: ClinicQColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ClinicQColors.primaryTeal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
              ),
              onPressed: () => context.go(route),
              child: Text(
                buttonLabel,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabPill extends StatelessWidget {
  const _TabPill({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = (theme.textTheme.bodyMedium ?? const TextStyle()).copyWith(
      fontWeight: FontWeight.bold,
      color: isActive ? Colors.white : ClinicQColors.textSecondary,
    );

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? ClinicQColors.primaryTeal : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: ClinicQColors.primaryTeal.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : const [],
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: textStyle,
          child: Text(label),
        ),
      ),
    );
  }
}
