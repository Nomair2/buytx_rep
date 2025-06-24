import 'package:equatable/equatable.dart';
import 'package:buytx/core/utils/typedefs.dart';

class ErrorResponse extends Equatable {
  final String? type;
  final String? message;
  // final String? errorMessage;

  ErrorResponse(this.type, this.message);

  factory ErrorResponse.fromMap(DataMap map) {
    return ErrorResponse(map['type'] as String?, map['msg'] as String?);
  }

  String get errorMessage {
    var payload = '';
    if (message != null) {
      payload += message!;
    } else {
      payload = 'there is no error message !!!';
    }
    return payload;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [type, message, errorMessage];
}
