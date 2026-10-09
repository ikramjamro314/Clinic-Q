import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../../doctor/domain/entities/doctor_entity.dart';
import '../../domain/entities/tracking_snapshot.dart';

class TrackingQueueLineup extends StatefulWidget {
  final TrackingSnapshot snapshot;
  final DoctorEntity? doctor;

  const TrackingQueueLineup({
    super.key,
    required this.snapshot,
    this.doctor,
  });

  @override
  State<TrackingQueueLineup> createState() => _TrackingQueueLineupState();
}

class _TrackingQueueLineupState extends State<TrackingQueueLineup> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToActiveToken());
  }

  @override
  void didUpdateWidget(covariant TrackingQueueLineup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.snapshot.currentTokenNumber != widget.snapshot.currentTokenNumber ||
        oldWidget.snapshot.yourTokenNumber != widget.snapshot.yourTokenNumber) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToActiveToken());
    }
  }

  void _scrollToActiveToken() {
    if (!_scrollController.hasClients) return;

    final current = widget.snapshot.currentTokenNumber;
    final mine = widget.snapshot.yourTokenNumber;
    final targetToken = current > 0 ? current : mine;
    if (targetToken > 1) {
      final itemWidth = 54.0 + 10.0;
      final targetOffset = max(0.0, (targetToken - 2) * itemWidth);
      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final current = widget.snapshot.currentTokenNumber;
    final mine = widget.snapshot.yourTokenNumber;

    List<int> numbers = [];

    if (widget.snapshot.fullTokenList.isNotEmpty) {
      numbers = widget.snapshot.fullTokenList
          .map((t) => t.tokenNumber ?? 0)
          .where((n) => n > 0)
          .toSet()
          .toList();
      numbers.sort();
    }

    if (numbers.isEmpty) {
      final maxVal = max(5, max(current, mine));
      numbers = List.generate(maxVal, (i) => i + 1);
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
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: ClinicQColors.availableBadgeBackground,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ClinicQColors.availableBadgeBorder,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: ClinicQColors.tokenActive,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Serving ${current.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      color: ClinicQColors.availableBadgeText,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 56,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: numbers.length,
            itemBuilder: (context, index) {
              final tokenNum = numbers[index];
              final isCurrent = tokenNum == current;
              final isMine = tokenNum == mine;
              final isPassed = current > 0 && tokenNum < current;

              Color circleBg = Colors.white;
              Color borderCol = ClinicQColors.cardBorder;
              Color textCol = ClinicQColors.textSecondary;
              double borderWidth = 1.0;

              if (isMine) {
                circleBg = ClinicQColors.primaryTeal;
                borderCol = ClinicQColors.darkTeal;
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
                margin: const EdgeInsets.only(right: 10),
                width: 54,
                height: 54,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: circleBg,
                  shape: BoxShape.circle,
                  border: isMine || isCurrent || isPassed
                      ? Border.all(color: borderCol, width: borderWidth)
                      : Border.all(color: borderCol),
                  boxShadow: isMine
                      ? [
                          BoxShadow(
                            color: ClinicQColors.primaryTeal.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : isCurrent
                          ? [
                              BoxShadow(
                                color: ClinicQColors.tokenActive.withOpacity(0.2),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tokenNum.toString().padLeft(2, '0'),
                      style: TextStyle(
                        color: textCol,
                        fontSize: 13.5,
                        fontWeight: (isMine || isCurrent)
                            ? FontWeight.w800
                            : FontWeight.w600,
                      ),
                    ),
                    if (isMine)
                      const Text(
                        'YOU',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      )
                    else if (isCurrent)
                      const Text(
                        'NOW',
                        style: TextStyle(
                          color: ClinicQColors.availableBadgeText,
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      )
                    else if (isPassed)
                      const Icon(
                        Icons.check_rounded,
                        size: 10,
                        color: ClinicQColors.textTertiary,
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
