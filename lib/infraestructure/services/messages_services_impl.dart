import 'dart:convert';
import 'package:flutter_application_alon2/config/keys/keys_config.dart';
import 'package:flutter_application_alon2/domain/services/message_services.dart';
import 'package:flutter_application_alon2/infraestructure/models/chat_message_model.dart';
import 'package:http/http.dart' as http;

class MessageServiceImpl implements MessageService {
  final String _apiKey = KeysConfig.keyChatGpt;
  final String _apiUrl = 'https://api.openai.com/v1/chat/completions';

  @override
  Future<MessageModel> sendMessage({required MessageModel message}) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_apiKey",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [message.toJson()],
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final responseMessage = jsonResponse['choices'][0]['message'];
        return MessageModel.fromJson(responseMessage);
      } else {
         return Future.error('Error in MessageServiceImpl: ${response.body}');
      }
    } catch (e) {
      return Future.error('Error in MessageServiceImpl: $e');
    }
  }
}
