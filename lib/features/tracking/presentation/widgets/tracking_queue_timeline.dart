import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../domain/entities/tracking_snapshot.dart';

class TrackingQueueTimeline extends StatelessWidget {
  final TrackingSnapshot snapshot;

  const TrackingQueueTimeline({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final current = snapshot.currentTokenNumber;
    final mine = snapshot.yourTokenNumber;
    final isYourTurn = current == mine;
    final isUpcoming = current < mine;
    final isPassed = current > mine;

    Widget buildStep({
      required bool isActive,
      required bool isCompleted,
      required IconData icon,
      required Color color,
      required String title,
      required String subtitle,
      bool showLine = true,
    }) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? ClinicQColors.successBackground
                      : (isActive
                            ? color.withOpacity(0.12)
                            : ClinicQColors.secondaryBackground),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isCompleted
                        ? ClinicQColors.successBorder
                        : (isActive ? color : ClinicQColors.dividerMedium),
                    width: 2,
                  ),
                ),
                child: Icon(
                  isCompleted ? Icons.check_circle : icon,
                  size: 18,
                  color: isCompleted
                      ? ClinicQColors.successIcon
                      : (isActive ? color : ClinicQColors.textTertiary),
                ),
              ),
              if (showLine)
                Container(
                  width: 2,
                  height: 36,
                  color: isCompleted
                      ? ClinicQColors.successBorder
                      : ClinicQColors.dividerMedium,
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isActive || isCompleted
                        ? ClinicQColors.textPrimary
                        : ClinicQColors.textSecondary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: ClinicQColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Queue Status',
          style: TextStyle(
            color: ClinicQColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: ClinicQColors.cardBorder),
          ),
          child: Column(
            children: [
              buildStep(
                isActive: current >= 1,
                isCompleted: current > 0,
                icon: Icons.assignment_turned_in_outlined,
                color: ClinicQColors.primaryTeal,
                title: 'Checked In',
                subtitle: 'Successfully arrived and registered in the queue',
              ),
              buildStep(
                isActive: isUpcoming && current > 0,
                isCompleted: isYourTurn || isPassed,
                icon: Icons.hourglass_empty_rounded,
                color: ClinicQColors.primaryBlue,
                title: 'In Queue',
                subtitle: isPassed
                    ? 'Your turn has passed'
                    : (isYourTurn
                          ? 'You are next!'
                          : 'Currently ${snapshot.patientsAheadCount} patients ahead of you'),
              ),
              buildStep(
                isActive: isYourTurn,
                isCompleted: isPassed,
                icon: Icons.person_outline_rounded,
                color: ClinicQColors.tokenActive,
                title: 'Your Turn',
                subtitle: isYourTurn
                    ? 'Please proceed to the doctor\'s room now!'
                    : (isPassed
                          ? 'Completed'
                          : (snapshot.estimatedWaitMinutes != null
                              ? 'Estimated wait: ~${snapshot.estimatedWaitMinutes} mins'
                              : (snapshot.status == 'paused' || snapshot.queueStatus == 'PAUSED'
                                  ? 'Queue currently paused'
                                  : 'Wait time calculating...'))),
                showLine: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
