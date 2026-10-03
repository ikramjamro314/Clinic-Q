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
    // Focus target is the current token or your token (whichever is earlier)
    final targetToken = current > 0 ? current : mine;
    if (targetToken > 1) {
      final itemWidth = 56.0 + 12.0; // width + right margin
      final targetOffset = max(0.0, (targetToken - 2) * itemWidth);
      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 400),
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

    // Determine max token limit from API response or Doctor Profile
    final maxLimit = widget.snapshot.maxTokens ?? widget.doctor?.maxTokensPerDay ?? 0;

    List<int> numbers = [];
    if (maxLimit > 0) {
      // Generate full sequential lineup up to the doctor's max token capacity
      final totalCapacity = max(maxLimit, max(current, mine));
      for (int i = 1; i <= totalCapacity; i++) {
        numbers.add(i);
      }
    } else if (widget.snapshot.fullTokenList.isNotEmpty) {
      // Fallback: Use tokens provided in the live queue list
      numbers = widget.snapshot.fullTokenList
          .map((t) => t.tokenNumber ?? 0)
          .where((n) => n > 0)
          .toSet()
          .toList();
      numbers.sort();
    } else {
      // General dynamic fallback
      final start = (current > 1) ? current - 1 : 1;
      final end = max(mine + 3, current + 5);
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Live Queue Lineup',
                  style: TextStyle(
                    color: ClinicQColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (maxLimit > 0) ...[
                  const SizedBox(height: 2),
                  Text(
                    'Daily capacity: $maxLimit tokens',
                    style: const TextStyle(
                      color: ClinicQColors.textTertiary,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                    maxLimit > 0
                        ? 'Serving #${current.toString().padLeft(2, '0')} / $maxLimit'
                        : 'Serving #${current.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      color: ClinicQColors.availableBadgeText,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 64,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: numbers.length,
            itemBuilder: (context, index) {
              final tokenNum = numbers[index];
              final isCurrent = tokenNum == current;
              final isMine = tokenNum == mine;
              final isPassed = tokenNum < current;

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
                  border: isMine || isCurrent || isPassed
                      ? Border.all(color: borderCol, width: borderWidth)
                      : Border.all(color: borderCol),
                  boxShadow: isMine
                      ? [
                          BoxShadow(
                            color: ClinicQColors.primaryBlue.withValues(alpha: 0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : isCurrent
                          ? [
                              BoxShadow(
                                color: ClinicQColors.tokenActive.withValues(alpha: 0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '#${tokenNum.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        color: textCol,
                        fontSize: 14,
                        fontWeight: (isMine || isCurrent)
                            ? FontWeight.bold
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
