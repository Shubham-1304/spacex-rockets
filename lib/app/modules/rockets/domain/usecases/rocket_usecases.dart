import 'package:spacex_rockets/app/core/typedef.dart';
import 'package:spacex_rockets/app/core/usecases.dart';
import 'package:spacex_rockets/app/modules/rockets/domain/entities/rocket.dart';
import 'package:spacex_rockets/app/modules/rockets/domain/repositories/rocket_repository.dart';

class GetRockets extends UsecaseWithoutParams<List<Rocket>> {
  const GetRockets(this._repository);

  final RocketRepository _repository;

  @override
  ResultFuture<List<Rocket>> call() async =>
      _repository.getRockets();
}

class GetRocketById
    extends UsecaseWithParams<Rocket, GetRocketByIdParams> {
  const GetRocketById(this._repository);

  final RocketRepository _repository;

  @override
  ResultFuture<Rocket> call(GetRocketByIdParams params) async =>
      _repository.getRocketById(params.id);
}

class GetRocketByIdParams {
  const GetRocketByIdParams(this.id);

  final String id;
}