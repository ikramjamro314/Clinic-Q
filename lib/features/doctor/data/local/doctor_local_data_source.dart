import 'package:clinic_q/core/local/app_database.dart';
import 'package:drift/drift.dart';

class DoctorLocalDataSource {
  final AppDatabase _db;

  DoctorLocalDataSource(this._db);

  /// Retrieves all cached doctors
  Future<List<DoctorsTableData>> getCachedDoctors() async {
    return await _db.select(_db.doctorsTable).get();
  }

  /// Retrieves a specific cached doctor by ID
  Future<DoctorsTableData?> getCachedDoctorById(String id) async {
    final query = _db.select(_db.doctorsTable)..where((t) => t.id.equals(id));
    return await query.getSingleOrNull();
  }

  /// Caches a list of doctors, replacing older entries on conflict
  Future<void> upsertDoctors(List<DoctorsTableCompanion> companions) async {
    await _db.batch((batch) {
      for (final companion in companions) {
        batch.insert(
          _db.doctorsTable,
          companion,
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  /// Clears all cached doctors
  Future<void> clearCache() async {
    await _db.delete(_db.doctorsTable).go();
  }
}
