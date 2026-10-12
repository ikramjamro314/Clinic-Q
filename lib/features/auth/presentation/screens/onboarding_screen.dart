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
    final onboardingState = ref.watch(onboardingViewModelProvider);
    final onboardingNotifier = ref.read(onboardingViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;

            // Ideal card width: ~87% of screen width (6.5% horizontal margin on both sides)
            final idealCardWidth = screenWidth * 0.87;
            final idealCardHeight = idealCardWidth * (680.0 / 540.0);

            // Vertical space required for non-card elements:
            // topSpacing + cardToTextSpacing + heading + textToDescSpacing + description + gap + button + bottomMargin
            final nonCardHeightNeeded =
                (screenHeight * 0.065).clamp(18.0, 38.0) +
                20.0 +
                58.0 +
                10.0 +
                56.0 +
                16.0 +
                64.0 +
                24.0;

            final maxCardHeightAllowed = (screenHeight - nonCardHeightNeeded)
                .clamp(180.0, screenHeight * 0.52);

            // Scale card proportionally on short screens to prevent any overflow or scrolling
            final double cardHeight;
            final double cardWidth;
            if (idealCardHeight > maxCardHeightAllowed) {
              cardHeight = maxCardHeightAllowed;
              cardWidth = cardHeight * (540.0 / 680.0);
            } else {
              cardWidth = idealCardWidth;
              cardHeight = idealCardHeight;
            }

            // Card corner radius: ~7.5% of card width
            final cardCornerRadius = cardWidth * 0.075;

            // Top spacing: ~6% to 7% of screen height below status bar
            final topSpacing = (screenHeight * 0.065).clamp(16.0, 36.0);
            final cardToTextSpacing =
                (screenHeight * 0.026).clamp(16.0, 22.0) + 20;
            const textToDescSpacing = 12.0;
            const bottomMargin = 24.0;

            // Text and indicator dots align slightly inside card's left edge (16px at 612px Figma ref)
            final cardLeft = (screenWidth - cardWidth) / 2.0;
            final figmaInset = (16.0 / 612.0) * screenWidth;
            final contentHorizontalPadding = cardLeft + figmaInset;

            final headingFontSize =
                (screenWidth * 0.065).clamp(22.0, 28.0) + 10;
            final descFontSize = (screenWidth * 0.038).clamp(14.0, 16.0) + 3;

            return Column(
              children: [
                // Swipable slides (Card + Headline + Description)
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: onboardingNotifier.setCurrentIndex,
                    children: [
                      OnboardingSlide(
                        title: 'Book your token from home.',
                        description:
                            'Pick your doctor and a day that suits you, then book in a few taps. No paper slip needed.',
                        imageAssetPath: 'assets/onboarding/step_1.png',
                        stepNumber: 1,
                        totalSteps: onboardingState.totalSlides,
                        onSkip: _finishOnboarding,
                        showSkip:
                            onboardingState.currentIndex <
                            onboardingState.totalSlides - 1,
                        cardWidth: cardWidth,
                        cardHeight: cardHeight,
                        cardCornerRadius: cardCornerRadius,
                        topSpacing: topSpacing,
                        cardToTextSpacing: cardToTextSpacing,
                        textToDescSpacing: textToDescSpacing,
                        contentHorizontalPadding: contentHorizontalPadding,
                        headingFontSize: headingFontSize,
                        descFontSize: descFontSize,
                      ),
                      OnboardingSlide(
                        title: 'Follow your turn live.',
                        description:
                            'After booking, see who is being served and how many people are ahead of you, with a live wait estimate.',
                        imageAssetPath: 'assets/onboarding/step_2.png',
                        stepNumber: 2,
                        totalSteps: onboardingState.totalSlides,
                        onSkip: _finishOnboarding,
                        showSkip:
                            onboardingState.currentIndex <
                            onboardingState.totalSlides - 1,
                        cardWidth: cardWidth,
                        cardHeight: cardHeight,
                        cardCornerRadius: cardCornerRadius,
                        topSpacing: topSpacing,
                        cardToTextSpacing: cardToTextSpacing,
                        textToDescSpacing: textToDescSpacing,
                        contentHorizontalPadding: contentHorizontalPadding,
                        headingFontSize: headingFontSize,
                        descFontSize: descFontSize,
                      ),
                      OnboardingSlide(
                        title: 'We tell you when it\'s time.',
                        description:
                            'Get a notification when your turn is near, so you can wait anywhere and arrive just in time.',
                        imageAssetPath: 'assets/onboarding/step_3.png',
                        stepNumber: 3,
                        totalSteps: onboardingState.totalSlides,
                        onSkip: _finishOnboarding,
                        showSkip:
                            onboardingState.currentIndex <
                            onboardingState.totalSlides - 1,
                        cardWidth: cardWidth,
                        cardHeight: cardHeight,
                        cardCornerRadius: cardCornerRadius,
                        topSpacing: topSpacing,
                        cardToTextSpacing: cardToTextSpacing,
                        textToDescSpacing: textToDescSpacing,
                        contentHorizontalPadding: contentHorizontalPadding,
                        headingFontSize: headingFontSize,
                        descFontSize: descFontSize,
                      ),
                    ],
                  ),
                ),

                // Bottom Row: Indicator dots (left) & Round Arrow Button (right)
                Padding(
                  padding: EdgeInsets.only(
                    left: contentHorizontalPadding,
                    right: contentHorizontalPadding,
                    bottom: bottomMargin,
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
                          final isSelected =
                              index == onboardingState.currentIndex;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            margin: const EdgeInsets.only(right: 6),
                            width: isSelected ? 26 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              gradient: isSelected
                                  ? ClinicQColors.gradientPrimary
                                  : null,
                              color: isSelected
                                  ? null
                                  : ClinicQColors.buttonDisabledBackground,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          );
                        }),
                      ),

                      // 64dp Circular Next Button with Gradient and Glow Shadow
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            onboardingNotifier.nextPage(
                              _pageController,
                              _finishOnboarding,
                            );
                          },
                          borderRadius: BorderRadius.circular(32),
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              gradient: ClinicQColors.gradientPrimary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: ClinicQColors.primaryTeal.withOpacity(
                                    0.38,
                                  ),
                                  blurRadius: 18,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_forward_rounded,
                              color: ClinicQColors.textWhite,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
