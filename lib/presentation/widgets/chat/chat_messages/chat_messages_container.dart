import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_message_space_expand/chat_message_space_expand_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_input/chat_input_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_message_gpt_status/chat_message_gpt_status_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_messages/chat_messages_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_messages_thump/chat_messages_thump_bloc.dart';
import 'package:flutter_application_alon2/presentation/widgets/chat/chat_messages/chat_message_error_conection.dart';
import 'package:flutter_application_alon2/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MyContainerChatMessages extends StatelessWidget {
  const MyContainerChatMessages({
    super.key,
    required this.sizePaddingChat,
    required this.sizeFullMemoryHeight,
  });

  final double sizePaddingChat;
  final double sizeFullMemoryHeight;
  final double spaceBtwMessages = 30;

  void _scrollEndNotificationHandle(
      ChatMessagesThumpBloc chatMessagesThumpBloc) {
    if (chatMessagesThumpBloc.isUserInteractionEnd) {
      chatMessagesThumpBloc.setIsUserInteractionStarted(false);
    }
    chatMessagesThumpBloc.setCancelVisibilityThumpByUserInteraction(true);
  }

  void _userScrollNotificationHandle(
      ChatMessagesThumpBloc chatMessagesThumpBloc) {
    if (chatMessagesThumpBloc.isUserInteractionStarted) {
      chatMessagesThumpBloc.setCancelVisibilityThumpByUserInteraction(false);
      chatMessagesThumpBloc.setIsUserInteractionEnd(true);
    } else {
      chatMessagesThumpBloc.setIsUserInteractionEnd(false);
      chatMessagesThumpBloc.setIsUserInteractionStarted(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatMessagesThumpBloc = context.read<ChatMessagesThumpBloc>();
    final chatInputBlocState = context.watch<ChatInputBloc>().state;
    final chatMessagesStatusBlocState =
        context.watch<ChatMessageGptStatusBloc>().state;
    final chatMessagesStatusBloc = context.read<ChatMessageGptStatusBloc>();
    final chatMessageSpaceExpandBloc =
        context.read<ChatMessageSpaceExpandBloc>();
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is UserScrollNotification) {
          _userScrollNotificationHandle(chatMessagesThumpBloc);
        } else if (notification is ScrollUpdateNotification) {
          chatMessagesThumpBloc.scrollController.position.notifyListeners();
        } else if (notification is ScrollEndNotification) {
          _scrollEndNotificationHandle(chatMessagesThumpBloc);
        }
        return true;
      },
      child: BlocBuilder<ChatMessagesBloc, ChatMessagesState>(
        builder: (context, state) {
          final bool isZeroSizeBaseOneLine = chatMessageSpaceExpandBloc
                  .state.sizeBaseOneLineHeightMessageUser ==
              0;
          final bool isZeroSizeBaseTwoLine = chatMessageSpaceExpandBloc
                  .state.sizeBaseTwoLineHeightMessageUser ==
              0;
          final bool conditionToCalculateSizeChatUserLines =
              (state.messagesList.isEmpty) &&
                  (isZeroSizeBaseOneLine && isZeroSizeBaseTwoLine);

          return Container(
            padding: EdgeInsets.symmetric(horizontal: sizePaddingChat),
            color: Theme.of(context).colorScheme.primary,
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(
                scrollbars: false,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ListView(
                      controller: chatMessagesThumpBloc.scrollController,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _mySpaceTopAppBar(context),
                        if (conditionToCalculateSizeChatUserLines)
                          _myMessageUserMinSize(context),
                        if (chatMessageSpaceExpandBloc
                                .state.sizeHeightMiniatureChatGpt ==
                            0)
                          _myMiniatureLogoChatGlobalCalculateSize(
                              chatMessageSpaceExpandBloc),
                        ...state.messagesList.asMap().entries.map((entry) {
                          int index = entry.key;
                          var message = entry.value;
                          if (message['sender'] == 'chatgpt') {
                          
                            return _myMessageChatGPT(index, state.messagesList,
                                message['message']!, spaceBtwMessages);
                          }
                          if (index == state.messagesList.length - 1 &&
                              message['sender'] == 'user') {
                            return _myMessageUserKeepAlive(
                                index,
                                state.messagesList,
                                chatMessagesStatusBlocState,
                                message['message']!,
                                spaceBtwMessages);
                          }
                          return _myMessageUser(
                              index,
                              state.messagesList,
                              chatMessagesStatusBlocState,
                              message['message']!,
                              spaceBtwMessages);
                        }),
                        _myMessageChatGPTResponseContainer(
                            chatMessagesStatusBloc),
                        const MyMessageErrorConnectionContainer(),
                        MySpaceExpandedWhenAMessageIsSent(
                            spaceBtwMessages: spaceBtwMessages,
                            sizeFullMemoryHeight: sizeFullMemoryHeight,
                            chatInputBlocState: chatInputBlocState),
                        SizedBox(
                          height: spaceBtwMessages,
                        ),
                        MySpaceBottomBtwChatAndInput(
                            spaceBtwMessages: spaceBtwMessages),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: BlocBuilder<ChatMessageGptStatusBloc,
                        ChatMessageGptStatusState>(
                      builder: (context, state) {
                        return state is ChatMessageTextEffectLoading
                            ? Offstage(
                                offstage: true,
                                child:
                                    MyMessageChatGPTResponseFallbackCalculator(
                                  sizePaddingChat: sizePaddingChat,
                                ))
                            : const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  MeasureSize _myMiniatureLogoChatGlobalCalculateSize(
      ChatMessageSpaceExpandBloc chatMessageSpaceExpandBloc) {
    return MeasureSize(
      onSizeChange: (size) {
        chatMessageSpaceExpandBloc.add(
            ChatMessagesSetSizeHeightMiniatureChatGptEvent(
                sizeHeight: size.height));
      },
      child: const MyChatGptLogo(),
    );
  }

  Widget _myMessageChatGPTResponseContainer(
      ChatMessageGptStatusBloc chatMessagesStatusBloc) {
    return VisibilityDetector(
        key: const Key('visibilityDetector-key'),
        onVisibilityChanged: (visibilityInfo) {
          final bool condition = visibilityInfo.visibleFraction > 0;
          chatMessagesStatusBloc
              .updateCalculateSpaceExpandedForListElement(condition);
        },
        child: const MyMessageChatGPTResponseContainer());
  }

  SizedBox _mySpaceTopAppBar(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight +
          sizeFullMemoryHeight +
          (sizeFullMemoryHeight / 2) +
          MediaQuery.of(context).viewPadding.top,
    );
  }

  Offstage _myMessageUserMinSize(BuildContext context) {
    return Offstage(
      offstage: true,
      child: Stack(
        children: [
          MeasureSize(
            onSizeChange: (size) {
              final chatMessageSpaceExpandBloc =
                  context.read<ChatMessageSpaceExpandBloc>();
              chatMessageSpaceExpandBloc.add(
                  ChatMessagesSetSizeBaseOneLineHeightMssUserEvent(
                      sizeHeight: size.height));
            },
            child: const MyMessageUser(messageUser: ""),
          ),
          MeasureSize(
            onSizeChange: (size) {
              final chatMessageSpaceExpandBloc =
                  context.read<ChatMessageSpaceExpandBloc>();
              chatMessageSpaceExpandBloc.add(
                  ChatMessagesSetSizeBaseTwoLinesHeightMssUserEvent(
                      sizeHeight: size.height));
            },
            child: const MyMessageUser(messageUser: "\n"),
          ),
        ],
      ),
    );
  }

  Padding _myMessageChatGPT(int index, List<Map<String, String>> messagesList,
      String message, double spaceBtwMessages) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: index == messagesList.length - 1 ? 0 : spaceBtwMessages),
      child: MyMessageChatGPT(messageUser: message),
    );
  }

  Padding _myMessageUser(
      int index,
      List<Map<String, String>> messagesList,
      ChatMessageGptStatusState chatMessagesStatusBlocState,
      String message,
      double spaceBtwMessages) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: (index == messagesList.length - 1) &&
                  chatMessagesStatusBlocState is ChatMessageWithOutStatus
              ? 0
              : spaceBtwMessages),
      child: MyMessageUser(messageUser: message),
    );
  }

  Padding _myMessageUserKeepAlive(
      int index,
      List<Map<String, String>> messagesList,
      ChatMessageGptStatusState chatMessagesStatusBlocState,
      String message,
      double spaceBtwMessages) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: (index == messagesList.length - 1) &&
                  chatMessagesStatusBlocState is ChatMessageWithOutStatus
              ? 0
              : spaceBtwMessages),
      child: MyMessageUserKeepAlive(messageUser: message),
    );
  }
}
