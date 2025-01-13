part of 'chat_message_error_conection_bloc.dart';

sealed class ChatMessageErrorConectionState extends Equatable {
  const ChatMessageErrorConectionState();
  
  @override
  List<Object> get props => [];
}

final class ChatMessageErrorConectionInitial extends ChatMessageErrorConectionState {}


final class ChatNoConnectivityState extends ChatMessageErrorConectionState  {
  const ChatNoConnectivityState();
  @override
  List<Object> get props => [];
}


final class ChatCheckingConnectivityState extends ChatMessageErrorConectionState  {
  const ChatCheckingConnectivityState();
  @override
  List<Object> get props => [];
}
