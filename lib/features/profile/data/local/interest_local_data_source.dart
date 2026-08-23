import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/local/app_database.dart';
import '../../domain/interest_item.dart';

class InterestLocalDataSource {
  final AppDatabase _db;

  InterestLocalDataSource(this._db);

  Future<void> add(String entityId, String entityType) async {
    await _db.into(_db.interestedItemsTable).insertOnConflictUpdate(
      InterestedItemsTableCompanion(
        entityId: Value(entityId),
        entityType: Value(entityType),
        addedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> remove(String entityId, String entityType) async {
    await (_db.delete(_db.interestedItemsTable)
          ..where((t) => t.entityId.equals(entityId) & t.entityType.equals(entityType)))
        .go();
  }

  Future<bool> isInterested(String entityId, String entityType) async {
    final query = _db.select(_db.interestedItemsTable)
      ..where((t) => t.entityId.equals(entityId) & t.entityType.equals(entityType));
    final item = await query.getSingleOrNull();
    return item != null;
  }

  Future<List<InterestItem>> getAllByType(String entityType) async {
    final query = _db.select(_db.interestedItemsTable)
      ..where((t) => t.entityType.equals(entityType))
      ..orderBy([(t) => OrderingTerm(expression: t.addedAt, mode: OrderingMode.desc)]);
    
    final rows = await query.get();
    return rows.map((row) => InterestItem(
      entityId: row.entityId,
      entityType: row.entityType,
      addedAt: row.addedAt,
    )).toList();
  }
}

final interestLocalDataSourceProvider = Provider<InterestLocalDataSource>((ref) {
  final db = ref.watch(databaseProvider);
  return InterestLocalDataSource(db);
});

final isInterestedProvider = FutureProvider.family<bool, ({String entityId, String entityType})>((ref, arg) {
  return ref.watch(interestLocalDataSourceProvider).isInterested(arg.entityId, arg.entityType);
});
