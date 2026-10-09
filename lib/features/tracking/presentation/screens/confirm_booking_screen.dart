import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../core/widgets/feedback/clinicq_loader.dart';
import '../../../../core/widgets/feedback/clinicq_error_widget.dart';
import '../../../../core/widgets/buttons/clinicq_button.dart';
import '../../../../core/widgets/buttons/clinicq_outlined_button.dart';
import '../../../doctor/domain/entities/doctor_entity.dart';
import '../../domain/entities/queue_preview.dart';
import '../providers.dart';
import '../utils/booking_date_utils.dart';
import '../widgets/booking_app_bar.dart';
import '../widgets/booking_doctor_card.dart';
import '../widgets/today_queue_card.dart';
import '../widgets/metric_stat_box.dart';
import '../widgets/queue_status_badge.dart';

class ConfirmBookingScreen extends ConsumerWidget {
  final String doctorId;
  final String clinicId;
  final TokenInfoData? initialData;
  final DoctorEntity? initialDoctor;

  const ConfirmBookingScreen({
    super.key,
    required this.doctorId,
    required this.clinicId,
    this.initialData,
    this.initialDoctor,
  });

  void _showDoctorNotAvailableDialog(
    BuildContext context,
    DoctorEntity doctor,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Row(
          children: [
            Icon(
              Icons.info_outline_rounded,
              color: ClinicQColors.primaryTeal,
              size: 24,
            ),
            SizedBox(width: 10),
            Text(
              'Not Available Today',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: ClinicQColors.textPrimary,
              ),
            ),
          ],
        ),
        content: Text(
          '${doctor.name} is not seeing patients today. You can pick an upcoming day to book your token.',
          style: const TextStyle(
            fontSize: 14,
            color: ClinicQColors.textSecondary,
            height: 1.4,
          ),
        ),
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        actions: [
          ClinicQButton(
            label: 'Pick another day',
            gradient: ClinicQColors.gradientPrimary,
            onPressed: () {
              Navigator.pop(ctx);
              context.push(
                '/booking/pick-day?doctorId=${doctor.id}&clinicId=$clinicId',
                extra: doctor,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final effectiveDoctorId =
        doctorId.isNotEmpty ? doctorId : (initialDoctor?.id ?? '');
    final effectiveClinicId =
        clinicId.isNotEmpty ? clinicId : (initialDoctor?.clinicId ?? '');

    final params = TokenInfoParams(
      doctorId: effectiveDoctorId,
      clinicId: effectiveClinicId,
    );

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      appBar: BookingAppBar(
        title: 'Book a token',
        stepText: '1 of 3',
        onBack: () => context.pop(),
      ),
      body: initialData != null
          ? _buildScreen(context, initialData!.doctor, initialData!.preview)
          : ref.watch(tokenInfoLoaderProvider(params)).when(
              loading: () => const Center(child: ClinicQLoader()),
              error: (err, stack) => Center(
                child: ClinicQErrorWidget(
                  message: err.toString(),
                  onRetry: () => ref.refresh(tokenInfoLoaderProvider(params)),
                ),
              ),
              data: (data) => _buildScreen(
                context,
                initialDoctor ?? data.doctor,
                data.preview,
              ),
            ),
    );
  }

  Widget _buildScreen(
    BuildContext context,
    DoctorEntity doctor,
    QueuePreview preview,
  ) {
    final now = DateTime.now();
    final todayFormatted = BookingDateUtils.formatTodayHeader(now);
    final isWorkingToday =
        BookingDateUtils.isDoctorWorkingOn(doctor, now) && doctor.isAvailable;
    final queueStatusText = preview.nowServingNumber > 0
        ? 'Queue running'
        : 'Queue live';

    String waitTimeStr;
    if (preview.estimatedWaitMinutes < 60) {
      waitTimeStr = '~${preview.estimatedWaitMinutes} min';
    } else {
      final hrs = preview.estimatedWaitMinutes ~/ 60;
      final mins = preview.estimatedWaitMinutes % 60;
      waitTimeStr = mins > 0 ? '~$hrs hr $mins m' : '~$hrs hr';
    }

    final maxTokens = doctor.maxTokensPerDay ?? 30;
    final tokensLeft = (maxTokens - preview.nextTokenNumber + 1).clamp(
      0,
      maxTokens,
    );

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

                  // Today Date Header & Queue Status Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          todayFormatted,
                          style: const TextStyle(
                            color: ClinicQColors.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      QueueStatusBadge(text: queueStatusText),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Large Teal Card: Now Serving + Token Number
                  TodayQueueCard(
                    nowServingNumber: preview.nowServingNumber,
                    yourTokenNumber: preview.nextTokenNumber,
                    label: 'If you book now, your token is',
                  ),
                  const SizedBox(height: 14),

                  // 3 Stat Cards in a Row
                  Row(
                    children: [
                      Expanded(
                        child: MetricStatBox(
                          label: 'Ahead of you',
                          value: preview.patientsAheadCount.toString(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: MetricStatBox(label: 'Wait', value: waitTimeStr),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: MetricStatBox(
                          label: 'Tokens left',
                          value: tokensLeft.toString(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Estimate text using real duration from API
                  Text(
                    'Estimate uses about ${doctor.durationMinutes} minutes per patient. It can change if the doctor is delayed.',
                    style: const TextStyle(
                      color: ClinicQColors.textSecondary,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Bottom Buttons
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClinicQButton(
                  label: 'Book token for today',
                  gradient: ClinicQColors.gradientPrimary,
                  onPressed: () {
                    if (!isWorkingToday) {
                      _showDoctorNotAvailableDialog(context, doctor);
                      return;
                    }
                    context.push(
                      '/booking/check-token',
                      extra: CheckTokenParams(
                        doctor: doctor,
                        preview: preview,
                        selectedDate: DateTime.now(),
                        isToday: true,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                ClinicQOutlinedButton(
                  label: 'Book for another day',
                  borderColor: ClinicQColors.primaryTeal,
                  textColor: ClinicQColors.primaryTeal,
                  onPressed: () {
                    context.push(
                      '/booking/pick-day?doctorId=${doctor.id}&clinicId=$clinicId',
                      extra: doctor,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CheckTokenParams {
  final DoctorEntity doctor;
  final QueuePreview preview;
  final DateTime selectedDate;
  final bool isToday;

  const CheckTokenParams({
    required this.doctor,
    required this.preview,
    required this.selectedDate,
    required this.isToday,
  });
}
