import 'package:flutter_application_alon2/domain/services/chat_services.dart';
import 'package:http/http.dart' as http;
import 'package:http/src/response.dart';

class ChatServicesImpl extends ChatServices {
  @override
  Future<Response> getAllChats() async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/todos");
    try {
      final response = await http.get(url);
      return response;
    } catch (error) {
      return Future.error(error);
    }
  }
}
