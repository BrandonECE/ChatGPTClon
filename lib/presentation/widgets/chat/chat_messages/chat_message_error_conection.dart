import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_message_error_conection/chat_message_error_conection_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_message_gpt_status/chat_message_gpt_status_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_message_space_expand/chat_message_space_expand_bloc.dart';
import 'package:flutter_application_alon2/utils/adjust_color_brightness.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyMessageErrorConnectionContainer extends StatelessWidget {
  const MyMessageErrorConnectionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).colorScheme.tertiary;
    return BlocBuilder<ChatMessageGptStatusBloc, ChatMessageGptStatusState>(
      builder: (context, state) {
        if (state is ChatMessageError) {
          _hiddeShowSpaceExpandedWhenMssIsSent(context);
          return MyMessageErrorConnection(color: color);
        }
        return const SizedBox.shrink();
        // return MyMessageErrorConnection(color: color);
      },
    );
  }

  void _hiddeShowSpaceExpandedWhenMssIsSent(BuildContext context) {
    final chatMessageSpaceExpandBloc =
        context.read<ChatMessageSpaceExpandBloc>();
    chatMessageSpaceExpandBloc.add(
        const ChatMessagesShowSpaceExpandedWhenMssIsSentEvent(
            showSpaceExpandedWhenMssIsSent: false));
  }
}

class MyMessageErrorConnection extends StatefulWidget {
  const MyMessageErrorConnection({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  State<MyMessageErrorConnection> createState() =>
      _MyMessageErrorConnectionState();
}

class _MyMessageErrorConnectionState extends State<MyMessageErrorConnection> {
  bool _isHover = false;
  Timer? timer;

  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatMessageErrorConectionBloc,
        ChatMessageErrorConectionState>(
      builder: (context, state) {
        final chatMessageErrorConectionBloc =
            context.read<ChatMessageErrorConectionBloc>();

        final colorButtonConditionNoConnectivity = _isHover
            ? adjustColorBrightness(widget.color, -0.05)
            : widget.color;

        final Color colorButton = state is ChatNoConnectivityState
            ? colorButtonConditionNoConnectivity
            : adjustColorBrightness(widget.color, 0.3);

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
              color: widget.color.withOpacity(0.04),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: widget.color.withOpacity(0.4))),
          child: Column(
            children: [
              Text(
                "The Internet connection appears to be offline.",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: widget.color),
              ),
              const SizedBox(
                height: 11.5,
              ),
              GestureDetector(
                onTapDown: (details) {
                  if (state is ChatNoConnectivityState) {
                    _isHover = true;
                    _update();
                  }
                },
                onTapUp: (details) {
                  if (state is ChatNoConnectivityState) {
                    timer?.cancel();
                    timer = Timer(
                      const Duration(milliseconds: 75),
                      () {
                        _isHover = false;
                        _update();
                        chatMessageErrorConectionBloc
                            .add(const ChatCheckingConnectivityEvent());
                      },
                    );
                  }
                },
                onTapCancel: () {
                  if (state is ChatNoConnectivityState) {
                    _isHover = false;
                    _update();
                  }
                },
                child: AnimatedContainer(
                  duration: Duration(
                      milliseconds: state is ChatNoConnectivityState ? 0 : 200),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 52.5,
                  decoration: BoxDecoration(
                    color: colorButton,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "Retry",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
