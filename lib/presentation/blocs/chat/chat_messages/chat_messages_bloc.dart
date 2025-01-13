import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'chat_messages_event.dart';
part 'chat_messages_state.dart';

class ChatMessagesBloc extends Bloc<ChatMessagesEvent, ChatMessagesState> {
  ChatMessagesBloc() : super(ChatMessagesInitial()) {
    on<ChatMessagesAddMsgUserEvent>((event, emit) {
      final Map<String, String> messageUser = {
        'sender': 'user',
        'message': event.message
      };
      emit(state.copyWith(messagesList: [...state.messagesList, messageUser]));
    });

    on<ChatMessagesAddMsgChatGptEvent>((event, emit) {
      final Map<String, String> messageGpt = {
        'sender': 'chatgpt',
        'message': event.message
      };
      emit(state.copyWith(messagesList: [...state.messagesList, messageGpt]));
    });

  }
}


// class MessagesExample {
//   MessagesExample();
//   // ignore: unused_field
//   final List<Map<String, String>> _messages = [
//     {'sender': 'user', 'message': 'Hola, ¿cómo estás?'},
//     {'sender': 'chatgpt', 'message': '¡Hola! Estoy aquí para ayudarte. 😊'},
//     {'sender': 'user', 'message': '¿Puedes explicarme qué es Flutter?'},
//     {
//       'sender': 'chatgpt',
//       'message':
//           'Claro, Flutter es un framework de UI desarrollado por Google para crear aplicaciones móviles, web y de escritorio con una única base de código.'
//     },
//   ];
// }
