import '../../domain/entities/tracking_snapshot.dart';
import '../../domain/entities/token.dart';
import 'token_model.dart';

class TrackingSnapshotModel extends TrackingSnapshot {
  const TrackingSnapshotModel({
    required super.tokenId,
    required super.currentTokenNumber,
    required super.yourTokenNumber,
    required super.patientsAheadCount,
    required super.estimatedWaitMinutes,
    required super.status,
    required super.lastSyncedAt,
    super.fullTokenList = const [],
    super.isFromCache = false,
    super.isStale = false,
  });

  factory TrackingSnapshotModel.fromJson(Map<String, dynamic> json, String defaultTokenId) {
    final id = json['tokenId'] as String? ?? json['id'] as String? ?? json['token_id'] as String? ?? defaultTokenId;
    
    // Check for nested queuePosition object
    final queuePos = json['queuePosition'] as Map<String, dynamic>? ?? json['queue_position'] as Map<String, dynamic>?;

    final currentToken = (queuePos != null
            ? (queuePos['currentTokenServing'] as int? ?? queuePos['currentTokenNumber'] as int? ?? queuePos['currentToken'] as int?)
            : null) ??
        json['currentTokenNumber'] as int? ??
        json['currentToken'] as int? ??
        json['current_token'] as int? ??
        0;

    final yourToken = (queuePos != null
            ? (queuePos['yourTokenNumber'] as int? ?? queuePos['yourToken'] as int? ?? queuePos['tokenNumber'] as int?)
            : null) ??
        json['yourTokenNumber'] as int? ??
        json['yourToken'] as int? ??
        json['tokenNumber'] as int? ??
        json['token_number'] as int? ??
        0;

    final patientsAhead = (queuePos != null
            ? (queuePos['patientsAhead'] as int? ?? queuePos['patientsAheadCount'] as int?)
            : null) ??
        json['patientsAheadCount'] as int? ??
        json['patientsAhead'] as int? ??
        json['patients_ahead'] as int? ??
        0;

    final estWait = (queuePos != null
            ? (queuePos['estimatedWaitMinutes'] as int? ?? queuePos['estimatedWaitTime'] as int? ?? queuePos['estimatedWait'] as int?)
            : null) ??
        json['estimatedWaitMinutes'] as int? ??
        json['estimatedWaitTime'] as int? ??
        json['estimated_wait'] as int? ??
        json['estimatedWait'] as int? ??
        0;

    final statusVal = json['status'] as String? ?? 'waiting';

    final tokenListRaw = json['fullTokenList'] ?? json['tokens'] ?? json['tokenList'];
    final List<Token> fullTokens = [];
    if (tokenListRaw is List) {
      for (final item in tokenListRaw) {
        if (item is Map<String, dynamic>) {
          fullTokens.add(TokenModel.fromJson(item));
        }
      }
    }

    return TrackingSnapshotModel(
      tokenId: id,
      currentTokenNumber: currentToken,
      yourTokenNumber: yourToken,
      patientsAheadCount: patientsAhead,
      estimatedWaitMinutes: estWait,
      status: statusVal,
      lastSyncedAt: DateTime.now(),
      fullTokenList: fullTokens,
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
