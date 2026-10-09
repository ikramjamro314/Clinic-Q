import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';

class TodayQueueCard extends StatelessWidget {
  final int nowServingNumber;
  final int yourTokenNumber;
  final String label;

  const TodayQueueCard({
    super.key,
    required this.nowServingNumber,
    required this.yourTokenNumber,
    this.label = 'If you book now, your token is',
  });

  @override
  Widget build(BuildContext context) {
    final servingStr = nowServingNumber > 0
        ? nowServingNumber.toString().padLeft(2, '0')
        : '--';
    final tokenStr = yourTokenNumber > 0
        ? yourTokenNumber.toString().padLeft(2, '0')
        : '--';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: ClinicQColors.gradientBanner,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: ClinicQColors.darkTeal.withOpacity(0.3),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'NOW SERVING',
            style: TextStyle(
              color: ClinicQColors.lightTeal,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            servingStr,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 68,
              fontWeight: FontWeight.w900,
              height: 1.05,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 14),
          const Divider(
            color: Colors.white24,
            height: 1,
            thickness: 1,
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  tokenStr,
                  style: const TextStyle(
                    color: ClinicQColors.darkTeal,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
