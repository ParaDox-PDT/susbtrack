import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1455/g1455.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/liquid_glass_card_container.dart';
import '../../../../core/widgets/system_home_indicator.dart';
import '../../../../core/widgets/system_status_bar.dart';
import '../../domain/entities/billing_cycle.dart';
import '../../domain/entities/subscription_entity.dart';
import '../bloc/subscription_bloc.dart';
import '../bloc/subscription_event.dart';
import '../bloc/subscription_state.dart';

/// 07 / Home dashboard & 05 / Find subscriptions
/// Complete, interactive Home screen matching the Figma specifications with g1455 Liquid Glass.
class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<SubscriptionBloc>().add(const LoadSubscriptionsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F5),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // Scrollable Content
            Positioned.fill(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SystemStatusBar(),

                    // Header: Greeting & Profile
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: Row(
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
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF555555),
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Alex',
                                style: TextStyle(
                                  fontFamily: 'SF Pro',
                                  fontSize: 34,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF050505),
                                  letterSpacing: -0.6,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Track your recurring payments.',
                                style: TextStyle(
                                  fontFamily: 'SF Pro',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF737373),
                                ),
                              ),
                            ],
                          ),

                          // User Avatar inside Liquid Glass Bubble
                          GlassSurface(
                            borderRadius: BorderRadius.circular(24),
                            finish: GlassFinish.regularLight,
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.6),
                                border: Border.all(color: const Color(0xFFE5E5E5)),
                              ),
                              child: const Icon(
                                Icons.person_rounded,
                                color: Color(0xFF111111),
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Main Liquid Glass Spending Card (from Figma 02 & 07)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: LiquidGlassContainer(
                        borderRadius: 32,
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Monthly spending',
                              style: TextStyle(
                                fontFamily: 'SF Pro',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF555555),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                BlocBuilder<SubscriptionBloc, SubscriptionState>(
                                  builder: (context, state) {
                                    final total = state is SubscriptionsLoaded
                                        ? state.totalMonthlyCost
                                        : 74.92;
                                    return Text(
                                      '\$${total.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontFamily: 'SF Pro',
                                        fontSize: 42,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF050505),
                                        letterSpacing: -1.2,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  '/ month',
                                  style: TextStyle(
                                    fontFamily: 'SF Pro',
                                    fontSize: 14,
                                    color: Color(0xFF737373),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),

                            // Badge: Change comparison
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: const Color(0xFFE2E2E2)),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '↓ 12%',
                                        style: TextStyle(
                                          fontFamily: 'SF Pro',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF10B981),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'than last month',
                                  style: TextStyle(
                                    fontFamily: 'SF Pro',
                                    fontSize: 13,
                                    color: Color(0xFF444444),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // Mini Bar Chart (Jan - Jun)
                            const _MiniBarChart(),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Upcoming Payments Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Upcoming payments',
                            style: TextStyle(
                              fontFamily: 'SF Pro',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF080808),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.go(RouteNames.subscriptions),
                            child: const Text(
                              'See all',
                              style: TextStyle(
                                fontFamily: 'SF Pro',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF6C5CE7),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Subscription Items List / Cards
                    BlocBuilder<SubscriptionBloc, SubscriptionState>(
                      builder: (context, state) {
                        final subscriptions = state is SubscriptionsLoaded &&
                                state.subscriptions.isNotEmpty
                            ? state.subscriptions
                            : _sampleSubscriptions;

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: subscriptions.take(3).length,
                          separatorBuilder: (_, _) => const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final sub = subscriptions[index];
                            return _SubscriptionTile(
                              subscription: sub,
                              onTap: () => context.go(
                                '/subscriptions/${sub.id}',
                              ),
                            );
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // Find Subscriptions Automatically (Gmail Discovery Card from Figma 05)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: LiquidGlassContainer(
                        borderRadius: 24,
                        padding: const EdgeInsets.all(18),
                        onTap: () => context.go(RouteNames.addSubscription),
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
                              child: const Icon(
                                Icons.auto_awesome_rounded,
                                color: Color(0xFF6C5CE7),
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 14),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Find subscriptions\nautomatically',
                                    style: TextStyle(
                                      fontFamily: 'SF Pro',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF111111),
                                      height: 1.2,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Connect Gmail to discover recurring fees.',
                                    style: TextStyle(
                                      fontFamily: 'SF Pro',
                                      fontSize: 12,
                                      color: Color(0xFF737373),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 38,
                              height: 38,
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
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Privacy Assurances Row (from Figma 05)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _PrivacyAssuranceItem(
                            icon: Icons.lock_outline_rounded,
                            label: 'Read-only\naccess',
                          ),
                          _PrivacyAssuranceItem(
                            icon: Icons.shield_outlined,
                            label: 'We don’t store\nyour emails',
                          ),
                          _PrivacyAssuranceItem(
                            icon: Icons.mark_email_read_outlined,
                            label: 'Only subscription\ninformation',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Floating Liquid Glass Navigation Bar (from Figma 07 / nav)
            Positioned(
              left: 20,
              right: 20,
              bottom: 16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GlassBar(
                    borderRadius: BorderRadius.circular(32),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    finish: GlassFinish.regularLight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _NavBarItem(
                          icon: Icons.home_filled,
                          label: 'Home',
                          isSelected: _selectedTabIndex == 0,
                          onTap: () {
                            setState(() => _selectedTabIndex = 0);
                          },
                        ),
                        _NavBarItem(
                          icon: Icons.format_list_bulleted_rounded,
                          label: 'Subscriptions',
                          isSelected: _selectedTabIndex == 1,
                          onTap: () {
                            setState(() => _selectedTabIndex = 1);
                            context.go(RouteNames.subscriptions);
                          },
                        ),
                        _NavBarItem(
                          icon: Icons.insert_chart_outlined_rounded,
                          label: 'Insights',
                          isSelected: _selectedTabIndex == 2,
                          onTap: () {
                            setState(() => _selectedTabIndex = 2);
                            context.go(RouteNames.analytics);
                          },
                        ),
                        _NavBarItem(
                          icon: Icons.person_outline_rounded,
                          label: 'Profile',
                          isSelected: _selectedTabIndex == 3,
                          onTap: () {
                            setState(() => _selectedTabIndex = 3);
                            context.go(RouteNames.settings);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  const SystemHomeIndicator(opacity: 0.18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniBarChart extends StatelessWidget {
  const _MiniBarChart();

  @override
  Widget build(BuildContext context) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
    const values = [0.42, 0.68, 0.45, 0.62, 0.82, 0.95];

    return SizedBox(
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(6, (index) {
          final isCurrent = index == 5;
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 24,
                height: 60 * values[index],
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isCurrent
                      ? const Color(0xFF080909)
                      : const Color(0xFFD4D4D4).withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                months[index],
                style: TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 11,
                  fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400,
                  color: isCurrent ? const Color(0xFF111111) : const Color(0xFF888888),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _SubscriptionTile extends StatelessWidget {
  final SubscriptionEntity subscription;
  final VoidCallback onTap;

  const _SubscriptionTile({
    required this.subscription,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LiquidGlassContainer(
      borderRadius: 20,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      onTap: onTap,
      child: Row(
        children: [
          // Icon badge
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFECECEC)),
            ),
            child: Center(
              child: Text(
                subscription.name.isNotEmpty ? subscription.name[0] : 'S',
                style: const TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111111),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subscription.name,
                  style: const TextStyle(
                    fontFamily: 'SF Pro',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111111),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Renews in 5 days',
                  style: const TextStyle(
                    fontFamily: 'SF Pro',
                    fontSize: 13,
                    color: Color(0xFF737373),
                  ),
                ),
              ],
            ),
          ),

          // Price
          Text(
            '\$${subscription.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontFamily: 'SF Pro',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF080808),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivacyAssuranceItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _PrivacyAssuranceItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 22, color: const Color(0xFF666666)),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'SF Pro',
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Color(0xFF737373),
            height: 1.25,
          ),
        ),
      ],
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? const Color(0xFF050505) : const Color(0xFFAAAAAA);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(height: 2),
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

final List<SubscriptionEntity> _sampleSubscriptions = [
  SubscriptionEntity(
    id: 'sub_spotify',
    userId: 'user_1',
    name: 'Spotify',
    price: 11.99,
    currency: 'USD',
    billingCycle: BillingCycle.monthly,
    firstBillDate: DateTime(2026, 1, 1),
    nextBillingDate: DateTime(2026, 10, 24),
    category: 'Entertainment',
    createdAt: DateTime(2026, 1, 1),
  ),
  SubscriptionEntity(
    id: 'sub_netflix',
    userId: 'user_1',
    name: 'Netflix',
    price: 15.49,
    currency: 'USD',
    billingCycle: BillingCycle.monthly,
    firstBillDate: DateTime(2026, 2, 1),
    nextBillingDate: DateTime(2026, 10, 29),
    category: 'Entertainment',
    createdAt: DateTime(2026, 2, 1),
  ),
  SubscriptionEntity(
    id: 'sub_youtube',
    userId: 'user_1',
    name: 'YouTube Premium',
    price: 13.99,
    currency: 'USD',
    billingCycle: BillingCycle.monthly,
    firstBillDate: DateTime(2026, 3, 1),
    nextBillingDate: DateTime(2026, 11, 4),
    category: 'Entertainment',
    createdAt: DateTime(2026, 3, 1),
  ),
];
