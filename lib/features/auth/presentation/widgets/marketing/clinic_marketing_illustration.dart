import 'package:flutter/material.dart';
import '../../../../../core/theme/clinic_q_colors.dart';

class ClinicMarketingIllustration extends StatelessWidget {
  const ClinicMarketingIllustration({super.key, required this.isSmallScreen});

  final bool isSmallScreen;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // Dynamic scale factor based on design standard (812px height)
    final double scale = (screenHeight / 812).clamp(0.75, 1.15);

    final double baseWidth = 250.0 * scale;
    final double baseHeight = 160.0 * scale;

    return SizedBox(
      width: baseWidth + (80.0 * scale),
      height: baseHeight + (50.0 * scale),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Laptop Stand
          Positioned(
            bottom: 30 * scale,
            child: Container(
              width: baseWidth * 0.35,
              height: 15 * scale,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(8 * scale),
                ),
              ),
            ),
          ),
          // Laptop Base (bottom bar)
          Positioned(
            bottom: 25 * scale,
            child: Container(
              width: baseWidth * 1.15,
              height: 8 * scale,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(4 * scale),
              ),
            ),
          ),

          // Laptop Main Screen
          Positioned(
            bottom: 31 * scale,
            child: Container(
              width: baseWidth,
              height: baseHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16 * scale),
                border: Border.all(
                  color: Colors.white.withOpacity(0.8),
                  width: 3 * scale,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20 * scale,
                    offset: Offset(0, 10 * scale),
                  ),
                ],
              ),
              padding: EdgeInsets.all(8 * scale),
              child: Column(
                children: [
                  // Upper Header area in the mock dashboard
                  Row(
                    children: [
                      Container(
                        width: 10 * scale,
                        height: 10 * scale,
                        decoration: const BoxDecoration(
                          color: ClinicQColors.primaryTeal,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 6 * scale),
                      Container(
                        width: 25 * scale,
                        height: 4 * scale,
                        decoration: BoxDecoration(
                          color: ClinicQColors.textTertiary.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(2 * scale),
                        ),
                      ),
                      const Spacer(),
                      // Three mock dots/tabs
                      Container(
                        width: 25 * scale,
                        height: 6 * scale,
                        decoration: BoxDecoration(
                          color: ClinicQColors.primaryTeal.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(3 * scale),
                        ),
                      ),
                      SizedBox(width: 4 * scale),
                      Container(
                        width: 25 * scale,
                        height: 6 * scale,
                        decoration: BoxDecoration(
                          color: ClinicQColors.primaryBlue.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(3 * scale),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8 * scale),

                  // Dashboard Middle Row with three color block/cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMockMiniCard(
                        ClinicQColors.primaryTeal.withOpacity(0.2),
                        35 * scale,
                        scale,
                      ),
                      _buildMockMiniCard(
                        ClinicQColors.primaryBlue.withOpacity(0.2),
                        35 * scale,
                        scale,
                      ),
                      _buildMockMiniCard(
                        ClinicQColors.tokenWaiting.withOpacity(0.2),
                        35 * scale,
                        scale,
                      ),
                    ],
                  ),
                  SizedBox(height: 8 * scale),

                  // Dashboard Bottom Row: left side metrics, right side charts
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Left block: lines representation
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildMockLine(50, scale),
                              SizedBox(height: 4 * scale),
                              _buildMockLine(35, scale),
                              SizedBox(height: 4 * scale),
                              _buildMockLine(45, scale),
                            ],
                          ),
                        ),
                        // Right block: simple mock bar chart
                        Expanded(
                          flex: 6,
                          child: Container(
                            decoration: BoxDecoration(
                              color: ClinicQColors.secondaryBackground
                                  .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8 * scale),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 6 * scale,
                              vertical: 4 * scale,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _buildMockBar(
                                  15 * scale,
                                  ClinicQColors.primaryTeal,
                                  scale,
                                ),
                                _buildMockBar(
                                  35 * scale,
                                  ClinicQColors.primaryTeal,
                                  scale,
                                ),
                                _buildMockBar(
                                  25 * scale,
                                  ClinicQColors.primaryBlue,
                                  scale,
                                ),
                                _buildMockBar(
                                  45 * scale,
                                  ClinicQColors.primaryTeal,
                                  scale,
                                ),
                                _buildMockBar(
                                  18 * scale,
                                  ClinicQColors.primaryBlue,
                                  scale,
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
          ),

          // Pill 1: top-right overlapping "12 new tokens"
          Positioned(
            top: 25 * scale,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10 * scale,
                vertical: 6 * scale,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20 * scale),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 10 * scale,
                    offset: Offset(0, 4 * scale),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6 * scale,
                    height: 6 * scale,
                    decoration: const BoxDecoration(
                      color: ClinicQColors.tokenActive,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 6 * scale),
                  Text(
                    '12 new tokens',
                    style: TextStyle(
                      color: ClinicQColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 10 * scale,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Pill 2: bottom-left overlapping "Queue live"
          Positioned(
            bottom: 12 * scale,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10 * scale,
                vertical: 6 * scale,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20 * scale),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 10 * scale,
                    offset: Offset(0, 4 * scale),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6 * scale,
                    height: 6 * scale,
                    decoration: const BoxDecoration(
                      color: ClinicQColors.primaryBlue,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 6 * scale),
                  Text(
                    'Queue live',
                    style: TextStyle(
                      color: ClinicQColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 10 * scale,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMockMiniCard(Color bgColor, double width, double scale) {
    return Container(
      width: width,
      height: 18 * scale,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4 * scale),
      ),
      padding: EdgeInsets.symmetric(horizontal: 3 * scale, vertical: 4 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(width: width * 0.7, height: 2 * scale, color: Colors.white),
          Container(width: width * 0.4, height: 2 * scale, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildMockLine(double widthPct, double scale) {
    return FractionallySizedBox(
      widthFactor: widthPct / 100,
      child: Container(
        height: 3 * scale,
        decoration: BoxDecoration(
          color: ClinicQColors.dividerStrong.withOpacity(0.5),
          borderRadius: BorderRadius.circular(1.5 * scale),
        ),
      ),
    );
  }

  Widget _buildMockBar(double height, Color color, double scale) {
    return Container(
      width: 8 * scale,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.vertical(top: Radius.circular(2 * scale)),
      ),
    );
  }
}
