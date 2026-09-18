import 'package:clinic_q/features/tracking/domain/entities/token.dart';
import 'package:clinic_q/features/tracking/domain/entities/queue_preview.dart';

abstract class AppointmentRepository {
  Future<Token> createToken({
    required String doctorId,
    required String clinicId,
    required String userId,
    String? notes,
  });

  Future<List<Token>> getTokens({
    String? doctorId,
    String? clinicId,
    String? userId,
  });

  Future<void> cancelToken(String id);

  Future<void> deleteToken(String id);

  Future<QueuePreview> getQueuePreview({
    required String doctorId,
    required String clinicId,
  });
}

