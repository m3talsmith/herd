import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'form.dart';
import '../shared/app/scaffold.dart';

class ConfigCreate extends ConsumerWidget {
  const ConfigCreate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppScaffold(
      title: 'Create Config',
      child: ConfigForm(),
    );
  }
}
