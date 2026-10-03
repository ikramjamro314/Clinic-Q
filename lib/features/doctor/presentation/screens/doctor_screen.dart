import 'package:clinic_q/features/doctor/domain/entities/doctor_entity.dart';
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
  UpcomingDoctorInfo? _cachedUpcomingDoctor;

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

  UpcomingDoctorInfo? _getUpcomingDoctor(List<DoctorEntity> doctors) {
    if (doctors.isEmpty) return null;
    final now = DateTime.now();
    final dayMap = {
      'mon': 1,
      'monday': 1,
      'tue': 2,
      'tuesday': 2,
      'wed': 3,
      'wednesday': 3,
      'thu': 4,
      'thursday': 4,
      'fri': 5,
      'friday': 5,
      'sat': 6,
      'saturday': 6,
      'sun': 7,
      'sunday': 7,
    };

    final candidates = <UpcomingDoctorInfo>[];

    for (final doc in doctors) {
      DateTime? earliestForDoc;
      final docWorkingDays = doc.workingDays
          .map((d) => d.toLowerCase().trim())
          .toSet();
      if (docWorkingDays.isEmpty) {
        for (final d in ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun']) {
          docWorkingDays.add(d);
        }
      }

      int startHour = 9;
      int startMinute = 0;
      if (doc.startTime != null && doc.startTime!.contains(':')) {
        final parts = doc.startTime!.split(':');
        startHour = int.tryParse(parts[0]) ?? 9;
        startMinute = int.tryParse(parts[1]) ?? 0;
      }

      for (int offset = 0; offset <= 7; offset++) {
        final candidateDate = now.add(Duration(days: offset));
        final candidateWeekday = candidateDate.weekday;

        bool worksOnThisDay = false;
        for (final wDay in docWorkingDays) {
          if (dayMap[wDay] == candidateWeekday) {
            worksOnThisDay = true;
            break;
          }
        }

        if (worksOnThisDay) {
          final sessionTime = DateTime(
            candidateDate.year,
            candidateDate.month,
            candidateDate.day,
            startHour,
            startMinute,
          );

          if (offset == 0) {
            if (now.isBefore(sessionTime.add(const Duration(hours: 4)))) {
              earliestForDoc = sessionTime;
              break;
            }
          } else {
            earliestForDoc = sessionTime;
            break;
          }
        }
      }

      if (earliestForDoc != null) {
        candidates.add(
          UpcomingDoctorInfo(doctor: doc, nextSession: earliestForDoc),
        );
      }
    }

    if (candidates.isEmpty) {
      final doc = doctors.first;
      return UpcomingDoctorInfo(
        doctor: doc,
        nextSession: now.add(const Duration(days: 1)),
      );
    }

    candidates.sort((a, b) => a.nextSession.compareTo(b.nextSession));
    final earliestDate = candidates.first.nextSession;
    final tied = candidates
        .where(
          (c) =>
              c.nextSession.year == earliestDate.year &&
              c.nextSession.month == earliestDate.month &&
              c.nextSession.day == earliestDate.day,
        )
        .toList();

    if (tied.length > 1) {
      final random = DateTime.now().millisecond % tied.length;
      return tied[random];
    }

    return candidates.first;
  }

  @override
  Widget build(BuildContext context) {
    final doctorState = ref.watch(doctorViewModelProvider);
    final doctorNotifier = ref.read(doctorViewModelProvider.notifier);

    // Lock the banner data to the full unfiltered list of doctors
    if (doctorState.allDoctors.isNotEmpty &&
        _searchController.text.isEmpty &&
        doctorState.filters.isEmpty) {
      if (_cachedUpcomingDoctor == null || doctorState.isLoading == false) {
        _cachedUpcomingDoctor = _getUpcomingDoctor(doctorState.allDoctors);
      }
    }

    final hasActiveFilter =
        (doctorState.filters['specialties'] as List<String>?)?.isNotEmpty ==
            true ||
        (doctorState.filters['specialization'] as String?)?.isNotEmpty == true;
    final isSearchingOrFiltering =
        _searchFocusNode.hasFocus ||
        _searchController.text.isNotEmpty ||
        hasActiveFilter;

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
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.tune_rounded,
                  color: ClinicQColors.primaryTeal,
                ),
                onPressed: () {
                  context.push(AppRoutes.doctorFilter);
                },
              ),
              if ((doctorState.filters['specialties'] as List<String>?)
                          ?.isNotEmpty ==
                      true ||
                  (doctorState.filters['specialization'] as String?)
                          ?.isNotEmpty ==
                      true)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: ClinicQColors.primaryTeal,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          if (doctorState.isFromCache)
            OfflineBanner(message: doctorState.errorMessage),
          Expanded(
            child:
                doctorState.isLoading &&
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

                            // Active Filter Chips row if filters applied
                            if ((doctorState.filters['specialties']
                                        as List<String>?)
                                    ?.isNotEmpty ==
                                true) ...[
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  for (final spec
                                      in (doctorState.filters['specialties']
                                          as List<String>))
                                    Chip(
                                      backgroundColor: ClinicQColors.primaryTeal
                                          .withOpacity(0.12),
                                      side: BorderSide.none,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      label: Text(
                                        spec,
                                        style: const TextStyle(
                                          color: ClinicQColors.primaryTeal,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                      deleteIcon: const Icon(
                                        Icons.close,
                                        size: 14,
                                        color: ClinicQColors.primaryTeal,
                                      ),
                                      onDeleted: () {
                                        final currentList = List<String>.from(
                                          doctorState.filters['specialties']
                                              as List<String>,
                                        )..remove(spec);
                                        doctorNotifier.applyFilters({
                                          if (currentList.isNotEmpty)
                                            'specialties': currentList,
                                          if (currentList.isNotEmpty)
                                            'specialization': currentList.first,
                                        });
                                      },
                                    ),
                                  ActionChip(
                                    backgroundColor: Colors.transparent,
                                    side: BorderSide(
                                      color: ClinicQColors.textSecondary
                                          .withOpacity(0.3),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    label: const Text(
                                      'Clear all',
                                      style: TextStyle(
                                        color: ClinicQColors.textSecondary,
                                        fontSize: 12,
                                      ),
                                    ),
                                    onPressed: () {
                                      doctorNotifier.applyFilters({});
                                    },
                                  ),
                                ],
                              ),
                            ],

                            // Collapsible banner on search / active filters
                            AnimatedCrossFade(
                              firstChild: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  DoctorBanner(
                                    doctor: _cachedUpcomingDoctor?.doctor,
                                    appointmentDate:
                                        _cachedUpcomingDoctor?.nextSession,
                                    onTap: _cachedUpcomingDoctor != null
                                        ? () {
                                            context.push(
                                              '/doctors/${_cachedUpcomingDoctor!.doctor.id}',
                                            );
                                          }
                                        : null,
                                  ),
                                ],
                              ),
                              secondChild: const SizedBox.shrink(),
                              crossFadeState: isSearchingOrFiltering
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
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 4,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, index) =>
                                    const AllDoctorCardSkeleton(),
                              )
                            else if (doctorState.filteredDoctors.isEmpty)
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
                                          color: ClinicQColors.textSecondary,
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
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: doctorState.filteredDoctors.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, index) {
                                  final doc =
                                      doctorState.filteredDoctors[index];
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
          if (index != 1) {
            _searchController.clear();
            doctorNotifier.resetSearch();
          }
          if (index == 0) {
            context.go(AppRoutes.clinics);
          } else if (index == 2) {
            context.go(AppRoutes.home);
          } else if (index == 3) {
            context.go('/tracking/active');
          } else if (index == 4) {
            context.go(AppRoutes.profile);
          }
        },
      ),
    );
  }
}

class UpcomingDoctorInfo {
  final DoctorEntity doctor;
  final DateTime nextSession;

  const UpcomingDoctorInfo({required this.doctor, required this.nextSession});
}
