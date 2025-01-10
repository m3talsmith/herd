import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../providers/configs.dart';
import '../config/create.dart';
import '../config/menu.dart';
import '../shared/app/scaffold.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final configs = ref.watch(configsProvider);

    return AppScaffold(
      title: 'Home',
      onRefresh: () => ref.read(refreshConfigsProvider),
      child: configs.isNotEmpty
          ? Column(
              children: [
                StaggeredGrid.count(
                  crossAxisCount: size.width ~/ 300,
                  children: configs
                      .map((e) => Card(
                            child: ListTile(
                              title: Text(
                                e.name!,
                              ),
                              trailing: ConfigMenu(config: e),
                            ),
                          ))
                      .toList(),
                ),
              ],
            )
          : Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('No cluster configs found.'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FilledButton.icon(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ConfigCreate(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Add Cluster Config'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
