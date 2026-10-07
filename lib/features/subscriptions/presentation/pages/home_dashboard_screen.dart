import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1455/g1455.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/liquid_glass_card_container.dart';
import '../../../../core/widgets/subtrack_bottom_nav_bar.dart';
import '../../../../core/widgets/system_status_bar.dart';
import '../../domain/entities/billing_cycle.dart';
import '../../domain/entities/subscription_entity.dart';
import '../bloc/subscription_bloc.dart';
import '../bloc/subscription_event.dart';
import '../bloc/subscription_state.dart';

/// 07 / Home dashboard matching Figma node 16:114 precisely.
class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
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
        child: Column(
          children: [
            const SystemStatusBar(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Header: Greeting, Subtitle, Notification Bell, Avatar
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
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF555555),
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Alex',
                                style: TextStyle(
                                  fontFamily: 'SF Pro',
                                  fontSize: 29,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF050505),
                                  letterSpacing: -0.6,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                'Here’s your subscription overview.',
                                style: TextStyle(
                                  fontFamily: 'SF Pro',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF666666),
                                ),
                              ),
                            ],
                          ),

                          // Header Actions: Notification Bell + Avatar
                          Row(
                            children: [
                              // Notification Bell with indicator
                              GlassSurface(
                                borderRadius: BorderRadius.circular(20),
                                finish: GlassFinish.regularLight,
                                child: InkWell(
                                  onTap: () {},
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    width: 42,
                                    height: 42,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withValues(alpha: 0.7),
                                      border: Border.all(
                                        color: const Color(0xFFE5E5E5),
                                        width: 1,
                                      ),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        const Icon(
                                          Icons.notifications_none_rounded,
                                          color: Color(0xFF222222),
                                          size: 22,
                                        ),
                                        Positioned(
                                          top: 10,
                                          right: 11,
                                          child: Container(
                                            width: 7,
                                            height: 7,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF10B981),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),

                              // Alex Avatar
                              GlassSurface(
                                borderRadius: BorderRadius.circular(22),
                                finish: GlassFinish.regularLight,
                                child: InkWell(
                                  onTap: () => context.go(RouteNames.settings),
                                  borderRadius: BorderRadius.circular(22),
                                  child: Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFF222222),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.1),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'A',
                                      style: TextStyle(
                                        fontFamily: 'SF Pro',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Monthly spending Card (Figma 16:248)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: LiquidGlassContainer(
                        borderRadius: 28,
                        padding: const EdgeInsets.all(22),
                        border: Border.all(
                          color: const Color(0xFFEBEBEB),
                          width: 1,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Monthly spending',
                              style: TextStyle(
                                fontFamily: 'SF Pro',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF444444),
                              ),
                            ),
                            const SizedBox(height: 4),

                            BlocBuilder<SubscriptionBloc, SubscriptionState>(
                              builder: (context, state) {
                                final total = state is SubscriptionsLoaded
                                    ? state.totalMonthlyCost
                                    : 74.92;
                                return Text(
                                  '\$${total.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontFamily: 'SF Pro',
                                    fontSize: 38,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF050505),
                                    letterSpacing: -1,
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 12),

                            // Badge: "↓ 12%" + "than last month"
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8F5E9),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    '↓ 12%',
                                    style: TextStyle(
                                      fontFamily: 'SF Pro',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF138329),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'than last month',
                                  style: TextStyle(
                                    fontFamily: 'SF Pro',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF555555),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),

                            // Spending Chart (5 gradient bars + latest marker)
                            const _SpendingBarChart(),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // 4 Statistics Cards in 2x2 Grid (Figma 16:261)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _MetricCard(
                                  icon: Icons.layers_outlined,
                                  label: 'Active\nsubscriptions',
                                  value: '8',
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _MetricCard(
                                  icon: Icons.credit_card_rounded,
                                  label: 'Yearly cost',
                                  value: '\$899',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _MetricCard(
                                  icon: Icons.calendar_today_rounded,
                                  label: 'Upcoming\npayments',
                                  value: '3',
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _MetricCard(
                                  icon: Icons.savings_outlined,
                                  label: 'Potential savings',
                                  value: '\$216',
                                  subText: '/ year',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Upcoming Payments Section Header
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
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF050505),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.go(RouteNames.subscriptions),
                            child: const Text(
                              'See all',
                              style: TextStyle(
                                fontFamily: 'SF Pro',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF555555),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Upcoming Payments List (Spotify, iCloud+, Netflix)
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
                            return _UpcomingSubscriptionTile(
                              subscription: sub,
                              onTap: () => context.go('/subscriptions/${sub.id}'),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Bar
            const SubTrackBottomNavBar(currentIndex: 0),
          ],
        ),
      ),
    );
  }
}

/// Statistics metric card widget
class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? subText;

  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
    this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return LiquidGlassContainer(
      borderRadius: 22,
      padding: const EdgeInsets.all(16),
      border: Border.all(
        color: const Color(0xFFECECEC),
        width: 1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFE5E5E5),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              size: 18,
              color: const Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'SF Pro',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF666666),
              height: 1.25,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF080808),
                  letterSpacing: -0.5,
                ),
              ),
              if (subText != null) ...[
                const SizedBox(width: 4),
                Text(
                  subText!,
                  style: const TextStyle(
                    fontFamily: 'SF Pro',
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111111),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

/// Spending Bar Chart matching Figma 16:254
class _SpendingBarChart extends StatelessWidget {
  const _SpendingBarChart();

  @override
  Widget build(BuildContext context) {
    final bars = [
      {'month': 'Jan', 'height': 36.0, 'active': false},
      {'month': 'Feb', 'height': 52.0, 'active': false},
      {'month': 'Mar', 'height': 44.0, 'active': false},
      {'month': 'Apr', 'height': 68.0, 'active': false},
      {'month': 'May', 'height': 82.0, 'active': true},
    ];

    return SizedBox(
      height: 94,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: bars.map((bar) {
          final height = bar['height'] as double;
          final isActive = bar['active'] as bool;
          final month = bar['month'] as String;

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (isActive)
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981),
                    shape: BoxShape.circle,
                  ),
                ),
              Container(
                width: 36,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: isActive
                      ? const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF080808),
                            Color(0xFF444444),
                          ],
                        )
                      : LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFFDCDCE0).withValues(alpha: 0.9),
                            const Color(0xFFEDEDF0).withValues(alpha: 0.6),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                month,
                style: TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  color: isActive ? const Color(0xFF111111) : const Color(0xFF888888),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

/// Upcoming subscription tile matching Figma 16:293
class _UpcomingSubscriptionTile extends StatelessWidget {
  final SubscriptionEntity subscription;
  final VoidCallback onTap;

  const _UpcomingSubscriptionTile({
    required this.subscription,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color iconBgColor = const Color(0xFFF2F2F2);
    Widget iconWidget = const Icon(Icons.star_rounded, size: 20);

    final lower = subscription.name.toLowerCase();
    if (lower.contains('spotify')) {
      iconBgColor = const Color(0xFFE8F5E9);
      iconWidget = const Icon(Icons.music_note_rounded, color: Color(0xFF1DB954), size: 22);
    } else if (lower.contains('icloud') || lower.contains('apple')) {
      iconBgColor = const Color(0xFFE3F2FD);
      iconWidget = const Icon(Icons.cloud_rounded, color: Color(0xFF007AFF), size: 22);
    } else if (lower.contains('netflix')) {
      iconBgColor = const Color(0xFFFFEBEE);
      iconWidget = const Text(
        'N',
        style: TextStyle(
          fontFamily: 'SF Pro',
          fontSize: 18,
          fontWeight: FontWeight.w900,
          color: Color(0xFFE50914),
        ),
      );
    }

    return LiquidGlassContainer(
      borderRadius: 20,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: Border.all(
        color: const Color(0xFFECECEC),
        width: 1,
      ),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: iconWidget,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subscription.name,
                  style: const TextStyle(
                    fontFamily: 'SF Pro',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111111),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Oct ${8 + (subscription.id.hashCode % 10).abs()}, 2026',
                  style: const TextStyle(
                    fontFamily: 'SF Pro',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF737373),
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${subscription.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontFamily: 'SF Pro',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF050505),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFFBBBBBB),
            size: 20,
          ),
        ],
      ),
    );
  }
}

final List<SubscriptionEntity> _sampleSubscriptions = [
  SubscriptionEntity(
    id: 'spotify',
    userId: 'user_1',
    name: 'Spotify Premium',
    price: 10.99,
    currency: 'USD',
    billingCycle: BillingCycle.monthly,
    firstBillDate: DateTime(2025, 1, 8),
    nextBillingDate: DateTime(2026, 10, 8),
    createdAt: DateTime(2025, 1, 8),
  ),
  SubscriptionEntity(
    id: 'icloud',
    userId: 'user_1',
    name: 'iCloud+',
    price: 2.99,
    currency: 'USD',
    billingCycle: BillingCycle.monthly,
    firstBillDate: DateTime(2025, 1, 12),
    nextBillingDate: DateTime(2026, 10, 12),
    createdAt: DateTime(2025, 1, 12),
  ),
  SubscriptionEntity(
    id: 'netflix',
    userId: 'user_1',
    name: 'Netflix',
    price: 15.49,
    currency: 'USD',
    billingCycle: BillingCycle.monthly,
    firstBillDate: DateTime(2025, 1, 18),
    nextBillingDate: DateTime(2026, 10, 18),
    createdAt: DateTime(2025, 1, 18),
  ),
];
