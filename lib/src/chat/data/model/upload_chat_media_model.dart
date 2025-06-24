import 'package:buytx/src/chat/domain/entity/upload_message_entity.dart';

class UploadChatMediaModel {
  final String key;
  final String url;

  const UploadChatMediaModel({required this.key, required this.url});

  factory UploadChatMediaModel.fromJson(Map<String, dynamic> json) {
    return UploadChatMediaModel(
      key: json['key'] as String,
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'key': key, 'url': url};
  }

  /// Convert from Entity to Model
  factory UploadChatMediaModel.fromEntity(UploadChatMediaEntity entity) {
    return UploadChatMediaModel(key: entity.key, url: entity.url);
  }

  /// Convert from Model to Entity
  UploadChatMediaEntity toEntity() {
    return UploadChatMediaEntity(key: key, url: url);
  }

  UploadChatMediaModel copyWith({String? key, String? url}) {
    return UploadChatMediaModel(key: key ?? this.key, url: url ?? this.url);
  }
}
