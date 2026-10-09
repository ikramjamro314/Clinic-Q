import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/app_routes.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../core/utils/time_utils.dart';
import '../../../../core/widgets/feedback/clinicq_error_widget.dart';
import '../../../../core/widgets/feedback/clinicq_loader.dart';
import '../../../doctor/domain/entities/doctor_entity.dart';
import '../../../doctor/presentation/doctor_providers.dart';
import '../../../auth/presentation/auth_providers.dart';
import '../../domain/entities/token.dart';
import '../providers.dart';

class AppointmentHistoryScreen extends ConsumerStatefulWidget {
  const AppointmentHistoryScreen({super.key});

  @override
  ConsumerState<AppointmentHistoryScreen> createState() =>
      _AppointmentHistoryScreenState();
}

class _AppointmentHistoryScreenState
    extends ConsumerState<AppointmentHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentUser = ref.read(authRepositoryProvider).getCurrentUser();
      ref
          .read(appointmentViewModelProvider.notifier)
          .fetchTokens(userId: currentUser?.id);
    });
  }

  String _formatDateTime(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return 'Today';
    try {
      final dt = DateTime.parse(dateStr).toLocal();
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      final timeFormatted = TimeUtils.formatDateTimeTo12Hour(dt);
      return '${dt.day} ${months[dt.month - 1]}, ${dt.year} at $timeFormatted';
    } catch (e) {
      return 'Today';
    }
  }

  @override
  Widget build(BuildContext context) {
    final appointmentState = ref.watch(appointmentViewModelProvider);
    final currentUser = ref.watch(authRepositoryProvider).getCurrentUser();
    final userTokens = (currentUser != null
        ? appointmentState.tokens
            .where((t) => t.userId == currentUser.id)
            .toList()
        : appointmentState.tokens)
      ..sort((a, b) => (b.createdAt ?? '').compareTo(a.createdAt ?? ''));

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
          'Appointment History',
          style: TextStyle(
            color: ClinicQColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref
            .read(appointmentViewModelProvider.notifier)
            .fetchTokens(userId: currentUser?.id),
        color: ClinicQColors.primaryTeal,
        child: appointmentState.isLoading && userTokens.isEmpty
            ? const Center(child: ClinicQLoader())
            : appointmentState.errorMessage != null
            ? Center(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ClinicQErrorWidget(
                    message: appointmentState.errorMessage!,
                    onRetry: () => ref
                        .read(appointmentViewModelProvider.notifier)
                        .fetchTokens(userId: currentUser?.id),
                  ),
                ),
              )
            : userTokens.isEmpty
            ? _buildEmptyState()
            : _buildAppointmentList(userTokens),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: ClinicQColors.primaryTeal.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.calendar_today_rounded,
                color: ClinicQColors.primaryTeal,
                size: 48,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Appointments Found',
              style: TextStyle(
                color: ClinicQColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'You have not booked any clinic appointments yet.',
              style: TextStyle(
                color: ClinicQColors.textSecondary,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentList(List<Token> tokens) {
    return ListView.separated(
      padding: const EdgeInsets.all(24),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: tokens.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final token = tokens[index];
        return _AppointmentHistoryCard(
          token: token,
          formattedDate: _formatDateTime(token.createdAt),
        );
      },
    );
  }
}

class _AppointmentHistoryCard extends ConsumerWidget {
  final Token token;
  final String formattedDate;

  const _AppointmentHistoryCard({
    required this.token,
    required this.formattedDate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorAsync = ref
        .watch(doctorRepositoryProvider)
        .getDoctorById(token.doctorId);

    final isCompleted = token.status == 'completed';
    final isCancelled = token.status == 'cancelled';
    final isActive = !isCompleted && !isCancelled;

    Color badgeColor;
    Color textColor;
    String statusLabel;

    if (isCompleted) {
      badgeColor = ClinicQColors.tokenCompleted.withOpacity(0.1);
      textColor = ClinicQColors.tokenCompleted;
      statusLabel = 'Completed';
    } else if (isCancelled) {
      badgeColor = ClinicQColors.errorBackground;
      textColor = ClinicQColors.errorText;
      statusLabel = 'Cancelled';
    } else {
      badgeColor = ClinicQColors.successBackground;
      textColor = ClinicQColors.successText;
      statusLabel = 'Active';
    }

    return FutureBuilder<DoctorEntity?>(
      future: doctorAsync,
      builder: (context, snapshot) {
        final doctor = snapshot.data;
        final doctorName = doctor?.name ?? 'Doctor';
        final clinicName = doctor?.clinicName ?? 'Clinic';
        final specialty = doctor?.specialty ?? 'General Practice';
        final initials = doctorName
            .split(' ')
            .where((e) => e.isNotEmpty)
            .map((e) => e[0])
            .take(2)
            .join()
            .toUpperCase();

        return Container(
          decoration: BoxDecoration(
            color: ClinicQColors.cardBackground,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: ClinicQColors.cardBorder, width: 1),
            boxShadow: [
              BoxShadow(
                color: ClinicQColors.textPrimary.withOpacity(0.04),
                blurRadius: 16,
                spreadRadius: 0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                if (isActive) {
                  // Direct to Live Tracking screen
                  context.push('/tracking/${token.id}');
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: ClinicQColors.primaryTeal.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            initials,
                            style: const TextStyle(
                              color: ClinicQColors.primaryTeal,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctorName,
                                style: const TextStyle(
                                  color: ClinicQColors.textPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '$specialty • $clinicName',
                                style: const TextStyle(
                                  color: ClinicQColors.textSecondary,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: badgeColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            statusLabel,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    const Divider(color: ClinicQColors.dividerLight, height: 1),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Appointment Time',
                              style: TextStyle(
                                color: ClinicQColors.textTertiary,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              formattedDate,
                              style: const TextStyle(
                                color: ClinicQColors.textPrimary,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Token Number',
                              style: TextStyle(
                                color: ClinicQColors.textTertiary,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              token.tokenNumber != null
                                  ? '#${token.tokenNumber}'
                                  : '--',
                              style: const TextStyle(
                                color: ClinicQColors.primaryTeal,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (isActive) ...[
                      const SizedBox(height: 14),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: ClinicQColors.primaryTeal.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.radar_rounded,
                              color: ClinicQColors.primaryTeal,
                              size: 16,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Tap to Live Track Queue',
                              style: TextStyle(
                                color: ClinicQColors.primaryTeal,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
