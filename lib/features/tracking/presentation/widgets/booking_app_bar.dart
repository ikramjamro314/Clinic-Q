import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/clinic_q_colors.dart';

class BookingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? stepText;
  final VoidCallback? onBack;
  final Widget? trailing;

  const BookingAppBar({
    super.key,
    this.title = 'Book a token',
    this.stepText,
    this.onBack,
    this.trailing,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ClinicQColors.appBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 20,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ClinicQColors.cardBorder,
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 14,
                    color: ClinicQColors.textPrimary,
                  ),
                  onPressed: onBack ?? () => context.pop(),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  color: ClinicQColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          if (stepText != null)
            Text(
              stepText!,
              style: const TextStyle(
                color: ClinicQColors.textTertiary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            )
          else if (trailing != null)
            trailing!,
        ],
      ),
    );
  }
}
