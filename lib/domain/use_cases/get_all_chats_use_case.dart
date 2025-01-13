import 'package:flutter_application_alon2/domain/repositories/chat_repository.dart';
import 'package:http/http.dart';

class GetAllChatsUseCase {
  final ChatRepository chatRepository;
  const GetAllChatsUseCase({required this.chatRepository});
  Future<Response> getAllChats() async {
    try {
      final response = await chatRepository.getAllChats();
      return response;
    } catch (error) {
      return Future.error(error);
    }
  }
}
