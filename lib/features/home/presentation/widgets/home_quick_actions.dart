import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';

class QuickActionData {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const QuickActionData({required this.label, required this.icon, this.onTap});
}

class HomeQuickActions extends StatelessWidget {
  const HomeQuickActions({
    super.key,
    this.onBookApptTap,
    this.onMyRecordsTap,
    this.onFindClinicTap,
    this.onSupportTap,
  });

  final VoidCallback? onBookApptTap;
  final VoidCallback? onMyRecordsTap;
  final VoidCallback? onFindClinicTap;
  final VoidCallback? onSupportTap;

  @override
  Widget build(BuildContext context) {
    final actions = [
      QuickActionData(
        label: 'Book Appt',
        icon: Icons.add_circle,
        onTap: onBookApptTap,
      ),
      QuickActionData(
        label: 'My Appt',
        icon: Icons.calendar_month,
        onTap: onMyRecordsTap,
      ),
      QuickActionData(
        label: 'Find Clinic',
        icon: Icons.local_hospital,
        onTap: onFindClinicTap,
      ),
      QuickActionData(
        label: 'Support',
        icon: Icons.headset_mic_outlined,
        onTap: onSupportTap,
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actions.map((item) {
        return Expanded(
          child: GestureDetector(
            onTap: item.onTap,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: ClinicQColors.quickActionBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    item.icon,
                    color: ClinicQColors.infoIcon,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: ClinicQColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
