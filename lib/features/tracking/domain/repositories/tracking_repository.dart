import '../entities/tracking_snapshot.dart';
import '../entities/queue_preview.dart';

abstract class TrackingRepository {
  Future<TrackingSnapshot> getLiveTracking(String tokenId);
  Stream<TrackingSnapshot> getLiveTrackingStream(String tokenId);
  Stream<QueuePreview> getDoctorQueueStream(String doctorId, String clinicId);
}
