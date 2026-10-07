import 'package:flutter_test/flutter_test.dart';
import 'package:substrack/features/subscriptions/domain/entities/billing_cycle.dart';
import 'package:substrack/features/subscriptions/domain/entities/subscription_entity.dart';

void main() {
  test('SubscriptionEntity computes monthly and yearly normalized costs correctly', () {
    final sub = SubscriptionEntity(
      id: 'sub_1',
      userId: 'user_1',
      name: 'Netflix',
      price: 15.0,
      currency: 'USD',
      billingCycle: BillingCycle.monthly,
      firstBillDate: DateTime(2026, 1, 1),
      nextBillingDate: DateTime(2026, 11, 1),
      createdAt: DateTime(2026, 1, 1),
    );

    expect(sub.monthlyNormalizedCost, equals(15.0));
    expect(sub.yearlyNormalizedCost, equals(180.0));
  });
}
