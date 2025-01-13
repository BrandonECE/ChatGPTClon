part of 'chat_messages_bloc.dart';

class ChatMessagesState extends Equatable {
  final List<Map<String, String>> messagesList;
  const ChatMessagesState(
      {required this.messagesList});

  ChatMessagesState copyWith(
      {List<Map<String, String>>? messagesList}) {
    return ChatMessagesState(messagesList: messagesList ?? this.messagesList,);
  }

  @override
  List<Object> get props => [
        messagesList
      ];
}

final class ChatMessagesInitial extends ChatMessagesState {
  ChatMessagesInitial()
      : super(messagesList: []);
}
