import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:herd/providers/configs.dart';
import 'package:herd/views/config/update.dart';

import 'app_theme_data.dart';
import 'views/config/create.dart';
import 'views/home/home.dart';
import 'views/shared/app/scaffold.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final configs = ref.watch(configsProvider);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Herd',
        theme: AppThemeData.theme,
        home: Builder(builder: (context) => const HomeView()));
  }
}
