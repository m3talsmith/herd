import 'package:flutter/material.dart';

import 'scaffold_container.dart';

class ScaffoldListTile extends StatelessWidget {
  const ScaffoldListTile({
    super.key,
    required this.title,
    this.leading,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ScaffoldContainer(
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 32.0),
              child: leading,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                title,
                if (subtitle != null) subtitle!,
              ],
            ),
            if (trailing != null) ...[
              const Spacer(),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}
