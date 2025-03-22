import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:spacex_rockets/app/core/network/network_info.dart';
import 'package:spacex_rockets/app/modules/rockets/data/datasources/rocket_local_datasource.dart';
import 'package:spacex_rockets/app/modules/rockets/data/datasources/rocket_remote_datasource.dart';
import 'package:spacex_rockets/app/modules/rockets/data/managers/rocket_data_manager.dart';
import 'package:spacex_rockets/app/modules/rockets/data/repositories/rocket_repository_implementation.dart';
import 'package:spacex_rockets/app/modules/rockets/domain/repositories/rocket_repository.dart';
import 'package:spacex_rockets/app/modules/rockets/domain/usecases/rocket_usecases.dart';
import 'package:spacex_rockets/app/modules/rockets/ui/blocs/cubit/rocket_by_id_cubit.dart';
import 'package:spacex_rockets/app/modules/rockets/ui/blocs/cubit/rocket_cubit.dart';
final sl = GetIt.instance;

Future<void> init() async {

  // Cubit
  sl.registerFactory(() => RocketCubit(
        getRockets: sl(),
      ));
  sl.registerFactory(() => RocketByIdCubit(
        getRocketById: sl(),
      ));


  // Use Cases
  sl.registerLazySingleton(() => GetRockets(sl()));
  sl.registerLazySingleton(() => GetRocketById(sl()));


  // Repositories
  sl.registerLazySingleton<RocketRepository>(
      () => RocketRepositoryImplementation(localDataSource: sl(),remoteDataSource: sl(),networkInfo: sl()));


  // Managers
  sl.registerLazySingleton(() => RocketDataManager());

  // Data Source
  sl.registerLazySingleton<RocketRemoteDataSource>(
      () => RocketRemoteDataSourceImplementation(sl()));

  sl.registerLazySingleton<RocketLocalDataSource>(
      () => RocketLocalDataSourceImpl(dataManager: sl()));

  //network
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl()));

  //connectivity
  sl.registerLazySingleton(Connectivity.new);


  // http
  sl.registerLazySingleton(http.Client.new);
}

void disposeDependency() {

  //Bloc
  sl<RocketCubit>().close();
}
