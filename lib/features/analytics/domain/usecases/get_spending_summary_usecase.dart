import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/spending_summary_entity.dart';
import '../repositories/analytics_repository.dart';

class GetSpendingSummaryUseCase implements UseCase<SpendingSummaryEntity, NoParams> {
  final AnalyticsRepository _repository;

  GetSpendingSummaryUseCase(this._repository);

  @override
  Future<Result<SpendingSummaryEntity, Failure>> call(NoParams params) {
    return _repository.getSpendingSummary();
  }
}
