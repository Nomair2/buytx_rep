import 'package:dartz/dartz.dart';
import 'package:buytx/core/error/failure.dart';

typedef DataMap = Map<String, dynamic>;
typedef ResultFuture<T> = Future<Either<Failure, T>>;
