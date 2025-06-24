import 'package:equatable/equatable.dart';
import 'package:buytx/core/error/exceptions.dart';

sealed class Failure extends Equatable {
  Failure({required this.message, required this.statusCode});
  final String message;
  final int statusCode;

  String get errorMessage => '$message';

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, required super.statusCode});

  ServerFailure.fromException(ServerExceptions e)
    : this(message: e.message, statusCode: e.statusCode);
}

class CacheFailure extends Failure {
  CacheFailure({required super.message}) : super(statusCode: 3);

  CacheFailure.fromException(CacheExceptions e) : this(message: e.message);
}
