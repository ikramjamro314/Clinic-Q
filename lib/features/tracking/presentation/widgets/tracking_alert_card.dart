import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';

class TrackingAlertCard extends StatelessWidget {
  const TrackingAlertCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: ClinicQColors.infoBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ClinicQColors.infoBorder.withOpacity(0.25),
          width: 1.2,
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.notifications_active_rounded,
            color: ClinicQColors.infoIcon,
            size: 20,
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Alert me when 1 person is ahead',
                  style: TextStyle(
                    color: ClinicQColors.infoText,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'So you can start walking in',
                  style: TextStyle(
                    color: ClinicQColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
