import 'package:clinic_q/features/doctor/domain/entities/doctor_entity.dart';
import 'package:clinic_q/features/profile/presentation/profile_providers.dart';
import 'package:clinic_q/features/tracking/presentation/screens/tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../core/widgets/buttons/clinicq_button.dart';
import '../../../../core/widgets/buttons/clinicq_outlined_button.dart';
import '../../../auth/presentation/auth_providers.dart';
import '../../domain/entities/token.dart';
import '../providers.dart';
import '../utils/booking_date_utils.dart';
import '../widgets/booking_app_bar.dart';
import 'confirm_booking_screen.dart';
import 'booking_success_screen.dart';

class CheckTokenScreen extends ConsumerStatefulWidget {
  final CheckTokenParams params;

  const CheckTokenScreen({super.key, required this.params});

  @override
  ConsumerState<CheckTokenScreen> createState() => _CheckTokenScreenState();
}

class _CheckTokenScreenState extends ConsumerState<CheckTokenScreen> {
  bool _isSubmitting = false;

  void _showQueueClosedDialog(BuildContext context, DoctorEntity doctor) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Row(
          children: [
            Icon(
              Icons.schedule_rounded,
              color: ClinicQColors.primaryTeal,
              size: 24,
            ),
            SizedBox(width: 10),
            Text(
              'Shift Ended',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: ClinicQColors.textPrimary,
              ),
            ),
          ],
        ),
        content: Text(
          'The queue for today has closed because ${doctor.name}\'s shift has ended. Please pick an upcoming day to book your token.',
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
                '/booking/pick-day?doctorId=${doctor.id}&clinicId=${doctor.clinicId ?? ""}',
                extra: doctor,
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _onConfirm() async {
    final authRepo = ref.read(authRepositoryProvider);
    final currentUser = authRepo.getCurrentUser();
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: No active user session.')),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final appointmentNotifier = ref.read(appointmentViewModelProvider.notifier);

    final date = widget.params.selectedDate;
    final formattedDate =
        '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    final success = await appointmentNotifier.createToken(
      doctorId: widget.params.doctor.id,
      clinicId: widget.params.doctor.clinicId ?? 'clinic_1',
      userId: currentUser.id,
      appointmentDate: formattedDate,
      isFuture: !widget.params.isToday,
      notes: widget.params.isToday
          ? null
          : 'Booking for: ${BookingDateUtils.formatFullDate(widget.params.selectedDate)}',
    );

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    if (success) {
      ref.invalidate(activeTokenLookupProvider);

      final appState = ref.read(appointmentViewModelProvider);
      final bookedToken = appState.tokens.firstWhere(
        (t) => t.doctorId == widget.params.doctor.id,
        orElse: () => Token(
          id: 'token_${DateTime.now().millisecondsSinceEpoch}',
          doctorId: widget.params.doctor.id,
          clinicId: widget.params.doctor.clinicId ?? 'clinic_1',
          userId: currentUser.id,
          status: 'booked',
          tokenNumber: widget.params.preview.nextTokenNumber,
          createdAt: DateTime.now().toIso8601String(),
          appointmentDate: formattedDate,
          doctorName: widget.params.doctor.name,
          clinicName: widget.params.doctor.clinicName,
          specialization: widget.params.doctor.specialty,
        ),
      );

      context.push(
        '/booking/success?doctorId=${widget.params.doctor.id}&clinicId=${widget.params.doctor.clinicId ?? "clinic_1"}',
        extra: BookingSuccessParams(
          doctor: widget.params.doctor,
          preview: widget.params.preview,
          token: bookedToken,
          selectedDate: widget.params.selectedDate,
          isToday: widget.params.isToday,
        ),
      );
    } else {
      final appState = ref.read(appointmentViewModelProvider);
      final errMsg = appState.errorMessage ?? '';

      if (errMsg.contains("shift has ended") ||
          errMsg.contains("QUEUE_CLOSED") ||
          errMsg.contains("closed")) {
        _showQueueClosedDialog(context, widget.params.doctor);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              appState.errorMessage ?? 'Booking failed. Please try again.',
            ),
            backgroundColor: ClinicQColors.errorIcon,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final doctor = widget.params.doctor;
    final preview = widget.params.preview;
    final date = widget.params.selectedDate;

    final dateFormatted = widget.params.isToday
        ? BookingDateUtils.formatFullDate(date, includeTodayPrefix: true)
        : BookingDateUtils.formatFullDate(date);

    final feeFormatted =
        'Rs. ${doctor.price.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}, paid at the clinic';

    final authRepo = ref.watch(authRepositoryProvider);
    final user = authRepo.getCurrentUser();
    final profileState = ref.watch(profileViewModelProvider);

    String patientName = 'Patient';
    if (profileState.profile?.name != null &&
        profileState.profile!.name.trim().isNotEmpty) {
      patientName = profileState.profile!.name.trim();
    } else if (user?.firstName != null && user!.firstName!.trim().isNotEmpty) {
      final last = user.lastName ?? '';
      patientName = '${user.firstName!} $last'.trim();
    } else if (user?.email != null && user!.email.isNotEmpty) {
      patientName = user.email.split('@').first;
    }

    final tokenFormatted = preview.nextTokenNumber > 0
        ? '${preview.nextTokenNumber.toString().padLeft(2, '0')} (if you book now)'
        : '09 (if you book now)';

    final clinicLocation =
        doctor.clinicAddress != null && doctor.clinicAddress!.isNotEmpty
        ? (doctor.clinicAddress!.contains(doctor.clinicName)
              ? doctor.clinicAddress!
              : '${doctor.clinicName}, ${doctor.clinicAddress}')
        : (doctor.location != null && doctor.location!.isNotEmpty
              ? '${doctor.clinicName}, ${doctor.location}'
              : doctor.clinicName);

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      appBar: BookingAppBar(
        title: 'Book a token',
        stepText: '2 of 3',
        onBack: () => context.pop(),
      ),
      body: SafeArea(
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
                    // Title & Subtitle
                    const Text(
                      'Check your token',
                      style: TextStyle(
                        color: ClinicQColors.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'One last look before we save your place.',
                      style: TextStyle(
                        color: ClinicQColors.textSecondary,
                        fontSize: 13.5,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Table Card
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: ClinicQColors.cardBorder,
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildDetailRow(
                            label: 'Clinic',
                            value: clinicLocation,
                            isFirst: true,
                          ),
                          _buildDetailRow(label: 'Doctor', value: doctor.name),
                          _buildDetailRow(label: 'Day', value: dateFormatted),
                          _buildDetailRow(label: 'Fee', value: feeFormatted),
                          _buildDetailRow(label: 'Patient', value: patientName),
                          _buildDetailRow(
                            label: 'Your token',
                            value: tokenFormatted,
                            isLast: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // How numbers work box
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ClinicQColors.infoBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: ClinicQColors.infoBorder.withOpacity(0.2),
                        ),
                      ),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            color: ClinicQColors.infoText,
                            fontSize: 13,
                            height: 1.45,
                          ),
                          children: [
                            TextSpan(
                              text: 'How numbers work. ',
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                              text:
                                  'Tokens go out in the order people book. Confirm now and you stay ahead of anyone who books later.',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    const Text(
                      'You can cancel any time before you are called.',
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

            // Bottom CTA Buttons
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClinicQButton(
                    label: 'Confirm token',
                    gradient: ClinicQColors.gradientPrimary,
                    isLoading: _isSubmitting,
                    onPressed: _onConfirm,
                  ),
                  const SizedBox(height: 12),
                  ClinicQOutlinedButton(
                    label: 'Change day',
                    borderColor: ClinicQColors.primaryTeal,
                    textColor: ClinicQColors.primaryTeal,
                    onPressed: () {
                      context.pop();
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

  Widget _buildDetailRow({
    required String label,
    required String value,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        border: !isLast
            ? const Border(
                bottom: BorderSide(color: ClinicQColors.dividerLight, width: 1),
              )
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                color: ClinicQColors.textTertiary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: ClinicQColors.textPrimary,
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
