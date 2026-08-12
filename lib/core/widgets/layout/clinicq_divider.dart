import 'package:flutter/material.dart';
import '../../theme/clinic_q_colors.dart';

class ClinicQDivider extends StatelessWidget {
  const ClinicQDivider({
    super.key,
    this.height = 1.0,
    this.thickness = 1.0,
    this.color,
    this.indent = 0.0,
    this.endIndent = 0.0,
  });

  final double height;
  final double thickness;
  final Color? color;
  final double indent;
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Divider(
      height: height,
      thickness: thickness,
      color: color ??
          (isDark ? ClinicQColors.darkSurfaceVariant : ClinicQColors.dividerMedium),
      indent: indent,
      endIndent: endIndent,
    );
  }
}
