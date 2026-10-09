import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../core/widgets/feedback/clinicq_loader.dart';
import '../../../../core/widgets/feedback/clinicq_error_widget.dart';
import '../../../../core/widgets/buttons/clinicq_button.dart';
import '../../../doctor/domain/entities/doctor_entity.dart';
import '../../../doctor/presentation/doctor_providers.dart';
import '../../domain/entities/queue_preview.dart';
import '../providers.dart';
import '../utils/booking_date_utils.dart';
import '../widgets/booking_app_bar.dart';
import '../widgets/booking_doctor_card.dart';
import 'confirm_booking_screen.dart';

import '../../../doctor/domain/entities/available_date_entity.dart';

class PickDayScreen extends ConsumerStatefulWidget {
  final String doctorId;
  final String clinicId;
  final DoctorEntity? initialDoctor;

  const PickDayScreen({
    super.key,
    required this.doctorId,
    required this.clinicId,
    this.initialDoctor,
  });

  @override
  ConsumerState<PickDayScreen> createState() => _PickDayScreenState();
}

class _PickDayScreenState extends ConsumerState<PickDayScreen> {
  DateTime? _selectedDate;
  int? _selectedNextTokenNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      appBar: BookingAppBar(
        title: 'Book a token',
        stepText: '1 of 3',
        onBack: () => context.pop(),
      ),
      body: widget.initialDoctor != null
          ? _buildContent(widget.initialDoctor!)
          : ref.watch(doctorLoaderProvider(widget.doctorId)).when(
              loading: () => const Center(child: ClinicQLoader()),
              error: (err, stack) => Center(
                child: ClinicQErrorWidget(
                  message: err.toString(),
                  onRetry: () =>
                      ref.refresh(doctorLoaderProvider(widget.doctorId)),
                ),
              ),
              data: (doctor) {
                if (doctor == null) {
                  return const Center(child: Text('Doctor not found'));
                }
                return _buildContent(doctor);
              },
            ),
    );
  }

  Widget _buildContent(DoctorEntity doctor) {
    final availableDatesAsync = ref.watch(doctorAvailableDatesProvider(widget.doctorId));

    return availableDatesAsync.when(
      loading: () => const Center(child: ClinicQLoader()),
      error: (err, _) {
        // Graceful fallback to client-side date calculations if API fails or offline
        return _buildDaysList(
          doctor: doctor,
          days: BookingDateUtils.getUpcomingDays(
            doctor,
            targetWorkingDaysCount: 3,
          ),
        );
      },
      data: (apiDates) {
        if (apiDates.isEmpty) {
          // Fallback if empty
          return _buildDaysList(
            doctor: doctor,
            days: BookingDateUtils.getUpcomingDays(
              doctor,
              targetWorkingDaysCount: 3,
            ),
          );
        }

        // Convert API dates to BookingDayItem objects
        final now = DateTime.now();
        final tomorrow = DateTime(now.year, now.month, now.day).add(const Duration(days: 1));

        final days = apiDates.map((apiItem) {
          final parsedDate = DateTime.tryParse(apiItem.date) ??
              DateTime(now.year, now.month, now.day).add(const Duration(days: 1));

          final isTomorrow = parsedDate.year == tomorrow.year &&
              parsedDate.month == tomorrow.month &&
              parsedDate.day == tomorrow.day;

          final weekdayName = BookingDateUtils.weekdayNames[parsedDate.weekday - 1];
          final dayLabel = isTomorrow ? 'Tomorrow' : weekdayName;

          return BookingDayItem(
            date: parsedDate,
            dayLabel: dayLabel,
            shortWeekday: apiItem.dayName.toUpperCase(),
            dayNumber: parsedDate.day,
            isWorking: true,
            statusText: '${apiItem.tokensRemaining} of ${apiItem.dailyTokenCap} tokens left',
            tokensLeft: apiItem.tokensRemaining,
            totalTokens: apiItem.dailyTokenCap,
          );
        }).toList();

        return _buildDaysList(
          doctor: doctor,
          days: days,
          apiDates: apiDates,
        );
      },
    );
  }

  Widget _buildDaysList({
    required DoctorEntity doctor,
    required List<BookingDayItem> days,
    List<AvailableDateEntity>? apiDates,
  }) {
    // Default select first available working day if none selected
    if (_selectedDate == null) {
      final firstWorking = days.where((d) => d.isWorking).firstOrNull;
      if (firstWorking != null) {
        _selectedDate = firstWorking.date;
        if (apiDates != null && apiDates.isNotEmpty) {
          _selectedNextTokenNumber = apiDates.first.nextTokenNumber;
        }
      }
    }

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Doctor Card
                  BookingDoctorCard(doctor: doctor),
                  const SizedBox(height: 20),

                  // Heading & Subheading
                  const Text(
                    'Pick another day',
                    style: TextStyle(
                      color: ClinicQColors.textPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Today is covered on the previous screen. Pick a day up to 3 days ahead. No time to choose, your number depends on when you book.',
                    style: TextStyle(
                      color: ClinicQColors.textSecondary,
                      fontSize: 13,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // List of Days
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: days.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = days[index];
                      final isSelected =
                          _selectedDate != null &&
                          _selectedDate!.year == item.date.year &&
                          _selectedDate!.month == item.date.month &&
                          _selectedDate!.day == item.date.day;

                      return _buildDayCard(item, isSelected, () {
                        setState(() {
                          _selectedDate = item.date;
                          if (apiDates != null && index < apiDates.length) {
                            _selectedNextTokenNumber = apiDates[index].nextTokenNumber;
                          }
                        });
                      });
                    },
                  ),

                  const SizedBox(height: 14),
                  const Text(
                    'You can book up to 3 days ahead.',
                    style: TextStyle(
                      color: ClinicQColors.textTertiary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Continue Button
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: ClinicQButton(
              label: 'Continue',
              gradient: ClinicQColors.gradientPrimary,
              onPressed: _selectedDate != null
                  ? () {
                      final nextNum = _selectedNextTokenNumber ?? 1;
                      final futurePreview = QueuePreview(
                        nowServingNumber: 0,
                        nextTokenNumber: nextNum,
                        patientsAheadCount: nextNum > 1 ? nextNum - 1 : 0,
                        estimatedWaitMinutes: 0,
                      );

                      context.push(
                        '/booking/check-token',
                        extra: CheckTokenParams(
                          doctor: doctor,
                          preview: futurePreview,
                          selectedDate: _selectedDate!,
                          isToday: false,
                        ),
                      );
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayCard(
    BookingDayItem item,
    bool isSelected, [
    VoidCallback? onSelect,
  ]) {
    if (!item.isWorking) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: ClinicQColors.dividerStrong, width: 1.2),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.shortWeekday,
                    style: const TextStyle(
                      color: ClinicQColors.textSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    item.dayNumber.toString(),
                    style: const TextStyle(
                      color: ClinicQColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.dayLabel,
                    style: const TextStyle(
                      color: ClinicQColors.textSecondary,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.statusText,
                    style: const TextStyle(
                      color: ClinicQColors.textTertiary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFECACA)),
              ),
              child: const Text(
                'Off',
                style: TextStyle(
                  color: Color(0xFFDC2626),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: onSelect ??
          () {
            setState(() {
              _selectedDate = item.date;
            });
          },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected
                ? ClinicQColors.primaryTeal
                : ClinicQColors.cardBorder,
            width: isSelected ? 1.8 : 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isSelected ? 0.04 : 0.015),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isSelected
                    ? ClinicQColors.appointmentBadgeBackground
                    : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.shortWeekday,
                    style: TextStyle(
                      color: isSelected
                          ? ClinicQColors.primaryTeal
                          : ClinicQColors.textSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    item.dayNumber.toString(),
                    style: TextStyle(
                      color: isSelected
                          ? ClinicQColors.primaryTeal
                          : ClinicQColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.dayLabel,
                    style: const TextStyle(
                      color: ClinicQColors.textPrimary,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.statusText,
                    style: const TextStyle(
                      color: ClinicQColors.appointmentBadgeText,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  color: ClinicQColors.primaryTeal,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.check, color: Colors.white, size: 16),
              ),
          ],
        ),
      ),
    );
  }
}
