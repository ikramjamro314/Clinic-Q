import 'package:flutter/material.dart';
import '../../theme/clinic_q_colors.dart';

class ClinicQPageIndicator extends StatelessWidget {
  const ClinicQPageIndicator({
    super.key,
    required this.currentIndex,
    required this.count,
    this.activeColor,
    this.inactiveColor,
    this.activeWidth = 18.0,
    this.inactiveWidth = 6.0,
    this.height = 6.0,
    this.spacing = 6.0,
  });

  final int currentIndex;
  final int count;
  final Color? activeColor;
  final Color? inactiveColor;
  final double activeWidth;
  final double inactiveWidth;
  final double height;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final resolvedActiveColor = activeColor ?? ClinicQColors.primaryTeal;
    final resolvedInactiveColor = inactiveColor ??
        (isDark ? ClinicQColors.darkSurfaceVariant : ClinicQColors.dividerStrong);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final selected = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          width: selected ? activeWidth : inactiveWidth,
          height: height,
          decoration: BoxDecoration(
            color: selected ? resolvedActiveColor : resolvedInactiveColor,
            borderRadius: BorderRadius.circular(height / 2),
          ),
        );
      }),
    );
  }
}
