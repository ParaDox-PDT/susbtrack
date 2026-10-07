import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_spending_summary_usecase.dart';
import 'analytics_event.dart';
import 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final GetSpendingSummaryUseCase getSpendingSummaryUseCase;

  AnalyticsBloc({
    required this.getSpendingSummaryUseCase,
  }) : super(const AnalyticsInitial()) {
    on<LoadAnalyticsRequested>(_onLoadAnalyticsRequested);
  }

  Future<void> _onLoadAnalyticsRequested(
    LoadAnalyticsRequested event,
    Emitter<AnalyticsState> emit,
  ) async {
    emit(const AnalyticsLoading());
    final result = await getSpendingSummaryUseCase(const NoParams());
    result.fold(
      onSuccess: (summary) => emit(AnalyticsLoaded(summary)),
      onFailure: (failure) => emit(AnalyticsError(failure.message)),
    );
  }
}
