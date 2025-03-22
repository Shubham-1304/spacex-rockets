part of 'rocket_cubit.dart';


sealed class RocketState extends Equatable {
  const RocketState();

  @override
  List<Object> get props => [];
}


class RocketInitial extends RocketState {}

class LoadingRocket extends RocketState {
  const LoadingRocket();
}

final class RocketLoaded extends RocketState {
  const RocketLoaded(this.rockets);
  final List<Rocket> rockets;

  @override
  List<Object> get props =>
      rockets.map((rocket) => rocket.id).toList();
}

final class RocketLoadError extends RocketState {
  const RocketLoadError(this.message, this.errorCode);

  final String message;
  final int errorCode;

  @override
  List<Object> get props => [message, errorCode];
}