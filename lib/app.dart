import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'app_theme_data.dart';
import 'providers/window.dart';
import 'views/home/home.dart';
import 'utils/window_preferences.dart';
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

    final offset = await windowManager.getPosition();
    final position = WindowPosition(top: offset.dx, left: offset.dy);

    ref.watch(windowPreferencesProvider.notifier).state?.windowPosition =
        position;
  }

  @override
  void onWindowResize() async {
    super.onWindowResize();

    final size = await windowManager.getSize();

    ref.watch(windowPreferencesProvider.notifier).state?.windowSize = size;
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
