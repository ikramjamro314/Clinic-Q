import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';

class QueueProgressRow extends StatelessWidget {
  final int nowServingNumber;
  final int totalTokens;
  final int? yourTokenNumber;

  const QueueProgressRow({
    super.key,
    required this.nowServingNumber,
    required this.totalTokens,
    this.yourTokenNumber,
  });

  @override
  Widget build(BuildContext context) {
    // Served count = nowServingNumber - 1 (approximate)
    // Avoid negative values
    final servedCount = max(0, nowServingNumber - 1);
    final total = max(1, max(totalTokens, servedCount));
    final progressValue = servedCount / total;

    // Generate upcoming bubbles to show
    // We want to show from nowServingNumber up to at least max(nowServingNumber + 6, yourTokenNumber + 2)
    final startNum = nowServingNumber;
    final endNum = max(
      nowServingNumber + 6,
      (yourTokenNumber ?? nowServingNumber) + 2,
    );
    final bubbleNumbers = List<int>.generate(
      endNum - startNum + 1,
      (i) => startNum + i,
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Queue Progress',
                style: TextStyle(
                  color: ClinicQColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$servedCount / $total served',
                style: const TextStyle(
                  color: ClinicQColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progressValue,
              backgroundColor: ClinicQColors.dividerLight,
              color: ClinicQColors.primaryTeal,
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 20),
          // Scrollable bubbles row
          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: bubbleNumbers.length,
              itemBuilder: (context, index) {
                final num = bubbleNumbers[index];
                final isNow = num == nowServingNumber;
                final isYou = num == yourTokenNumber;

                Color circleColor = Colors.white;
                Color textColor = ClinicQColors.textSecondary;
                Border? border = Border.all(color: ClinicQColors.dividerMedium);
                String? label;

                if (isNow && isYou) {
                  circleColor = ClinicQColors.primaryTeal;
                  textColor = Colors.white;
                  border = null;
                  label = 'NOW / YOU';
                } else if (isNow) {
                  circleColor = ClinicQColors.primaryTeal;
                  textColor = Colors.white;
                  border = null;
                  label = 'NOW';
                } else if (isYou) {
                  circleColor = Colors.white;
                  textColor = ClinicQColors.primaryBlue;
                  border = Border.all(
                    color: ClinicQColors.primaryBlue,
                    width: 2,
                  );
                  label = 'YOU';
                }

                return Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: circleColor,
                          border: border,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '#$num',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (label != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          label,
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: ClinicQColors.primaryTeal,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
