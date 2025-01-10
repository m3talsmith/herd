import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herd/app.dart';

import 'models/config.dart';
import 'providers/configs.dart';
import 'tables/tables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = AppDatabase();
  Config.ensureInitializedWithDb(db);

  final configs = await Config.load();

  runApp(
    ProviderScope(
      overrides: [
        configsProvider.overrideWith((ref) => configs),
      ],
      child: const App(),
    ),
  );
}
