import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spacex_rockets/app/modules/rockets/domain/entities/rocket.dart';
import 'package:spacex_rockets/app/modules/rockets/domain/usecases/rocket_usecases.dart';

part 'rocket_by_id_state.dart';

class RocketByIdCubit extends Cubit<RocketByIdState> {
  RocketByIdCubit({required GetRocketById getRocketById,})
      : _getRocketById = getRocketById,
        super(RocketByIdInitial());

  final GetRocketById _getRocketById;

  Future<void> getRocketById(String id) async {
    emit(const LoadingRocketById());
    final result = await _getRocketById(GetRocketByIdParams(id));
    result.fold(
        (failure) =>
            emit(RocketByIdLoadError(failure.message, failure.statusCode)),
        (rockets) => emit(RocketByIdLoaded(rockets)));
  }

  void dispose() => emit(RocketByIdInitial());
}