// To parse this JSON data, do
//
//     final MessageEntity = MessageEntityFromMap(jsonString);

import 'package:buytx/src/chat/data/model/message_model.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

enum MessageStatus { sending, sent, received, read, failed }

class MessageEntity {
  String? id;
  String? sender;
  String? receiver;
  String? content;
  String? status;
  DateTime? sentAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  MediaEntity? media;

  MessageEntity({
    this.id,
    this.sender,
    this.receiver,
    this.content,
    this.status,
    this.sentAt,
    this.media,
    this.createdAt,
    this.updatedAt,
  });
}

List<MessageEntity> fromMessageModel(List<MessageModel> messages) =>
    messages
        .map(
          (message) => MessageEntity(
            id: message.id,
            sender: message.sender,
            receiver: message.receiver,
            media: message.media != null ? fromMedia(message.media!) : null,
            content: message.content,
            status: message.status,
            sentAt: message.sentAt,
            createdAt: message.createdAt,
            updatedAt: message.updatedAt,
          ),
        )
        .toList();

MessageEntity toMessageEntity(MessageModel message) {
  print("123");
  return MessageEntity(
    content: message.content,
    createdAt: message.createdAt,
    id: message.id,
    media: fromMedia(message.media!),
    receiver: message.receiver,
    sender: message.sender,
    sentAt: message.sentAt,
    status: message.status,
    updatedAt: message.updatedAt,
  );
}

Map<String, dynamic> convertToJSON(String jsonString) {
  Map<String, dynamic> map = json.decode(jsonString);
  return map;
}

class MediaEntity {
  final String url;
  final String type;
  final String key;

  MediaEntity({required this.url, required this.type, required this.key});
}

MediaEntity fromMedia(Media media) =>
    MediaEntity(url: media.url, type: media.type, key: media.key);
