import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../core/utils/time_utils.dart';
import '../../domain/entities/doctor_entity.dart';

class DoctorScheduleCard extends StatelessWidget {
  final DoctorEntity doctor;

  const DoctorScheduleCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final timingsDisplay = TimeUtils.formatTimeRange(
      doctor.startTime ?? '09:00',
      doctor.endTime ?? '14:00',
    );

    const allWeekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final normalizedWorkingDays = doctor.workingDays
        .map((d) => d.toLowerCase().trim())
        .toSet();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: ClinicQColors.cardBorder, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.schedule_rounded,
                color: ClinicQColors.primaryTeal,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Schedule & Timings',
                style: TextStyle(
                  color: ClinicQColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Timing highlight box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 11,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 16,
                      color: ClinicQColors.primaryTeal,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Hours',
                      style: TextStyle(
                        color: ClinicQColors.textSecondary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    timingsDisplay,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: ClinicQColors.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          const Text(
            'Working Days',
            style: TextStyle(
              color: ClinicQColors.textTertiary,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),

          // Weekday Pill Chips
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: allWeekdays.map((day) {
              final dayLower = day.toLowerCase();
              final isWorking = normalizedWorkingDays.isEmpty
                  ? true
                  : normalizedWorkingDays.any(
                      (wd) => wd.startsWith(dayLower) || wd == dayLower,
                    );

              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isWorking
                      ? ClinicQColors.primaryTeal
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  day,
                  style: TextStyle(
                    color: isWorking ? Colors.white : const Color(0xFF94A3B8),
                    fontSize: 12,
                    fontWeight: isWorking ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
