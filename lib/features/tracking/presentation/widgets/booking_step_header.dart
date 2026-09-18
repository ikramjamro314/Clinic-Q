import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';

class BookingStepHeader extends StatelessWidget {
  final int currentStep; // 1: Doctor, 2: Confirm

  const BookingStepHeader({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStep(1, 'Doctor'),
          _buildDivider(1),
          _buildStep(2, 'Confirm'),
        ],
      ),
    );
  }

  Widget _buildStep(int stepIndex, String label) {
    final isCompleted = currentStep > stepIndex;
    final isActive = currentStep == stepIndex;

    Color circleColor;
    Widget innerWidget;
    TextStyle textStyle;

    if (isCompleted) {
      circleColor = ClinicQColors.primaryTeal;
      innerWidget = const Icon(Icons.check, color: Colors.white, size: 16);
      textStyle = const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: ClinicQColors.textSecondary,
      );
    } else if (isActive) {
      circleColor = ClinicQColors.darkBackground;
      innerWidget = Text(
        stepIndex.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      );
      textStyle = const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: ClinicQColors.textPrimary,
      );
    } else {
      circleColor = ClinicQColors.secondaryBackground;
      innerWidget = Text(
        stepIndex.toString(),
        style: const TextStyle(
          color: ClinicQColors.textTertiary,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      );
      textStyle = const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: ClinicQColors.textTertiary,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(shape: BoxShape.circle, color: circleColor),
          alignment: Alignment.center,
          child: innerWidget,
        ),
        const SizedBox(height: 6),
        Text(label, style: textStyle),
      ],
    );
  }

  Widget _buildDivider(int leftStepIndex) {
    final isCompleted = currentStep > leftStepIndex;
    return Container(
      width: 48,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8).copyWith(bottom: 20),
      color: isCompleted
          ? ClinicQColors.primaryTeal
          : ClinicQColors.dividerMedium,
    );
  }
}
