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

  @override
  Widget build(BuildContext context) {
    final fontSize = Theme.of(context).textTheme.titleLarge!.fontSize!;
    final multiplier = fontSize * 1.5;
    final width = label != null ? (label!.length + 1) * multiplier : multiplier;
    final height = fontSize + 10;

    return InkWell(
      onTap: onPressed,
      child: ScaffoldContainer(
        width: width,
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
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: labelColor,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
