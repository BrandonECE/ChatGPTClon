import 'package:flutter_application_alon2/domain/entities/chat_message.dart';


abstract class MessageRepository {
  Future<MessageEntity> sendMessage({required MessageEntity message});
}