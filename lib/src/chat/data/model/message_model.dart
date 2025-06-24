// // To parse this JSON data, do
// //
// //     final messageModel = messageModelFromMap(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// MessageModel messageModelFromMap(String str) =>
//     MessageModel.fromMap(json.decode(str));

// String messageModelToMap(MessageModel data) => json.encode(data.toMap());

// class MessageModel {
//   String? id;
//   String? sender;
//   String? receiver;
//   String? content;
//   Media? media;
//   String? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   DateTime? sentAt;

//   MessageModel({
//     this.id,
//     this.sender,
//     this.receiver,
//     this.sentAt,
//     this.content,
//     this.media,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory MessageModel.fromMap(Map<String, dynamic> json) => MessageModel(
//         id: json["_id"] ?? "",
//         sender: json["sender"] ?? "",
//         receiver: json["receiver"] ?? "",
//         content: json["content"] ?? "",
//         sentAt: DateTime.parse(json["sentAt"]),
//         media: json["media"] != null ? Media.fromJson(json["media"]) : null,
//         status: json["status"] ?? "",
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "_id": id,
//         "sender": sender,
//         "receiver": receiver,
//         'sentAt': sentAt,
//         "content": content,
//         "media": media?.toJson(),
//         "status": status,
//         "createdAt": createdAt!.toIso8601String(),
//         "updatedAt": updatedAt!.toIso8601String(),
//       };
// }

// class Media {
//   final String url;
//   final String type;
//   final String key;

//   Media({
//     required this.url,
//     required this.type,
//     required this.key,
//   });

//   factory Media.fromJson(Map<String, dynamic> json) {
//     return Media(
//       url: json['url'],
//       type: json['type'],
//       key: json['key'],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'url': url,
//         'type': type,
//         'key': key,
//       };
// }

class MessageModel {
  final String id;
  final String sender;
  final String receiver;
  final String content;
  final Media? media;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime sentAt;

  MessageModel({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.content,
    this.media,
    required this.sentAt,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'] ?? '',
      sender: json['sender'] ?? '',
      receiver: json['receiver'] ?? '',
      content: json['content'] ?? '',
      media: json['media'] != null ? Media.fromJson(json['media']) : null,
      status: json['status'] ?? '',
      sentAt: DateTime.tryParse(json['sentAt'] ?? '') ?? DateTime.now(),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'sender': sender,
        'receiver': receiver,
        'content': content,
        'media': media?.toJson(),
        'status': status,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        "sentAt": sentAt.toIso8601String(),
      };
}

class Media {
  final String url;
  final String type;
  final String key;

  Media({
    required this.url,
    required this.type,
    required this.key,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      url: json['url'] ?? '',
      type: json['type'] ?? '',
      key: json['key'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'url': url,
        'type': type,
        'key': key,
      };
}

List<MessageModel> parseMessages(List<dynamic> data) {
  return data.map((json) => MessageModel.fromJson(json)).toList();
}
