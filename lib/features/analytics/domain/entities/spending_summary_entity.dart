import 'package:equatable/equatable.dart';

/// Pure domain entity representing recurring financial spendings and categories.
class SpendingSummaryEntity extends Equatable {
  final double totalMonthly;
  final double totalYearly;
  final int activeSubscriptionsCount;
  final String highestSubscriptionName;
  final double highestSubscriptionCost;
  final Map<String, double> categoryBreakdown; // e.g. {'Entertainment': 45.0, 'Work': 80.0}
  final List<String> potentialSavingsSuggestions;

  const SpendingSummaryEntity({
    required this.totalMonthly,
    required this.totalYearly,
    required this.activeSubscriptionsCount,
    required this.highestSubscriptionName,
    required this.highestSubscriptionCost,
    required this.categoryBreakdown,
    this.potentialSavingsSuggestions = const [],
  });

  @override
  List<Object?> get props => [
        totalMonthly,
        totalYearly,
        activeSubscriptionsCount,
        highestSubscriptionName,
        highestSubscriptionCost,
        categoryBreakdown,
        potentialSavingsSuggestions,
      ];
}
