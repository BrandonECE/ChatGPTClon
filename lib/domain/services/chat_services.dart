import 'package:http/http.dart';

abstract class ChatServices {
  Future<Response> getAllChats();
}
