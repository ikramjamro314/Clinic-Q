import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';

class BookingDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Widget? valueWidget;

  const BookingDetailRow({
    super.key,
    required this.label,
    required this.value,
    this.valueWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: ClinicQColors.textTertiary,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        valueWidget ??
            Text(
              value,
              style: const TextStyle(
                color: ClinicQColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
      ],
    );
  }
}
