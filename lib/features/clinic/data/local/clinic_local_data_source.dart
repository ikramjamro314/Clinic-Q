import 'package:clinic_q/core/local/app_database.dart';
import 'package:drift/drift.dart';

class ClinicLocalDataSource {
  final AppDatabase _db;

  ClinicLocalDataSource(this._db);

  /// Retrieves all cached clinics
  Future<List<ClinicsTableData>> getCachedClinics() async {
    return await _db.select(_db.clinicsTable).get();
  }

  /// Retrieves a specific cached clinic by ID
  Future<ClinicsTableData?> getCachedClinicById(String id) async {
    final query = _db.select(_db.clinicsTable)..where((t) => t.id.equals(id));
    return await query.getSingleOrNull();
  }

  /// Caches a list of clinics, replacing older entries on primary key conflicts
  Future<void> upsertClinics(List<ClinicsTableCompanion> companions) async {
    await _db.batch((batch) {
      for (final companion in companions) {
        batch.insert(
          _db.clinicsTable,
          companion,
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  /// Clears all cached clinics
  Future<void> clearCache() async {
    await _db.delete(_db.clinicsTable).go();
  }
}
