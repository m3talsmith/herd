import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../models/config.dart';
import '../shared/app/list_tile.dart';
import '../shared/app/scaffold.dart';

class ConfigView extends StatelessWidget {
  const ConfigView({super.key, required this.config});

  final Config config;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final contexts = config.contexts;

    return AppScaffold(
      title: config.name!,
      child: SizedBox(
        height: size.height - 136,
        width: size.width,
        child: StaggeredGrid.count(
          crossAxisCount: size.width ~/ 200,
          children: contexts
              .map((context) => ScaffoldListTile(
                    title: Text(context.name),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
