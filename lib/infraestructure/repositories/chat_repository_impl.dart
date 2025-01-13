import 'package:flutter_application_alon2/domain/repositories/chat_repository.dart';
import 'package:flutter_application_alon2/domain/services/chat_services.dart';
import 'package:http/src/response.dart';

class ChatRepositoryImpl extends ChatRepository {
  final ChatServices chatServices;
  ChatRepositoryImpl({required this.chatServices});

  @override
  Future<Response> getAllChats() async {
    try {
      final response = await chatServices.getAllChats();
      if(response.statusCode == 200){
        return response;
      }else{
        return Future.error("Error: ${response.body}");
      }
    } catch (error) {
      return Future.error(error);
    }
  }
}
