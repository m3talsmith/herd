import 'package:flutter/material.dart';

import 'scaffold_container.dart';

class ScaffoldAction extends StatelessWidget {
  const ScaffoldAction({
    super.key,
    required this.icon,
    this.label,
    this.onPressed,
    this.color,
    this.iconColor,
    this.labelColor,
  });

  final Color? color;
  final IconData icon;
  final Color? iconColor;
  final String? label;
  final Color? labelColor;
  final VoidCallback? onPressed;

  ScaffoldAction.primary({
    super.key,
    required this.icon,
    this.label,
    required this.onPressed,
    required BuildContext context,
  })  : color = Theme.of(context).colorScheme.primary,
        iconColor = Theme.of(context).colorScheme.onPrimary,
        labelColor = Theme.of(context).colorScheme.onPrimary;

  @override
  Widget build(BuildContext context) {
    final fontSize = Theme.of(context).textTheme.titleLarge!.fontSize!;
    final multiplier = fontSize / 2.5;
    final width =
        label != null ? (label!.length + 1) * multiplier : multiplier * 5;
    final height = fontSize + 10;

    return InkWell(
      onTap: onPressed,
      child: ScaffoldContainer(
        width: width.toDouble(),
        height: height,
        color: color ?? Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor),
            if (label != null)
              Text(
                label!,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: labelColor,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
