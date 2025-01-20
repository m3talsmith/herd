import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/context.dart';

class ContextMetadata extends ConsumerWidget {
  const ContextMetadata({
    required this.context,
  });

  final ConfigContext context;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text('Metadata');
  }
}
