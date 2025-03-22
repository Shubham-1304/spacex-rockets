import 'dart:convert';

import 'package:spacex_rockets/app/modules/rockets/data/managers/rocket_data_manager.dart';
import 'package:spacex_rockets/app/modules/rockets/data/models/rocket_model.dart';
import 'package:spacex_rockets/app/modules/rockets/domain/entities/rocket.dart';

abstract class RocketLocalDataSource {
  Future<List<Rocket>> getRockets();
  Future<Rocket> getRocketById(String id);
  Future<void> cacheRockets(List<RocketModel> rockets);
  Future<void> cacheRocket(RocketModel rocket);
  Future<bool> isCacheExpired();
  Future<void> clearCache();
}

class RocketLocalDataSourceImpl implements RocketLocalDataSource {
  final RocketDataManager dataManager;
  final Duration cacheExpiration = const Duration(minutes: 10);

  RocketLocalDataSourceImpl({required this.dataManager});

  @override
  Future<List<RocketModel>> getRockets() async {
    final data = await dataManager.getCachedResponse('rockets');
    if (data != null) {
      final List<dynamic> jsonList = json.decode(data);
      try {
        return jsonList.map((json) => RocketModel.fromLocalJson(json)).toList();
      } catch (e) {
        print("local exception: $e");
      }
    }
    throw Exception('Rockets not cached');
  }

  @override
  Future<RocketModel> getRocketById(String id) async {
    final data = await dataManager.getCachedResponse('rocket_$id');
    if (data != null) {
      return RocketModel.fromLocalJson(json.decode(data));
    }
    throw Exception('Rocket with id $id not cached');
  }

  @override
  Future<void> cacheRockets(List<RocketModel> rockets) async {
    final jsonString = json.encode(rockets.map((p) => p.toJson()).toList());
    await dataManager.cacheApiResponse('rockets', jsonString);
  }

  @override
  Future<void> cacheRocket(RocketModel rocket) async {
    final jsonString = json.encode(rocket.toJson());
    await dataManager.cacheApiResponse('rocket_${rocket.id}', jsonString);
  }

  @override
  Future<bool> isCacheExpired() async {
    return await dataManager.isCacheExpired('rockets', cacheExpiration);
  }

  @override
  Future<void> clearCache() async {
    await dataManager.clearAllCache();
  }
}
