import 'package:clinic_q/core/local/app_database.dart';

/// Lightweight lookups against the local token cache used to resolve the
/// doctor/clinic room when joining the live-tracking socket.
/// Live queue snapshots are intentionally NOT cached — tracking always
/// reflects the current server state.
class TrackingLocalDataSource {
  final AppDatabase _db;

  TrackingLocalDataSource(this._db);

  Future<String?> getDoctorIdByTokenId(String tokenId) async {
    final query = _db.select(_db.tokensTable)..where((t) => t.id.equals(tokenId));
    final token = await query.getSingleOrNull();
    return token?.doctorId;
  }

  Future<String?> getClinicIdByTokenId(String tokenId) async {
    final query = _db.select(_db.tokensTable)..where((t) => t.id.equals(tokenId));
    final token = await query.getSingleOrNull();
    return token?.clinicId;
  }
}
