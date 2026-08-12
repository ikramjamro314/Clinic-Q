import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../core/theme/clinic_q_colors.dart';
import '../../../../core/theme/clinic_q_theme.dart';
import '../../../../core/widgets/layout/clinicq_bottom_sheet_handle.dart';
import '../../../../core/widgets/layout/clinicq_gradient_background.dart';
import '../widgets/role_based/role_selection_card.dart';
import '../widgets/role_based/role_selection_illustration.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _entranceController;

  // Animations
  late Animation<double> _headingFade;
  late Animation<Offset> _headingSlide;
  late Animation<double> _subtitleFade;

  // Card Animations
  late Animation<double> _card1Fade;
  late Animation<Offset> _card1Slide;
  late Animation<double> _card2Fade;
  late Animation<Offset> _card2Slide;

  @override
  void initState() {
    super.initState();

    // Entrance Animation Controller (800ms)
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _headingFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    _headingSlide =
        Tween<Offset>(begin: const Offset(0.0, 0.25), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
          ),
        );

    _subtitleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.125, 0.525, curve: Curves.easeOut),
      ),
    );

    // Card 1: 200ms delay => starts at 0.25 (200/800) to 0.75 (600/800)
    _card1Fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.25, 0.75, curve: Curves.easeOut),
      ),
    );

    _card1Slide =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: const Interval(0.25, 0.75, curve: Curves.easeOut),
          ),
        );

    // Card 2: 320ms delay => starts at 0.4 (320/800) to 0.9 (720/800)
    _card2Fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.4, 0.9, curve: Curves.easeOut),
      ),
    );

    _card2Slide =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: const Interval(0.4, 0.9, curve: Curves.easeOut),
          ),
        );

    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  void _navigateToLogin() {
    context.go(AppRoutes.login);
  }

  void _navigateToWalkInEntry() {
    context.go(AppRoutes.walkInEntry);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;

    final double scale = (screenHeight / 812).clamp(0.75, 1.15);
    final bool useSmallStyle = screenHeight < 720;

    return Scaffold(
      body: ClinicQGradientBackground(
        child: Column(
          children: [
            // Upper Section: Logo, title, illustration (takes remaining space)
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: ClinicQColors.gradientPrimary,
                ),
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 8 * scale),
                      // Plus brand logo
                      Container(
                        width: (useSmallStyle ? 50.0 : 64.0) * scale,
                        height: (useSmallStyle ? 50.0 : 64.0) * scale,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16 * scale),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.4),
                            width: 1.5 * scale,
                          ),
                        ),
                        child: Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 32 * scale,
                        ),
                      ),

                      // Title Text
                      Column(
                        children: [
                          Text(
                            'CLINICQ',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5 * scale,
                              fontSize: (14 * scale).clamp(11.0, 16.0),
                            ),
                          ),
                          SizedBox(height: 4 * scale),
                          FadeTransition(
                            opacity: _headingFade,
                            child: SlideTransition(
                              position: _headingSlide,
                              child: Text(
                                'Your health,\nyour queue.',
                                textAlign: TextAlign.center,
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  height: 1.2,
                                  fontSize: (32 * scale).clamp(24.0, 36.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 4 * scale),
                          FadeTransition(
                            opacity: _subtitleFade,
                            child: Text(
                              'How would you like to continue?',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.w500,
                                fontSize: (14 * scale).clamp(11.5, 16.0),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Upper Graphic: Clinic & People line art
                      Flexible(
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8 * scale,
                              ),
                              child: RoleSelectionIllustration(
                                isSmallScreen: useSmallStyle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Lower Section: White Card (takes required height)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark
                    ? ClinicQColors.darkBackground
                    : ClinicQColors.cardBackground,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32 * scale),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 24 * scale,
                    offset: Offset(0, -8 * scale),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 24 * scale,
                vertical: 28 * scale,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Handle-like indicator bar
                  ClinicQBottomSheetHandle(
                    width: 48 * scale,
                    height: 4 * scale,
                    borderRadius: 2 * scale,
                  ),
                  SizedBox(height: 24 * scale),

                  // Title
                  Text(
                    'Choose how to continue',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: isDark ? Colors.white : ClinicQColors.textPrimary,
                      fontWeight: FontWeight.w900,
                      fontSize: (22 * scale).clamp(18.0, 26.0),
                    ),
                  ),
                  SizedBox(height: 28 * scale),

                  // Role Cards Stack
                  Column(
                    children: [
                      // Card 1: I have an Account (Gradient border)
                      FadeTransition(
                        opacity: _card1Fade,
                        child: SlideTransition(
                          position: _card1Slide,
                          child: RoleSelectionCard(
                            title: 'I have an Account',
                            subtitle: 'Login or sign up with phone number',
                            icon: Icons.person_outline_rounded,
                            iconColor: ClinicQColors.primaryTeal,
                            iconBg: ClinicQColors.primaryTeal.withOpacity(0.1),
                            trailing: Container(
                              width: 32 * scale,
                              height: 32 * scale,
                              decoration: const BoxDecoration(
                                gradient: ClinicQColors.gradientPrimary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: 16 * scale,
                              ),
                            ),
                            onTap: _navigateToLogin,
                            isSmallScreen: useSmallStyle,
                            isDark: isDark,
                            isGradientBorder: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 16 * scale),

                      // Card 2: I\'m a Walk-in Patient (Normal Border)
                      FadeTransition(
                        opacity: _card2Fade,
                        child: SlideTransition(
                          position: _card2Slide,
                          child: RoleSelectionCard(
                            title: 'I\'m a Walk-in Patient',
                            subtitle: 'Track queue without signing up',
                            icon: Icons.airline_seat_recline_normal_rounded,
                            iconColor: ClinicQColors.primaryBlue,
                            iconBg: ClinicQColors.primaryBlue.withOpacity(0.1),
                            trailing: Icon(
                              Icons.chevron_right_rounded,
                              color: isDark
                                  ? ClinicQColors.textTertiary
                                  : ClinicQColors.textSecondary,
                              size: 24 * scale,
                            ),
                            onTap: _navigateToWalkInEntry,
                            isSmallScreen: useSmallStyle,
                            isDark: isDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24 * scale),

                  // Terms & Privacy disclaimer text
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8 * scale),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: ClinicQColors.textTertiary,
                          fontWeight: FontWeight.w500,
                          fontSize: (11 * scale).clamp(9.0, 13.0),
                        ),
                        children: [
                          const TextSpan(
                            text: 'By continuing you agree to our ',
                          ),
                          TextSpan(
                            text: 'Terms',
                            style: TextStyle(
                              color: isDark
                                  ? ClinicQColors.lightTeal
                                  : ClinicQColors.primaryTeal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: ' & '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: isDark
                                  ? ClinicQColors.lightTeal
                                  : ClinicQColors.primaryTeal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
