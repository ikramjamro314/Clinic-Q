import 'package:clinic_q/core/local/app_database.dart';
import 'package:drift/drift.dart';

class TokensLocalDataSource {
  final AppDatabase _db;

  TokensLocalDataSource(this._db);

  Future<List<TokensTableData>> getCachedTokens() async {
    return await _db.select(_db.tokensTable).get();
  }

  Future<void> upsertTokens(List<TokensTableCompanion> companions) async {
    await _db.batch((batch) {
      for (final companion in companions) {
        batch.insert(
          _db.tokensTable,
          companion,
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  Future<void> deleteToken(String id) async {
    final query = _db.delete(_db.tokensTable)..where((t) => t.id.equals(id));
    await query.go();
  }

  Future<void> clearCache() async {
    await _db.delete(_db.tokensTable).go();
  }
}
