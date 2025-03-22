part of 'rocket_by_id_cubit.dart';

sealed class RocketByIdState extends Equatable {
  const RocketByIdState();

  @override
  List<Object> get props => [];
}

final class RocketByIdInitial extends RocketByIdState {}

class LoadingRocketById extends RocketByIdState {
  const LoadingRocketById();
}

final class RocketByIdLoaded extends RocketByIdState {
  const RocketByIdLoaded(this.rocket);
  final Rocket rocket;
}

final class RocketByIdLoadError extends RocketByIdState {
  const RocketByIdLoadError(this.message, this.errorCode);

  final String message;
  final int errorCode;

  @override
  List<Object> get props => [message, errorCode];
}