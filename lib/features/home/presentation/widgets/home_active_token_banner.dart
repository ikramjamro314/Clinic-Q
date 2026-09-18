import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../../tracking/domain/entities/token.dart';
import '../../../tracking/presentation/providers.dart';
import '../../../tracking/presentation/screens/tracking_screen.dart';

class HomeActiveTokenBanner extends ConsumerWidget {
  final Token token;
  final VoidCallback onTap;

  const HomeActiveTokenBanner({
    super.key,
    required this.token,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackingState = ref.watch(trackingViewModelProvider(token.id));
    final doctorAsync = ref.watch(trackingDoctorProvider(token.id));

    final snapshot = trackingState.snapshot;
    final yourToken = snapshot?.yourTokenNumber ?? token.tokenNumber ?? 1;
    final currentToken =
        snapshot?.currentTokenNumber ?? (yourToken > 1 ? yourToken - 1 : 1);
    final patientsAhead =
        snapshot?.patientsAheadCount ??
        (yourToken > currentToken ? yourToken - currentToken : 0);
    final waitMinutes =
        snapshot?.estimatedWaitMinutes ?? (patientsAhead * 10);

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
              color: const Color(0xFF0F766E).withOpacity(0.28),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Background organic decorative curves
              Positioned.fill(
                child: CustomPaint(painter: _BannerWavePainter()),
              ),

              // Content Layout
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top Row: Live badge & Live Track link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF5EEAD4),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'LIVE QUEUE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Track Details',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 14,
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Middle Section: Token number + Doctor info
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Large Token Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.25),
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'YOUR TOKEN',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Text(
                                '#${yourToken.toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w900,
                                  height: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        // Doctor & Clinic Info
                        Expanded(
                          child: doctorAsync.when(
                            loading: () => const Text(
                              'Loading doctor...',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                            error: (_, __) => const Text(
                              'Doctor Appointment',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            data: (doctor) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  doctor?.name ?? 'Dr. Specialist',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  doctor?.clinicName ?? 'ClinicQ Care Center',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.85),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Bottom Queue Mini-Stats Strip
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.person_rounded,
                                size: 13,
                                color: Color(0xFF5EEAD4),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Now: #$currentToken',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            patientsAhead == 0
                                ? "It's your turn!"
                                : '$patientsAhead patients ahead',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time_rounded,
                                size: 12,
                                color: Colors.white70,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                '${waitMinutes}m wait',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
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
