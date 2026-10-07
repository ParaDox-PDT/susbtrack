import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/spending_summary_model.dart';

abstract class AnalyticsRemoteDataSource {
  Future<SpendingSummaryModel> fetchSpendingSummary();
}

class AnalyticsRemoteDataSourceImpl implements AnalyticsRemoteDataSource {
  final ApiClient _apiClient;

  AnalyticsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<SpendingSummaryModel> fetchSpendingSummary() async {
    final response = await _apiClient.get(ApiEndpoints.analyticsSummary);
    return SpendingSummaryModel.fromJson(response as Map<String, dynamic>);
  }
}
