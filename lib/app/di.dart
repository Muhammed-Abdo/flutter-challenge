import 'package:flutter_challenge/data/data_source/local_data_source.dart';
import 'package:flutter_challenge/data/repository/repository_impl.dart';
import 'package:flutter_challenge/domain/repository/repository.dart';
import 'package:flutter_challenge/domain/usecase/get_orders_usecase.dart';
import 'package:flutter_challenge/presentation/cubit/orders_cubit.dart';
import 'package:get_it/get_it.dart';

final instance = GetIt.instance;

initAppModule() {
  // remote data source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance()));
}

initOrdersModule() {
  if (!GetIt.I.isRegistered<GetOrdersUsecase>()) {
    instance.registerFactory(() => GetOrdersUsecase(instance()));
    instance.registerFactory(() => OrdersCubit(instance()));
  }
}
