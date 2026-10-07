import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/analytics/data/datasources/analytics_remote_data_source.dart';
import '../../features/analytics/data/repositories/analytics_repository_impl.dart';
import '../../features/analytics/domain/repositories/analytics_repository.dart';
import '../../features/analytics/domain/usecases/get_spending_summary_usecase.dart';
import '../../features/analytics/presentation/bloc/analytics_bloc.dart';

import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/get_current_user_usecase.dart';
import '../../features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import '../../features/auth/domain/usecases/sign_out_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

import '../../features/settings/data/datasources/settings_local_data_source.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/domain/usecases/get_settings_usecase.dart';
import '../../features/settings/domain/usecases/update_settings_usecase.dart';
import '../../features/settings/presentation/bloc/settings_bloc.dart';

import '../../features/subscriptions/data/datasources/subscription_local_data_source.dart';
import '../../features/subscriptions/data/datasources/subscription_remote_data_source.dart';
import '../../features/subscriptions/data/repositories/subscription_repository_impl.dart';
import '../../features/subscriptions/domain/repositories/subscription_repository.dart';
import '../../features/subscriptions/domain/usecases/add_subscription_usecase.dart';
import '../../features/subscriptions/domain/usecases/delete_subscription_usecase.dart';
import '../../features/subscriptions/domain/usecases/get_subscriptions_usecase.dart';
import '../../features/subscriptions/domain/usecases/update_subscription_usecase.dart';
import '../../features/subscriptions/presentation/bloc/subscription_bloc.dart';

import '../network/api_client.dart';
import '../network/api_interceptor.dart';
import '../network/network_info.dart';
import '../storage/local_storage_service.dart';
import '../storage/secure_storage_service.dart';

final sl = GetIt.instance;

/// Central Dependency Injection setup.
Future<void> initDependencies() async {
  // ----------------------------------------------------
  // External & Core Services
  // ----------------------------------------------------
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  sl.registerLazySingleton<LocalStorageService>(
    () => LocalStorageServiceImpl(sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<SecureStorageService>(
    () => SecureStorageServiceImpl(storage: sl<FlutterSecureStorage>()),
  );

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  sl.registerLazySingleton<ApiInterceptor>(
    () => ApiInterceptor(sl<SecureStorageService>()),
  );

  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(interceptor: sl<ApiInterceptor>()),
  );

  // ----------------------------------------------------
  // Feature: Auth
  // ----------------------------------------------------
  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<ApiClient>()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      secureStorage: sl<SecureStorageService>(),
      localStorage: sl<LocalStorageService>(),
    ),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      localDataSource: sl<AuthLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => SignInWithGoogleUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => SignOutUseCase(sl<AuthRepository>()));

  // BLoC
  sl.registerFactory(
    () => AuthBloc(
      getCurrentUserUseCase: sl<GetCurrentUserUseCase>(),
      signInWithGoogleUseCase: sl<SignInWithGoogleUseCase>(),
      signOutUseCase: sl<SignOutUseCase>(),
    ),
  );

  // ----------------------------------------------------
  // Feature: Subscriptions
  // ----------------------------------------------------
  // Data sources
  sl.registerLazySingleton<SubscriptionRemoteDataSource>(
    () => SubscriptionRemoteDataSourceImpl(sl<ApiClient>()),
  );
  sl.registerLazySingleton<SubscriptionLocalDataSource>(
    () => SubscriptionLocalDataSourceImpl(sl<LocalStorageService>()),
  );

  // Repositories
  sl.registerLazySingleton<SubscriptionRepository>(
    () => SubscriptionRepositoryImpl(
      remoteDataSource: sl<SubscriptionRemoteDataSource>(),
      localDataSource: sl<SubscriptionLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetSubscriptionsUseCase(sl<SubscriptionRepository>()));
  sl.registerLazySingleton(() => AddSubscriptionUseCase(sl<SubscriptionRepository>()));
  sl.registerLazySingleton(() => UpdateSubscriptionUseCase(sl<SubscriptionRepository>()));
  sl.registerLazySingleton(() => DeleteSubscriptionUseCase(sl<SubscriptionRepository>()));

  // BLoC
  sl.registerFactory(
    () => SubscriptionBloc(
      getSubscriptionsUseCase: sl<GetSubscriptionsUseCase>(),
      addSubscriptionUseCase: sl<AddSubscriptionUseCase>(),
      updateSubscriptionUseCase: sl<UpdateSubscriptionUseCase>(),
      deleteSubscriptionUseCase: sl<DeleteSubscriptionUseCase>(),
    ),
  );

  // ----------------------------------------------------
  // Feature: Analytics
  // ----------------------------------------------------
  // Data sources
  sl.registerLazySingleton<AnalyticsRemoteDataSource>(
    () => AnalyticsRemoteDataSourceImpl(sl<ApiClient>()),
  );

  // Repositories
  sl.registerLazySingleton<AnalyticsRepository>(
    () => AnalyticsRepositoryImpl(
      remoteDataSource: sl<AnalyticsRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetSpendingSummaryUseCase(sl<AnalyticsRepository>()));

  // BLoC
  sl.registerFactory(
    () => AnalyticsBloc(
      getSpendingSummaryUseCase: sl<GetSpendingSummaryUseCase>(),
    ),
  );

  // ----------------------------------------------------
  // Feature: Settings
  // ----------------------------------------------------
  // Data sources
  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(sl<LocalStorageService>()),
  );

  // Repositories
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(sl<SettingsLocalDataSource>()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetSettingsUseCase(sl<SettingsRepository>()));
  sl.registerLazySingleton(() => UpdateSettingsUseCase(sl<SettingsRepository>()));

  // BLoC
  sl.registerFactory(
    () => SettingsBloc(
      getSettingsUseCase: sl<GetSettingsUseCase>(),
      updateSettingsUseCase: sl<UpdateSettingsUseCase>(),
    ),
  );
}
