import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/app_routes.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../app/theme/clinic_q_theme.dart';
import '../../../../core/widgets/buttons/clinicq_button.dart';
import '../../../../core/widgets/layout/clinicq_gradient_background.dart';
import '../widgets/marketing/clinic_marketing_feature_item.dart';
import '../widgets/marketing/clinic_marketing_illustration.dart';

class ClinicMarketingScreen extends StatefulWidget {
  const ClinicMarketingScreen({super.key});

  @override
  State<ClinicMarketingScreen> createState() => _ClinicMarketingScreenState();
}

class _ClinicMarketingScreenState extends State<ClinicMarketingScreen>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late AnimationController _floatController;

  // Animations
  late Animation<double> _skipFade;
  late Animation<double> _heroFade;
  late Animation<double> _headingFade;
  late Animation<Offset> _headingSlide;
  late Animation<double> _bodyFade;

  // Feature items staggered animations
  final List<Animation<double>> _featureFades = [];
  final List<Animation<Offset>> _featureSlides = [];

  // CTA Button animation
  late Animation<double> _ctaScale;

  // Floating loop animation
  late Animation<double> _floatOffset;

  @override
  void initState() {
    super.initState();

    // 1. Entrance Animations Controller (1200ms total)
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // 2. Float Loop Controller (2000ms total, repeats infinitely in reverse)
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Define Animations
    _skipFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.2, curve: Curves.easeOut),
      ),
    );

    _heroFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    _headingFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.125, 0.375, curve: Curves.easeOut),
      ),
    );

    _headingSlide =
        Tween<Offset>(begin: const Offset(0.0, 0.25), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: const Interval(0.125, 0.375, curve: Curves.easeOut),
          ),
        );

    _bodyFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.208, 0.458, curve: Curves.easeOut),
      ),
    );

    // Staggered features: 50ms gaps => in 1200ms controller, 50ms is ~0.041
    for (int i = 0; i < 4; i++) {
      final start = 0.208 + (i * 0.041);
      final end = start + 0.25; // 300ms duration

      _featureFades.add(
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: Interval(start, end, curve: Curves.easeOut),
          ),
        ),
      );

      _featureSlides.add(
        Tween<Offset>(begin: const Offset(0.0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: Interval(start, end, curve: Curves.easeOut),
          ),
        ),
      );
    }

    // CTA Button starts at 416ms (0.347) to 750ms (0.625)
    _ctaScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.347, 0.625, curve: Curves.easeOutBack),
      ),
    );

    // Floating loop (gentle float up/down)
    _floatOffset = Tween<double>(begin: 0.0, end: -8.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // Start Animations
    _entranceController.forward();
    _floatController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  Future<void> _launchDashboard() async {
    await HapticFeedback.mediumImpact();
    final url = Uri.parse('https://dashboard.clinicq.com');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch ClinicQ Dashboard')),
        );
      }
    }
  }

  void _navigateToRoleSelection() {
    context.go(AppRoutes.roleSelection);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;

    // Proportional scale factor based on standard height (812px)
    final double scale = (screenHeight / 812).clamp(0.75, 1.15);

    // Breakpoint for structural layout switch (2x2 grid vs vertical list)
    final bool useGrid = screenHeight < 760;

    return Scaffold(
      body: ClinicQGradientBackground(
        child: Column(
          children: [
            // Top Section (Upper part: Onboarding illustration, Skip button)
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: ClinicQColors.gradientPrimary,
                ),
                child: SafeArea(
                  bottom: false,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Skip Button in Top Right
                      Positioned(
                        top: 8 * scale,
                        right: 16 * scale,
                        child: FadeTransition(
                          opacity: _skipFade,
                          child: TextButton(
                            onPressed: _navigateToRoleSelection,
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.2),
                              shape: const StadiumBorder(),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16 * scale,
                                vertical: 8 * scale,
                              ),
                            ),
                            child: Text(
                              'Skip',
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: (14 * scale).clamp(11.0, 16.0),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Hero Illustration
                      Positioned(
                        top: 44 * scale,
                        bottom: 10 * scale,
                        left: 20 * scale,
                        right: 20 * scale,
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: FadeTransition(
                              opacity: _heroFade,
                              child: AnimatedBuilder(
                                animation: _floatOffset,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset: Offset(0, _floatOffset.value),
                                    child: child,
                                  );
                                },
                                child: ClinicMarketingIllustration(
                                  isSmallScreen: useGrid,
                                ),
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

            // Bottom Section (Lower part: Marketing features card)
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
                vertical: 20 * scale,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Heading Text
                  FadeTransition(
                    opacity: _headingFade,
                    child: SlideTransition(
                      position: _headingSlide,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: isDark
                                ? Colors.white
                                : ClinicQColors.textPrimary,
                            letterSpacing: -0.5,
                            fontSize: (24 * scale).clamp(18.0, 28.0),
                          ),
                          children: const [
                            TextSpan(text: 'Are You a '),
                            TextSpan(
                              text: 'Clinic Owner?',
                              style: TextStyle(
                                color: ClinicQColors.primaryTeal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 6 * scale),

                  // Subtitle Body
                  FadeTransition(
                    opacity: _bodyFade,
                    child: Text(
                      'ClinicQ gives your clinic a powerful web dashboard to manage appointments, reduce queues, and delight patients.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? ClinicQColors.textTertiary
                            : ClinicQColors.textSecondary,
                        height: 1.35,
                        fontWeight: FontWeight.w500,
                        fontSize: (14 * scale).clamp(11.5, 16.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 12 * scale),

                  // Feature List (4 items)
                  useGrid
                      ? Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ClinicMarketingFeatureItem(
                                    icon: Icons.local_hospital_outlined,
                                    iconColor: ClinicQColors.primaryTeal,
                                    bgColor: ClinicQColors.primaryTeal
                                        .withOpacity(0.1),
                                    title: 'Manage appointments',
                                    isSmallScreen: useGrid,
                                    fadeAnimation: _featureFades[0],
                                    slideAnimation: _featureSlides[0],
                                    isGrid: true,
                                  ),
                                ),
                                SizedBox(width: 8 * scale),
                                Expanded(
                                  child: ClinicMarketingFeatureItem(
                                    icon: Icons.access_time_rounded,
                                    iconColor: ClinicQColors.primaryBlue,
                                    bgColor: ClinicQColors.primaryBlue
                                        .withOpacity(0.1),
                                    title: 'Real-time queue',
                                    isSmallScreen: useGrid,
                                    fadeAnimation: _featureFades[1],
                                    slideAnimation: _featureSlides[1],
                                    isGrid: true,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8 * scale),
                            Row(
                              children: [
                                Expanded(
                                  child: ClinicMarketingFeatureItem(
                                    icon: Icons.trending_up_rounded,
                                    iconColor: ClinicQColors.primaryTeal,
                                    bgColor: ClinicQColors.primaryTeal
                                        .withOpacity(0.1),
                                    title: 'Patient flow insights',
                                    isSmallScreen: useGrid,
                                    fadeAnimation: _featureFades[2],
                                    slideAnimation: _featureSlides[2],
                                    isGrid: true,
                                  ),
                                ),
                                SizedBox(width: 8 * scale),
                                Expanded(
                                  child: ClinicMarketingFeatureItem(
                                    icon: Icons.check_box_outlined,
                                    iconColor: ClinicQColors.primaryBlue,
                                    bgColor: ClinicQColors.primaryBlue
                                        .withOpacity(0.1),
                                    title: 'Zero paperwork',
                                    isSmallScreen: useGrid,
                                    fadeAnimation: _featureFades[3],
                                    slideAnimation: _featureSlides[3],
                                    isGrid: true,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            ClinicMarketingFeatureItem(
                              icon: Icons.local_hospital_outlined,
                              iconColor: ClinicQColors.primaryTeal,
                              bgColor: ClinicQColors.primaryTeal.withOpacity(
                                0.1,
                              ),
                              title: 'Manage appointments easily',
                              isSmallScreen: useGrid,
                              fadeAnimation: _featureFades[0],
                              slideAnimation: _featureSlides[0],
                            ),
                            SizedBox(height: 8 * scale),
                            ClinicMarketingFeatureItem(
                              icon: Icons.access_time_rounded,
                              iconColor: ClinicQColors.primaryBlue,
                              bgColor: ClinicQColors.primaryBlue.withOpacity(
                                0.1,
                              ),
                              title: 'Real-time queue management',
                              isSmallScreen: useGrid,
                              fadeAnimation: _featureFades[1],
                              slideAnimation: _featureSlides[1],
                            ),
                            SizedBox(height: 8 * scale),
                            ClinicMarketingFeatureItem(
                              icon: Icons.trending_up_rounded,
                              iconColor: ClinicQColors.primaryTeal,
                              bgColor: ClinicQColors.primaryTeal.withOpacity(
                                0.1,
                              ),
                              title: 'Patient flow insights & analytics',
                              isSmallScreen: useGrid,
                              fadeAnimation: _featureFades[2],
                              slideAnimation: _featureSlides[2],
                            ),
                            SizedBox(height: 8 * scale),
                            ClinicMarketingFeatureItem(
                              icon: Icons.check_box_outlined,
                              iconColor: ClinicQColors.primaryBlue,
                              bgColor: ClinicQColors.primaryBlue.withOpacity(
                                0.1,
                              ),
                              title: 'Zero paperwork, fully digital',
                              isSmallScreen: useGrid,
                              fadeAnimation: _featureFades[3],
                              slideAnimation: _featureSlides[3],
                            ),
                          ],
                        ),
                  SizedBox(height: 16 * scale),

                  // CTA Button with Scale entrance
                  ScaleTransition(
                    scale: _ctaScale,
                    child: ClinicQButton(
                      label: 'Visit ClinicQ Dashboard',
                      onPressed: _launchDashboard,
                      icon: Icons.arrow_forward_rounded,
                      height: 56 * scale,
                      gradient: ClinicQColors.gradientPrimary,
                    ),
                  ),
                  SizedBox(height: 6 * scale),

                  // dashboard link under CTA
                  Text(
                    'dashboard.clinicq.com',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: ClinicQColors.textTertiary,
                      fontWeight: FontWeight.w500,
                      fontSize: (12 * scale).clamp(10.0, 14.0),
                    ),
                  ),
                  SizedBox(height: 12 * scale),

                  // Continue as Patient secondary button
                  Center(
                    child: TextButton(
                      onPressed: _navigateToRoleSelection,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24 * scale,
                          vertical: 8 * scale,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Continue as Patient',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: isDark
                                  ? ClinicQColors.lightTeal
                                  : ClinicQColors.darkTeal,
                              fontWeight: FontWeight.bold,
                              fontSize: (16 * scale).clamp(13.0, 18.0),
                            ),
                          ),
                          SizedBox(width: 6 * scale),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: isDark
                                ? ClinicQColors.lightTeal
                                : ClinicQColors.darkTeal,
                            size: (18 * scale).clamp(14.0, 20.0),
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
