import 'package:flutter/material.dart';
import '../../theme/clinic_q_colors.dart';

class ClinicQGradientBackground extends StatelessWidget {
  const ClinicQGradientBackground({
    super.key,
    required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = double.infinity,
  });

  final Widget child;
  final Gradient? gradient;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient ?? ClinicQColors.gradientBackground,
      ),
      child: child,
    );
  }
}
