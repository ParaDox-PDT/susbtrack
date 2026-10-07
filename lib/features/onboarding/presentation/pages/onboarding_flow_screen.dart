import 'package:flutter/material.dart';
import 'package:g1455/g1455.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/system_home_indicator.dart';
import '../../../../core/widgets/system_status_bar.dart';

/// 01 / All subscriptions, 02 / Spending insights, 03 / Connect Gmail
/// Onboarding interactive flow screen matching Figma node 6:281 precisely.
class OnboardingFlowScreen extends StatefulWidget {
  const OnboardingFlowScreen({super.key});

  @override
  State<OnboardingFlowScreen> createState() => _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends State<OnboardingFlowScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingStepData> _steps = const [
    _OnboardingStepData(
      stepNumber: '01 / 03',
      headline: 'All your subscriptions\nin one place',
      description:
          'We automatically find your recurring subscriptions from Gmail so you don’t miss anything.',
      imagePath: 'assets/onboarding/onboarding-01.png',
    ),
    _OnboardingStepData(
      stepNumber: '02 / 03',
      headline: 'Understand\nyour spending',
      description:
          'See how much you spend, when payments are due, and where you can save.',
      imagePath: 'assets/onboarding/onboarding-02.png',
    ),
    _OnboardingStepData(
      stepNumber: '03 / 03',
      headline: 'Secure. Private.\nAutomatic.',
      description:
          'Connect Gmail and let SubTrack find your subscriptions. We only keep subscription details, not your emails.',
      imagePath: 'assets/onboarding/onboarding-03.png',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < _steps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 380),
        curve: Curves.easeInOutCubic,
      );
    } else {
      context.go(RouteNames.login);
    }
  }

  void _onSkip() {
    context.go(RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Status bar
            const SystemStatusBar(),

            // Top navigation: Skip button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
              child: Align(
                alignment: Alignment.topRight,
                child: GlassSurface(
                  borderRadius: BorderRadius.circular(20),
                  finish: GlassFinish.regularLight,
                  child: InkWell(
                    onTap: _onSkip,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 72,
                      height: 37,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE8E8E8)),
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
              ),
            ),

            // Page carousel
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _steps.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final step = _steps[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Central Visual Illustration
                        Expanded(
                          flex: 11,
                          child: Center(
                            child: Image.asset(
                              step.imagePath,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Step label
                        Text(
                          step.stepNumber,
                          style: const TextStyle(
                            fontFamily: 'SF Pro',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF888888),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Headline
                        Text(
                          step.headline,
                          style: const TextStyle(
                            fontFamily: 'SF Pro',
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF080808),
                            height: 1.12,
                            letterSpacing: -0.4,
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Description
                        Text(
                          step.description,
                          style: const TextStyle(
                            fontFamily: 'SF Pro',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF737373),
                            height: 1.35,
                          ),
                        ),

                        const Spacer(flex: 1),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom controls
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: _currentPage < 2
                  ? _buildStandardBottomControls()
                  : _buildFinalStepBottomControls(),
            ),

            const SystemHomeIndicator(opacity: 0.18),
          ],
        ),
      ),
    );
  }

  /// Step 01 and Step 02 bottom pagination + next arrow button
  Widget _buildStandardBottomControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Dots
        Row(
          children: List.generate(3, (dotIndex) {
            final isActive = dotIndex == _currentPage;
            return Container(
              margin: const EdgeInsets.only(right: 9),
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? const Color(0xFF080808) : const Color(0xFFDADADA),
              ),
            );
          }),
        ),

        // Floating Next Circle Button
        GestureDetector(
          onTap: _onNext,
          child: Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: const Color(0xFF080909),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  /// Step 03 "Connect Gmail" & "Not now" actions
  Widget _buildFinalStepBottomControls() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Primary Connect Gmail button
        InkWell(
          onTap: () => context.go(RouteNames.login),
          borderRadius: BorderRadius.circular(25),
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF080808),
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.mail_outline_rounded, color: Colors.white, size: 20),
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
                Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Secondary "Not now" Liquid Glass capsule button
        GlassSurface(
          borderRadius: BorderRadius.circular(25),
          finish: GlassFinish.regularLight,
          child: InkWell(
            onTap: () => context.go(RouteNames.login),
            borderRadius: BorderRadius.circular(25),
            child: Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: const Color(0xFFEAEAEA)),
              ),
              child: const Text(
                'Not now',
                style: TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111111),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OnboardingStepData {
  final String stepNumber;
  final String headline;
  final String description;
  final String imagePath;

  const _OnboardingStepData({
    required this.stepNumber,
    required this.headline,
    required this.description,
    required this.imagePath,
  });
}
