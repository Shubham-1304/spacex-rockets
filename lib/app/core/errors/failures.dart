import 'package:equatable/equatable.dart';
import 'exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  String get errorMessage=> '$statusCode Error: $message';

  @override
  List<Object?> get props => [message, statusCode];
}

class APIFailure extends Failure {
  const APIFailure({required super.message, required super.statusCode});

  APIFailure.fromException(APIException apiException)
      : this(
          message: apiException.message,
          statusCode: apiException.statusCode,
        );
}

class ManagerFailure extends Failure {
  const ManagerFailure({required super.message,required super.statusCode});
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.message,required super.statusCode});
}

class UseCaseFailure extends Failure {
  const UseCaseFailure({required super.message,required super.statusCode});
}

class ServiceFailure extends Failure {
  const ServiceFailure({required super.message,required super.statusCode});
}