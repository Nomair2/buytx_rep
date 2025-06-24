import 'dart:convert';

import 'package:buytx/src/chat/domain/entity/upload_message_entity.dart';

class UploadMessageModel {
  final String key;
  final String url;

  UploadMessageModel({required this.key, required this.url});

  factory UploadMessageModel.fromMap(Map<String, dynamic> json) {
    return UploadMessageModel(key: json['key'], url: json['url']);
  }

  Map<String, dynamic> toMap() {
    return {'key': key, 'url': url};
  }
}

UploadChatMediaEntity fromUploadMessageModel(UploadMessageModel model) =>
    UploadChatMediaEntity(key: model.key, url: model.url);
