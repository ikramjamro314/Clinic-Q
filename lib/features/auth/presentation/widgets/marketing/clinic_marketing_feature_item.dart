import 'package:flutter/material.dart';
import '../../../../../app/theme/clinic_q_colors.dart';

class ClinicMarketingFeatureItem extends StatelessWidget {
  const ClinicMarketingFeatureItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.title,
    required this.isSmallScreen,
    required this.fadeAnimation,
    required this.slideAnimation,
    this.isGrid = false,
  });

  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String title;
  final bool isSmallScreen;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;
    final double scale = (screenHeight / 812).clamp(0.75, 1.15);

    final double paddingVertical = isGrid ? 8.0 : (10.0 * scale);
    final double paddingHorizontal = isGrid ? 10.0 : (16.0 * scale);
    final double iconBoxSize = isGrid ? 30.0 : (42.0 * scale);
    final double iconSize = isGrid ? 15.0 : (22.0 * scale);
    final double fontSize = isGrid ? 11.5 : (14.0 * scale);

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal,
            vertical: paddingVertical,
          ),
          decoration: BoxDecoration(
            color: isDark
                ? ClinicQColors.darkSurface
                : ClinicQColors.secondaryBackground.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark
                  ? theme.colorScheme.outline.withOpacity(0.2)
                  : ClinicQColors.inputBorderDefault.withOpacity(0.5),
            ),
          ),
          child: Row(
            children: [
              // Left Icon container
              Container(
                width: iconBoxSize,
                height: iconBoxSize,
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: iconSize),
              ),
              const SizedBox(width: 10),
              // Feature Title
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDark ? Colors.white : ClinicQColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: fontSize,
                  ),
                ),
              ),
              if (!isGrid) ...[
                const SizedBox(width: 8),
                // Small green dot on right
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: ClinicQColors.tokenActive,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
