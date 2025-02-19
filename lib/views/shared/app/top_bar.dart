import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../home/home.dart';
import 'scaffold_action.dart';
import 'scaffold_container.dart';
import 'scaffold_page_route_builder.dart';

class TopBarView extends ConsumerWidget {
  const TopBarView({
    super.key,
    this.title,
    this.actions = const [],
    this.onRefresh,
    this.showBackButton = false,
  });

  final String? title;
  final List<Widget> actions;
  final Function()? onRefresh;
  final bool? showBackButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigator = Navigator.of(context);

    final listedActions = <Widget>[
      if (showBackButton!)
        ScaffoldAction.primary(
          context: context,
          icon: Icons.arrow_back,
          onPressed: () => navigator.pop(),
        ),
      // if (onRefresh != null)
      //   ScaffoldAction.primary(
      //     context: context,
      //     icon: Icons.refresh,
      //     onPressed: () => onRefresh!(),
      //   ),
      if (actions.isNotEmpty) ...actions,
    ];

    final canDisplay = (showBackButton! || onRefresh != null) ||
        title != null ||
        actions.isNotEmpty;
    final fontSize = Theme.of(context).textTheme.titleLarge!.fontSize!;

    final width = MediaQuery.of(context).size.width;
    final barHeight = fontSize + 10;

    return canDisplay
        ? ScaffoldContainer(
            margin: const EdgeInsets.all(32.0),
            height: barHeight,
            width: width / 3,
            color: Theme.of(context).colorScheme.surface.withAlpha(100),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ScaffoldContainer(
                  height: barHeight,
                  borderRadius: BorderRadius.circular(20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (listedActions.isNotEmpty) ...[
                        ...listedActions,
                        SizedBox(width: fontSize * 0.5),
                      ],
                      ScaffoldAction(
                        icon: Icons.home_rounded,
                        onPressed: () => Navigator.of(context).pushReplacement(
                          ScaffoldPageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const HomeView(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (title != null && width > 650)
                  Expanded(
                    child: ScaffoldContainer(
                      height: barHeight,
                      padding: EdgeInsets.only(
                        right: fontSize * 0.5,
                      ),
                      color: Colors.transparent,
                      child: Text(
                        title!,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withAlpha(150),
                              fontWeight: FontWeight.normal,
                              overflow: TextOverflow.ellipsis,
                            ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
