part of 'chat_messages_thump_bloc.dart';

sealed class ChatMessagesThumpEvent extends Equatable {
  const ChatMessagesThumpEvent();

  @override
  List<Object> get props => [];
}

final class ChatMessagesThumpUpdatePositionEvent
    extends ChatMessagesThumpEvent {
  final double thumpPosition;
  const ChatMessagesThumpUpdatePositionEvent({required this.thumpPosition});
  @override
  List<Object> get props => [thumpPosition];
}

final class ChatMessagesThumpUpdateSizeThumpEvent
    extends ChatMessagesThumpEvent {
  final double sizeThump;
  const ChatMessagesThumpUpdateSizeThumpEvent({required this.sizeThump});
  @override
  List<Object> get props => [sizeThump];
}

final class ChatMessagesThumpUpdateSizeSpaceAvailableEvent
    extends ChatMessagesThumpEvent {
  final double sizeSpaceAvailable;
  const ChatMessagesThumpUpdateSizeSpaceAvailableEvent(
      {required this.sizeSpaceAvailable});
  @override
  List<Object> get props => [sizeSpaceAvailable];
}

final class ChatMessagesThumpUpdateAnimatedPositionedEvent
    extends ChatMessagesThumpEvent {
  final bool isAnimatedPositioned;
  const ChatMessagesThumpUpdateAnimatedPositionedEvent(
      {required this.isAnimatedPositioned});
  @override
  List<Object> get props => [isAnimatedPositioned];
}

final class ChatMessagesThumpShowButtonReturnToButtonChatEvent
    extends ChatMessagesThumpEvent {
  final bool showButtonReturnToBottomChat;
  const ChatMessagesThumpShowButtonReturnToButtonChatEvent(
      {required this.showButtonReturnToBottomChat});
  @override
  List<Object> get props => [showButtonReturnToBottomChat];
}

final class ChatMessagesHiddeThumpEvent extends ChatMessagesThumpEvent {
  final bool isVisibleThump;
  const ChatMessagesHiddeThumpEvent({required this.isVisibleThump});
  @override
  List<Object> get props => [isVisibleThump];
}

