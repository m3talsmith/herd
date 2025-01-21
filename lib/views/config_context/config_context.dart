import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herd/views/shared/app/scaffold_container.dart';
import 'package:humanizer/humanizer.dart';
import 'package:kuberneteslib/kuberneteslib.dart' as k8s;
import '../../models/context.dart';
import '../../providers/configs.dart';
import '../shared/app/scaffold.dart';

class ConfigContextView extends ConsumerStatefulWidget {
  const ConfigContextView({super.key, required this.configContext});

  final ConfigContext configContext;

  @override
  ConsumerState<ConfigContextView> createState() => _ConfigContextViewState();
}

class _ConfigContextViewState extends ConsumerState<ConfigContextView> {
  bool _isExpanded = false;
  int _selectedTabIndex = -1;

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

    return AppScaffold(
      title:
          SymbolName(widget.configContext.name).toHumanizedName().toTitleCase(),
      child: SizedBox(
        height: size.height - 156,
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).colorScheme.surface
                              : Theme.of(context).colorScheme.tertiaryContainer,
                        ),
                        color: isSelected
                            ? Theme.of(context).colorScheme.primaryContainer
                            : Theme.of(context).colorScheme.surface,
                      ),
                      child: ListTile(
                        title: Text(e),
                        tileColor: isSelected
                            ? Theme.of(context).colorScheme.onPrimaryContainer
                            : null,
                        onTap: () => setState(() {
                          _isExpanded = true;
                          _selectedTabIndex = index;
                        }),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            if (_isExpanded)
              Expanded(
                flex: 3,
                child: ScaffoldContainer(
                  child: ListView(
                    children: [
                      Text(user.name ?? ''),
                      Text(cluster.name ?? ''),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
