import 'package:clinic_q/core/local/app_database.dart';
import 'package:drift/drift.dart';

class TrackingLocalDataSource {
  final AppDatabase _db;

  TrackingLocalDataSource(this._db);

  Future<TrackingCacheTableData?> getCachedSnapshot(String tokenId) async {
    final query = _db.select(_db.trackingCacheTable)..where((t) => t.tokenId.equals(tokenId));
    return await query.getSingleOrNull();
  }

  Future<void> upsertSnapshot(TrackingCacheTableCompanion companion) async {
    await _db.into(_db.trackingCacheTable).insertOnConflictUpdate(companion);
  }

  Future<void> deleteSnapshot(String tokenId) async {
    final query = _db.delete(_db.trackingCacheTable)..where((t) => t.tokenId.equals(tokenId));
    await query.go();
  }

  Future<String?> getDoctorIdByTokenId(String tokenId) async {
    final query = _db.select(_db.tokensTable)..where((t) => t.id.equals(tokenId));
    final token = await query.getSingleOrNull();
    return token?.doctorId;
  }

  Future<void> clearCache() async {
    await _db.delete(_db.trackingCacheTable).go();
  }
}
