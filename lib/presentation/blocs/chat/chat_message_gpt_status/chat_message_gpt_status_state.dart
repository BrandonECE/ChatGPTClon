part of 'chat_message_gpt_status_bloc.dart';

sealed class ChatMessageGptStatusState extends Equatable {
  const ChatMessageGptStatusState();
  
  @override
  List<Object> get props => [];
}

final class ChatMessageGptStatusInitial extends ChatMessageGptStatusState {}

final class ChatMessageWithOutStatus extends ChatMessageGptStatusState{}

final class ChatMessageLoading extends ChatMessageGptStatusState{}

final class ChatMessageError extends ChatMessageGptStatusState{}

final class ChatMessageTextEffectLoading extends ChatMessageGptStatusState{}

final class ChatMessageTextEffectLoaded extends ChatMessageGptStatusState{}

final class ChatMessageTextEffectCancel extends ChatMessageGptStatusState{}
