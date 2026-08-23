import '../../domain/entities/tracking_snapshot.dart';

class TrackingSnapshotModel extends TrackingSnapshot {
  const TrackingSnapshotModel({
    required super.tokenId,
    required super.currentTokenNumber,
    required super.yourTokenNumber,
    required super.patientsAheadCount,
    required super.estimatedWaitMinutes,
    required super.status,
    required super.lastSyncedAt,
    super.isFromCache = false,
    super.isStale = false,
  });

  factory TrackingSnapshotModel.fromJson(Map<String, dynamic> json, String defaultTokenId) {
    final id = json['tokenId'] as String? ?? json['id'] as String? ?? json['token_id'] as String? ?? defaultTokenId;
    final currentToken = json['currentTokenNumber'] as int? ?? json['currentToken'] as int? ?? json['current_token'] as int? ?? 0;
    final yourToken = json['yourTokenNumber'] as int? ?? json['yourToken'] as int? ?? json['tokenNumber'] as int? ?? json['token_number'] as int? ?? 0;
    final patientsAhead = json['patientsAheadCount'] as int? ?? json['patientsAhead'] as int? ?? json['patients_ahead'] as int? ?? 0;
    final estWait = json['estimatedWaitMinutes'] as int? ?? json['estimatedWaitTime'] as int? ?? json['estimated_wait'] as int? ?? json['estimatedWait'] as int? ?? 0;
    final statusVal = json['status'] as String? ?? 'waiting';

    return TrackingSnapshotModel(
      tokenId: id,
      currentTokenNumber: currentToken,
      yourTokenNumber: yourToken,
      patientsAheadCount: patientsAhead,
      estimatedWaitMinutes: estWait,
      status: statusVal,
      lastSyncedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tokenId': tokenId,
      'currentTokenNumber': currentTokenNumber,
      'yourTokenNumber': yourTokenNumber,
      'patientsAheadCount': patientsAheadCount,
      'estimatedWaitMinutes': estimatedWaitMinutes,
      'status': status,
      'lastSyncedAt': lastSyncedAt.toIso8601String(),
    };
  }
}
