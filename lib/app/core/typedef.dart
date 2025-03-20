import 'package:dartz/dartz.dart';
import 'package:spacex_rockets/app/core/errors/failures.dart';

typedef ResultFuture<T>=Future<Either<Failure,T>>;

typedef DataMap=Map<String,dynamic>;

typedef BoolCallback = void Function(bool val);

typedef Result<T>=Either<Failure,T>;