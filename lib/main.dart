import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herd/app.dart';

import 'storage/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage.ensureInitialized();
  Storage.loadConfigs();

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
