import 'package:equatable/equatable.dart';
import '../../domain/entities/subscription_entity.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object?> get props => [];
}

class LoadSubscriptionsRequested extends SubscriptionEvent {
  const LoadSubscriptionsRequested();
}

class AddSubscriptionRequested extends SubscriptionEvent {
  final SubscriptionEntity subscription;

  const AddSubscriptionRequested(this.subscription);

  @override
  List<Object?> get props => [subscription];
}

class UpdateSubscriptionRequested extends SubscriptionEvent {
  final SubscriptionEntity subscription;

  const UpdateSubscriptionRequested(this.subscription);

  @override
  List<Object?> get props => [subscription];
}

class DeleteSubscriptionRequested extends SubscriptionEvent {
  final String id;

  const DeleteSubscriptionRequested(this.id);

  @override
  List<Object?> get props => [id];
}
