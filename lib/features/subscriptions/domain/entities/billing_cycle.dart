/// Frequency of recurring payments.
enum BillingCycle {
  weekly,
  monthly,
  quarterly,
  semiAnnual,
  yearly;

  String get displayName => switch (this) {
        BillingCycle.weekly => 'Weekly',
        BillingCycle.monthly => 'Monthly',
        BillingCycle.quarterly => 'Quarterly',
        BillingCycle.semiAnnual => '6 Months',
        BillingCycle.yearly => 'Yearly',
      };

  int get monthsInterval => switch (this) {
        BillingCycle.weekly => 0,
        BillingCycle.monthly => 1,
        BillingCycle.quarterly => 3,
        BillingCycle.semiAnnual => 6,
        BillingCycle.yearly => 12,
      };
}
