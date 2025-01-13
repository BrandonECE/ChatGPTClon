import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_message_space_expand_event.dart';
part 'chat_message_space_expand_state.dart';

class ChatMessageSpaceExpandBloc
    extends Bloc<ChatMessageSpaceExpandEvent, ChatMessageSpaceExpandState> {
  double minSizeHeightMssUser = 0;
  double sizeSpaceExpanded = 0;

  ChatMessageSpaceExpandBloc() : super(const ChatMessageSpaceExpandInitial()) {
    on<ChatMessagesSetSizeHeightMssChatGptEvent>((event, emit) {
      // print(event.sizeHeight);
      emit(state.copyWith(sizeHeightMessageChatGpt: event.sizeHeight));
    });

    on<ChatMessagesSetSizeHeightMssUserEvent>((event, emit) {
      emit(state.copyWith(sizeHeightMessageUser: event.sizeHeight));
    });

    on<ChatMessagesSetSizeBaseOneLineHeightMssUserEvent>((event, emit) {
      emit(state.copyWith(sizeBaseOneLineHeightMessageUser: event.sizeHeight));
    });

    on<ChatMessagesSetSizeBaseTwoLinesHeightMssUserEvent>((event, emit) {
      emit(state.copyWith(sizeBaseTwoLineHeightMessageUser: event.sizeHeight));
    });

    on<ChatMessagesSetSizeHeightMiniatureChatGptEvent>((event, emit) {
      emit(state.copyWith(sizeHeightMiniatureChatGpt: event.sizeHeight));
    });

    on<ChatMessagesShowSpaceExpandedWhenMssIsSentEvent>((event, emit) {
      emit(state.copyWith(
          showSpaceExpandedWhenMssIsSent:
              event.showSpaceExpandedWhenMssIsSent));
    });
  }

  void updateMinSizeHeightMssUser(double newMinSizeHeightMssUser) {
    minSizeHeightMssUser = newMinSizeHeightMssUser;
  }

  void updateSizeSpaceExpanded(double newSizeSpaceExpanded) {
    sizeSpaceExpanded = newSizeSpaceExpanded;
  }
}
