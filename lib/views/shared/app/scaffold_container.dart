import 'package:flutter/material.dart';

class ScaffoldContainer extends StatelessWidget {
  const ScaffoldContainer({
    super.key,
    this.child,
    this.color,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.padding,
    this.margin,
    this.height,
    this.width,
  });

  final Widget? child;
  final Color? color;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final double? borderWidth;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.surface,
          borderRadius: borderRadius ?? BorderRadius.circular(20.0),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 1.0,
          ),
        ),
        child: child != null
            ? Padding(
                padding: padding ?? EdgeInsets.zero,
                child: child,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
