import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_message_space_expand/chat_message_space_expand_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_message_gpt_status/chat_message_gpt_status_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyWidgetIconStopResponse extends StatefulWidget {
  const MyWidgetIconStopResponse({
    super.key,
    this.sizeContainerButton = 33.5,
    this.sizeIcon = 22.5,
  });

  final double sizeContainerButton;
  final double sizeIcon;

  @override
  State<MyWidgetIconStopResponse> createState() => _MyWidgetIconStopResponse();
}

class _MyWidgetIconStopResponse extends State<MyWidgetIconStopResponse> {
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

  void _onTapUp() {
    context.read<ChatMessageGptStatusBloc>().add(const ChatMessageGptSetStatusTextEffectCancelEvent());
    context.read<ChatMessageSpaceExpandBloc>().add(const ChatMessagesShowSpaceExpandedWhenMssIsSentEvent(showSpaceExpandedWhenMssIsSent: false));
    _timerButtonPressUpHandle();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).colorScheme.onPrimary;
    final Color activeColor = color.withOpacity(0.6);

    return GestureDetector(
      onTapDown: (_) {
        _isPressed = true;
        _update();
      },
      onTapUp: (_) {
        _onTapUp();
      },
      onTapCancel: () {
        timer?.cancel();
        _isPressed = false;
        _update();
      },
      child: Container(
        width: widget.sizeContainerButton,
        height: widget.sizeContainerButton,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _isPressed
              ? activeColor
              : Theme.of(context).colorScheme.onPrimary,
          shape: BoxShape.circle,
        ),
        child: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(2.5)),
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
