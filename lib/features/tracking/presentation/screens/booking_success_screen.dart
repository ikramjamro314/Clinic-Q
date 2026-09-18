import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../core/widgets/buttons/clinicq_button.dart';
import '../../../doctor/domain/entities/doctor_entity.dart';
import '../../domain/entities/token.dart';
import '../../domain/entities/queue_preview.dart';

class BookingSuccessParams {
  final DoctorEntity doctor;
  final QueuePreview preview;
  final Token token;
  const BookingSuccessParams({
    required this.doctor,
    required this.preview,
    required this.token,
  });
}

class BookingSuccessScreen extends StatelessWidget {
  final DoctorEntity doctor;
  final QueuePreview preview;
  final Token token;

  const BookingSuccessScreen({
    super.key,
    required this.doctor,
    required this.preview,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    String waitTimeStr;
    if (preview.estimatedWaitMinutes < 60) {
      waitTimeStr = '${preview.estimatedWaitMinutes} min';
    } else {
      final hrs = preview.estimatedWaitMinutes ~/ 60;
      final mins = preview.estimatedWaitMinutes % 60;
      waitTimeStr = '~${hrs} hr ${mins} min';
    }

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Big Success Checkmark
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: ClinicQColors.primaryTeal.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    color: ClinicQColors.primaryTeal,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Token Booked!',
                style: TextStyle(
                  color: ClinicQColors.textPrimary,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You are in the queue for ${doctor.name}',
                style: const TextStyle(
                  color: ClinicQColors.textSecondary,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36),
              // Compact Summary Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        gradient: ClinicQColors.gradientPrimary,
                      ),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'YOUR TOKEN',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                token.tokenNumber != null
                                    ? '#${token.tokenNumber}'
                                    : '#--',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                doctor.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                doctor.clinicName,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Queue Live',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem(
                            value: preview.patientsAheadCount.toString(),
                            label: 'Ahead',
                          ),
                          const SizedBox(
                            height: 32,
                            child: VerticalDivider(
                              color: ClinicQColors.dividerMedium,
                            ),
                          ),
                          _buildStatItem(
                            value: waitTimeStr,
                            label: 'Est. Wait',
                          ),
                          const SizedBox(
                            height: 32,
                            child: VerticalDivider(
                              color: ClinicQColors.dividerMedium,
                            ),
                          ),
                          _buildStatItem(
                            value: doctor.startTime ?? '9:00 AM',
                            label: 'Opens At',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Actions
              ClinicQButton(
                label: 'Track My Token',
                icon: Icons.track_changes_rounded,
                gradient: ClinicQColors.gradientPrimary,
                onPressed: () {
                  // Direct to tracking tab/screen
                  context.go('/tracking/${token.id}');
                },
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  context.go('/home');
                },
                child: const Text(
                  'Back to Appointments',
                  style: TextStyle(
                    color: ClinicQColors.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem({required String value, required String label}) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: ClinicQColors.primaryBlue,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: ClinicQColors.textTertiary,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
