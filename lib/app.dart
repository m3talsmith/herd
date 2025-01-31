import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'app_theme_data.dart';
import 'providers/window.dart';
import 'views/home/home.dart';
import 'utils/window.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  onWindowMove() async {
    super.onWindowMove();

    final fullscreen = ref.watch(fullscreenProvider);
    ref.read(windowPreferencesProvider.notifier).state?.fullscreen = fullscreen;

    final offset = await windowManager.getPosition();
    final size = await windowManager.getSize();
    final currentPosition = ref.read(windowPreferencesProvider.notifier).state?.windowPosition;
    final position = WindowPosition(top: offset.dy, left: offset.dx, right: offset.dx + size.width, bottom: offset.dy + size.height);

    if (currentPosition == null &&
        (currentPosition?.top != offset.dy ||
            currentPosition?.left != offset.dx)) {
      if (!fullscreen) {
        ref.read(windowPreferencesProvider.notifier).state?.windowPosition =
            position;
      }
    } else {
      ref.read(windowPreferencesProvider.notifier).state?.windowPosition =
          position;
    }
  }

  @override
  void onWindowResize() async {
    super.onWindowResize();

    final fullscreen = ref.watch(fullscreenProvider);
    ref.read(windowPreferencesProvider.notifier).state?.fullscreen = fullscreen;

    final size = await windowManager.getSize();

    if (!fullscreen) {
      ref.read(windowPreferencesProvider.notifier).state?.windowSize = size;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Herd',
      theme: AppThemeData.theme,
      home: Builder(builder: (context) => const HomeView()),
    );
  }
}
