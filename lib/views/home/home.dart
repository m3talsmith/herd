import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../providers/configs.dart';
import '../config/create.dart';
import '../config/menu.dart';
import '../config/view.dart';
import '../shared/app/header_bar.dart';
import '../shared/app/list_tile.dart';
import '../shared/app/scaffold.dart';
import '../shared/app/scaffold_action.dart';
import '../shared/app/scaffold_container.dart';
import '../shared/app/scaffold_page_route_builder.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final configs = ref.watch(configsProvider);
    final statuses = [];

    return AppScaffold(
      title: 'Home',
      onRefresh: () => ref.read(configsProvider.notifier).refresh(),
      child: configs.valueOrNull?.isNotEmpty ?? false
          ? SizedBox(
              height: size.height - 136,
              child: Column(
                children: [
                  if (statuses.isNotEmpty)
                    const Expanded(
                      flex: 3,
                      child: ScaffoldContainer(
                        child: Column(
                          children: [
                            Text('Statuses'),
                          ],
                        ),
                      ),
                    ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        HeaderBar(
                          title: 'Clusters',
                          action: ScaffoldAction.primary(
                            context: context,
                            icon: Icons.add,
                            label: 'Add Cluster Config',
                            onPressed: () => Navigator.of(context).push(
                              ScaffoldPageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const ConfigCreate(),
                              ),
                            ),
                          ),
                        ),
                        StaggeredGrid.count(
                          crossAxisCount: size.width ~/ 300,
                          children: configs.valueOrNull!
                              .map(
                                (e) => ScaffoldListTile(
                                  title: e.name!,
                                  trailing: ConfigMenu(config: e),
                                  onTap: () {
                                    final navigator = Navigator.of(context);
                                    ref
                                        .read(currentConfigProvider.notifier)
                                        .setConfig(e);
                                    navigator.push(
                                      ScaffoldPageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            ConfigView(
                                          config: e,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
