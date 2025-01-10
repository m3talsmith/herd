import 'package:drift/drift.dart';

class ConfigsTable extends Table {
  TextColumn get id => text().unique()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get content => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
