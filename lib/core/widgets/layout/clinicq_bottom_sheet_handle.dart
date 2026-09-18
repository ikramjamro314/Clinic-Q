import 'package:flutter/material.dart';
import '../../../app/theme/clinic_q_colors.dart';

class ClinicQBottomSheetHandle extends StatelessWidget {
  const ClinicQBottomSheetHandle({
    super.key,
    this.width = 48.0,
    this.height = 4.0,
    this.color,
    this.borderRadius = 2.0,
  });

  final double width;
  final double height;
  final Color? color;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final resolvedColor =
        color ??
        (isDark
            ? ClinicQColors.darkSurfaceVariant
            : ClinicQColors.dividerMedium);

    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: resolvedColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
