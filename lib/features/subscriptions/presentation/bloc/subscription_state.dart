import 'package:equatable/equatable.dart';
import '../../domain/entities/subscription_entity.dart';

sealed class SubscriptionState extends Equatable {
  const SubscriptionState();

  @override
  List<Object?> get props => [];
}

class SubscriptionInitial extends SubscriptionState {
  const SubscriptionInitial();
}

class SubscriptionLoading extends SubscriptionState {
  const SubscriptionLoading();
}

class SubscriptionsLoaded extends SubscriptionState {
  final List<SubscriptionEntity> subscriptions;

  const SubscriptionsLoaded(this.subscriptions);

  /// Calculated total monthly recurring expense.
  double get totalMonthlyCost =>
      subscriptions.where((s) => s.isActive).fold(0.0, (acc, s) => acc + s.monthlyNormalizedCost);

  /// Calculated total annual recurring expense.
  double get totalYearlyCost => totalMonthlyCost * 12;

  int get activeCount => subscriptions.where((s) => s.isActive).length;

  @override
  List<Object?> get props => [subscriptions];
}

class SubscriptionActionSuccess extends SubscriptionState {
  final String message;

  const SubscriptionActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class SubscriptionError extends SubscriptionState {
  final String message;

  const SubscriptionError(this.message);

  @override
  List<Object?> get props => [message];
}
