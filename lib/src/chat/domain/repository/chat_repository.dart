import 'package:buytx/core/utils/typedefs.dart';
import 'package:buytx/src/chat/domain/entity/message_entity.dart';
import 'package:buytx/src/chat/domain/entity/upload_message_entity.dart';
import 'package:buytx/src/chat/domain/entity/user_chat_entity.dart';
import 'package:buytx/src/chat/domain/usecases/get_chats.dart';
import 'package:buytx/src/chat/domain/usecases/get_messages.dart';
import 'package:buytx/src/chat/domain/usecases/upload_message.dart';

abstract class ChatRepository {
  ResultFuture<List<UserChatEntity>> getChats(ChatsPatams params);

  ResultFuture<List<MessageEntity>> getMessages(MessageParms params);


  // ResultFuture<String> UploadChatMedia(UploadChatMediaEntity params);
}
