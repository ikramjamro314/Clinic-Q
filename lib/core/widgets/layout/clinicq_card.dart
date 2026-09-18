import 'package:flutter/material.dart';
import '../../../app/theme/clinic_q_colors.dart';

class ClinicQCard extends StatelessWidget {
  const ClinicQCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = 24,
    this.backgroundColor,
    this.border,
    this.boxShadow,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color? backgroundColor;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final defaultBorder =
        border ??
        Border.all(
          color: isDark
              ? ClinicQColors.darkSurfaceVariant
              : theme.colorScheme.outlineVariant,
        );

    final defaultBoxShadow =
        boxShadow ??
        const [
          BoxShadow(
            color: ClinicQColors.cardShadow,
            blurRadius: 30,
            offset: Offset(0, 14),
          ),
        ];

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            (isDark ? ClinicQColors.darkSurface : theme.colorScheme.surface),
        borderRadius: BorderRadius.circular(borderRadius),
        border: defaultBorder,
        boxShadow: defaultBoxShadow,
      ),
      child: child,
    );
  }
}
