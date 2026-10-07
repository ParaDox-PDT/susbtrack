import 'package:flutter/material.dart';
import 'package:g1455/g1455.dart';

/// A reusable liquid glass panel using g1455 Liquid Glass shaders
/// with smooth refraction, blur, tint, and a delicate rim.
class LiquidGlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsets padding;
  final GlassFinish? finish;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const LiquidGlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 24,
    this.padding = const EdgeInsets.all(16),
    this.finish,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveFinish = finish ??
        (Theme.of(context).brightness == Brightness.dark
            ? GlassFinish.regularDark
            : GlassFinish.regularLight);

    Widget content = GlassSurface(
      borderRadius: BorderRadius.circular(borderRadius),
      finish: effectiveFinish,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        child: child,
      ),
    );

    if (onTap != null) {
      content = GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: content,
      );
    }

    return content;
  }
}
