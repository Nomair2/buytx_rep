import 'package:buytx/src/chat/domain/entity/message_entity.dart';
import 'package:buytx/src/chat/domain/entity/user_chat_entity.dart';

abstract class MessagesStates {}

class MessagesLoading extends MessagesStates {}

class MessagesLoaded extends MessagesStates {
  final List<MessageEntity> messages;

  MessagesLoaded(this.messages);
}

class ChatsLoaded extends MessagesStates {
  final List<UserChatEntity> chats;

  ChatsLoaded(this.chats);
}

class StatusMessageState extends MessagesStates {
  String id;
  MessageStatus status;
  StatusMessageState({required this.id, required this.status});
}

class ReadMessageStatus extends MessagesStates {
  final String id;
  ReadMessageStatus(this.id);
}

class MessagesError extends MessagesStates {
  final String message;

  MessagesError(this.message);
}

class LastSeenState extends MessagesStates {
  String lastSeen;
  String partnerId;
  LastSeenState({required this.lastSeen, required this.partnerId});
}
