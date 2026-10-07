import 'package:flutter/material.dart';
import 'package:g1455/g1455.dart';
import 'package:go_router/go_router.dart';
import '../router/route_names.dart';
import 'system_home_indicator.dart';

/// Bottom Navigation Bar matching Figma node 16:48 specification with Liquid Glass.
class SubTrackBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const SubTrackBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  void _onTabTapped(BuildContext context, int index) {
    if (index == currentIndex) return;
    switch (index) {
      case 0:
        context.go(RouteNames.home);
        break;
      case 1:
        context.go(RouteNames.subscriptions);
        break;
      case 2:
        context.go(RouteNames.analytics);
        break;
      case 3:
        context.go(RouteNames.settings);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GlassSurface(
          finish: GlassFinish.regularLight,
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.65),
              border: const Border(
                top: BorderSide(
                  color: Color(0xFFEBEBEB),
                  width: 0.8,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_filled,
                  inactiveIcon: Icons.home_outlined,
                  label: 'Home',
                  isSelected: currentIndex == 0,
                  onTap: () => _onTabTapped(context, 0),
                ),
                _NavItem(
                  icon: Icons.format_list_bulleted_rounded,
                  inactiveIcon: Icons.format_list_bulleted_outlined,
                  label: 'Subscriptions',
                  isSelected: currentIndex == 1,
                  onTap: () => _onTabTapped(context, 1),
                ),
                _NavItem(
                  icon: Icons.bar_chart_rounded,
                  inactiveIcon: Icons.bar_chart_outlined,
                  label: 'Insights',
                  isSelected: currentIndex == 2,
                  onTap: () => _onTabTapped(context, 2),
                ),
                _NavItem(
                  icon: Icons.person_rounded,
                  inactiveIcon: Icons.person_outline_rounded,
                  label: 'Profile',
                  isSelected: currentIndex == 3,
                  onTap: () => _onTabTapped(context, 3),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: const SystemHomeIndicator(opacity: 0.4),
        ),
      ],
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData inactiveIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.inactiveIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = const Color(0xFF111111);
    final inactiveColor = const Color(0xFF999999);
    final color = isSelected ? activeColor : inactiveColor;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? icon : inactiveIcon,
              size: 22,
              color: color,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'SF Pro',
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
