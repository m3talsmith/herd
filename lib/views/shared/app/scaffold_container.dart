import 'package:flutter/material.dart';

class ScaffoldContainer extends StatelessWidget {
  const ScaffoldContainer({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: child != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: child,
            )
          : const SizedBox.shrink(),
    );
  }
}
