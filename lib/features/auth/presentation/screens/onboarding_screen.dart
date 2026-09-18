import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:clinic_q/app/app_routes.dart';
import 'package:clinic_q/app/theme/clinic_q_colors.dart';
import 'package:clinic_q/core/utils/app_initializer.dart';
import '../auth_providers.dart';
import '../widgets/on_boarding/onboarding_slide.dart';

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
            const SizedBox(height: 12),

            // Main Page Content (Illustration card + Headline + Description)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PageView(
                  controller: _pageController,
                  onPageChanged: onboardingNotifier.setCurrentIndex,
                  children: [
                    OnboardingSlide(
                      title: 'Easy appointment\nbooking.',
                      description:
                          'Book with confidence\n- Easy to use\n- Quick operation',
                      svgAssetPath: 'assets/onboarding/step_1.svg',
                      stepNumber: 1,
                      totalSteps: onboardingState.totalSlides,
                      onSkip: _finishOnboarding,
                      showSkip:
                          onboardingState.currentIndex <
                          onboardingState.totalSlides - 1,
                    ),
                    OnboardingSlide(
                      title: 'Profile security\n& care history.',
                      description:
                          'Keep a careful record of your\nexaminations.',
                      svgAssetPath: 'assets/onboarding/step_2.svg',
                      stepNumber: 2,
                      totalSteps: onboardingState.totalSlides,
                      onSkip: _finishOnboarding,
                      showSkip:
                          onboardingState.currentIndex <
                          onboardingState.totalSlides - 1,
                    ),
                    OnboardingSlide(
                      title: 'Quick action,\nanywhere.',
                      description:
                          'Make an appointment at any time\nand from any location. Operation is\nsimple.',
                      svgAssetPath: 'assets/onboarding/step_3.svg',
                      stepNumber: 3,
                      totalSteps: onboardingState.totalSlides,
                      onSkip: _finishOnboarding,
                      showSkip:
                          onboardingState.currentIndex <
                          onboardingState.totalSlides - 1,
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Row: Step indicator dots (left) & Circular Next Button (right)
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 28,
                top: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Step Progress Dots
                  Row(
                    children: List.generate(onboardingState.totalSlides, (
                      index,
                    ) {
                      final isSelected = index == onboardingState.currentIndex;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        margin: const EdgeInsets.only(right: 6),
                        width: isSelected ? 24 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ClinicQColors.primaryTeal
                              : ClinicQColors.dividerStrong,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      );
                    }),
                  ),

                  // Circular Next Button with Primary Gradient
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        onboardingNotifier.nextPage(
                          _pageController,
                          _finishOnboarding,
                        );
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          gradient: ClinicQColors.gradientPrimary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: ClinicQColors.primaryTeal.withOpacity(
                                0.38,
                              ),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
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
