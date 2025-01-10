import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopBarView extends ConsumerWidget {
  const TopBarView({
    super.key,
    this.title,
    this.actions = const [],
    this.onRefresh,
  });

  final String? title;
  final List<Widget> actions;
  final Function()? onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    const padding = 16.0;
    final navigator = Navigator.of(context);
    final canPop = navigator.canPop();
    final canDisplay =
        (canPop || onRefresh != null) || title != null || actions.isNotEmpty;

    return canDisplay
        ? Padding(
            padding: const EdgeInsets.all(padding),
            child: Container(
              width: size.width - padding,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
              child: Stack(
                children: [
                  if (canPop)
                    IconButton(
                      onPressed: () => navigator.pop(),
                      icon: const Icon(Icons.arrow_back),
                    ),
                  if (onRefresh != null)
                    IconButton(
                      onPressed: () => onRefresh!(),
                      icon: const Icon(Icons.refresh),
                    ),
                  Positioned(
                    top: Theme.of(context).textTheme.titleLarge!.fontSize! / 4,
                    left: 0,
                    right: 0,
                    child: Row(
                      children: [
                        const Spacer(),
                        if (title != null)
                          Text(
                            title!,
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: actions,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
