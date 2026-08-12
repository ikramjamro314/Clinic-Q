import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/app_routes.dart';
import '../../../../core/theme/clinic_q_theme.dart';
import '../../../../core/theme/clinic_q_colors.dart';
import '../../../../core/utils/app_initializer.dart';
import '../../../../core/widgets/buttons/clinicq_button.dart';
import '../../../../core/widgets/display/clinicq_page_indicator.dart';
import '../auth_providers.dart';
import '../widgets/on_boarding/onboarding_slide.dart';
import '../widgets/marketing/appointment_booking_illustration.dart';
import '../widgets/profile/profile_security_illustration.dart';
import '../widgets/marketing/quick_action_illustration.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    await AppInitializer.markOnboardingComplete();
    if (mounted) {
      context.go(AppRoutes.clinicMarketing);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onboardingState = ref.watch(onboardingViewModelProvider);
    final onboardingNotifier = ref.read(onboardingViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Skip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              alignment: Alignment.centerRight,
              child:
                  onboardingState.currentIndex < onboardingState.totalSlides - 1
                  ? TextButton(
                      onPressed: _finishOnboarding,
                      child: Text(
                        'Skip',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  : const SizedBox(height: 48), // keeps spacing equal
            ),

            // Page Content
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: onboardingNotifier.setCurrentIndex,
                children: [
                  OnboardingSlide(
                    title: 'Easy appointment booking',
                    description:
                        'Book with confidence\n- Easy to use\n- Quick operation',
                    illustration: const AppointmentBookingIllustration(),
                  ),
                  OnboardingSlide(
                    title: 'Profile security',
                    description: 'Keep a careful record of your\nexaminations.',
                    illustration: const ProfileSecurityIllustration(),
                  ),
                  OnboardingSlide(
                    title: 'Quick action',
                    description:
                        'Make an appointment at any time\nand from any location. Operation is\nsimple.',
                    illustration: const QuickActionIllustration(),
                  ),
                ],
              ),
            ),

            // Navigation Area (Indicator & Action Button)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                children: [
                  ClinicQPageIndicator(
                    currentIndex: onboardingState.currentIndex,
                    count: onboardingState.totalSlides,
                  ),
                  const SizedBox(height: 32),
                  ClinicQButton(
                    label:
                        onboardingState.currentIndex ==
                            onboardingState.totalSlides - 1
                        ? 'Get started'
                        : 'Next',
                    onPressed: () {
                      onboardingNotifier.nextPage(
                        _pageController,
                        _finishOnboarding,
                      );
                    },
                    height: 56,
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
