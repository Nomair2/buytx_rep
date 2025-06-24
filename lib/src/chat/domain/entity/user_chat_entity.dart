// To parse this JSON data, do
//
//     final userChatEntity = userChatEntityFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class UserChatEntity {
  final String lastMessage;
  final DateTime lastMessageDate;
  final String id;
  final String messageId;
  final String fullName;
  final String? lastLoginTime;
  final int messageCount;

  UserChatEntity({
    required this.lastMessage,
    required this.lastMessageDate,
    required this.id,
    required this.messageId,
    required this.fullName,
    this.lastLoginTime,
    required this.messageCount,
  });
}
