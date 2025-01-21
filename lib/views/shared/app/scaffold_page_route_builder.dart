import 'package:flutter/material.dart';

class ScaffoldPageRouteBuilder extends PageRouteBuilder {
  ScaffoldPageRouteBuilder({
    required super.pageBuilder,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SizeTransition(
            sizeFactor: animation,
            child: child,
          ),
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
