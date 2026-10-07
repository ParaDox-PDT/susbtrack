import '../../domain/entities/billing_cycle.dart';
import '../../domain/entities/subscription_entity.dart';

/// Data Transfer Object for Subscription with JSON mapping.
class SubscriptionModel extends SubscriptionEntity {
  const SubscriptionModel({
    required super.id,
    required super.userId,
    required super.name,
    required super.price,
    super.currency = 'USD',
    required super.billingCycle,
    required super.firstBillDate,
    required super.nextBillingDate,
    super.category,
    super.iconUrl,
    super.colorHex,
    super.isActive = true,
    super.notes,
    required super.createdAt,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'] as String,
      userId: json['userId'] as String? ?? '',
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'USD',
      billingCycle: BillingCycle.values.firstWhere(
        (e) => e.name == json['billingCycle'],
        orElse: () => BillingCycle.monthly,
      ),
      firstBillDate: DateTime.parse(json['firstBillDate'] as String),
      nextBillingDate: DateTime.parse(json['nextBillingDate'] as String),
      category: json['category'] as String?,
      iconUrl: json['iconUrl'] as String?,
      colorHex: json['colorHex'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'price': price,
      'currency': currency,
      'billingCycle': billingCycle.name,
      'firstBillDate': firstBillDate.toIso8601String(),
      'nextBillingDate': nextBillingDate.toIso8601String(),
      'category': category,
      'iconUrl': iconUrl,
      'colorHex': colorHex,
      'isActive': isActive,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory SubscriptionModel.fromEntity(SubscriptionEntity entity) {
    return SubscriptionModel(
      id: entity.id,
      userId: entity.userId,
      name: entity.name,
      price: entity.price,
      currency: entity.currency,
      billingCycle: entity.billingCycle,
      firstBillDate: entity.firstBillDate,
      nextBillingDate: entity.nextBillingDate,
      category: entity.category,
      iconUrl: entity.iconUrl,
      colorHex: entity.colorHex,
      isActive: entity.isActive,
      notes: entity.notes,
      createdAt: entity.createdAt,
    );
  }
}
