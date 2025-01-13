import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_input/chat_input_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyChatInputBottomSheetContentButtonMinimize extends StatefulWidget {
  const MyChatInputBottomSheetContentButtonMinimize({
    super.key,
    required this.chatInputBloc,
  });

  final ChatInputBloc chatInputBloc;

  @override
  State<MyChatInputBottomSheetContentButtonMinimize> createState() =>
      _MyChatInputBottomSheetContentButtonMinimizeState();
}

class _MyChatInputBottomSheetContentButtonMinimizeState
    extends State<MyChatInputBottomSheetContentButtonMinimize> {
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

    final Color color = _isPressed ? Theme.of(context).colorScheme.onPrimary.withOpacity(0.3) : Theme.of(context).colorScheme.onPrimary;

    return Transform.rotate(
        angle: pi * 0.5,
        child: GestureDetector(
          onTapDown: (_) {
            _isPressed = true;
            _update();
          },
          onTapUp: (_) {
            _timerButtonPressUpHandle();
            final chatInputBloc = context.read<ChatInputBloc>();
            chatInputBloc.showBottomSheet(false);
          },
          onTapCancel: () {
            _isPressed = false;
            _update();
          },
          child:  Icon(
            color: color,
            Icons.close_fullscreen,
            size: 25,
          ),
        ));
  }
}
