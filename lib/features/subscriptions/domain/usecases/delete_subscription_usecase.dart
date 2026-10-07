import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../repositories/subscription_repository.dart';

class DeleteSubscriptionParams extends Equatable {
  final String id;

  const DeleteSubscriptionParams(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteSubscriptionUseCase implements UseCase<void, DeleteSubscriptionParams> {
  final SubscriptionRepository _repository;

  DeleteSubscriptionUseCase(this._repository);

  @override
  Future<Result<void, Failure>> call(DeleteSubscriptionParams params) {
    return _repository.deleteSubscription(params.id);
  }
}
