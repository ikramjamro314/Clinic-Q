import 'package:clinic_q/core/local/app_database.dart';
import 'package:drift/drift.dart';

class ProfileLocalDataSource {
  final AppDatabase _db;

  ProfileLocalDataSource(this._db);

  /// Retrieves the single cached profile row
  Future<ProfileTableData?> getCachedProfile() async {
    final query = _db.select(_db.profileTable);
    return await query.getSingleOrNull();
  }

  /// Caches the user profile, replacing the old entry
  Future<void> upsertProfile(ProfileTableCompanion companion) async {
    await _db.into(_db.profileTable).insertOnConflictUpdate(companion);
  }

  /// Clears the cached profile
  Future<void> clearCache() async {
    await _db.delete(_db.profileTable).go();
  }
}
