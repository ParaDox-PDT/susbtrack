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

/// 09 / Spotify subscription details screen matching Figma specifications.
class SubscriptionDetailScreen extends StatelessWidget {
  final String subscriptionId;

  const SubscriptionDetailScreen({
    super.key,
    required this.subscriptionId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionBloc, SubscriptionState>(
      builder: (context, state) {
        SubscriptionEntity? sub;
        if (state is SubscriptionsLoaded) {
          sub = state.subscriptions.where((s) => s.id == subscriptionId).firstOrNull;
        }

        // Fallback demo model if not found in state
        final item = sub ??
            SubscriptionEntity(
              id: subscriptionId,
              userId: 'user_1',
              name: 'Spotify Premium',
              price: 11.99,
              currency: 'USD',
              billingCycle: BillingCycle.monthly,
              firstBillDate: DateTime(2025, 1, 15),
              nextBillingDate: DateTime(2026, 10, 24),
              category: 'Entertainment',
              createdAt: DateTime(2025, 1, 15),
            );

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GlassSurface(
                        borderRadius: BorderRadius.circular(20),
                        finish: GlassFinish.regularLight,
                        child: InkWell(
                          onTap: () => context.go(RouteNames.subscriptions),
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
                      const Text(
                        'Subscription Details',
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF080808),
                        ),
                      ),
                      GlassSurface(
                        borderRadius: BorderRadius.circular(20),
                        finish: GlassFinish.regularLight,
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.more_horiz_rounded,
                              size: 20,
                              color: Color(0xFF111111),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Column(
                      children: [
                        // Hero Liquid Glass Service Card
                        LiquidGlassContainer(
                          borderRadius: 32,
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              // Monogram / Logo Badge
                              Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.05),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  item.name.isNotEmpty ? item.name[0] : 'S',
                                  style: const TextStyle(
                                    fontFamily: 'SF Pro',
                                    fontSize: 34,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF111111),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 14),

                              Text(
                                item.name,
                                style: const TextStyle(
                                  fontFamily: 'SF Pro',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF050505),
                                ),
                              ),
                              const SizedBox(height: 6),

                              // Price display
                              Text(
                                '\$${item.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontFamily: 'SF Pro',
                                  fontSize: 38,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF050505),
                                  letterSpacing: -1.0,
                                ),
                              ),
                              const SizedBox(height: 4),

                              Text(
                                '${item.billingCycle.displayName} plan',
                                style: const TextStyle(
                                  fontFamily: 'SF Pro',
                                  fontSize: 14,
                                  color: Color(0xFF737373),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Detail Rows Container
                        LiquidGlassContainer(
                          borderRadius: 24,
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                          child: Column(
                            children: [
                              _DetailRow(
                                title: 'Next payment',
                                value: 'Oct 24, 2026',
                                subtitle: 'In 5 days',
                              ),
                              const Divider(color: Color(0xFFEEEEEE)),
                              _DetailRow(
                                title: 'Category',
                                value: item.category ?? 'Entertainment',
                              ),
                              const Divider(color: Color(0xFFEEEEEE)),
                              const _DetailRow(
                                title: 'Payment method',
                                value: 'Mastercard •••• 4242',
                              ),
                              const Divider(color: Color(0xFFEEEEEE)),
                              const _DetailRow(
                                title: 'Annual cost',
                                value: '\$143.88 / yr',
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Action Buttons
                        InkWell(
                          onTap: () {
                            // Edit flow
                          },
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            width: double.infinity,
                            height: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFF080808),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Edit Subscription',
                              style: TextStyle(
                                fontFamily: 'SF Pro',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Delete button
                        GlassSurface(
                          borderRadius: BorderRadius.circular(25),
                          finish: GlassFinish.regularLight,
                          child: InkWell(
                            onTap: () {
                              context.read<SubscriptionBloc>().add(
                                    DeleteSubscriptionRequested(item.id),
                                  );
                              context.go(RouteNames.subscriptions);
                            },
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              width: double.infinity,
                              height: 52,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: const Color(0xFFEF4444).withValues(alpha: 0.3),
                                ),
                              ),
                              child: const Text(
                                'Delete from SubTrack',
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
      },
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;

  const _DetailRow({
    required this.title,
    required this.value,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'SF Pro',
              fontSize: 14,
              color: Color(0xFF737373),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111111),
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle!,
                  style: const TextStyle(
                    fontFamily: 'SF Pro',
                    fontSize: 12,
                    color: Color(0xFF10B981),
                    fontWeight: FontWeight.w500,
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
