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
import '../bloc/subscription_state.dart';

/// 08 / Subscriptions screen matching Figma specifications with g1455 liquid glass controls.
class SubscriptionsListScreen extends StatefulWidget {
  const SubscriptionsListScreen({super.key});

  @override
  State<SubscriptionsListScreen> createState() => _SubscriptionsListScreenState();
}

class _SubscriptionsListScreenState extends State<SubscriptionsListScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';

  final List<String> _categories = [
    'All',
    'Entertainment',
    'Productivity',
    'Utilities',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F5),
      body: SafeArea(
        child: Column(
          children: [
            const SystemStatusBar(),

            // Top Header & Navigation Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  // Back button
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
                        'Subscriptions',
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF080808),
                        ),
                      ),
                    ),
                  ),

                  // Add button
                  GlassSurface(
                    borderRadius: BorderRadius.circular(20),
                    finish: GlassFinish.regularLight,
                    child: InkWell(
                      onTap: () => context.go(RouteNames.addSubscription),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFF080909),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add_rounded,
                          size: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Search Bar with Liquid Glass
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LiquidGlassContainer(
                borderRadius: 20,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded, color: Color(0xFF888888), size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        onChanged: (val) {
                          setState(() {
                            _searchQuery = val.toLowerCase();
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search subscriptions...',
                          hintStyle: TextStyle(
                            fontFamily: 'SF Pro',
                            fontSize: 14,
                            color: Color(0xFF888888),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Filter Chips
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _categories.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = cat == _selectedCategory;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = cat;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF080909)
                            : Colors.white.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(19),
                        border: Border.all(
                          color: isSelected ? Colors.transparent : const Color(0xFFE2E2E2),
                        ),
                      ),
                      child: Text(
                        cat,
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                          fontSize: 13,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: isSelected ? Colors.white : const Color(0xFF444444),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 14),

            // Subscriptions List
            Expanded(
              child: BlocBuilder<SubscriptionBloc, SubscriptionState>(
                builder: (context, state) {
                  final allSubscriptions =
                      state is SubscriptionsLoaded && state.subscriptions.isNotEmpty
                          ? state.subscriptions
                          : _defaultSubscriptionsList;

                  final filtered = allSubscriptions.where((s) {
                    final matchesCat = _selectedCategory == 'All' ||
                        s.category?.toLowerCase() == _selectedCategory.toLowerCase();
                    final matchesSearch = _searchQuery.isEmpty ||
                        s.name.toLowerCase().contains(_searchQuery);
                    return matchesCat && matchesSearch;
                  }).toList();

                  if (filtered.isEmpty) {
                    return const Center(
                      child: Text(
                        'No subscriptions found',
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                          fontSize: 16,
                          color: Color(0xFF888888),
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    itemCount: filtered.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      return _SubscriptionListItem(
                        item: item,
                        onTap: () => context.go('/subscriptions/${item.id}'),
                      );
                    },
                  );
                },
              ),
            ),

            const SystemHomeIndicator(opacity: 0.18),
          ],
        ),
      ),
    );
  }
}

class _SubscriptionListItem extends StatelessWidget {
  final SubscriptionEntity item;
  final VoidCallback onTap;

  const _SubscriptionListItem({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LiquidGlassContainer(
      borderRadius: 22,
      padding: const EdgeInsets.all(16),
      onTap: onTap,
      child: Row(
        children: [
          // Monogram / Logo box
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFEBEBEB)),
            ),
            alignment: Alignment.center,
            child: Text(
              item.name.isNotEmpty ? item.name[0] : 'S',
              style: const TextStyle(
                fontFamily: 'SF Pro',
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111111),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Name and Billing cycle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontFamily: 'SF Pro',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF080808),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${item.billingCycle.displayName} • Renews Nov 2026',
                  style: const TextStyle(
                    fontFamily: 'SF Pro',
                    fontSize: 13,
                    color: Color(0xFF777777),
                  ),
                ),
              ],
            ),
          ),

          // Cost
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${item.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF080808),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '/${item.billingCycle == BillingCycle.yearly ? "yr" : "mo"}',
                style: const TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 12,
                  color: Color(0xFF999999),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final List<SubscriptionEntity> _defaultSubscriptionsList = [
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
  SubscriptionEntity(
    id: 'sub_chatgpt',
    userId: 'user_1',
    name: 'ChatGPT Plus',
    price: 20.00,
    currency: 'USD',
    billingCycle: BillingCycle.monthly,
    firstBillDate: DateTime(2026, 4, 1),
    nextBillingDate: DateTime(2026, 11, 12),
    category: 'Productivity',
    createdAt: DateTime(2026, 4, 1),
  ),
  SubscriptionEntity(
    id: 'sub_icloud',
    userId: 'user_1',
    name: 'iCloud+ 50GB',
    price: 2.99,
    currency: 'USD',
    billingCycle: BillingCycle.monthly,
    firstBillDate: DateTime(2026, 5, 1),
    nextBillingDate: DateTime(2026, 11, 18),
    category: 'Utilities',
    createdAt: DateTime(2026, 5, 1),
  ),
];
