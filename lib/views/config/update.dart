import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/config.dart';
import 'form.dart';
import '../shared/app/scaffold.dart';

class ConfigUpdate extends ConsumerWidget {
  const ConfigUpdate({super.key, required this.config});

  final Config config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      title: 'Update ${config.name}',
      child: ConfigForm(config: config),
    );
  }
}
