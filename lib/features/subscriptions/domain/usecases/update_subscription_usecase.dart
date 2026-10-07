import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/subscription_entity.dart';
import '../repositories/subscription_repository.dart';

class UpdateSubscriptionParams extends Equatable {
  final SubscriptionEntity subscription;

  const UpdateSubscriptionParams(this.subscription);

  @override
  List<Object?> get props => [subscription];
}

class UpdateSubscriptionUseCase implements UseCase<SubscriptionEntity, UpdateSubscriptionParams> {
  final SubscriptionRepository _repository;

  UpdateSubscriptionUseCase(this._repository);

  @override
  Future<Result<SubscriptionEntity, Failure>> call(UpdateSubscriptionParams params) {
    return _repository.updateSubscription(params.subscription);
  }
}
