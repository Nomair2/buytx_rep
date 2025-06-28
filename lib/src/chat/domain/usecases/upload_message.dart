import 'package:buytx/core/usercase/usecase.dart';
import 'package:buytx/core/utils/typedefs.dart';
import 'package:buytx/src/chat/domain/entity/upload_message_entity.dart';
import 'package:buytx/src/chat/domain/repository/chat_repository.dart';


class MessageUpload {
  final String filename;
  final String contentType;
  final String token;
  MessageUpload(this.filename, this.contentType, this.token);
}
