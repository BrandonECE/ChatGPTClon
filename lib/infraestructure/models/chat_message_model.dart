import 'package:flutter_application_alon2/domain/entities/chat_message.dart';


class MessageModel {
  final String role;
  final String content;

  MessageModel({
    required this.role,
    required this.content,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      role: json['role'] as String,
      content: json['content'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
    };
  }

  MessageEntity toEntity() {
    return MessageEntity(
      role: role,
      content: content,
    );
  }

  static MessageModel fromEntity(MessageEntity entity) {
    return MessageModel(
      role: entity.role,
      content: entity.content,
    );
  }
}
