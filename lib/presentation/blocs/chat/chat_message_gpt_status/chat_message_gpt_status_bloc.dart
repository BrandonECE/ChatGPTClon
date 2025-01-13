import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_alon2/domain/entities/chat_message.dart';
import 'package:flutter_application_alon2/domain/use_cases/get_all_chats_use_case.dart';
import 'package:flutter_application_alon2/domain/use_cases/send_message_use_case.dart';

import 'package:flutter_application_alon2/presentation/blocs/chat/chat_input/chat_input_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_messages/chat_messages_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_messages_thump/chat_messages_thump_bloc.dart';

part 'chat_message_gpt_status_event.dart';
part 'chat_message_gpt_status_state.dart';

class ChatMessageGptStatusBloc
    extends Bloc<ChatMessageGptStatusEvent, ChatMessageGptStatusState> {
  String textProccesed = "";
  String messageUser = "";
  String messageChatGpt =  ""; 
  bool calculateSpaceExpandedForListElement = true;
  Timer? timerLoading;
  final ChatMessagesThumpBloc chatMessagesThumpBloc;
  final ChatInputBloc chatInputBloc;
  final ChatMessagesBloc chatMessagesBloc;
  final GetAllChatsUseCase getAllChatsUseCase;
  final SendMessageUseCase sendMessageUseCase;
 
  ChatMessageGptStatusBloc(
      {required this.chatMessagesThumpBloc,
      required this.chatInputBloc,
      required this.chatMessagesBloc,
      required this.getAllChatsUseCase,
      required this.sendMessageUseCase})
      : super(ChatMessageWithOutStatus()) {
    on<ChatMessageGptSetWithOutStatusEvent>((event, emit) {
      emit(ChatMessageWithOutStatus());
      _resetTextProccesed();
    });

    on<ChatMessageGptSetStatusLoadingEvent>((event, emit) {
      _cleanInputFocus();
      _loadingResponse();
      emit(ChatMessageLoading());
    });

    on<ChatMessageGptSetStatusErrorEvent>((event, emit) {
      emit(ChatMessageError());
    });

    on<ChatMessageGptSetStatusTextEffectLoadingEvent>((event, emit) {
      emit(ChatMessageTextEffectLoading());
    });

    on<ChatMessageGptSetStatusTextEffectLoadedEvent>((event, emit) {
      chatMessagesBloc.add(ChatMessagesAddMsgChatGptEvent(message: textProccesed));
      add(const ChatMessageGptSetWithOutStatusEvent());
    });

    on<ChatMessageGptSetStatusTextEffectCancelEvent>((event, emit) {
      _cancelMessage();
    });
  }

  void _cancelMessage() {
    timerLoading?.cancel();
    if (textProccesed.trim().isNotEmpty) {
      chatMessagesBloc
          .add(ChatMessagesAddMsgChatGptEvent(message: textProccesed));
    }
    add(const ChatMessageGptSetWithOutStatusEvent());
  }

  void _cleanInputFocus() {
    chatInputBloc.textEditingController.text = "";
    chatInputBloc.add(
        ChangeInputValueEvent(text: chatInputBloc.textEditingController.text));
  }

  void _loadingResponse() {
    timerLoading?.cancel();
    timerLoading = Timer(
      const Duration(seconds: 2),
      () async {
        try {

          final messageEntity = MessageEntity(
            role: "user", 
            content: messageUser,
          );

          final response = await sendMessageUseCase.sendMessage(message: messageEntity);
          messageChatGpt = response.content;

          // final response = await getAllChatsUseCase.getAllChats();
          add(const ChatMessageGptSetStatusTextEffectLoadingEvent());
        } catch (error) {
          add(const ChatMessageGptSetStatusErrorEvent());
        }
      },
    );
  }



  void updateMessageUser(String newMessageUser) {
    messageUser = newMessageUser.trim();
  }

  void updateTextProccesed(String newWord) {
    textProccesed += newWord;
  }

  void _resetTextProccesed() {
    textProccesed = "";
  }

  void updateCalculateSpaceExpandedForListElement(bool newValue) {
    calculateSpaceExpandedForListElement = newValue;
  }

  @override
  Future<void> close() {
    timerLoading?.cancel();
    return super.close();
  }
}
