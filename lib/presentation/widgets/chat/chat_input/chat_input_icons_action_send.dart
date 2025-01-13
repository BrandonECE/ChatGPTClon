import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_message_space_expand/chat_message_space_expand_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_input/chat_input_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_message_gpt_status/chat_message_gpt_status_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_messages/chat_messages_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_messages_thump/chat_messages_thump_bloc.dart';
import 'package:flutter_application_alon2/utils/transform_color_with_opacity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyWidgetIconSendMsj extends StatefulWidget {
  const MyWidgetIconSendMsj({
    super.key,
    this.padding = 5.5,
    this.sizeIcon = 22.5,
    required this.textEditingController,
  });

  final double padding;
  final double sizeIcon;
  final TextEditingController? textEditingController;

  @override
  State<MyWidgetIconSendMsj> createState() => _MyWidgetIconSendMsjState();
}

class _MyWidgetIconSendMsjState extends State<MyWidgetIconSendMsj> {
  bool _isPressed = false;
  Timer? timer;

  void _update() {
    setState(() {});
  }

  void _timerButtonPressUpHandle() {
    timer?.cancel();
    timer = Timer(
      const Duration(milliseconds: 75),
      () {
        _isPressed = false;
        _update();
      },
    );
  }

  void _onTapUp(BuildContext context) {
    
    final chatInputBloc = context.read<ChatInputBloc>();
    final chatMessageSpaceExpandBloc =
        context.read<ChatMessageSpaceExpandBloc>();
    final chatMessagesBloc = context.read<ChatMessagesBloc>();
    final chatMessageGptStatusBloc = context.read<ChatMessageGptStatusBloc>();
    final chatMessagesThumpBloc = context.read<ChatMessagesThumpBloc>();

    FocusScope.of(context).unfocus();
    chatInputBloc.buttonSendHandle();
    chatInputBloc.add(const ChatSetSizeContainerInputMinEvent(
        setSizeContainerInputMin: true));
    chatMessagesBloc.add(ChatMessagesAddMsgUserEvent(
        message: chatInputBloc.textEditingController.text));

    chatMessageSpaceExpandBloc
      ..add(ChatMessagesSetSizeHeightMssChatGptEvent(
          sizeHeight:
              chatMessageSpaceExpandBloc.state.sizeHeightMiniatureChatGpt))
      ..add(const ChatMessagesShowSpaceExpandedWhenMssIsSentEvent(
          showSpaceExpandedWhenMssIsSent: true));

    chatMessageGptStatusBloc.add(const ChatMessageGptSetStatusLoadingEvent());
    chatMessageGptStatusBloc
        .updateMessageUser(widget.textEditingController!.text);
    chatMessagesThumpBloc.add(
        const ChatMessagesThumpShowButtonReturnToButtonChatEvent(
            showButtonReturnToBottomChat: true));


  }

  @override
  Widget build(BuildContext context) {
    final chatMessageGptStatusBlocState =
        context.watch<ChatMessageGptStatusBloc>().state;

    final bool conditionToEnableButton =
        (widget.textEditingController!.text.isNotEmpty) &&
            (chatMessageGptStatusBlocState is ChatMessageWithOutStatus ||
                chatMessageGptStatusBlocState is ChatMessageError);

    final Color defaultColor = conditionToEnableButton
        ? Theme.of(context).colorScheme.onPrimary
        : transformWithOpacity(Theme.of(context).colorScheme.onPrimary,
            Theme.of(context).colorScheme.primary, 0.2);

    final Color activeColor = defaultColor.withOpacity(0.6);

    return GestureDetector(
      onTapDown: (_) {
        _isPressed = true;
        _update();
      },
      onTapUp: (_) {
        if (conditionToEnableButton) {
          _onTapUp(context);
        }
        _timerButtonPressUpHandle();
      },
      onTapCancel: () {
        timer?.cancel();
        _isPressed = false;
        _update();
      },
      child: Container(
        padding: EdgeInsets.all(widget.padding),
        decoration: BoxDecoration(
          color: _isPressed ? activeColor : defaultColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_upward_outlined,
          color: Theme.of(context).colorScheme.primary,
          size: widget.sizeIcon,
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
