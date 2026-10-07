import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/subscription_entity.dart';

/// Contract defining all subscription data operations in the domain layer.
abstract class SubscriptionRepository {
  Future<Result<List<SubscriptionEntity>, Failure>> getSubscriptions();
  Future<Result<SubscriptionEntity, Failure>> getSubscriptionById(String id);
  Future<Result<SubscriptionEntity, Failure>> addSubscription(SubscriptionEntity subscription);
  Future<Result<SubscriptionEntity, Failure>> updateSubscription(SubscriptionEntity subscription);
  Future<Result<void, Failure>> deleteSubscription(String id);
  Future<Result<void, Failure>> toggleSubscriptionStatus(String id, bool isActive);
}
