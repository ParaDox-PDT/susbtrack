import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/system_home_indicator.dart';
import '../../../../core/widgets/system_status_bar.dart';

/// 00 / Splash screen matching the Figma specifications exactly.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 2800), () {
      if (mounted) {
        context.go(RouteNames.onboarding);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onTap() {
    _timer?.cancel();
    context.go(RouteNames.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: _onTap,
          behavior: HitTestBehavior.opaque,
          child: Column(
            children: [
              const SystemStatusBar(),
              const Spacer(flex: 1),
              // Main Liquid Glass 3D visual orb from Figma
              Center(
                child: SizedBox(
                  width: 320,
                  height: 320,
                  child: Image.asset(
                    'assets/onboarding/splash.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Brand
              const Text(
                'SubTrack',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF050505),
                  letterSpacing: -0.8,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 10),
              // Tagline
              const Text(
                'Track subscriptions. Save money.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF333333),
                  letterSpacing: -0.2,
                ),
              ),
              const Spacer(flex: 2),
              const SystemHomeIndicator(opacity: 0.8),
            ],
          ),
        ),
      ),
    );
  }
}
