import 'package:flutter/material.dart';
import 'package:clinic_q/app/theme/clinic_q_colors.dart';

class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({
    super.key,
    required this.title,
    required this.description,
    required this.imageAssetPath,
    required this.stepNumber,
    this.totalSteps = 3,
    this.onSkip,
    this.showSkip = true,
    required this.cardWidth,
    required this.cardHeight,
    required this.cardCornerRadius,
    required this.topSpacing,
    required this.cardToTextSpacing,
    required this.textToDescSpacing,
    required this.contentHorizontalPadding,
    required this.headingFontSize,
    required this.descFontSize,
  });

  final String title;
  final String description;
  final String imageAssetPath;
  final int stepNumber;
  final int totalSteps;
  final VoidCallback? onSkip;
  final bool showSkip;

  final double cardWidth;
  final double cardHeight;
  final double cardCornerRadius;
  final double topSpacing;
  final double cardToTextSpacing;
  final double textToDescSpacing;
  final double contentHorizontalPadding;
  final double headingFontSize;
  final double descFontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Spacing below status bar
        SizedBox(height: topSpacing),

        // Edge-to-edge image card with 540:680 aspect ratio and corner radius ~7.5% of card width
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(cardCornerRadius),
            child: SizedBox(
              width: cardWidth,
              height: cardHeight,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    imageAssetPath,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),

                  // Top overlays: Skip pill (left) and Step chip (right)
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (showSkip && onSkip != null)
                          GestureDetector(
                            onTap: onSkip,
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: ClinicQColors.cardBackground,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Text(
                                'Skip',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: ClinicQColors.textPrimary,
                                ),
                              ),
                            ),
                          )
                        else
                          const SizedBox.shrink(),

                        // White chip with teal sparkle icon and dark text
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: ClinicQColors.cardBackground,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.auto_awesome,
                                size: 14,
                                color: ClinicQColors.primaryTeal,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Step $stepNumber / $totalSteps',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: ClinicQColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        SizedBox(height: cardToTextSpacing),

        // Bold headline (2 lines max, left aligned, aligned inside card left edge)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: contentHorizontalPadding),
          child: Text(
            title,
            style: TextStyle(
              fontSize: headingFontSize,
              fontWeight: FontWeight.w900,
              color: ClinicQColors.textPrimary,
              letterSpacing: -0.5,
              height: 1.2,
            ),
            maxLines: 2,
          ),
        ),

        SizedBox(height: textToDescSpacing),

        // Description (3 lines max, line height 1.5, colour textSecondary)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: contentHorizontalPadding),
          child: Text(
            description,
            style: TextStyle(
              fontSize: descFontSize,
              color: ClinicQColors.textSecondary,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}
