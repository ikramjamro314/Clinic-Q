import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/clinic_q_colors.dart';
import '../../../../core/widgets/feedback/clinicq_loader.dart';
import '../../../../core/widgets/feedback/clinicq_error_widget.dart';
import '../../../../core/widgets/buttons/clinicq_button.dart';
import '../../../auth/presentation/auth_providers.dart';
import '../providers.dart';
import '../widgets/booking_step_header.dart';
import '../widgets/doctor_queue_card.dart';
import '../widgets/booking_detail_row.dart';
import 'token_info_screen.dart';
import 'booking_success_screen.dart';

class ConfirmBookingScreen extends ConsumerStatefulWidget {
  final String doctorId;
  final String clinicId;
  final TokenInfoData? initialData;

  const ConfirmBookingScreen({
    super.key,
    required this.doctorId,
    required this.clinicId,
    this.initialData,
  });

  @override
  ConsumerState<ConfirmBookingScreen> createState() => _ConfirmBookingScreenState();
}

class _ConfirmBookingScreenState extends ConsumerState<ConfirmBookingScreen> {
  final TextEditingController _notesController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

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

  Future<void> _onConfirm(TokenInfoData data) async {
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
    final success = await appointmentNotifier.createToken(
      doctorId: widget.doctorId,
      clinicId: widget.clinicId,
      userId: currentUser.id,
      notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
    );

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    if (success) {
      // Find the booked token
      final appState = ref.read(appointmentViewModelProvider);
      final bookedToken = appState.tokens.firstWhere(
        (t) => t.doctorId == widget.doctorId && t.clinicId == widget.clinicId,
      );
      
      context.push(
        '/booking/success?doctorId=${widget.doctorId}&clinicId=${widget.clinicId}',
        extra: BookingSuccessParams(
          doctor: data.doctor,
          preview: data.preview,
          token: bookedToken,
        ),
      );
    } else {
      final appState = ref.read(appointmentViewModelProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(appState.errorMessage ?? 'Booking failed. Please try again.'),
          backgroundColor: ClinicQColors.errorIcon,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final todayStr = _formatToday();

    // Use initialData if provided, otherwise load using FutureProvider
    if (widget.initialData != null) {
      return _buildContent(widget.initialData!, todayStr);
    }

    final params = TokenInfoParams(doctorId: widget.doctorId, clinicId: widget.clinicId);
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
          'Confirm Booking',
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
        data: (data) => _buildContent(data, todayStr),
      ),
    );
  }

  Widget _buildContent(TokenInfoData data, String todayStr) {
    final doctor = data.doctor;
    final preview = data.preview;

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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const BookingStepHeader(currentStep: 3),
                    const SizedBox(height: 12),
                    // Details container card
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DoctorQueueCard(
                            doctor: doctor,
                            tokenNumber: preview.nextTokenNumber,
                            isConfirmLayout: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              children: [
                                // Grid of details
                                GridView.count(
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  childAspectRatio: 2.2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  children: [
                                    BookingDetailRow(
                                      label: 'Doctor',
                                      value: doctor.name,
                                    ),
                                    BookingDetailRow(
                                      label: 'Specialty',
                                      value: doctor.specialty,
                                    ),
                                    BookingDetailRow(
                                      label: 'Clinic',
                                      value: doctor.clinicName,
                                    ),
                                    BookingDetailRow(
                                      label: 'Date',
                                      value: 'Today',
                                    ),
                                    BookingDetailRow(
                                      label: 'Patients Ahead',
                                      value: preview.patientsAheadCount.toString(),
                                    ),
                                    BookingDetailRow(
                                      label: 'Est. Wait',
                                      value: waitTimeStr,
                                    ),
                                    BookingDetailRow(
                                      label: 'Timings',
                                      value: '${doctor.startTime ?? "9:00 AM"} – ${doctor.endTime ?? "2:00 PM"}',
                                    ),
                                    BookingDetailRow(
                                      label: 'Queue Status',
                                      value: 'In Progress',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                // Consultation Fee Row
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ClinicQColors.availableBadgeBackground,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Consultation Fee',
                                        style: TextStyle(
                                          color: ClinicQColors.textSecondary,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'PKR ${doctor.price.toInt()}',
                                        style: const TextStyle(
                                          color: ClinicQColors.availableBadgeText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Notes Input Field
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'SYMPTOMS OR NOTES (OPTIONAL)',
                            style: TextStyle(
                              color: ClinicQColors.textTertiary,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _notesController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'e.g. Fever, coughing, headache...',
                              hintStyle: const TextStyle(
                                color: ClinicQColors.textTertiary,
                                fontSize: 13,
                              ),
                              contentPadding: const EdgeInsets.all(12),
                              filled: true,
                              fillColor: ClinicQColors.secondaryBackground,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: ClinicQColors.primaryTeal,
                                  width: 1,
                                ),
                              ),
                            ),
                            style: const TextStyle(
                              color: ClinicQColors.textPrimary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Change doctor text link
                    GestureDetector(
                      onTap: () {
                        context.pop(); // Returns to TokenInfoScreen
                        context.pop(); // Returns to Profile or Clinic selector
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.arrow_back_rounded,
                            size: 16,
                            color: ClinicQColors.primaryBlue,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Change doctor',
                            style: TextStyle(
                              color: ClinicQColors.primaryBlue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: _isSubmitting
                  ? const Center(child: CircularProgressIndicator(color: ClinicQColors.primaryTeal))
                  : ClinicQButton(
                      label: 'Confirm Appointment',
                      gradient: ClinicQColors.gradientPrimary,
                      onPressed: () => _onConfirm(data),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
