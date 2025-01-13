part of 'chat_message_space_expand_bloc.dart';

sealed class ChatMessageSpaceExpandEvent extends Equatable {
  const ChatMessageSpaceExpandEvent();

  @override
  List<Object> get props => [];
}


final class ChatMessagesSetSizeBaseOneLineHeightMssUserEvent
    extends ChatMessageSpaceExpandEvent {
  final double sizeHeight;
  const ChatMessagesSetSizeBaseOneLineHeightMssUserEvent(
      {required this.sizeHeight});

  @override
  List<Object> get props => [sizeHeight];
}

final class ChatMessagesSetSizeBaseTwoLinesHeightMssUserEvent
    extends ChatMessageSpaceExpandEvent {
  final double sizeHeight;
  const ChatMessagesSetSizeBaseTwoLinesHeightMssUserEvent(
      {required this.sizeHeight});

  @override
  List<Object> get props => [sizeHeight];
}

final class ChatMessagesSetSizeHeightMssUserEvent extends ChatMessageSpaceExpandEvent {
  final double sizeHeight;
  const ChatMessagesSetSizeHeightMssUserEvent({required this.sizeHeight});

  @override
  List<Object> get props => [sizeHeight];
}

final class ChatMessagesSetSizeHeightMssChatGptEvent extends ChatMessageSpaceExpandEvent {
  final double sizeHeight;
  const ChatMessagesSetSizeHeightMssChatGptEvent({required this.sizeHeight});

  @override
  List<Object> get props => [sizeHeight];
}

final class ChatMessagesSetSizeHeightMiniatureChatGptEvent
    extends ChatMessageSpaceExpandEvent {
  final double sizeHeight;
  const ChatMessagesSetSizeHeightMiniatureChatGptEvent(
      {required this.sizeHeight});

  @override
  List<Object> get props => [sizeHeight];
}

final class ChatMessagesShowSpaceExpandedWhenMssIsSentEvent
    extends ChatMessageSpaceExpandEvent {
  final bool showSpaceExpandedWhenMssIsSent;
  const ChatMessagesShowSpaceExpandedWhenMssIsSentEvent(
      {required this.showSpaceExpandedWhenMssIsSent});

  @override
  List<Object> get props => [showSpaceExpandedWhenMssIsSent];
}
