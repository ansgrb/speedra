import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

// Features - Speed Test
import 'features/speed_test/data/datasources/speed_test_local_datasource.dart';
import 'features/speed_test/data/datasources/speed_test_remote_datasource.dart';
import 'features/speed_test/data/repositories/speed_test_repository_impl.dart';
import 'features/speed_test/domain/repositories/speed_test_repository.dart';
import 'features/speed_test/domain/usecases/run_speed_test.dart';
import 'features/speed_test/domain/usecases/get_speed_tests.dart';
import 'features/speed_test/domain/usecases/update_test_label.dart';
import 'features/speed_test/domain/usecases/toggle_favorite.dart';
import 'features/speed_test/domain/usecases/delete_test.dart';
import 'features/speed_test/presentation/providers/speed_test_provider.dart';

// Features - Settings
import 'features/settings/data/datasources/settings_local_datasource.dart';
import 'features/settings/data/repositories/settings_repository_impl.dart';
import 'features/settings/domain/repositories/settings_repository.dart';
import 'features/settings/domain/usecases/get_theme_mode.dart';
import 'features/settings/domain/usecases/toggle_theme_mode.dart';
import 'features/settings/presentation/providers/theme_provider.dart';

// Features - Connectivity
import 'features/connectivity/data/datasources/connectivity_datasource.dart';
import 'features/connectivity/data/repositories/connectivity_repository_impl.dart';
import 'features/connectivity/domain/repositories/connectivity_repository.dart';
import 'features/connectivity/domain/usecases/get_connectivity_status.dart';
import 'features/connectivity/presentation/bloc/connectivity_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // ═══════════════════════════════════════════════════════════════
  // Features - Speed Test
  // ═══════════════════════════════════════════════════════════════

  // Providers
  sl.registerFactory(
    () => SpeedTestProvider(
      runSpeedTest: sl(),
      getSpeedTests: sl(),
      updateTestLabel: sl(),
      toggleFavorite: sl(),
      deleteTest: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => RunSpeedTest(sl()));
  sl.registerLazySingleton(() => GetSpeedTests(sl()));
  sl.registerLazySingleton(() => UpdateTestLabel(sl()));
  sl.registerLazySingleton(() => ToggleFavorite(sl()));
  sl.registerLazySingleton(() => DeleteTest(sl()));

  // Repository
  sl.registerLazySingleton<SpeedTestRepository>(
    () =>
        SpeedTestRepositoryImpl(localDataSource: sl(), remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<SpeedTestLocalDataSource>(
    () => SpeedTestLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<SpeedTestRemoteDataSource>(
    () => SpeedTestRemoteDataSourceImpl(sl()),
  );

  // ═══════════════════════════════════════════════════════════════
  // Features - Settings
  // ═══════════════════════════════════════════════════════════════

  // Providers
  sl.registerFactory(
    () => ThemeProvider(getThemeMode: sl(), toggleThemeMode: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetThemeMode(sl()));
  sl.registerLazySingleton(() => ToggleThemeMode(sl()));

  // Repository
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(sl()),
  );

  // ═══════════════════════════════════════════════════════════════
  // External
  // ═══════════════════════════════════════════════════════════════

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());

  // ═══════════════════════════════════════════════════════════════
  // Features - Connectivity
  // ═══════════════════════════════════════════════════════════════

  // BLoC
  sl.registerLazySingleton(() => ConnectivityBloc(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetConnectivityStatus(sl()));

  // Repository
  sl.registerLazySingleton<ConnectivityRepository>(
    () => ConnectivityRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<ConnectivityDataSource>(
    () => ConnectivityDataSourceImpl(sl()),
  );
}
