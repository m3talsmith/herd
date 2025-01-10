import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart';

import '../tables/tables.dart';

part 'config.g.dart';

@JsonSerializable()
class Config {
  int? id;
  String? name;
  String? description;
  String? content;

  static late AppDatabase db;

  Config({this.id, this.name, this.description, this.content});

  static ensureInitializedWithDb(AppDatabase db) {
    Config.db = db;
  }

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigToJson(this);

  static Future<List<Config>> load() async {
    final result = await Config.db.configsTable.all().get();
    return result.map((e) => Config.fromJson(e.toJson())).toList();
  }

  Future<Config?> create() async {
    log('[Config] create');
    final result = await Config.db.configsTable
        .insert()
        .insertReturningOrNull(ConfigsTableCompanion(
          name: Value(name ?? ''),
          description: Value(description ?? ''),
          content: Value(content ?? ''),
        ));
    log('[Config] create result: ${result?.toJson()}');
    if (result != null) {
      return Config.fromJson(result.toJson());
    }
    return null;
  }

  Future<Config?> update() async {
    if (id == null) return null;

    final success =
        await Config.db.configsTable.update().replace(ConfigsTableCompanion(
              id: Value(id!),
              name: Value(name ?? ''),
              description: Value(description ?? ''),
              content: Value(content ?? ''),
            ));

    if (!success) return null;

    final query = Config.db.configsTable.select()
      ..where((tbl) => tbl.id.equals(id!));
    final result = await query.getSingleOrNull();
    return result == null ? null : Config.fromJson(result.toJson());
  }
}
