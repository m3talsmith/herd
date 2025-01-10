import 'package:drift_flutter/drift_flutter.dart';
import 'package:herd/tables/configs.dart';
import 'package:drift/drift.dart';
export 'configs.dart';

part 'tables.g.dart';

@DriftDatabase(tables: [ConfigsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    final db = driftDatabase(name: 'herd');
    return db;
  }
}
