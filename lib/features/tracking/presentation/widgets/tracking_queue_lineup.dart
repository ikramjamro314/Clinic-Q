import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../domain/entities/tracking_snapshot.dart';

class TrackingQueueLineup extends StatelessWidget {
  final TrackingSnapshot snapshot;

  const TrackingQueueLineup({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final current = snapshot.currentTokenNumber;
    final mine = snapshot.yourTokenNumber;

    List<int> numbers = [];
    if (snapshot.fullTokenList.isNotEmpty) {
      numbers = snapshot.fullTokenList
          .map((t) => t.tokenNumber ?? 0)
          .where((num) => num > 0)
          .toSet()
          .toList();
      numbers.sort();
    } else {
      final start = (current > 1) ? current - 1 : 1;
      final end = mine + 2;
      for (int i = start; i <= end; i++) {
        numbers.add(i);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Live Queue Lineup',
              style: TextStyle(
                color: ClinicQColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: ClinicQColors.availableBadgeBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Serving: #${snapshot.currentTokenNumber}',
                style: const TextStyle(
                  color: ClinicQColors.availableBadgeText,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 64,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: numbers.length,
            itemBuilder: (context, index) {
              final num = numbers[index];
              final isCurrent = num == current;
              final isMine = num == mine;
              final isPassed = num < current;

              Color circleBg = Colors.white;
              Color borderCol = ClinicQColors.cardBorder;
              Color textCol = ClinicQColors.textSecondary;
              double borderWidth = 1.0;

              if (isMine) {
                circleBg = ClinicQColors.primaryBlue;
                borderCol = ClinicQColors.primaryTeal;
                textCol = Colors.white;
                borderWidth = 2.0;
              } else if (isCurrent) {
                circleBg = ClinicQColors.availableBadgeBackground;
                borderCol = ClinicQColors.availableBadgeText;
                textCol = ClinicQColors.availableBadgeText;
                borderWidth = 2.0;
              } else if (isPassed) {
                circleBg = ClinicQColors.secondaryBackground;
                textCol = ClinicQColors.textTertiary;
              }

              return Container(
                margin: const EdgeInsets.only(right: 12),
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: circleBg,
                  shape: BoxShape.circle,
                  border: isMine
                      ? Border.all(color: borderCol, width: borderWidth)
                      : (isCurrent || isPassed
                            ? Border.all(color: borderCol, width: borderWidth)
                            : Border.all(color: borderCol)),
                  boxShadow: isMine
                      ? [
                          BoxShadow(
                            color: ClinicQColors.primaryBlue.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '#${num.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        color: textCol,
                        fontSize: 14,
                        fontWeight: (isMine || isCurrent)
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    if (isMine)
                      const Text(
                        'YOU',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    else if (isCurrent)
                      const Text(
                        'NOW',
                        style: TextStyle(
                          color: ClinicQColors.availableBadgeText,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
