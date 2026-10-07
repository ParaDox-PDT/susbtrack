import 'package:flutter/material.dart';
import 'package:g1455/g1455.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/liquid_glass_card_container.dart';
import '../../../../core/widgets/system_home_indicator.dart';
import '../../../../core/widgets/system_status_bar.dart';

/// 06 / Connect Gmail screen matching Figma node 16:104 precisely.
class ConnectGmailScreen extends StatelessWidget {
  const ConnectGmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SystemStatusBar(),

            // Top Bar: Back button and Skip button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button
                  GlassSurface(
                    borderRadius: BorderRadius.circular(20),
                    finish: GlassFinish.regularLight,
                    child: InkWell(
                      onTap: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go(RouteNames.discovery);
                        }
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.8),
                          border: Border.all(
                            color: const Color(0xFFE8E8E8),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          size: 20,
                          color: Color(0xFF111111),
                        ),
                      ),
                    ),
                  ),

                  // Skip button
                  GlassSurface(
                    borderRadius: BorderRadius.circular(20),
                    finish: GlassFinish.regularLight,
                    child: InkWell(
                      onTap: () => context.go(RouteNames.home),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withValues(alpha: 0.6),
                          border: Border.all(
                            color: const Color(0xFFE8E8E8),
                            width: 1,
                          ),
                        ),
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            fontFamily: 'SF Pro',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Image: Gmail permissions 3D glass art
                    Center(
                      child: SizedBox(
                        height: 190,
                        child: Image.asset(
                          'assets/onboarding/connect-hero.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Title
                    const Text(
                      'Connect Gmail',
                      style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontSize: 29,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF080808),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Description
                    const Text(
                      'Let SubTrack scan your billing emails\nto find your subscriptions automatically.',
                      style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontSize: 15.5,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF737373),
                        height: 1.35,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Permissions list container
                    LiquidGlassContainer(
                      borderRadius: 22,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: Border.all(
                        color: const Color(0xFFECECEC),
                        width: 1,
                      ),
                      child: Column(
                        children: [
                          _buildPermissionItem(
                            icon: Icons.receipt_long_rounded,
                            title: 'We look for',
                            body: 'Receipts, renewals,\nrecurring payments',
                          ),
                          const Divider(
                            color: Color(0xFFF0F0F0),
                            height: 20,
                            thickness: 0.8,
                          ),
                          _buildPermissionItem(
                            icon: Icons.bookmark_border_rounded,
                            title: 'We save',
                            body:
                                'Service, price, billing cycle,\nrenewal date',
                          ),
                          const Divider(
                            color: Color(0xFFF0F0F0),
                            height: 20,
                            thickness: 0.8,
                          ),
                          _buildPermissionItem(
                            icon: Icons.shield_outlined,
                            title: 'We don’t save',
                            body:
                                'Personal emails, conversations,\nor full email content',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Column(
                children: [
                  // Primary CTA: Connect Gmail
                  InkWell(
                    onTap: () => context.go(RouteNames.home),
                    borderRadius: BorderRadius.circular(27),
                    child: Container(
                      width: double.infinity,
                      height: 54,
                      decoration: BoxDecoration(
                        color: const Color(0xFF080808),
                        borderRadius: BorderRadius.circular(27),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.mail_outline_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Connect Gmail',
                            style: TextStyle(
                              fontFamily: 'SF Pro',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Secondary action: Not now
                  InkWell(
                    onTap: () => context.go(RouteNames.home),
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Not now',
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF111111),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SystemHomeIndicator(opacity: 0.3),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionItem({
    required IconData icon,
    required String title,
    required String body,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F7),
            borderRadius: BorderRadius.circular(19),
          ),
          child: Icon(
            icon,
            size: 20,
            color: const Color(0xFF222222),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111111),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                body,
                style: const TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF737373),
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.chevron_right_rounded,
          color: Color(0xFFBBBBBB),
          size: 20,
        ),
      ],
    );
  }
}
