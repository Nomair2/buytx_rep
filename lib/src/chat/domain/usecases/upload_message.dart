import 'package:buytx/core/usercase/usecase.dart';
import 'package:buytx/core/utils/typedefs.dart';
import 'package:buytx/src/chat/domain/entity/upload_message_entity.dart';
import 'package:buytx/src/chat/domain/repository/chat_repository.dart';

class UploadMessageUseCase
    extends UseCase<UploadChatMediaEntity, MessageUpload> {
  UploadMessageUseCase(this._chatRepository);
  final ChatRepository _chatRepository;
  @override
  ResultFuture<UploadChatMediaEntity> call(MessageUpload upload) {
    return _chatRepository.UploadMessage(upload);
  }
}

class MessageUpload {
  final String filename;
  final String contentType;
  final String token;
  MessageUpload(this.filename, this.contentType, this.token);
}
