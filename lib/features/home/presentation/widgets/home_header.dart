import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Good Morning, $userName ',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ClinicQColors.textSecondary,
              ),
            ),
            const Text('👋', style: TextStyle(fontSize: 14)),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          'How Are You Today?',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: ClinicQColors.textPrimary,
            letterSpacing: -0.4,
          ),
        ),
      ],
    );
  }
}
