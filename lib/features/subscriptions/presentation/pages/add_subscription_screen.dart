import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1455/g1455.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/liquid_glass_card_container.dart';
import '../../../../core/widgets/system_home_indicator.dart';
import '../../../../core/widgets/system_status_bar.dart';
import '../../domain/entities/billing_cycle.dart';
import '../../domain/entities/subscription_entity.dart';
import '../bloc/subscription_bloc.dart';
import '../bloc/subscription_event.dart';

/// 10 / Add subscription manual entry screen matching Figma specifications.
class AddSubscriptionScreen extends StatefulWidget {
  const AddSubscriptionScreen({super.key});

  @override
  State<AddSubscriptionScreen> createState() => _AddSubscriptionScreenState();
}

class _AddSubscriptionScreenState extends State<AddSubscriptionScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _notesController = TextEditingController();

  BillingCycle _billingCycle = BillingCycle.monthly;
  String _category = 'Entertainment';
  final _nextBillingDate = DateTime.now().add(const Duration(days: 30));

  final List<String> _categories = [
    'Entertainment',
    'Productivity',
    'Utilities',
    'Health',
    'Finance',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _onSave() {
    final name = _nameController.text.trim();
    final price = double.tryParse(_priceController.text.trim()) ?? 0.0;

    if (name.isEmpty || price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid name and price')),
      );
      return;
    }

    final newSubscription = SubscriptionEntity(
      id: const Uuid().v4(),
      userId: 'user_1',
      name: name,
      price: price,
      currency: 'USD',
      billingCycle: _billingCycle,
      firstBillDate: DateTime.now(),
      nextBillingDate: _nextBillingDate,
      category: _category,
      notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      createdAt: DateTime.now(),
    );

    context.read<SubscriptionBloc>().add(AddSubscriptionRequested(newSubscription));
    context.go(RouteNames.subscriptions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F5),
      body: SafeArea(
        child: Column(
          children: [
            const SystemStatusBar(),

            // Top Header
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
                          Icons.close_rounded,
                          size: 20,
                          color: Color(0xFF111111),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Add Subscription',
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF080808),
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
                    // Service Name Field
                    LiquidGlassContainer(
                      borderRadius: 22,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Service Name',
                          labelStyle: TextStyle(
                            fontFamily: 'SF Pro',
                            color: Color(0xFF888888),
                          ),
                          hintText: 'e.g. Netflix, Spotify',
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Price Field
                    LiquidGlassContainer(
                      borderRadius: 22,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      child: TextField(
                        controller: _priceController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'Price (USD)',
                          labelStyle: TextStyle(
                            fontFamily: 'SF Pro',
                            color: Color(0xFF888888),
                          ),
                          hintText: 'e.g. 11.99',
                          prefixText: '\$ ',
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Billing Cycle Selection
                    const Text(
                      'Billing Cycle',
                      style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111111),
                      ),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        _CycleOption(
                          label: 'Monthly',
                          isSelected: _billingCycle == BillingCycle.monthly,
                          onTap: () => setState(() => _billingCycle = BillingCycle.monthly),
                        ),
                        const SizedBox(width: 8),
                        _CycleOption(
                          label: 'Yearly',
                          isSelected: _billingCycle == BillingCycle.yearly,
                          onTap: () => setState(() => _billingCycle = BillingCycle.yearly),
                        ),
                        const SizedBox(width: 8),
                        _CycleOption(
                          label: 'Weekly',
                          isSelected: _billingCycle == BillingCycle.weekly,
                          onTap: () => setState(() => _billingCycle = BillingCycle.weekly),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Category Selection
                    const Text(
                      'Category',
                      style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111111),
                      ),
                    ),
                    const SizedBox(height: 10),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _categories.map((c) {
                        final isSelected = c == _category;
                        return GestureDetector(
                          onTap: () => setState(() => _category = c),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF080808)
                                  : Colors.white.withValues(alpha: 0.8),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected ? Colors.transparent : const Color(0xFFDDDDDD),
                              ),
                            ),
                            child: Text(
                              c,
                              style: TextStyle(
                                fontFamily: 'SF Pro',
                                fontSize: 13,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                color: isSelected ? Colors.white : const Color(0xFF333333),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),

                    // Notes Field
                    LiquidGlassContainer(
                      borderRadius: 22,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      child: TextField(
                        controller: _notesController,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          labelText: 'Notes (Optional)',
                          labelStyle: TextStyle(
                            fontFamily: 'SF Pro',
                            color: Color(0xFF888888),
                          ),
                          hintText: 'Add personal notes or account details...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Save Button
                    InkWell(
                      onTap: _onSave,
                      borderRadius: BorderRadius.circular(26),
                      child: Container(
                        width: double.infinity,
                        height: 54,
                        decoration: BoxDecoration(
                          color: const Color(0xFF080808),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Save Subscription',
                          style: TextStyle(
                            fontFamily: 'SF Pro',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
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

class _CycleOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CycleOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF080808) : Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? Colors.transparent : const Color(0xFFDDDDDD),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'SF Pro',
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? Colors.white : const Color(0xFF333333),
            ),
          ),
        ),
      ),
    );
  }
}
