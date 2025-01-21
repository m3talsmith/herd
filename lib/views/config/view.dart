import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../models/config.dart';
import '../config_context/config_context.dart';
import '../shared/app/header_bar.dart';
import '../shared/app/list_tile.dart';
import '../shared/app/scaffold.dart';

class ConfigView extends ConsumerWidget {
  const ConfigView({super.key, required this.config});

  final Config config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final contexts = config.contexts;

    return AppScaffold(
      title: config.name!,
      child: SizedBox(
        height: size.height - 136,
        width: size.width,
        child: Column(
          children: [
            const HeaderBar(
              title: 'Contexts',
            ),
            StaggeredGrid.count(
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              crossAxisCount: size.width ~/ 300,
              children: contexts
                  .map((e) => ScaffoldListTile(
                        title: e.name,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ConfigContextView(
                              configContext: e,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
