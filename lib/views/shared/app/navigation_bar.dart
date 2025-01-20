import 'package:flutter/material.dart';

class ScaffoldNavigationBar extends StatelessWidget {
  const ScaffoldNavigationBar({super.key, required this.children});

  final List<ScaffoldNavigationBarItem> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
              children.map((e) => Expanded(child: e.build(context))).toList(),
        ),
      ),
    );
  }
}

class ScaffoldNavigationBarItem extends StatelessWidget {
  const ScaffoldNavigationBarItem({
    super.key,
    required this.icon,
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Tooltip(
        message: label,
        child: Icon(
          icon,
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }
}
