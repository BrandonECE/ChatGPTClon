
import 'package:http/http.dart';

abstract class ChatRepository {
  Future<Response> getAllChats();
}