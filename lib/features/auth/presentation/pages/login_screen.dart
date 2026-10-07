import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1455/g1455.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/system_home_indicator.dart';
import '../../../../core/widgets/system_status_bar.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

/// 04 / Sign in screen matching the Figma specifications with g1455 liquid glass controls.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.go(RouteNames.home);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                const SystemStatusBar(),

                // Hero Illustration
                Expanded(
                  flex: 9,
                  child: Center(
                    child: Image.asset(
                      'assets/onboarding/splash.png',
                      fit: BoxFit.contain,
                      width: 320,
                    ),
                  ),
                ),

                // Brand
                const Text(
                  'SubTrack',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    fontSize: 44,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF050505),
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 8),

                // Tagline
                const Text(
                  'Track subscriptions. Save money.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF444444),
                  ),
                ),

                const Spacer(flex: 1),

                // Auth Action Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      // Continue with Google Button
                      InkWell(
                        onTap: isLoading
                            ? null
                            : () {
                                context
                                    .read<AuthBloc>()
                                    .add(const AuthSignInWithGoogleRequested());
                              },
                        borderRadius: BorderRadius.circular(30.5),
                        child: Container(
                          width: double.infinity,
                          height: 61,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0B0B0B),
                            borderRadius: BorderRadius.circular(30.5),
                          ),
                          child: Center(
                            child: isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _GoogleLogo(),
                                      SizedBox(width: 14),
                                      Text(
                                        'Continue with Google',
                                        style: TextStyle(
                                          fontFamily: 'SF Pro',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Continue with Apple Button with Liquid Glass
                      GlassSurface(
                        borderRadius: BorderRadius.circular(30.5),
                        finish: GlassFinish.regularLight,
                        child: InkWell(
                          onTap: isLoading
                              ? null
                              : () {
                                  // Navigates directly or invokes apple auth
                                  context.go(RouteNames.home);
                                },
                          borderRadius: BorderRadius.circular(30.5),
                          child: Container(
                            width: double.infinity,
                            height: 61,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.8),
                              borderRadius: BorderRadius.circular(30.5),
                              border: Border.all(color: const Color(0xFFDDDDDD)),
                            ),
                            child: const Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.apple_rounded, size: 24, color: Color(0xFF050505)),
                                  SizedBox(width: 12),
                                  Text(
                                    'Continue with Apple',
                                    style: TextStyle(
                                      fontFamily: 'SF Pro',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF111111),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Terms & Privacy agreement
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const Text(
                        'By continuing, you agree to our',
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF737373),
                        ),
                      ),
                      const SizedBox(height: 3),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Terms of Service and Privacy Policy.',
                          style: TextStyle(
                            fontFamily: 'SF Pro',
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF555555),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(flex: 1),
                const SystemHomeIndicator(opacity: 0.2),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _GoogleLogo extends StatelessWidget {
  const _GoogleLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          'G',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: Colors.blue.shade600,
          ),
        ),
      ),
    );
  }
}
