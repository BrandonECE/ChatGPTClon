import 'package:flutter_application_alon2/domain/entities/chat_message.dart';
import 'package:flutter_application_alon2/domain/repositories/message_repository.dart';
import 'package:flutter_application_alon2/domain/services/message_services.dart';
import 'package:flutter_application_alon2/infraestructure/models/chat_message_model.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageService messageService;

  MessageRepositoryImpl({required this.messageService});

  @override
  Future<MessageEntity> sendMessage({required MessageEntity message}) async {
    try {
      final messageModel = MessageModel.fromEntity(message);
      final responseModel = await messageService.sendMessage(message: messageModel);
      return responseModel.toEntity();
    } catch (e) {
      return Future.error('Error in MessageRepositoryImpl: $e');
    }
  }
}
