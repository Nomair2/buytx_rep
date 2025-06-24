import 'package:buytx/src/chat/domain/entity/message_entity.dart';

abstract class MesssagesEvents {}

class FetchMesssagesEvent extends MesssagesEvents {
  final String id;
  final String pagginationNum;
  FetchMesssagesEvent({required this.id, required this.pagginationNum});
}

class FetchChatsEvent extends MesssagesEvents {
  final String pagginationNum;
  FetchChatsEvent({required this.pagginationNum});
}

class MessagesLoadingEvent extends MesssagesEvents {}

class SendMessageEvent extends MesssagesEvents {
  String message;
  String idReceiver;
  SendMessageEvent({required this.message, required this.idReceiver});
}

class ChangeStatusEvent extends MesssagesEvents {
  String id;
  String status;
  ChangeStatusEvent({required this.id, required this.status});
}

class ReceiveMessageEvent extends MesssagesEvents {
  Map message;
  ReceiveMessageEvent({required this.message});
}

class ReadMessageEvent extends MesssagesEvents {}

class LastSeenEvent extends MesssagesEvents {
  String lastSeen;
  String partnerId;
  LastSeenEvent({required this.lastSeen, required this.partnerId});
}

class UploadMessageEvent extends MesssagesEvents {
  String fileName;
  String contentType;
  UploadMessageEvent({required this.fileName, required this.contentType});
}

class CloseEvent extends MesssagesEvents {}
