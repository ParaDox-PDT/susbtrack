import 'package:flutter/material.dart';

/// iOS Home indicator pill matching the Figma component.
class SystemHomeIndicator extends StatelessWidget {
  final Color color;
  final double opacity;

  const SystemHomeIndicator({
    super.key,
    this.color = const Color(0xFF777777),
    this.opacity = 0.8,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 134,
        height: 5,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: opacity),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}
