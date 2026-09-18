import 'package:flutter/material.dart';
import '../../../app/theme/clinic_q_colors.dart';

class ClinicQLoader extends StatelessWidget {
  const ClinicQLoader({
    super.key,
    this.color,
    this.size = 24.0,
    this.strokeWidth = 2.5,
  });

  final Color? color;
  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: color ?? ClinicQColors.spinnerColor,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
