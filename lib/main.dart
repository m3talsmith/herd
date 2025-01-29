import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform/platform.dart';

import 'app.dart';
import 'providers/window.dart';
import 'storage/storage.dart';
import 'utils/window.dart';
import 'utils/window_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage.ensureInitialized();
  Storage.loadConfigs();
  Storage.loadWindowPreferences();

  bool isFullscreen = false;
  WindowPreferences? preferences;

  if (!kIsWeb) {
    const platform = LocalPlatform();
    if (platform.isMacOS ||
        platform.isWindows ||
        platform.isLinux ||
        platform.isFuchsia) {
      final window = Window();
      await window.ensureInitialized();

      isFullscreen = window.fullscreen;
      preferences = window.preferences;
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
      child: App(),
    ),
  );
}
