import 'package:flutter/material.dart';
import '../../../../core/theme/clinic_q_colors.dart';

class HomeSectionHeader extends StatelessWidget {
  const HomeSectionHeader({
    super.key,
    required this.title,
    this.actionTitle = 'See All',
    this.showAction = true,
    this.onActionTap,
  });

  final String title;
  final String actionTitle;
  final bool showAction;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: ClinicQColors.textPrimary,
            letterSpacing: -0.3,
          ),
        ),
        if (showAction)
          GestureDetector(
            onTap: onActionTap,
            child: Text(
              actionTitle,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: ClinicQColors.quickActionIcon,
              ),
            ),
          ),
      ],
    );
  }
}
