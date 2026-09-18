import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'app_database.g.dart';

class DoctorsTable extends Table {
  TextColumn get id => text()();
  TextColumn get clinicId => text().nullable()();
  TextColumn get name => text()();
  TextColumn get qualification => text().nullable()();
  IntColumn get experience => integer().nullable()();
  TextColumn get specialty => text()();
  RealColumn get price => real()();
  IntColumn get durationMinutes => integer()();
  TextColumn get workingDays => text().nullable()();
  TextColumn get startTime => text().nullable()();
  TextColumn get endTime => text().nullable()();
  IntColumn get maxTokensPerDay => integer().nullable()();
  RealColumn get rating => real()();
  TextColumn get photoUrl => text().nullable()();
  TextColumn get clinicName => text()();
  IntColumn get reviewCount => integer()();
  BoolColumn get isInterested => boolean().withDefault(const Constant(false))();
  BoolColumn get isAvailable => boolean().withDefault(const Constant(true))();
  TextColumn get about => text().nullable()();
  TextColumn get location => text().nullable()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class ClinicsTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get specialtyTag => text()();
  RealColumn get rating => real()();
  IntColumn get reviewCount => integer()();
  TextColumn get openingHours => text()();
  TextColumn get address => text()();
  IntColumn get doctorCount => integer()();
  TextColumn get phone => text()();
  TextColumn get patientCount => text()();
  TextColumn get specialistCount => text()();
  TextColumn get yearsExperience => text()();
  BoolColumn get isOpen => boolean().withDefault(const Constant(true))();
  TextColumn get ownerId => text().nullable()();
  TextColumn get clinicName => text().nullable()();
  TextColumn get tagline => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get state => text().nullable()();
  TextColumn get zipCode => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get website => text().nullable()();
  TextColumn get openTime => text().nullable()();
  TextColumn get closeTime => text().nullable()();
  TextColumn get workingDays => text().nullable()();
  TextColumn get specialties => text().nullable()();
  TextColumn get facilities => text().nullable()();
  BoolColumn get emergencyServices => boolean().withDefault(const Constant(false))();
  TextColumn get createdAt => text().nullable()();
  TextColumn get updatedAt => text().nullable()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class ProfileTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get role => text()();
  TextColumn get email => text()();
  TextColumn get phone => text().nullable()();
  BoolColumn get isAccountVerified => boolean().withDefault(const Constant(false))();
  TextColumn get clinicId => text().nullable()();
  TextColumn get createdAt => text().nullable()();
  TextColumn get updatedAt => text().nullable()();
  TextColumn get gender => text().nullable()();
  TextColumn get dateOfBirth => text().nullable()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class InterestedItemsTable extends Table {
  TextColumn get entityId => text()();
  TextColumn get entityType => text()(); // 'doctor' or 'clinic'
  DateTimeColumn get addedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {entityId, entityType};
}

class TokensTable extends Table {
  TextColumn get id => text()();
  TextColumn get doctorId => text()();
  TextColumn get clinicId => text()();
  TextColumn get userId => text()();
  TextColumn get notes => text().nullable()();
  TextColumn get status => text()();
  IntColumn get tokenNumber => integer().nullable()();
  TextColumn get createdAt => text().nullable()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class TrackingCacheTable extends Table {
  TextColumn get tokenId => text()();
  IntColumn get currentTokenNumber => integer().nullable()();
  IntColumn get yourTokenNumber => integer().nullable()();
  IntColumn get patientsAheadCount => integer().nullable()();
  IntColumn get estimatedWaitMinutes => integer().nullable()();
  TextColumn get status => text().nullable()();
  DateTimeColumn get lastSyncedAt => dateTime()();
  BoolColumn get isFromCache => boolean().withDefault(const Constant(false))();
  BoolColumn get isStale => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {tokenId};
}

@DriftDatabase(tables: [DoctorsTable, ClinicsTable, ProfileTable, InterestedItemsTable, TokensTable, TrackingCacheTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(interestedItemsTable);
            try {
              await m.addColumn(profileTable, profileTable.gender);
              await m.addColumn(profileTable, profileTable.dateOfBirth);
            } catch (_) {}
          }
          if (from < 3) {
            await m.createTable(tokensTable);
            await m.createTable(trackingCacheTable);
          }
        },
      );

  Future<void> clearAllTables() async {
    await transaction(() async {
      for (final table in allSchemaEntities.whereType<TableInfo>()) {
        await delete(table).go();
      }
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'clinicq.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});
