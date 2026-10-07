import 'package:flutter/material.dart';
import 'package:g1455/g1455.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/liquid_glass_card_container.dart';
import '../../../../core/widgets/system_home_indicator.dart';
import '../../../../core/widgets/system_status_bar.dart';

/// 39 / Insights & Spending analytics screen matching Figma specifications with g1455 liquid glass.
class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

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
                        'Insights & Spending',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Overview Glass Card
                    LiquidGlassContainer(
                      borderRadius: 28,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Estimated yearly spending',
                            style: TextStyle(
                              fontFamily: 'SF Pro',
                              fontSize: 14,
                              color: Color(0xFF737373),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            '\$899.04',
                            style: TextStyle(
                              fontFamily: 'SF Pro',
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF050505),
                              letterSpacing: -1.0,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _OverviewMetric(
                                label: 'Monthly avg',
                                value: '\$74.92',
                              ),
                              _OverviewMetric(
                                label: 'Active services',
                                value: '5 apps',
                              ),
                              _OverviewMetric(
                                label: 'Highest bill',
                                value: '\$20.00',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Spending by Category Section
                    const Text(
                      'Spending by category',
                      style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF080808),
                      ),
                    ),
                    const SizedBox(height: 12),

                    LiquidGlassContainer(
                      borderRadius: 24,
                      padding: const EdgeInsets.all(18),
                      child: const Column(
                        children: [
                          _CategoryProgressRow(
                            category: 'Entertainment',
                            amount: '\$41.47',
                            percentage: 0.55,
                            color: Color(0xFF6C5CE7),
                          ),
                          SizedBox(height: 14),
                          _CategoryProgressRow(
                            category: 'Productivity',
                            amount: '\$20.00',
                            percentage: 0.27,
                            color: Color(0xFF00D2D3),
                          ),
                          SizedBox(height: 14),
                          _CategoryProgressRow(
                            category: 'Utilities & Cloud',
                            amount: '\$13.45',
                            percentage: 0.18,
                            color: Color(0xFF10B981),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Potential Savings Suggestions
                    const Text(
                      'Smart recommendations',
                      style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF080808),
                      ),
                    ),
                    const SizedBox(height: 12),

                    LiquidGlassContainer(
                      borderRadius: 24,
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981).withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.savings_outlined,
                              color: Color(0xFF10B981),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Switch to Annual Billing',
                                  style: TextStyle(
                                    fontFamily: 'SF Pro',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF111111),
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  'Switching YouTube and Spotify to annual plans saves you up to \$42/year.',
                                  style: TextStyle(
                                    fontFamily: 'SF Pro',
                                    fontSize: 13,
                                    color: Color(0xFF737373),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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

class _OverviewMetric extends StatelessWidget {
  final String label;
  final String value;

  const _OverviewMetric({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'SF Pro',
            fontSize: 12,
            color: Color(0xFF888888),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'SF Pro',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111111),
          ),
        ),
      ],
    );
  }
}

class _CategoryProgressRow extends StatelessWidget {
  final String category;
  final String amount;
  final double percentage;
  final Color color;

  const _CategoryProgressRow({
    required this.category,
    required this.amount,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category,
              style: const TextStyle(
                fontFamily: 'SF Pro',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF111111),
              ),
            ),
            Text(
              amount,
              style: const TextStyle(
                fontFamily: 'SF Pro',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111111),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: const Color(0xFFEEEEEE),
            valueColor: AlwaysStoppedAnimation(color),
            minHeight: 7,
          ),
        ),
      ],
    );
  }
}
