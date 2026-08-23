import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/clinic_q_colors.dart';
import '../../../../core/widgets/feedback/clinicq_loader.dart';
import '../../../../core/widgets/feedback/clinicq_error_widget.dart';
import '../../../../core/widgets/buttons/clinicq_button.dart';
import '../../../doctor/presentation/doctor_providers.dart';
import '../../../doctor/domain/entities/doctor_entity.dart';
import '../../domain/entities/queue_preview.dart';
import '../providers.dart';
import '../widgets/booking_step_header.dart';
import '../widgets/doctor_queue_card.dart';
import '../widgets/queue_stat_box.dart';
import '../widgets/queue_progress_row.dart';

class TokenInfoData {
  final DoctorEntity doctor;
  final QueuePreview preview;
  const TokenInfoData(this.doctor, this.preview);
}

final tokenInfoLoaderProvider = FutureProvider.family<TokenInfoData, TokenInfoParams>((ref, params) async {
  final doctor = await ref.watch(doctorRepositoryProvider).getDoctorById(params.doctorId);
  if (doctor == null) {
    throw Exception('Doctor not found');
  }
  final preview = await ref.watch(appointmentRepositoryProvider).getQueuePreview(
        doctorId: params.doctorId,
        clinicId: params.clinicId,
      );
  return TokenInfoData(doctor, preview);
});

class TokenInfoParams {
  final String doctorId;
  final String clinicId;
  const TokenInfoParams({required this.doctorId, required this.clinicId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenInfoParams &&
          runtimeType == other.runtimeType &&
          doctorId == other.doctorId &&
          clinicId == other.clinicId;

  @override
  int get hashCode => doctorId.hashCode ^ clinicId.hashCode;
}

class TokenInfoScreen extends ConsumerWidget {
  final String doctorId;
  final String clinicId;

  const TokenInfoScreen({
    super.key,
    required this.doctorId,
    required this.clinicId,
  });

  String _formatToday() {
    final now = DateTime.now();
    final weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return '${weekdays[now.weekday - 1]}, ${now.day} ${months[now.month - 1]}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = TokenInfoParams(doctorId: doctorId, clinicId: clinicId);
    final dataAsync = ref.watch(tokenInfoLoaderProvider(params));

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      appBar: AppBar(
        backgroundColor: ClinicQColors.appBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ClinicQColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Token Details',
          style: TextStyle(
            color: ClinicQColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: dataAsync.when(
        loading: () => const Center(child: ClinicQLoader()),
        error: (err, stack) => Center(
          child: ClinicQErrorWidget(
            message: err.toString(),
            onRetry: () => ref.refresh(tokenInfoLoaderProvider(params)),
          ),
        ),
        data: (data) {
          final doctor = data.doctor;
          final preview = data.preview;
          final todayStr = _formatToday();

          // Formatted wait time string
          String waitTimeStr;
          if (preview.estimatedWaitMinutes < 60) {
            waitTimeStr = '${preview.estimatedWaitMinutes} min';
          } else {
            final hrs = preview.estimatedWaitMinutes ~/ 60;
            final mins = preview.estimatedWaitMinutes % 60;
            waitTimeStr = '~${hrs} hr ${mins} min';
          }

          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BookingStepHeader(currentStep: 2),
                        const SizedBox(height: 12),
                        DoctorQueueCard(
                          doctor: doctor,
                          tokenNumber: preview.nextTokenNumber,
                          nowServingNumber: preview.nowServingNumber,
                          dateString: todayStr,
                          onChangeTap: () => context.pop(),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: QueueStatBox(
                                icon: Icons.people_outline_rounded,
                                iconColor: ClinicQColors.primaryBlue,
                                iconBackgroundColor:
                                    ClinicQColors.primaryBlue.withOpacity(0.1),
                                value: preview.patientsAheadCount.toString(),
                                label: 'Patients ahead of you',
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: QueueStatBox(
                                icon: Icons.access_time_rounded,
                                iconColor: ClinicQColors.primaryTeal,
                                iconBackgroundColor:
                                    ClinicQColors.primaryTeal.withOpacity(0.1),
                                value: waitTimeStr,
                                label: 'Estimated wait time',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        QueueProgressRow(
                          nowServingNumber: preview.nowServingNumber,
                          totalTokens: preview.nextTokenNumber,
                          yourTokenNumber: preview.nextTokenNumber,
                        ),
                        const SizedBox(height: 16),
                        // Details Card
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 10,
                                spreadRadius: 1,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              _buildDetailItem(
                                icon: Icons.access_time_rounded,
                                iconColor: ClinicQColors.primaryTeal,
                                label: 'Doctor Timings',
                                value: '${doctor.startTime ?? "9:00 AM"} – ${doctor.endTime ?? "2:00 PM"}',
                              ),
                              const Divider(height: 24),
                              _buildDetailItem(
                                icon: Icons.confirmation_number_outlined,
                                iconColor: ClinicQColors.primaryBlue,
                                label: 'Token Queue Starts',
                                value: doctor.startTime ?? '9:00 AM',
                                trailing: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ClinicQColors.primaryTeal.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'In Progress',
                                    style: TextStyle(
                                      color: ClinicQColors.primaryTeal,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(height: 24),
                              _buildDetailItem(
                                icon: Icons.calendar_month_outlined,
                                iconColor: ClinicQColors.textTertiary,
                                label: 'Appointment Date',
                                value: '$todayStr — Today',
                              ),
                              const Divider(height: 24),
                              _buildDetailItem(
                                icon: Icons.show_chart_rounded,
                                iconColor: Colors.redAccent,
                                label: 'Avg. Time Per Patient',
                                value: '${doctor.durationMinutes} minutes',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ClinicQButton(
                    label: 'Continue to Confirm',
                    gradient: ClinicQColors.gradientPrimary,
                    onPressed: () {
                      context.push(
                        '/booking/confirm?doctorId=$doctorId&clinicId=$clinicId',
                        extra: data,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    Widget? trailing,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: ClinicQColors.textTertiary,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: ClinicQColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }
}
