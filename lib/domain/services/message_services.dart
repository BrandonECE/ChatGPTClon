


import 'package:flutter_application_alon2/infraestructure/models/chat_message_model.dart';

abstract class MessageService {
  Future<MessageModel> sendMessage({required MessageModel message});
}
