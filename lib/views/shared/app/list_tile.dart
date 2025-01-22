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
    this.tileColor,
    this.textColor,
    this.borderColor,
  });

  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? tileColor;
  final Color? textColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return ScaffoldContainer(
      borderColor: borderColor,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      color: tileColor,
      child: SizedBox(
        height: 40,
        child: InkWell(
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leading != null)
                Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: leading,
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: textColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                  ),
                  if (subtitle != null)
                    SizedBox(
                      width: 200,
                      child: Text(
                        subtitle!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: textColor,
                              overflow: TextOverflow.ellipsis,
                            ),
                      ),
                    ),
                ],
              ),
              if (trailing != null) ...[
                const Spacer(),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
