import 'package:flutter/material.dart';
import '../shared/app/scaffold_container.dart';
import '../shared/app/header_bar.dart';
import 'package:kuberneteslib/kuberneteslib.dart';

class MetadataView extends StatelessWidget {
  const MetadataView({super.key, required this.resource});

  final Resource resource;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderBar(
          title: 'Metadata',
        ),
        ScaffoldContainer(
          child: Text('Metadata'),
        ),
      ],
    );
  }
}
