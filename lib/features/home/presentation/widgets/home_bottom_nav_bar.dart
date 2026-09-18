import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../../../app/theme/clinic_q_colors.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: currentIndex,
      height: 70, // Tuned for a shallower, subtler notch appearance
      backgroundColor: Colors.transparent, // Background behind the curve
      color: Colors.white.withOpacity(
        0.98,
      ), // Slightly translucent white for a low fade surface effect
      buttonBackgroundColor: Colors.transparent, // The raised active circle
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      onTap: onTap,
      items: [
        _buildNavItem(
          index: 0,
          icon: Icons.apartment_rounded,
          label: 'Clinics',
          showActiveDot: true,
        ),
        _buildNavItem(
          index: 1,
          icon: Icons.medical_services_outlined,
          label: 'Doctors',
          showActiveDot: true,
        ),
        _buildNavItem(
          index: 2,
          icon: Icons.home_outlined,
          label: 'Home',
          showActiveDot: false,
        ),
        _buildNavItem(
          index: 3,
          icon: Icons.queue_rounded,
          label: 'Queue',
          showActiveDot: true,
        ),
        _buildNavItem(
          index: 4,
          icon: Icons.person_outline_rounded,
          label: 'Profile',
          showActiveDot: true,
        ),
      ],
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    bool showActiveDot = false,
  }) {
    final isActive = currentIndex == index;

    // When active, the item moves up into the primaryTeal circle.
    if (isActive) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: ClinicQColors.gradientHomeFab,
          boxShadow: [
            BoxShadow(
              color: ClinicQColors.primaryTeal.withOpacity(0.5),
              blurRadius: 16,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 28),
      );
    }

    // When inactive, it stays in the white bar.
    // Show the icon, text, and conditional dot, same as before.
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: ClinicQColors.textSecondary, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: ClinicQColors.textSecondary,
          ),
        ),
        const SizedBox(height: 2),
        // Active dot indicator (only shows if active, but we are in inactive block.
        // However, to keep spacing exactly same, we render a transparent dot placeholder)
        Container(
          height: 4,
          width: 4,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
