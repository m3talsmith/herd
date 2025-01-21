import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'top_bar.dart';

class AppScaffold extends ConsumerWidget {
  const AppScaffold({
    super.key,
    required this.child,
    this.title,
    this.actions = const [],
    this.onRefresh,
  });

  final Widget child;
  final String? title;
  final List<Widget> actions;
  final Function()? onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              TopBarView(
                title: title,
                actions: actions,
                onRefresh: onRefresh,
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
