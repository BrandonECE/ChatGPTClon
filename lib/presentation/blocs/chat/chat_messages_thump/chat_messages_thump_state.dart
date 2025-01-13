part of 'chat_messages_thump_bloc.dart';

class ChatMessagesThumpState extends Equatable {
  final double thumpPosition;
  final double sizeHeightThumpDynamic;
  final double sizeMaxHeightThumpDynamic;
  final double sizeMinHeightThumpDynamic;
  final double scrollSpaceAvailable;
  final bool isAnimatedPositioned;
  final bool showButtonReturnToBottomChat;
  final bool isVisibleThump;
  const ChatMessagesThumpState(
      {required this.thumpPosition,
      required this.showButtonReturnToBottomChat,
      required this.isAnimatedPositioned,
      required this.sizeHeightThumpDynamic,
      required this.scrollSpaceAvailable,
      required this.isVisibleThump,
      this.sizeMaxHeightThumpDynamic = 140,
      this.sizeMinHeightThumpDynamic = 10});

  ChatMessagesThumpState copyWith(
      {double? thumpPosition,
      double? sizeHeightThumpDynamic,
      double? scrollSpaceAvailable,
      bool? isAnimatedPositioned,
      bool? showButtonReturnToBottomChat,
      final bool? isVisibleThump}) {
    return ChatMessagesThumpState(
        scrollSpaceAvailable: scrollSpaceAvailable ?? this.scrollSpaceAvailable,
        thumpPosition: thumpPosition ?? this.thumpPosition,
        sizeHeightThumpDynamic:
            sizeHeightThumpDynamic ?? this.sizeHeightThumpDynamic,
        isAnimatedPositioned: isAnimatedPositioned ?? this.isAnimatedPositioned,
        showButtonReturnToBottomChat:
            showButtonReturnToBottomChat ?? this.showButtonReturnToBottomChat,
        isVisibleThump: isVisibleThump ?? this.isVisibleThump);
  }

  @override
  List<Object> get props => [
        thumpPosition,
        sizeHeightThumpDynamic,
        scrollSpaceAvailable,
        isAnimatedPositioned,
        showButtonReturnToBottomChat,
        isVisibleThump,
      ];
}

final class ChatMessagesThumpInitial extends ChatMessagesThumpState {
  const ChatMessagesThumpInitial()
      : super(
            thumpPosition: 0,
            sizeHeightThumpDynamic: 140,
            scrollSpaceAvailable: 0,
            isAnimatedPositioned: false,
            showButtonReturnToBottomChat: false,
            isVisibleThump: false);
}
