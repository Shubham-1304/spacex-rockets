import 'package:dartz/dartz.dart';
import 'package:spacex_rockets/app/core/errors/failures.dart';
import 'package:spacex_rockets/app/core/network/network_info.dart';
import 'package:spacex_rockets/app/core/typedef.dart';
import 'package:spacex_rockets/app/modules/rockets/data/datasources/rocket_local_datasource.dart';
import 'package:spacex_rockets/app/modules/rockets/data/datasources/rocket_remote_datasource.dart';
import 'package:spacex_rockets/app/modules/rockets/domain/entities/rocket.dart';
import 'package:spacex_rockets/app/modules/rockets/domain/repositories/rocket_repository.dart';

// class RocketRepositoryImplementation implements RocketRepository {
//   RocketRepositoryImplementation(this._remoteDataSource,this._rocketDataManager);

//   final RocketRemoteDataSource _remoteDataSource;
//   final RocketDataManager _rocketDataManager;

//   @override
//   ResultFuture<List<Rocket>> getRockets() async {
//     try {
//       // if(_rocketDataManager.rockets.isNotEmpty){
//       //   return Right(_rocketDataManager.rockets);
//       // }
//       final result = await _remoteDataSource.getRockets();
//       // _rocketDataManager.getRockets(result);
//       return Right(result);
//     } on APIException catch (apiException) {
//       return Left(APIFailure.fromException(apiException));
//     }
//   }

//   @override
//   ResultFuture<Rocket> getRocketById(String id) async {
//     try {
//       // final result = await _remoteDataSource.getRocketById(id);
//       final result= _rocketDataManager.rocketById(id);
//       return Right(result);
//     } catch (exception) {
//       return Left(ManagerFailure(message: "Rocket not Found: $exception", statusCode: 404));
//     }
//   }
// }

class RocketRepositoryImplementation implements RocketRepository {
  final RocketRemoteDataSource remoteDataSource;
  final RocketLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  
  RocketRepositoryImplementation({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  
  @override
  ResultFuture<List<Rocket>> getRockets({bool forceRefresh = false}) async {
    if (forceRefresh || await localDataSource.isCacheExpired()) {
      return Right(await _getRocketsFromRemote());
    }
    
    try {
      return Right(await localDataSource.getRockets());
    } catch (e) {
      return Right(await _getRocketsFromRemote());
    }
  }
  
  Future<List<Rocket>> _getRocketsFromRemote() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRockets = await remoteDataSource.getRockets();
        localDataSource.cacheRockets(remoteRockets);
        return remoteRockets;
      } catch (e) {
        try {
          return await localDataSource.getRockets();
        } catch (_) {
          throw Exception('Failed to fetch products: No internet and no cache available');
        }
      }
    } else {
      try {
        return await localDataSource.getRockets();
      } catch (e) {
        throw Exception('No internet connection and no cached data available');
      }
    }
  }

  
  @override
  ResultFuture<Rocket> getRocketById(String id, {bool forceRefresh = false}) async {
    if (forceRefresh || await localDataSource.isCacheExpired()) {
      return await _getRocketByIdFromRemote(id);
    }
    
    try {
      return Right(await localDataSource.getRocketById(id));
    } catch (e) {
      return await _getRocketByIdFromRemote(id);
    }
  }
  
  ResultFuture<Rocket> _getRocketByIdFromRemote(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRocket = await remoteDataSource.getRocketById(id);
        localDataSource.cacheRocket(remoteRocket);
        return Right(remoteRocket);
      } catch (e) {
        try {
          return Right(await localDataSource.getRocketById(id));
        } catch (_) {
          return const Left(ManagerFailure(message: 'Failed to fetch details from Rocket api: No internet and no cache available', statusCode: 505));
        }
      }
    } else {
      try {
        return Right(await localDataSource.getRocketById(id));
      } catch (e) {
        throw const Left( ManagerFailure(message: 'No internet connection and no cached data available', statusCode: 505));
      }
    }
  }
  
  @override
  Future<void> clearCache() async {
    return await localDataSource.clearCache();
  }
}