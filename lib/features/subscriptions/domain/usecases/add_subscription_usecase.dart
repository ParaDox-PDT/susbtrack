import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/subscription_entity.dart';
import '../repositories/subscription_repository.dart';

class AddSubscriptionParams extends Equatable {
  final SubscriptionEntity subscription;

  const AddSubscriptionParams(this.subscription);

  @override
  List<Object?> get props => [subscription];
}

class AddSubscriptionUseCase implements UseCase<SubscriptionEntity, AddSubscriptionParams> {
  final SubscriptionRepository _repository;

  AddSubscriptionUseCase(this._repository);

  @override
  Future<Result<SubscriptionEntity, Failure>> call(AddSubscriptionParams params) {
    return _repository.addSubscription(params.subscription);
  }
}
