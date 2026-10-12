import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';

/// Clean and friendly empty state card shown when a home section has no items.
class HomeEmptySectionCard extends StatelessWidget {
  const HomeEmptySectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.actionLabel,
    this.onActionTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String? actionLabel;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? ClinicQColors.darkSurface : ClinicQColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? ClinicQColors.darkSurfaceVariant
              : ClinicQColors.cardBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: isDark
                  ? ClinicQColors.darkSurfaceVariant.withOpacity(0.6)
                  : ClinicQColors.primaryTeal.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 22,
              color: isDark ? ClinicQColors.lightTeal : ClinicQColors.primaryTeal,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : ClinicQColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: isDark
                  ? ClinicQColors.textTertiary
                  : ClinicQColors.textSecondary,
            ),
          ),
          if (actionLabel != null && onActionTap != null) ...[
            const SizedBox(height: 10),
            GestureDetector(
              onTap: onActionTap,
              child: Text(
                actionLabel!,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: ClinicQColors.primaryTeal,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
