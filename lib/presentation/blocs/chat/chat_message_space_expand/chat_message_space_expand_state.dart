part of 'chat_message_space_expand_bloc.dart';

class ChatMessageSpaceExpandState extends Equatable {
  final double sizeBaseOneLineHeightMessageUser;
  final double sizeBaseTwoLineHeightMessageUser;
  final double sizeHeightMessageUser;
  final double sizeHeightMessageChatGpt;
  final double sizeHeightMiniatureChatGpt;
  final bool showSpaceExpandedWhenMssIsSent;
  
  const ChatMessageSpaceExpandState(
      {required this.sizeHeightMessageChatGpt,
      required this.sizeHeightMessageUser,
      required this.sizeBaseOneLineHeightMessageUser,
      required this.sizeBaseTwoLineHeightMessageUser,
      required this.sizeHeightMiniatureChatGpt,
      required this.showSpaceExpandedWhenMssIsSent});



  ChatMessageSpaceExpandState copyWith({
      double? sizeHeightMessageUser,
      double? sizeBaseOneLineHeightMessageUser,
      double? sizeBaseTwoLineHeightMessageUser,
      double? sizeHeightMessageChatGpt,
      double? sizeHeightMiniatureChatGpt,
      bool? showSpaceExpandedWhenMssIsSent}) {
    return ChatMessageSpaceExpandState(
        sizeHeightMessageChatGpt:
            sizeHeightMessageChatGpt ?? this.sizeHeightMessageChatGpt,
        sizeBaseOneLineHeightMessageUser: sizeBaseOneLineHeightMessageUser ??
            this.sizeBaseOneLineHeightMessageUser,
         sizeBaseTwoLineHeightMessageUser:  sizeBaseTwoLineHeightMessageUser ?? this.sizeBaseTwoLineHeightMessageUser,
        sizeHeightMessageUser:
            sizeHeightMessageUser ?? this.sizeHeightMessageUser,
        sizeHeightMiniatureChatGpt:
            sizeHeightMiniatureChatGpt ?? this.sizeHeightMiniatureChatGpt,
        showSpaceExpandedWhenMssIsSent: showSpaceExpandedWhenMssIsSent ??
            this.showSpaceExpandedWhenMssIsSent);
  }
  
  @override
  List<Object> get props => [
    sizeBaseOneLineHeightMessageUser,
        sizeBaseTwoLineHeightMessageUser,
        sizeHeightMessageUser,
        sizeHeightMessageChatGpt,
        sizeHeightMiniatureChatGpt,
        showSpaceExpandedWhenMssIsSent];
}

final class ChatMessageSpaceExpandInitial extends ChatMessageSpaceExpandState {
  const ChatMessageSpaceExpandInitial() : super(
            sizeHeightMessageChatGpt: 0,
            sizeHeightMessageUser: 0,
            sizeBaseOneLineHeightMessageUser: 0,
            sizeBaseTwoLineHeightMessageUser: 0,
            sizeHeightMiniatureChatGpt: 0,
            showSpaceExpandedWhenMssIsSent: false);
}




