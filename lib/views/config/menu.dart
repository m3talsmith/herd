import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/config.dart';
import '../../providers/configs.dart';
import 'update.dart';

class ConfigMenu extends ConsumerWidget {
  const ConfigMenu({super.key, required this.config});

  final Config config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MenuAnchor(
      menuChildren: [
        MenuItemButton(
          child: const ListTile(
            title: Text('Edit'),
            leading: Icon(Icons.edit),
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfigUpdate(config: config),
            ),
          ),
        ),
        MenuItemButton(
          child: const ListTile(
            title: Text('Delete'),
            leading: Icon(Icons.delete),
            iconColor: Colors.red,
            textColor: Colors.red,
          ),
          onPressed: () async {
            await ref.read(configsProvider.notifier).deleteConfig(config);
          },
        ),
      ],
      builder: (context, controller, child) => IconButton(
        onPressed: () => controller.open(),
        icon: const Icon(Icons.more_vert),
      ),
    );
  }
}
