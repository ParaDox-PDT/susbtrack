import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';

/// AppBlocObserver logs all Bloc events, transitions, and errors
/// across the application for strict observability and debugging.
class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    developer.log('BLoC Event: [${bloc.runtimeType}] -> $event', name: 'AppBlocObserver');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    developer.log(
      'BLoC Change: [${bloc.runtimeType}] Current: ${change.currentState} -> Next: ${change.nextState}',
      name: 'AppBlocObserver',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    developer.log(
      'BLoC Error: [${bloc.runtimeType}] -> $error',
      name: 'AppBlocObserver',
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }
}
