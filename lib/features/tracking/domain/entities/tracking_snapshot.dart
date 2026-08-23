import 'package:flutter/foundation.dart';

@immutable
class TrackingSnapshot {
  final String tokenId;
  final int currentTokenNumber;
  final int yourTokenNumber;
  final int patientsAheadCount;
  final int estimatedWaitMinutes;
  final String status;
  final DateTime lastSyncedAt;

  // Cache-aside / stale status flags
  final bool isFromCache;
  final bool isStale;

  const TrackingSnapshot({
    required this.tokenId,
    required this.currentTokenNumber,
    required this.yourTokenNumber,
    required this.patientsAheadCount,
    required this.estimatedWaitMinutes,
    required this.status,
    required this.lastSyncedAt,
    this.isFromCache = false,
    this.isStale = false,
  });

  TrackingSnapshot copyWith({
    String? tokenId,
    int? currentTokenNumber,
    int? yourTokenNumber,
    int? patientsAheadCount,
    int? estimatedWaitMinutes,
    String? status,
    DateTime? lastSyncedAt,
    bool? isFromCache,
    bool? isStale,
  }) {
    return TrackingSnapshot(
      tokenId: tokenId ?? this.tokenId,
      currentTokenNumber: currentTokenNumber ?? this.currentTokenNumber,
      yourTokenNumber: yourTokenNumber ?? this.yourTokenNumber,
      patientsAheadCount: patientsAheadCount ?? this.patientsAheadCount,
      estimatedWaitMinutes: estimatedWaitMinutes ?? this.estimatedWaitMinutes,
      status: status ?? this.status,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      isFromCache: isFromCache ?? this.isFromCache,
      isStale: isStale ?? this.isStale,
    );
  }
}
