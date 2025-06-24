// To parse this JSON data, do
//
//     final receiveMessageModel = receiveMessageModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ReceiveMessageModel receiveMessageModelFromMap(String str) =>
    ReceiveMessageModel.fromMap(json.decode(str));

String receiveMessageModelToMap(ReceiveMessageModel data) =>
    json.encode(data.toMap());

class ReceiveMessageModel {
  final String content;
  final String receiver;
  final Sender sender;
  final String fullName;
  final DateTime sentAt;
  final String status;
  final String id;

  ReceiveMessageModel({
    required this.content,
    required this.receiver,
    required this.sender,
    required this.fullName,
    required this.sentAt,
    required this.status,
    required this.id,
  });

  factory ReceiveMessageModel.fromMap(Map<String, dynamic> json) =>
      ReceiveMessageModel(
        content: json["content"],
        receiver: json["receiver"],
        sender: Sender.fromMap(json["sender"]),
        fullName: json["fullName"],
        sentAt: DateTime.parse(json["sentAt"]),
        status: json["status"],
        id: json["_id"],
      );

  Map<String, dynamic> toMap() => {
        "content": content,
        "receiver": receiver,
        "sender": sender.toMap(),
        "fullName": fullName,
        "sentAt": sentAt.toIso8601String(),
        "status": status,
        "_id": id,
      };
}

class Sender {
  final String id;
  final String email;
  final String fullName;
  final String lastLoginTime;

  Sender({
    required this.id,
    required this.email,
    required this.fullName,
    required this.lastLoginTime,
  });

  factory Sender.fromMap(Map<String, dynamic> json) => Sender(
        id: json["_id"],
        email: json["email"],
        fullName: json["fullName"],
        lastLoginTime: json["lastLoginTime"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "email": email,
        "fullName": fullName,
        "lastLoginTime": lastLoginTime,
      };
}
