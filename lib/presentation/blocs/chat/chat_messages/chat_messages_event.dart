part of 'chat_messages_bloc.dart';

sealed class ChatMessagesEvent extends Equatable {
  const ChatMessagesEvent();

  @override
  List<Object> get props => [];
}

final class ChatMessagesAddMsgUserEvent extends ChatMessagesEvent {
  final String message;
  const ChatMessagesAddMsgUserEvent({required this.message});

  @override
  List<Object> get props => [message];
}

final class ChatMessagesAddMsgChatGptEvent extends ChatMessagesEvent {
  final String message;
  const ChatMessagesAddMsgChatGptEvent({required this.message});

  @override
  List<Object> get props => [message];
}

