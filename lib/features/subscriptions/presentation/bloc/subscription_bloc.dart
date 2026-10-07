import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/add_subscription_usecase.dart';
import '../../domain/usecases/delete_subscription_usecase.dart';
import '../../domain/usecases/get_subscriptions_usecase.dart';
import '../../domain/usecases/update_subscription_usecase.dart';
import 'subscription_event.dart';
import 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final GetSubscriptionsUseCase getSubscriptionsUseCase;
  final AddSubscriptionUseCase addSubscriptionUseCase;
  final UpdateSubscriptionUseCase updateSubscriptionUseCase;
  final DeleteSubscriptionUseCase deleteSubscriptionUseCase;

  SubscriptionBloc({
    required this.getSubscriptionsUseCase,
    required this.addSubscriptionUseCase,
    required this.updateSubscriptionUseCase,
    required this.deleteSubscriptionUseCase,
  }) : super(const SubscriptionInitial()) {
    on<LoadSubscriptionsRequested>(_onLoadSubscriptionsRequested);
    on<AddSubscriptionRequested>(_onAddSubscriptionRequested);
    on<UpdateSubscriptionRequested>(_onUpdateSubscriptionRequested);
    on<DeleteSubscriptionRequested>(_onDeleteSubscriptionRequested);
  }

  Future<void> _onLoadSubscriptionsRequested(
    LoadSubscriptionsRequested event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(const SubscriptionLoading());
    final result = await getSubscriptionsUseCase(const NoParams());
    result.fold(
      onSuccess: (subscriptions) => emit(SubscriptionsLoaded(subscriptions)),
      onFailure: (failure) => emit(SubscriptionError(failure.message)),
    );
  }

  Future<void> _onAddSubscriptionRequested(
    AddSubscriptionRequested event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(const SubscriptionLoading());
    final result = await addSubscriptionUseCase(AddSubscriptionParams(event.subscription));
    await result.fold(
      onSuccess: (_) async {
        emit(const SubscriptionActionSuccess('Subscription added successfully'));
        add(const LoadSubscriptionsRequested());
      },
      onFailure: (failure) async => emit(SubscriptionError(failure.message)),
    );
  }

  Future<void> _onUpdateSubscriptionRequested(
    UpdateSubscriptionRequested event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(const SubscriptionLoading());
    final result = await updateSubscriptionUseCase(UpdateSubscriptionParams(event.subscription));
    await result.fold(
      onSuccess: (_) async {
        emit(const SubscriptionActionSuccess('Subscription updated successfully'));
        add(const LoadSubscriptionsRequested());
      },
      onFailure: (failure) async => emit(SubscriptionError(failure.message)),
    );
  }

  Future<void> _onDeleteSubscriptionRequested(
    DeleteSubscriptionRequested event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(const SubscriptionLoading());
    final result = await deleteSubscriptionUseCase(DeleteSubscriptionParams(event.id));
    await result.fold(
      onSuccess: (_) async {
        emit(const SubscriptionActionSuccess('Subscription deleted successfully'));
        add(const LoadSubscriptionsRequested());
      },
      onFailure: (failure) async => emit(SubscriptionError(failure.message)),
    );
  }
}
