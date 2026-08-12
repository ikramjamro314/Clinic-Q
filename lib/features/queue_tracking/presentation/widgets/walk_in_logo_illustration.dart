import 'package:flutter/material.dart';
import '../../../../core/theme/clinic_q_colors.dart';

class WalkInLogoIllustration extends StatelessWidget {
  const WalkInLogoIllustration({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: isDark 
              ? ClinicQColors.darkSurface
              : ClinicQColors.availableBadgeBackground,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: isDark
                ? ClinicQColors.darkSurfaceVariant
                : ClinicQColors.availableBadgeBorder,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 54,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ClinicQColors.tokenActive,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Cross sign
                    Positioned(
                      top: 4,
                      child: Icon(
                        Icons.add_rounded,
                        color: ClinicQColors.tokenActive,
                        size: 14,
                      ),
                    ),
                    // Bottom dots/door representation
                    Positioned(
                      bottom: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              color: ClinicQColors.primaryBlue,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 8,
                            height: 10,
                            decoration: BoxDecoration(
                              color: ClinicQColors.tokenActive.withOpacity(0.3),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(2),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              color: ClinicQColors.primaryBlue,
                              shape: BoxShape.circle,
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
    );
  }
}
