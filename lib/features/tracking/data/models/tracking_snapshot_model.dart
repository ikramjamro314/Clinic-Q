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
    super.maxTokens,
    super.isFromCache = false,
    super.isStale = false,
  });

  factory TrackingSnapshotModel.fromJson(Map<String, dynamic> json, String defaultTokenId) {
    final id = json['tokenId'] as String? ?? json['id'] as String? ?? defaultTokenId;

    final currentToken = json['currentTokenNumber'] as int? ?? 0;
    final yourToken = json['yourTokenNumber'] as int? ?? json['tokenNumber'] as int? ?? 0;
    final patientsAhead = json['patientsAheadCount'] as int? ?? 0;
    final estWait = json['estimatedWaitMinutes'] as int? ?? 0;
    final statusVal = json['status'] as String? ?? 'waiting';
    final maxLimit = json['maxTokensPerDay'] as int?;

    final tokenListRaw = json['tokens'] ?? json['fullTokenList'];
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
      maxTokens: maxLimit,
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
