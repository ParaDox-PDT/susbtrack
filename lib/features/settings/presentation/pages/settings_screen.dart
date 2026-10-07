import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1455/g1455.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/liquid_glass_card_container.dart';
import '../../../../core/widgets/system_home_indicator.dart';
import '../../../../core/widgets/system_status_bar.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';

/// 43 / Profile & 46 / Preferences screen matching Figma specifications with g1455 liquid glass controls.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F5),
      body: SafeArea(
        child: Column(
          children: [
            const SystemStatusBar(),

            // Header Navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  GlassSurface(
                    borderRadius: BorderRadius.circular(20),
                    finish: GlassFinish.regularLight,
                    child: InkWell(
                      onTap: () => context.go(RouteNames.home),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: Color(0xFF111111),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Profile & Settings',
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF080808),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  children: [
                    // Profile Card
                    LiquidGlassContainer(
                      borderRadius: 26,
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        children: [
                          Container(
                            width: 54,
                            height: 54,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.9),
                              border: Border.all(color: const Color(0xFFE5E5E5)),
                            ),
                            child: const Icon(
                              Icons.person_rounded,
                              size: 28,
                              color: Color(0xFF111111),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Alex Miller',
                                style: TextStyle(
                                  fontFamily: 'SF Pro',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF050505),
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                'alex.miller@gmail.com',
                                style: TextStyle(
                                  fontFamily: 'SF Pro',
                                  fontSize: 13,
                                  color: Color(0xFF737373),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Connected Accounts (Figma 44)
                    LiquidGlassContainer(
                      borderRadius: 24,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      child: Row(
                        children: [
                          const Icon(Icons.mail_outline_rounded,
                              color: Color(0xFFEA4335), size: 24),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Gmail Connected',
                                  style: TextStyle(
                                    fontFamily: 'SF Pro',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF111111),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Auto-scanning active',
                                  style: TextStyle(
                                    fontFamily: 'SF Pro',
                                    fontSize: 12,
                                    color: Color(0xFF10B981),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Synced',
                              style: TextStyle(
                                fontFamily: 'SF Pro',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF10B981),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Preferences Block (Figma 46)
                    BlocBuilder<SettingsBloc, SettingsState>(
                      builder: (context, state) {
                        final isDark = state is SettingsLoaded ? state.settings.isDarkMode : false;
                        final reminderOn = state is SettingsLoaded
                            ? state.settings.reminderNotificationsEnabled
                            : true;

                        return LiquidGlassContainer(
                          borderRadius: 24,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: Column(
                            children: [
                              _SettingsSwitchRow(
                                title: 'Dark Mode',
                                value: isDark,
                                onChanged: (val) {
                                  if (state is SettingsLoaded) {
                                    context.read<SettingsBloc>().add(
                                          UpdateSettingsRequested(
                                            state.settings.copyWith(isDarkMode: val),
                                          ),
                                        );
                                  }
                                },
                              ),
                              const Divider(color: Color(0xFFEEEEEE)),
                              _SettingsSwitchRow(
                                title: 'Payment Reminders',
                                value: reminderOn,
                                onChanged: (val) {
                                  if (state is SettingsLoaded) {
                                    context.read<SettingsBloc>().add(
                                          UpdateSettingsRequested(
                                            state.settings.copyWith(
                                              reminderNotificationsEnabled: val,
                                            ),
                                          ),
                                        );
                                  }
                                },
                              ),
                              const Divider(color: Color(0xFFEEEEEE)),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Default Currency',
                                      style: TextStyle(
                                        fontFamily: 'SF Pro',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF111111),
                                      ),
                                    ),
                                    Text(
                                      state is SettingsLoaded
                                          ? state.settings.selectedCurrency
                                          : 'USD (\$)',
                                      style: const TextStyle(
                                        fontFamily: 'SF Pro',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF6C5CE7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 28),

                    // Sign Out Button
                    GlassSurface(
                      borderRadius: BorderRadius.circular(25),
                      finish: GlassFinish.regularLight,
                      child: InkWell(
                        onTap: () {
                          context.read<AuthBloc>().add(const AuthSignOutRequested());
                          context.go(RouteNames.login);
                        },
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: const Color(0xFFE2E2E2)),
                          ),
                          child: const Text(
                            'Sign out',
                            style: TextStyle(
                              fontFamily: 'SF Pro',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFEF4444),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SystemHomeIndicator(opacity: 0.18),
          ],
        ),
      ),
    );
  }
}

class _SettingsSwitchRow extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsSwitchRow({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'SF Pro',
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF111111),
            ),
          ),
          Switch.adaptive(
            value: value,
            activeTrackColor: const Color(0xFF080808),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
