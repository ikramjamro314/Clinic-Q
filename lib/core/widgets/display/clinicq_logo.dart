import 'package:flutter/material.dart';
import '../../theme/clinic_q_colors.dart';

class ClinicQLogo extends StatelessWidget {
  const ClinicQLogo({
    super.key,
    this.size = 90.0,
    this.showText = false,
    this.textColor,
  });

  final double size;
  final bool showText;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final computedBorderRadius = size * 0.25;
    final computedFontSize = size * 0.58;
    final computedBadgePosition = size * 0.12;
    final computedBadgePadding = size * 0.013;
    final computedIconSize = size * 0.16;

    final logoCard = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: ClinicQColors.gradientPrimary,
        borderRadius: BorderRadius.circular(computedBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: size * 0.18,
            offset: Offset(0, size * 0.09),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            'Q',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: computedFontSize,
            ),
          ),
          Positioned(
            bottom: computedBadgePosition,
            right: computedBadgePosition,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(computedBadgePadding.clamp(1.0, 3.0)),
              child: Icon(
                Icons.add_circle,
                color: ClinicQColors.primaryTeal,
                size: computedIconSize,
              ),
            ),
          ),
        ],
      ),
    );

    if (showText) {
      final resolvedTextColor = textColor ??
          (isDark ? ClinicQColors.lightTeal : ClinicQColors.primaryTeal);
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          logoCard,
          SizedBox(height: size * 0.13),
          Text(
            'ClinicQ',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: resolvedTextColor,
              letterSpacing: 0.5,
            ),
          ),
        ],
      );
    }

    return logoCard;
  }
}
