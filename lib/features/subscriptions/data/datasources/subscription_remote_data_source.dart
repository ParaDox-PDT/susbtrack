import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/subscription_model.dart';

abstract class SubscriptionRemoteDataSource {
  Future<List<SubscriptionModel>> fetchSubscriptions();
  Future<SubscriptionModel> fetchSubscriptionById(String id);
  Future<SubscriptionModel> createSubscription(SubscriptionModel model);
  Future<SubscriptionModel> updateSubscription(SubscriptionModel model);
  Future<void> deleteSubscription(String id);
}

class SubscriptionRemoteDataSourceImpl implements SubscriptionRemoteDataSource {
  final ApiClient _apiClient;

  SubscriptionRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<SubscriptionModel>> fetchSubscriptions() async {
    final response = await _apiClient.get(ApiEndpoints.subscriptions);
    final list = response as List<dynamic>;
    return list.map((item) => SubscriptionModel.fromJson(item as Map<String, dynamic>)).toList();
  }

  @override
  Future<SubscriptionModel> fetchSubscriptionById(String id) async {
    final response = await _apiClient.get(ApiEndpoints.subscriptionById(id));
    return SubscriptionModel.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<SubscriptionModel> createSubscription(SubscriptionModel model) async {
    final response = await _apiClient.post(
      ApiEndpoints.subscriptions,
      data: model.toJson(),
    );
    return SubscriptionModel.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<SubscriptionModel> updateSubscription(SubscriptionModel model) async {
    final response = await _apiClient.put(
      ApiEndpoints.subscriptionById(model.id),
      data: model.toJson(),
    );
    return SubscriptionModel.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<void> deleteSubscription(String id) async {
    await _apiClient.delete(ApiEndpoints.subscriptionById(id));
  }
}
