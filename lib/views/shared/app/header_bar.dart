import 'package:flutter/material.dart';

import 'scaffold_action.dart';
import 'scaffold_container.dart';

class HeaderBar extends StatelessWidget {
  const HeaderBar({
    super.key,
    required this.title,
    this.icon,
    this.action,
  });

  final IconData? icon;
  final String title;
  final ScaffoldAction? action;

  @override
  Widget build(BuildContext context) {
    final fontSize = Theme.of(context).textTheme.titleLarge!.fontSize!;
    final width = MediaQuery.of(context).size.width;
    return ScaffoldContainer(
      height: fontSize + 10,
      margin: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
      color: Theme.of(context).colorScheme.surface.withAlpha(100),
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Flexible(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ScaffoldContainer(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              padding: EdgeInsets.only(
                left: fontSize,
                right: fontSize,
              ),
              height: fontSize + 10,
              child: Flex(
                direction: Axis.horizontal,
                clipBehavior: Clip.hardEdge,
                children: [
                  if (icon != null) Icon(icon),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          overflow: TextOverflow.ellipsis,
                        ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            action?.build(context) ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class HeaderBarAction extends StatelessWidget {
  const HeaderBarAction({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
