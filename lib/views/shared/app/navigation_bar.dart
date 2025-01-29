import 'package:flutter/material.dart';

class ScaffoldNavigationBar extends StatelessWidget {
  const ScaffoldNavigationBar({
    super.key,
    required this.children,
    this.showLabels = false,
    this.height,
  });

  final List<ScaffoldNavigationBarItem> children;
  final bool showLabels;
  final double? height;

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
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: children.map((e) {
              e.showLabel = showLabels;
              return Expanded(
                child: e.build(context),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class ScaffoldNavigationBarItem extends StatelessWidget {
  ScaffoldNavigationBarItem({
    super.key,
    required this.icon,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.showLabel = false,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  bool showLabel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Tooltip(
        message: label,
        child: showLabel
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.tertiary,
                  ),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.tertiary,
                        ),
                  ),
                ],
              )
            : Icon(
                icon,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.tertiary,
              ),
      ),
    );
  }
}
