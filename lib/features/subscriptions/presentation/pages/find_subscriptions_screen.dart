import 'package:flutter/material.dart';
import 'package:g1455/g1455.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/liquid_glass_card_container.dart';
import '../../../../core/widgets/subtrack_bottom_nav_bar.dart';
import '../../../../core/widgets/system_status_bar.dart';

/// 05 / Find subscriptions screen matching Figma node 16:77 precisely.
class FindSubscriptionsScreen extends StatelessWidget {
  const FindSubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SystemStatusBar(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Greeting & Avatar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good morning,',
                              style: TextStyle(
                                fontFamily: 'SF Pro',
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF555555),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Alex',
                              style: TextStyle(
                                fontFamily: 'SF Pro',
                                fontSize: 36,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF050505),
                                letterSpacing: -0.6,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Let’s find your subscriptions.',
                              style: TextStyle(
                                fontFamily: 'SF Pro',
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF666666),
                              ),
                            ),
                          ],
                        ),

                        // Profile Avatar
                        GlassSurface(
                          borderRadius: BorderRadius.circular(24),
                          finish: GlassFinish.regularLight,
                          child: InkWell(
                            onTap: () => context.go(RouteNames.settings),
                            borderRadius: BorderRadius.circular(24),
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFF0F0F2),
                                border: Border.all(
                                  color: const Color(0xFFE2E2E6),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.person_rounded,
                                color: Color(0xFF555555),
                                size: 26,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // 3D Glass Discovery Illustration
                    Center(
                      child: SizedBox(
                        height: 200,
                        child: Image.asset(
                          'assets/onboarding/discovery-hero.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // "Find subscriptions automatically" Liquid Glass Card
                    LiquidGlassContainer(
                      borderRadius: 24,
                      padding: const EdgeInsets.all(20),
                      border: Border.all(
                        color: const Color(0xFFECECEC),
                        width: 1,
                      ),
                      child: InkWell(
                        onTap: () => context.go(RouteNames.connectGmail),
                        borderRadius: BorderRadius.circular(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Icon badge
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF080909),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.15),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.auto_awesome_rounded,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),

                                // Next action circle arrow
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF080909),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            const Text(
                              'Find subscriptions\nautomatically',
                              style: TextStyle(
                                fontFamily: 'SF Pro',
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF111111),
                                height: 1.25,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Connect Gmail to discover your recurring payments.',
                              style: TextStyle(
                                fontFamily: 'SF Pro',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF737373),
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Privacy Assurances Row (3 columns)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAssuranceItem(
                          icon: Icons.shield_outlined,
                          label: 'Read-only\naccess',
                        ),
                        _buildAssuranceItem(
                          icon: Icons.mark_email_read_outlined,
                          label: 'We don’t store\nyour emails',
                        ),
                        _buildAssuranceItem(
                          icon: Icons.receipt_long_outlined,
                          label: 'Only subscription\ninformation',
                          fontSize: 12,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // "or" Divider
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Color(0xFFE8E8E8),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            'or',
                            style: TextStyle(
                              fontFamily: 'SF Pro',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF737373),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Color(0xFFE8E8E8),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // "Add subscription manually" Outlined Button
                    InkWell(
                      onTap: () => context.go(RouteNames.addSubscription),
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: const Color(0xFFDDDDDD),
                            width: 1.2,
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_rounded,
                              size: 20,
                              color: Color(0xFF111111),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Add subscription manually',
                              style: TextStyle(
                                fontFamily: 'SF Pro',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF111111),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Navigation bar
            const SubTrackBottomNavBar(currentIndex: 0),
          ],
        ),
      ),
    );
  }

  Widget _buildAssuranceItem({
    required IconData icon,
    required String label,
    double fontSize = 13,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            size: 22,
            color: const Color(0xFF555555),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'SF Pro',
              fontSize: fontSize,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF737373),
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}
