import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/di/injection_container.dart';
import 'core/utils/bloc_observer.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Configure BLoC observer for logging and monitoring
      Bloc.observer = AppBlocObserver();

      // Initialize Dependency Injection
      await initDependencies();

      // Run application
      runApp(const SubTrackApp());
    },
    (error, stackTrace) {
      developer.log(
        'Unhandled Exception: $error',
        name: 'SubTrackApp',
        error: error,
        stackTrace: stackTrace,
      );
    },
  );
}
