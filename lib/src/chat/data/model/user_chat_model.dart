// To parse this JSON data, do
//
//     final userChatEntity = userChatEntityFromMap(jsonString);

import 'package:intl/intl.dart';
import 'package:buytx/src/chat/domain/entity/user_chat_entity.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

UserChatModel userChatEntityFromMap(String str) =>
    UserChatModel.fromMap(json.decode(str));

String userChatEntityToMap(UserChatModel data) => json.encode(data.toMap());

class UserChatModel {
  final String lastMessage;
  final DateTime lastMessageDate;
  final String id;
  final String messageId;
  final String fullName;
  final String lastLoginTime;
  final int messageCount;

  UserChatModel({
    required this.lastMessage,
    required this.lastMessageDate,
    required this.id,
    required this.messageId,
    required this.fullName,
    required this.lastLoginTime,
    required this.messageCount,
  });

  factory UserChatModel.fromMap(Map<String, dynamic> json) => UserChatModel(
    lastMessage: json["lastMessage"],
    lastMessageDate: DateTime.parse(json["lastMessageDate"]),
    id: json["id"],
    messageId: json["messageId"],
    fullName: json["fullName"],
    lastLoginTime: json["lastLoginTime"] ?? "",
    messageCount: json["messageCount"],
  );

  Map<String, dynamic> toMap() => {
    "lastMessage": lastMessage,
    "lastMessageDate": lastMessageDate.toIso8601String(),
    "id": id,
    "messageId": messageId,
    "fullName": fullName,
    "lastLoginTime": lastLoginTime,
    "messageCount": messageCount,
  };
}

String StrinToDateTime(String dateTime) {
  try {
    DateTime time = DateFormat('EEE, dd MMM yyyy HH:mm:ss zzz').parse(dateTime);
    return '${time.hour}:${time.minute}';
  } catch (e) {
    return dateTime;
  }
}

List<UserChatEntity> convertToList(List<UserChatModel> models) {
  return models.map((model) {
    return UserChatEntity(
      id: model.id,
      fullName: model.fullName,
      lastLoginTime: StrinToDateTime(
        model.lastLoginTime == null ? '' : model.lastLoginTime,
      ),
      lastMessage: model.lastMessage,
      lastMessageDate: model.lastMessageDate,
      messageCount: model.messageCount,
      messageId: model.messageId,
      // Add other properties from UserChatModel to UserChatEntity
      // Make sure all properties exist in both models
      // If some properties don't exist, you'll need to handle them appropriately
    );
  }).toList();
}
