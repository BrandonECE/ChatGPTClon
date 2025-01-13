import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_input_thump/chat_input_thump_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyInputChatFocusThump extends StatelessWidget {
  const MyInputChatFocusThump({
    super.key,
    required this.sizePaddingVerticalInputWidget,
    required this.sizePaddingRightInputWidget,
    required this.paddingRightIconExpanded,
    required this.sizeIconExpanded,
  });

  final double sizePaddingVerticalInputWidget;
  final double sizePaddingRightInputWidget;
  final double paddingRightIconExpanded;
  final double sizeIconExpanded;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatInputThumpBloc, ChatInputThumpState>(
      builder: (context, state) {
        return Positioned(
          top: sizePaddingVerticalInputWidget + state.position,
          right: 2.5 +
              sizePaddingRightInputWidget +
              paddingRightIconExpanded +
              sizeIconExpanded,
          child: Opacity(
            opacity: state.hiddeThumpByScroll ? 0 : 1,
            child: AnimatedOpacity(
              opacity: state.thumpVisibility ? 0 : 1,
              duration: Duration(milliseconds: state.thumpVisibility ? 100 : 25),
              child: Container(
                width: 3.5,
                height: state.sizeThumpDynamic,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimary
                      .withOpacity(0.425),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}