import 'package:equatable/equatable.dart';

class ServerExceptions extends Equatable implements Exception {
  final String message;
  final int statusCode;

  ServerExceptions({required this.message, required this.statusCode});

  @override
  // TODO: implement props
  List<Object?> get props => [message, statusCode];
}

class CacheExceptions extends Equatable implements Exception {
  final String message;

  CacheExceptions({
    required this.message,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
