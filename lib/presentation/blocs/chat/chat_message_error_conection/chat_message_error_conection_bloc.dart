import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_message_gpt_status/chat_message_gpt_status_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_message_space_expand/chat_message_space_expand_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_messages_thump/chat_messages_thump_bloc.dart';

part 'chat_message_error_conection_event.dart';
part 'chat_message_error_conection_state.dart';

class ChatMessageErrorConectionBloc extends Bloc<ChatMessageErrorConectionEvent,
    ChatMessageErrorConectionState> {
  final ChatMessageSpaceExpandBloc chatMessageSpaceExpandBloc;
  final ChatMessageGptStatusBloc chatMessageGptStatusBloc;
  final ChatMessagesThumpBloc chatMessagesThumpBloc;
  Timer? timer;

  ChatMessageErrorConectionBloc(
      {required this.chatMessageGptStatusBloc,
      required this.chatMessageSpaceExpandBloc,
      required this.chatMessagesThumpBloc})
      : super(const ChatNoConnectivityState()) {
    on<ChatNoConnectivityEvent>((event, emit) {
      emit(const ChatNoConnectivityState());
    });

    on<ChatCheckingConnectivityEvent>((event, emit) {
      emit(const ChatCheckingConnectivityState());
      timer?.cancel();
      timer = Timer(
        const Duration(seconds: 2),
        () async {
          await isInternetActive();
        },
      );
    });
  }

  Future<void> isInternetActive() async {
    final List<ConnectivityResult> result =
        await Connectivity().checkConnectivity();
    if (result[0] == ConnectivityResult.mobile ||
        result[0] == ConnectivityResult.wifi) {
      chatMessageSpaceExpandBloc.add(
          const ChatMessagesShowSpaceExpandedWhenMssIsSentEvent(
              showSpaceExpandedWhenMssIsSent: true));
      chatMessageGptStatusBloc.add(const ChatMessageGptSetStatusLoadingEvent());
      chatMessagesThumpBloc.initScrollControllerAnimatedToBottom();
    }
    add(const ChatNoConnectivityEvent());
  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }
}
