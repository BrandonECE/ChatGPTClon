part of 'chat_message_error_conection_bloc.dart';

sealed class ChatMessageErrorConectionEvent extends Equatable {
  const ChatMessageErrorConectionEvent();

  @override
  List<Object> get props => [];
}


final class ChatNoConnectivityEvent extends ChatMessageErrorConectionEvent  {
  const ChatNoConnectivityEvent();
  @override
  List<Object> get props => [];
}


final class ChatCheckingConnectivityEvent extends ChatMessageErrorConectionEvent  {
  const ChatCheckingConnectivityEvent();
  @override
  List<Object> get props => [];
}
