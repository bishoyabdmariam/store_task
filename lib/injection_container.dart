import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_task/Core/database/database_helper.dart';
import 'package:store_task/Features/products/data/data_sources/products_local_data_source/products_local_data_source.dart';
import 'package:store_task/Features/products/data/data_sources/products_remote_data_source/products_remote_data_source.dart';
import 'package:store_task/Features/products/domain/repository/products_repository.dart';
import 'package:store_task/Features/products/domain/repository/products_repository_impl.dart';
import 'package:store_task/Features/products/presentation/cubit/product_cubit.dart';
import 'package:store_task/Features/settings/data/data_sources/lang_local_data_sources.dart';
import 'package:store_task/Features/settings/data/repositories/lang_repositories_imp.dart';
import 'package:store_task/Features/settings/domain/repositories/lang_repositories.dart';
import 'package:store_task/Features/settings/presentation/cubit/locale/locale_cubit.dart';

import 'Core/api/app_interceptor.dart';
import 'Core/api/dio_consumer.dart';
import 'Core/network/network_info.dart';

final sl = GetIt.I;

Future<void> init() async {
  //    Blocs
  sl.registerLazySingleton<LocaleCubit>(
      () => LocaleCubit(langLocalDataSource: sl()));

  sl.registerLazySingleton<ProductCubit>(() => ProductCubit(repository: sl()));

  //    Repository

  sl.registerLazySingleton<LangRepository>(
      () => LangRepositoriesImp(langLocalDataSource: sl()));

  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
      ));

  // Data Sources

  sl.registerLazySingleton<LangLocalDataSource>(
      () => LangLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<ProductsLocalDataSource>(
      () => ProductsLocalDataSource());

  sl.registerLazySingleton<ProductsRemoteDataSource>(
      () => ProductsRemoteDataSource());

  //   Core
  sl.registerLazySingleton<DioConsumer>(() => DioConsumer(
        client: sl(),
      ));

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));

  //   External
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(
    () => sharedPreferences,
  );

  sl.registerLazySingleton(() => Dio());

  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());

  sl.registerLazySingleton(() => AppInterceptors(dio: sl()));

  sl.registerLazySingleton(
    () => LogInterceptor(
      request: true,
      error: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ),
  );

  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
}
