import 'package:spacex_rockets/app/core/typedef.dart';
import 'package:spacex_rockets/app/modules/rockets/domain/entities/rocket.dart';

abstract class RocketRepository{
  const RocketRepository();

  ResultFuture<List<Rocket>> getRockets();

  ResultFuture<Rocket> getRocketById(String id, {bool forceRefresh = false});
}