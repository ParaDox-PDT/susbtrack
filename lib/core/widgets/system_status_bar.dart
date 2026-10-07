import 'package:flutter/material.dart';

/// Clean iOS-style status bar matching the Figma component.
class SystemStatusBar extends StatelessWidget {
  final Color color;
  final String time;

  const SystemStatusBar({
    super.key,
    this.color = const Color(0xFF111111),
    this.time = '9:41',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            time,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
              letterSpacing: -0.2,
            ),
          ),
          Row(
            children: [
              // Cellular signal
              Icon(Icons.signal_cellular_alt_rounded, size: 16, color: color),
              const SizedBox(width: 5),
              // Wifi
              Icon(Icons.wifi_rounded, size: 16, color: color),
              const SizedBox(width: 5),
              // Battery
              Icon(Icons.battery_full_rounded, size: 20, color: color),
            ],
          ),
        ],
      ),
    );
  }
}
