import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herd/views/shared/app/scaffold_container.dart';
import 'package:humanizer/humanizer.dart';
import 'package:kuberneteslib/kuberneteslib.dart' as k8s;
import '../../models/context.dart';
import '../../providers/configs.dart';
import '../shared/app/header_bar.dart';
import '../shared/app/list_tile.dart';
import '../shared/app/scaffold.dart';
import '../shared/app/scaffold_action.dart';

class ConfigContextView extends ConsumerStatefulWidget {
  const ConfigContextView({super.key, required this.configContext});

  final ConfigContext configContext;

  @override
  ConsumerState<ConfigContextView> createState() => _ConfigContextViewState();
}

class _ConfigContextViewState extends ConsumerState<ConfigContextView> {
  bool _isExpanded = true;
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(currentConfigProvider);

    final user = widget.configContext.currentUser(config!).toK8sUser();
    final cluster = widget.configContext.currentCluster(config).toK8sCluster();

    final size = MediaQuery.of(context).size;
    final readKinds = k8s.ResourceKind.apiReadKinds;
    readKinds.sort((a, b) => a.name.compareTo(b.name));
    final tabs = readKinds.map((e) {
      var parts = SymbolName(e.name).toHumanizedName().split(' ');
      parts = parts.map((e) => e.toSingularForm()).toList();
      parts.last = parts.last.toPluralForm();
      return parts.join(' ').toTitleCase();
    }).toList();

    final selectedTab = tabs[_selectedTabIndex].toString().toTitleCase();

    return AppScaffold(
      title:
          SymbolName(widget.configContext.name).toHumanizedName().toTitleCase(),
      showBackButton: true,
      child: SizedBox(
        height: size.height - 106,
        width: size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: tabs.map((e) {
                  final index = tabs.indexOf(e);
                  final isSelected = _selectedTabIndex == index;
                  return ScaffoldListTile(
                    borderColor: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    textColor: isSelected
                        ? Theme.of(context).colorScheme.onPrimary
                        : null,
                    title: e,
                    tileColor: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    onTap: () => setState(() {
                      _isExpanded = true;
                      _selectedTabIndex = index;
                    }),
                  );
                }).toList(),
              ),
            ),
            if (_isExpanded)
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    HeaderBar(
                      title: selectedTab,
                      action: ScaffoldAction.primary(
                        context: context,
                        icon: Icons.add,
                        label: 'Add a ${selectedTab.toSingularForm()}',
                        onPressed: () => {},
                      ),
                    ),
                    Expanded(
                      child: ScaffoldContainer(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(8),
                        child: SizedBox(
                          height: size.height - 106,
                          width: size.width * 0.7,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Text(user.name ?? ''),
                              Text(cluster.name ?? ''),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
