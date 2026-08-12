import 'package:flutter/material.dart';
import '../../../../core/theme/clinic_q_colors.dart';
import '../viewmodels/home_state.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    super.key,
    this.bannerData,
    this.onTap,
  });

  final HomeBannerData? bannerData;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final badgeText = bannerData?.badgeText ?? 'Trusted doctor on your schedule 😁';
    final title = bannerData?.title ?? 'Consult A Doctor\n— Book Today!';
    final patientCountText = bannerData?.patientCountText ?? '30.000+\nHappy Patients';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: ClinicQColors.gradientBanner,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0F766E).withOpacity(0.25),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Background organic decorative wave curves
              Positioned.fill(
                child: CustomPaint(
                  painter: _BannerWavePainter(),
                ),
              ),

              // Banner Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Badge / Header tag
                    Text(
                      badgeText,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    // Main bold call-to-action title
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        height: 1.25,
                        letterSpacing: -0.3,
                      ),
                    ),

                    // Bottom statistic tag
                    Text(
                      patientCountText,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
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

class _BannerWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24.0;

    final path1 = Path();
    path1.moveTo(size.width * 0.4, 0);
    path1.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.5,
      size.width * 1.1,
      size.height * 0.8,
    );
    canvas.drawPath(path1, paint);

    final path2 = Path();
    path2.moveTo(size.width * 0.55, 0);
    path2.quadraticBezierTo(
      size.width * 0.85,
      size.height * 0.6,
      size.width * 1.2,
      size.height * 1.0,
    );
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
