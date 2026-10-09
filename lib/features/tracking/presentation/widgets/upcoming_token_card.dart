import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../core/utils/time_utils.dart';
import '../../../doctor/domain/entities/doctor_entity.dart';

class UpcomingTokenCard extends StatelessWidget {
  final int tokenNumber;
  final DoctorEntity? doctor;
  final String? customStartTime;

  const UpcomingTokenCard({
    super.key,
    required this.tokenNumber,
    this.doctor,
    this.customStartTime,
  });

  String _getDoctorInitials(String name) {
    if (name.isEmpty) return 'DR';
    final cleaned = name.replaceFirst('Dr. ', '').trim();
    final parts = cleaned.split(' ').where((e) => e.isNotEmpty).toList();
    if (parts.isEmpty) return 'DR';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final tokenStr = tokenNumber > 0
        ? tokenNumber.toString().padLeft(2, '0')
        : '--';
    final startTimeStr = TimeUtils.formatTo12Hour(
      customStartTime ?? doctor?.startTime ?? '20:30',
    );
    final doctorName = doctor?.name ?? 'Dr. Specialist';
    final clinicName = doctor?.clinicName ?? 'Clinic';
    final specialty = doctor?.specialty ?? 'Doctor';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      decoration: BoxDecoration(
        gradient: ClinicQColors.gradientBanner,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: ClinicQColors.darkTeal.withOpacity(0.3),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'YOUR TOKEN',
                    style: TextStyle(
                      color: ClinicQColors.lightTeal,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    tokenStr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 54,
                      fontWeight: FontWeight.w900,
                      height: 1.05,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.25),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.schedule_rounded,
                      size: 15,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Starts at $startTimeStr',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white24, height: 1, thickness: 1),
          const SizedBox(height: 14),
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                child: doctor?.photoUrl != null && doctor!.photoUrl!.isNotEmpty
                    ? Image.network(
                        doctor!.photoUrl!,
                        width: 44,
                        height: 44,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            _buildInitialsText(doctorName),
                      )
                    : _buildInitialsText(doctorName),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$clinicName · $specialty',
                      style: const TextStyle(
                        color: ClinicQColors.lightTeal,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInitialsText(String name) {
    return Text(
      _getDoctorInitials(name),
      style: const TextStyle(
        color: ClinicQColors.darkTeal,
        fontWeight: FontWeight.w900,
        fontSize: 16,
      ),
    );
  }
}
