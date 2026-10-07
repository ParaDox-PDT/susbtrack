import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_settings_usecase.dart';
import '../../domain/usecases/update_settings_usecase.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettingsUseCase getSettingsUseCase;
  final UpdateSettingsUseCase updateSettingsUseCase;

  SettingsBloc({
    required this.getSettingsUseCase,
    required this.updateSettingsUseCase,
  }) : super(const SettingsInitial()) {
    on<LoadSettingsRequested>(_onLoadSettingsRequested);
    on<UpdateSettingsRequested>(_onUpdateSettingsRequested);
  }

  Future<void> _onLoadSettingsRequested(
    LoadSettingsRequested event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoading());
    final result = await getSettingsUseCase(const NoParams());
    result.fold(
      onSuccess: (settings) => emit(SettingsLoaded(settings)),
      onFailure: (failure) => emit(SettingsError(failure.message)),
    );
  }

  Future<void> _onUpdateSettingsRequested(
    UpdateSettingsRequested event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoading());
    final result = await updateSettingsUseCase(UpdateSettingsParams(event.settings));
    result.fold(
      onSuccess: (_) => emit(SettingsLoaded(event.settings)),
      onFailure: (failure) => emit(SettingsError(failure.message)),
    );
  }
}
