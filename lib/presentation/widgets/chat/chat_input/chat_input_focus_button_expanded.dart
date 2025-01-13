import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_input/chat_input_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyInputChatFocusOptionExpanded extends StatefulWidget {
  const MyInputChatFocusOptionExpanded({
    super.key,
    required this.sizeIconExpanded,
  });

  final double sizeIconExpanded;

  @override
  State<MyInputChatFocusOptionExpanded> createState() =>
      _MyInputChatFocusOptionExpandedState();
}

class _MyInputChatFocusOptionExpandedState
    extends State<MyInputChatFocusOptionExpanded> {
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

  @override
  Widget build(BuildContext context) {
    final Color color = _isPressed
        ? Theme.of(context).colorScheme.onPrimary.withOpacity(0.5)
        : Theme.of(context).colorScheme.onPrimary.withOpacity(0.8);

    return GestureDetector(

      onTapDown: (_) {
        _isPressed = true;
        _update();
      },
      onTapUp: (_) {
        _timerButtonPressUpHandle();
        final chatInputBloc = context.read<ChatInputBloc>();
        chatInputBloc.showBottomSheet(true);
      },
      onTapCancel: () {
        _isPressed = false;
        _update();
      },
      child: Icon(
        Icons.open_in_full,
        size: widget.sizeIconExpanded,
        color: color,
      ),
    );
  }
}
