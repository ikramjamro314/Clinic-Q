import 'package:flutter/material.dart';

class RoleSelectionIllustration extends StatelessWidget {
  const RoleSelectionIllustration({
    super.key,
    required this.isSmallScreen,
  });

  final bool isSmallScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 200,
          height: 90,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Clinic Outline (Home) in center
              Positioned(
                bottom: 0,
                child: Container(
                  width: 70,
                  height: 65,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 1.5,
                    ),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Clinic Cross
                      Positioned(
                        top: 15,
                        child: Icon(
                          Icons.add_circle,
                          color: Colors.white.withOpacity(0.8),
                          size: 20,
                        ),
                      ),
                      // Clinic Door
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: 20,
                          height: 25,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Roof of Clinic (Triangle)
              Positioned(
                bottom: 64,
                child: CustomPaint(
                  size: const Size(80, 16),
                  painter: _TrianglePainter(Colors.white.withOpacity(0.5)),
                ),
              ),
              
              // Left Person Outline
              Positioned(
                bottom: 8,
                left: 20,
                child: _buildPersonOutline(),
              ),
              
              // Right Person Outline
              Positioned(
                bottom: 8,
                right: 20,
                child: _buildPersonOutline(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Step Indicator Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPersonOutline() {
    return Column(
      children: [
        // Head
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 4),
        // Shoulders / Torso
        CustomPaint(
          size: const Size(22, 10),
          painter: _ShouldersPainter(Colors.white.withOpacity(0.5)),
        ),
      ],
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  _TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ShouldersPainter extends CustomPainter {
  final Color color;
  _ShouldersPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path()
      ..moveTo(0, size.height)
      ..arcToPoint(
        Offset(size.width, size.height),
        radius: Radius.circular(size.width / 2),
        clockwise: true,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
