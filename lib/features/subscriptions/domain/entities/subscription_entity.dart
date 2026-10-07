import 'package:equatable/equatable.dart';
import 'billing_cycle.dart';

/// Pure domain entity representing a recurring subscription.
class SubscriptionEntity extends Equatable {
  final String id;
  final String userId;
  final String name;
  final double price;
  final String currency;
  final BillingCycle billingCycle;
  final DateTime firstBillDate;
  final DateTime nextBillingDate;
  final String? category;
  final String? iconUrl;
  final String? colorHex;
  final bool isActive;
  final String? notes;
  final DateTime createdAt;

  const SubscriptionEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.price,
    this.currency = 'USD',
    required this.billingCycle,
    required this.firstBillDate,
    required this.nextBillingDate,
    this.category,
    this.iconUrl,
    this.colorHex,
    this.isActive = true,
    this.notes,
    required this.createdAt,
  });

  /// Monthly normalized expense for recurring calculations.
  double get monthlyNormalizedCost => switch (billingCycle) {
        BillingCycle.weekly => price * 4.33,
        BillingCycle.monthly => price,
        BillingCycle.quarterly => price / 3,
        BillingCycle.semiAnnual => price / 6,
        BillingCycle.yearly => price / 12,
      };

  /// Yearly normalized expense.
  double get yearlyNormalizedCost => monthlyNormalizedCost * 12;

  SubscriptionEntity copyWith({
    String? id,
    String? userId,
    String? name,
    double? price,
    String? currency,
    BillingCycle? billingCycle,
    DateTime? firstBillDate,
    DateTime? nextBillingDate,
    String? category,
    String? iconUrl,
    String? colorHex,
    bool? isActive,
    String? notes,
    DateTime? createdAt,
  }) {
    return SubscriptionEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      billingCycle: billingCycle ?? this.billingCycle,
      firstBillDate: firstBillDate ?? this.firstBillDate,
      nextBillingDate: nextBillingDate ?? this.nextBillingDate,
      category: category ?? this.category,
      iconUrl: iconUrl ?? this.iconUrl,
      colorHex: colorHex ?? this.colorHex,
      isActive: isActive ?? this.isActive,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        price,
        currency,
        billingCycle,
        firstBillDate,
        nextBillingDate,
        category,
        iconUrl,
        colorHex,
        isActive,
        notes,
        createdAt,
      ];
}
