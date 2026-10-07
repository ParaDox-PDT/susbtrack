import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/spending_summary_entity.dart';

abstract class AnalyticsRepository {
  Future<Result<SpendingSummaryEntity, Failure>> getSpendingSummary();
}
