import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spacex_rockets/app/modules/rockets/domain/entities/rocket.dart';
import 'package:spacex_rockets/app/modules/rockets/domain/usecases/rocket_usecases.dart';

part 'rocket_state.dart';

class RocketCubit extends Cubit<RocketState> {
  RocketCubit(
      {required GetRockets getRockets,})
      : _getRockets = getRockets,
        super(RocketInitial());

  final GetRockets _getRockets;

  Future<void> getAllRockets() async {
    emit(const LoadingRocket());
    final result = await _getRockets();
    result.fold(
        (failure) =>
            emit(RocketLoadError(failure.message, failure.statusCode)),
        (rockets) => emit(RocketLoaded(rockets)));
  }

  void dispose() => emit(RocketInitial());
}
