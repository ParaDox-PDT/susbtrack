import '../../domain/entities/spending_summary_entity.dart';

class SpendingSummaryModel extends SpendingSummaryEntity {
  const SpendingSummaryModel({
    required super.totalMonthly,
    required super.totalYearly,
    required super.activeSubscriptionsCount,
    required super.highestSubscriptionName,
    required super.highestSubscriptionCost,
    required super.categoryBreakdown,
    super.potentialSavingsSuggestions = const [],
  });

  factory SpendingSummaryModel.fromJson(Map<String, dynamic> json) {
    return SpendingSummaryModel(
      totalMonthly: (json['totalMonthly'] as num).toDouble(),
      totalYearly: (json['totalYearly'] as num).toDouble(),
      activeSubscriptionsCount: json['activeSubscriptionsCount'] as int,
      highestSubscriptionName: json['highestSubscriptionName'] as String? ?? '',
      highestSubscriptionCost: (json['highestSubscriptionCost'] as num?)?.toDouble() ?? 0.0,
      categoryBreakdown: (json['categoryBreakdown'] as Map<String, dynamic>?)?.map(
            (k, v) => MapEntry(k, (v as num).toDouble()),
          ) ??
          {},
      potentialSavingsSuggestions: (json['potentialSavingsSuggestions'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalMonthly': totalMonthly,
      'totalYearly': totalYearly,
      'activeSubscriptionsCount': activeSubscriptionsCount,
      'highestSubscriptionName': highestSubscriptionName,
      'highestSubscriptionCost': highestSubscriptionCost,
      'categoryBreakdown': categoryBreakdown,
      'potentialSavingsSuggestions': potentialSavingsSuggestions,
    };
  }
}
