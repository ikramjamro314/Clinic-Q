import 'package:flutter/foundation.dart';

@immutable
class AvailableDateEntity {
  final String date; // '2026-10-09'
  final String dayName; // 'Fri'
  final int tokensRemaining;
  final int dailyTokenCap;
  final int nextTokenNumber;

  const AvailableDateEntity({
    required this.date,
    required this.dayName,
    required this.tokensRemaining,
    required this.dailyTokenCap,
    required this.nextTokenNumber,
  });

  AvailableDateEntity copyWith({
    String? date,
    String? dayName,
    int? tokensRemaining,
    int? dailyTokenCap,
    int? nextTokenNumber,
  }) {
    return AvailableDateEntity(
      date: date ?? this.date,
      dayName: dayName ?? this.dayName,
      tokensRemaining: tokensRemaining ?? this.tokensRemaining,
      dailyTokenCap: dailyTokenCap ?? this.dailyTokenCap,
      nextTokenNumber: nextTokenNumber ?? this.nextTokenNumber,
    );
  }
}
