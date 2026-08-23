import '../entities/tracking_snapshot.dart';

abstract class TrackingRepository {
  Future<TrackingSnapshot> getLiveTracking(String tokenId);
  Stream<TrackingSnapshot> getLiveTrackingStream(String tokenId);
}
