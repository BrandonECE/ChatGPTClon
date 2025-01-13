part of 'chat_message_gpt_status_bloc.dart';

sealed class ChatMessageGptStatusEvent extends Equatable {
  const ChatMessageGptStatusEvent();

  @override
  List<Object> get props => [];
}


final class ChatMessageGptSetWithOutStatusEvent extends ChatMessageGptStatusEvent {
  const ChatMessageGptSetWithOutStatusEvent();
  @override
  List<Object> get props => [];
}

final class ChatMessageGptSetStatusLoadingEvent extends ChatMessageGptStatusEvent {
  const ChatMessageGptSetStatusLoadingEvent();
  @override
  List<Object> get props => [];
}


final class ChatMessageGptSetStatusErrorEvent extends ChatMessageGptStatusEvent {
  const ChatMessageGptSetStatusErrorEvent();
  @override
  List<Object> get props => [];
}

final class ChatMessageGptSetStatusTextEffectLoadingEvent extends ChatMessageGptStatusEvent {
  const ChatMessageGptSetStatusTextEffectLoadingEvent();
  @override
  List<Object> get props => [];
}

final class ChatMessageGptSetStatusTextEffectLoadedEvent extends ChatMessageGptStatusEvent {
  const ChatMessageGptSetStatusTextEffectLoadedEvent();
  @override
  List<Object> get props => [];
}

final class ChatMessageGptSetStatusTextEffectCancelEvent extends ChatMessageGptStatusEvent {
  const ChatMessageGptSetStatusTextEffectCancelEvent();
  @override
  List<Object> get props => [];
}



// sealed class ChatMessageGptUpdateTextProccesedEvent extends ChatMessageGptStatusEvent {
//   const ChatMessageGptUpdateTextProccesedEvent({required this.word});
//   final String word;
//   @override
//   List<Object> get props => [word];
// }
