import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herd/views/shared/app/scaffold_container.dart';
import 'package:humanizer/humanizer.dart';
import 'package:kuberneteslib/kuberneteslib.dart';

import '../shared/app/header_bar.dart';
import '../shared/app/navigation_bar.dart';
import '../shared/app/scaffold.dart';
import 'metadata.dart';
import 'specifications.dart';
import 'statuses.dart';

class ResourceView extends ConsumerStatefulWidget {
  const ResourceView({super.key, required this.resource});

  final Resource resource;

  @override
  ConsumerState<ResourceView> createState() => _ResourceViewState();
}

class _ResourceViewState extends ConsumerState<ResourceView> {
  int _selectedTab = 0;
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      MetadataView(resource: widget.resource),
      SpecificationsView(resource: widget.resource),
      StatusesView(resource: widget.resource),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppScaffold(
      showBackButton: true,
      title: widget.resource.metadata!.name!,
      child: SizedBox(
        height: size.height - 100,
        width: size.width,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: _pages[_selectedTab]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ScaffoldNavigationBar(
                showLabels: true,
                children: [
                  ScaffoldNavigationBarItem(
                      icon: Icons.data_array_rounded,
                      label: 'Metadata',
                      isSelected: _selectedTab == 0,
                      onTap: () => setState(() => _selectedTab = 0)),
                  ScaffoldNavigationBarItem(
                      icon: Icons.list_rounded,
                      label: 'Specifications',
                      isSelected: _selectedTab == 1,
                      onTap: () => setState(() => _selectedTab = 1)),
                  ScaffoldNavigationBarItem(
                      icon: Icons.stacked_bar_chart_rounded,
                      label: 'Statuses',
                      isSelected: _selectedTab == 2,
                      onTap: () => setState(() => _selectedTab = 2)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
