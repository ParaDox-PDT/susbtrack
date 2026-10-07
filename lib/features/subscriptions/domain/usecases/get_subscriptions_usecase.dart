import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/subscription_entity.dart';
import '../repositories/subscription_repository.dart';

class GetSubscriptionsUseCase implements UseCase<List<SubscriptionEntity>, NoParams> {
  final SubscriptionRepository _repository;

  GetSubscriptionsUseCase(this._repository);

  @override
  Future<Result<List<SubscriptionEntity>, Failure>> call(NoParams params) {
    return _repository.getSubscriptions();
  }
}
