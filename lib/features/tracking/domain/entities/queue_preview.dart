import 'package:flutter/foundation.dart';

@immutable
class QueuePreview {
  final int nextTokenNumber;
  final int nowServingNumber;
  final int patientsAheadCount;
  final int estimatedWaitMinutes;

  const QueuePreview({
    required this.nextTokenNumber,
    required this.nowServingNumber,
    required this.patientsAheadCount,
    required this.estimatedWaitMinutes,
  });
}
