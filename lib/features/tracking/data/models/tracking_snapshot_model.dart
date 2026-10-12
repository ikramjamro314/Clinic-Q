import '../../domain/entities/tracking_snapshot.dart';
import '../../domain/entities/token.dart';
import 'token_model.dart';

class TrackingSnapshotModel extends TrackingSnapshot {
  const TrackingSnapshotModel({
    required super.tokenId,
    required super.currentTokenNumber,
    required super.yourTokenNumber,
    required super.patientsAheadCount,
    super.estimatedWaitMinutes,
    required super.status,
    required super.lastSyncedAt,
    super.fullTokenList = const [],
    super.maxTokens,
    super.estimatedTime,
    super.queueStatus,
    super.activeTokenId,
    super.appointmentDate,
    super.isQueueActive = false,
    super.isQueuePaused = false,
    super.isFromCache = false,
    super.isStale = false,
  });

  factory TrackingSnapshotModel.fromJson(Map<String, dynamic> json, String defaultTokenId) {
    final id = json['tokenId'] as String? ?? json['id'] as String? ?? defaultTokenId;

    final currentToken = json['currentTokenNumber'] as int? ??
        json['currentlyServing'] as int? ??
        0;
    final yourToken = json['yourTokenNumber'] as int? ??
        json['tokenNumber'] as int? ??
        0;
    final patientsAhead = json['patientsAheadCount'] as int? ??
        json['tokensAhead'] as int? ??
        0;

    final queueStatus = json['queueStatus'] as String? ??
        json['queue_status'] as String?;
    final isQueueActive = json['isQueueActive'] as bool? ?? false;
    final isQueuePaused = (json['isQueuePaused'] as bool? ?? false) ||
        (queueStatus != null && queueStatus.toUpperCase() == 'PAUSED') ||
        json['status'] == 'paused' ||
        json['isPaused'] == true;

    // Paused queues & future appointments return null estimatedWaitMinutes
    final estWait = isQueuePaused
        ? null
        : (json['estimatedWaitMinutes'] as int? ??
            json['estimated_wait_minutes'] as int? ??
            json['estimatedWait'] as int?);

    final estTime = json['estimatedTime'] as String? ??
        json['estimated_time'] as String?;

    final activeTokenIdVal = json['activeTokenId'] as String? ??
        json['active_token_id'] as String? ??
        json['myTokenId'] as String?;

    final statusVal = json['status'] as String? ?? (isQueuePaused ? 'paused' : 'waiting');
    final maxLimit = json['maxTokensPerDay'] as int? ??
        json['dailyTokenCap'] as int?;

    final appointmentDateVal = json['appointmentDate'] as String? ??
        json['appointment_date'] as String? ??
        json['date'] as String?;

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
      estimatedTime: estTime,
      queueStatus: queueStatus,
      activeTokenId: activeTokenIdVal,
      appointmentDate: appointmentDateVal,
      isQueueActive: isQueueActive,
      isQueuePaused: isQueuePaused,
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
      'estimatedTime': estimatedTime,
      'queueStatus': queueStatus,
      'activeTokenId': activeTokenId,
      'appointmentDate': appointmentDate,
      'isQueueActive': isQueueActive,
      'isQueuePaused': isQueuePaused,
    };
  }
}
