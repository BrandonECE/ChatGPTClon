import 'package:flutter_application_alon2/domain/entities/chat_message.dart';
import 'package:flutter_application_alon2/domain/repositories/message_repository.dart';
class SendMessageUseCase {
  final MessageRepository repository;

  SendMessageUseCase({required this.repository});

  Future<MessageEntity> sendMessage({required MessageEntity message}) async {
    try {
      return await repository.sendMessage(message: message);
    } catch (e) {
      return Future.error('Error in SendMessageUseCase: $e');
    }
  }
}
