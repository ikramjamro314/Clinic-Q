import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../core/widgets/buttons/clinicq_button.dart';
import '../../../../core/widgets/buttons/clinicq_outlined_button.dart';
import '../../../doctor/domain/entities/doctor_entity.dart';
import '../../domain/entities/token.dart';
import '../../domain/entities/queue_preview.dart';
import '../utils/booking_date_utils.dart';
import '../widgets/booking_app_bar.dart';
import '../widgets/booking_ticket_card.dart';

class BookingSuccessParams {
  final DoctorEntity doctor;
  final QueuePreview preview;
  final Token token;
  final DateTime? selectedDate;
  final bool isToday;

  const BookingSuccessParams({
    required this.doctor,
    required this.preview,
    required this.token,
    this.selectedDate,
    this.isToday = true,
  });
}

class BookingSuccessScreen extends StatelessWidget {
  final DoctorEntity doctor;
  final QueuePreview preview;
  final Token token;
  final DateTime? selectedDate;
  final bool isToday;

  const BookingSuccessScreen({
    super.key,
    required this.doctor,
    required this.preview,
    required this.token,
    this.selectedDate,
    this.isToday = true,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveDate = selectedDate ?? DateTime.now();
    final dateFormatted = isToday
        ? BookingDateUtils.formatFullDate(effectiveDate, includeTodayPrefix: true)
        : BookingDateUtils.formatFullDate(effectiveDate);

    final tokenNumber = token.tokenNumber ?? preview.nextTokenNumber;

    // Enrich doctor with token response fields if available
    final displayDoctor = doctor.copyWith(
      name: (token.doctorName != null && token.doctorName!.isNotEmpty)
          ? token.doctorName
          : doctor.name,
      clinicName: (token.clinicName != null && token.clinicName!.isNotEmpty)
          ? token.clinicName
          : doctor.clinicName,
      specialty: (token.specialization != null && token.specialization!.isNotEmpty)
          ? token.specialization
          : doctor.specialty,
    );

    // Queue status explanation text
    String statusExplanation;
    if (!isToday) {
      statusExplanation =
          'Your token is reserved for $dateFormatted. The live queue and wait time metrics will automatically activate on the day of your appointment. We will remind you beforehand.';
    } else if (token.estimatedWaitMinutes != null && token.estimatedWaitMinutes! > 0) {
      final ahead = token.tokensAhead ?? preview.patientsAheadCount;
      statusExplanation =
          'Your estimated wait is ~${token.estimatedWaitMinutes} min ($ahead patients ahead). You can track your live queue position anytime.';
    } else {
      statusExplanation =
          'The queue has not started yet, so there is no wait time to show. On the day, you will see your live position here. We will notify you when consultations begin.';
    }

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      appBar: BookingAppBar(
        title: 'Book a token',
        stepText: '3 of 3',
        onBack: () => context.go('/home'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 8),

                    // Clean Checkmark Badge consistent with App Theme
                    Container(
                      width: 52,
                      height: 52,
                      decoration: const BoxDecoration(
                        color: ClinicQColors.primaryTeal,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x3314B8A6),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Title
                    const Text(
                      'You are booked',
                      style: TextStyle(
                        color: ClinicQColors.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Booking Ticket Card
                    BookingTicketCard(
                      tokenNumber: tokenNumber,
                      dateText: dateFormatted,
                      doctor: displayDoctor,
                    ),
                    const SizedBox(height: 20),

                    // Queue status explanation text
                    Text(
                      statusExplanation,
                      style: const TextStyle(
                        color: ClinicQColors.textSecondary,
                        fontSize: 13,
                        height: 1.45,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClinicQButton(
                    label: 'Track my token',
                    gradient: ClinicQColors.gradientPrimary,
                    onPressed: () {
                      context.go('/tracking/${token.id}');
                    },
                  ),
                  const SizedBox(height: 12),
                  ClinicQOutlinedButton(
                    label: 'Back to home',
                    borderColor: ClinicQColors.primaryTeal,
                    textColor: ClinicQColors.primaryTeal,
                    onPressed: () {
                      context.go('/home');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
