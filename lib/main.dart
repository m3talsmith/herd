import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform/platform.dart';
import 'package:window_manager/window_manager.dart';

import 'app.dart';
import 'providers/window.dart';
import 'storage/storage.dart';
// import 'utils/window.dart';
// import 'utils/window_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage.ensureInitialized();
  Storage.loadConfigs();
  final preferences = Storage.loadWindowPreferences();
  bool isFullscreen = preferences?.fullscreen ?? false;

  if (!kIsWeb) {
    const platform = LocalPlatform();
    if (platform.isMacOS ||
        platform.isWindows ||
        platform.isLinux ||
        platform.isFuchsia) {
      // final window = Window();
      // await window.ensureInitialized();

      await windowManager.ensureInitialized();
      final windowOptions = WindowOptions(
        size: preferences?.windowSize,
        title: 'Herd',
      );

      log('Setting position: ${preferences?.windowPosition?.left}, ${preferences?.windowPosition?.top}');
      windowManager.setPosition(Offset(preferences?.windowPosition?.left ?? 0, preferences?.windowPosition?.top ?? 0));

      await windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.show();
        await windowManager.focus();
      });
    }
  }

  runApp(
    ProviderScope(
      overrides: [
        fullscreenProvider.overrideWith(
          (ref) => isFullscreen,
        ),
        windowPreferencesProvider.overrideWith(
          (ref) => preferences,
        ),
      ],
      child: const App(),
    ),
  );
}
