import 'package:flutter/material.dart';
import '../shared/app/scaffold_container.dart';
import '../shared/app/header_bar.dart';
import 'package:kuberneteslib/kuberneteslib.dart';

class StatusesView extends StatelessWidget {
  const StatusesView({super.key, required this.resource});

  final Resource resource;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderBar(
          title: 'Statuses',
        ),
        ScaffoldContainer(
          child: Text('Statuses'),
        ),
      ],
    );
  }
}
