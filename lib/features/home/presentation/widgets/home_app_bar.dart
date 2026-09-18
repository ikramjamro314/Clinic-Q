import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../core/widgets/display/clinicq_avatar.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.userName,
    this.onNotificationTap,
    this.onProfileTap,
    this.hasUnreadNotifications = true,
  });

  final String userName;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;
  final bool hasUnreadNotifications;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ClinicQColors.appBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      title: const Text(
        'ClinicQ',
        style: TextStyle(
          color: ClinicQColors.primaryBlue,
          fontWeight: FontWeight.w800,
          fontSize: 20,
          letterSpacing: -0.2,
        ),
      ),
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              onPressed: onNotificationTap,
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: ClinicQColors.textPrimary,
                size: 24,
              ),
            ),
            if (hasUnreadNotifications)
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: ClinicQColors.tokenMissed,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        GestureDetector(
          onTap: onProfileTap,
          child: Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ClinicQColors.inputBorderDefault,
                width: 1.5,
              ),
            ),
            child: ClinicQAvatar(
              initials: userName.isNotEmpty ? userName[0] : 'U',
              radius: 16,
              backgroundColor: ClinicQColors.secondaryBackground,
              foregroundColor: ClinicQColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
