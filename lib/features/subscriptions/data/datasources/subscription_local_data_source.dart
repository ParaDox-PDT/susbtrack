import 'dart:convert';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/storage/local_storage_service.dart';
import '../models/subscription_model.dart';

abstract class SubscriptionLocalDataSource {
  Future<void> cacheSubscriptions(List<SubscriptionModel> subscriptions);
  Future<List<SubscriptionModel>> getCachedSubscriptions();
  Future<void> clearCache();
}

class SubscriptionLocalDataSourceImpl implements SubscriptionLocalDataSource {
  final LocalStorageService _localStorage;

  SubscriptionLocalDataSourceImpl(this._localStorage);

  @override
  Future<void> cacheSubscriptions(List<SubscriptionModel> subscriptions) async {
    final jsonList = subscriptions.map((s) => s.toJson()).toList();
    await _localStorage.setString(AppConstants.keySubscriptionsCache, jsonEncode(jsonList));
  }

  @override
  Future<List<SubscriptionModel>> getCachedSubscriptions() async {
    final cachedString = _localStorage.getString(AppConstants.keySubscriptionsCache);
    if (cachedString == null) return [];
    final jsonList = jsonDecode(cachedString) as List<dynamic>;
    return jsonList
        .map((item) => SubscriptionModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> clearCache() async {
    await _localStorage.remove(AppConstants.keySubscriptionsCache);
  }
}
