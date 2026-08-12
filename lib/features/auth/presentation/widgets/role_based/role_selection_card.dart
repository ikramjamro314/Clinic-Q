import 'package:flutter/material.dart';
import '../../../../../core/theme/clinic_q_colors.dart';

class RoleSelectionCard extends StatelessWidget {
  const RoleSelectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.trailing,
    required this.onTap,
    required this.isSmallScreen,
    required this.isDark,
    this.isGradientBorder = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final Widget trailing;
  final VoidCallback onTap;
  final bool isSmallScreen;
  final bool isDark;
  final bool isGradientBorder;

  @override
  Widget build(BuildContext context) {
    final double padding = isSmallScreen ? 12.0 : 16.0;
    final double iconBoxSize = isSmallScreen ? 40 : 48;
    final double iconSize = isSmallScreen ? 20 : 24;

    Widget cardContent = Padding(
      padding: EdgeInsets.all(padding),
      child: Row(
        children: [
          Container(
            width: iconBoxSize,
            height: iconBoxSize,
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: iconSize),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isDark ? Colors.white : ClinicQColors.textPrimary,
                    fontWeight: FontWeight.w900,
                    fontSize: isSmallScreen ? 14 : 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isDark
                        ? ClinicQColors.textTertiary
                        : ClinicQColors.textSecondary,
                    fontSize: isSmallScreen ? 11 : 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );

    if (isGradientBorder) {
      return Container(
        decoration: BoxDecoration(
          gradient: ClinicQColors.gradientPrimary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: ClinicQColors.primaryTeal.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.all(1.5), // Gradient border thickness
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? ClinicQColors.darkSurface : Colors.white,
            borderRadius: BorderRadius.circular(18.5),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(18.5),
              child: cardContent,
            ),
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: isDark ? ClinicQColors.darkSurface : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark
                ? ClinicQColors.darkSurfaceVariant
                : ClinicQColors.inputBorderDefault,
            width: 1.5,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(18.5),
            child: cardContent,
          ),
        ),
      );
    }
  }
}
