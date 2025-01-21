import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:herd/providers/resources.dart';
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
  List<String> _tabs = [];

  @override
  void initState() {
    super.initState();

    final readKinds = k8s.ResourceKind.apiReadKinds;
    readKinds.sort((a, b) => a.name.compareTo(b.name));

    _tabs = readKinds.map((e) {
      var parts = SymbolName(e.name).toHumanizedName().split(' ');
      parts = parts.map((e) => e.toSingularForm()).toList();
      parts.last = parts.last.toPluralForm();
      return parts.join(' ').toTitleCase();
    }).toList();

    // refreshResources();
  }

  refreshResources() async {
    final config = ref.watch(currentConfigProvider);
    final k8sConfig = config!.toK8sConfig();
    final context = config.contextByName(widget.configContext.name);

    var parts = _tabs[_selectedTabIndex].split(' ');
    parts = parts.map((e) => e.toSingularForm().toTitleCase()).toList();
    parts.first = parts.first.toLowerCase();
    final resourceKindName = parts.join('');

    final resourceKind = k8s.ResourceKind.fromString(resourceKindName);

    await ref
        .read(resourcesProvider.notifier)
        .refreshResources(k8sConfig, context.name, resourceKind);
  }

  @override
  Widget build(BuildContext context) {
    final resourcesResult = ref.watch(resourcesProvider);
    final resources = resourcesResult.valueOrNull ?? [];

    final size = MediaQuery.of(context).size;

    final formattedTabs = _tabs.map((e) {
      final index = _tabs.indexOf(e);
      final isSelected = _selectedTabIndex == index;
      return ScaffoldListTile(
        borderColor: isSelected ? Theme.of(context).colorScheme.primary : null,
        textColor: isSelected ? Theme.of(context).colorScheme.onPrimary : null,
        title: e,
        tileColor: isSelected ? Theme.of(context).colorScheme.primary : null,
        onTap: () {
          setState(() {
            if (isSelected) {
              _isExpanded = false;
              _selectedTabIndex = -1;
            } else {
              _isExpanded = true;
              _selectedTabIndex = index;
              refreshResources();
            }
          });
        },
      );
    }).toList();

    final selectedTab = _selectedTabIndex == -1
        ? 'All'
        : _tabs[_selectedTabIndex].toString().toTitleCase();

    Future.delayed(const Duration(milliseconds: 100), () {
      refreshResources();
    });

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
              child: !_isExpanded
                  ? StaggeredGrid.count(
                      crossAxisCount: size.width ~/ 300,
                      children: formattedTabs,
                    )
                  : ListView(
                      shrinkWrap: true,
                      children: formattedTabs,
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
                            children:
                                resources.map((e) => Text(e.kind!)).toList(),
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
