import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_input/chat_input_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyLogoChatGptNewChat extends StatelessWidget {
  const MyLogoChatGptNewChat({
    super.key,
    required this.sizeSuggestionsBottomPadding,
    required this.sizeSuggestionsChatHeight,
    required this.sizeFullMemoryHeight,
    required this.sizeLogo,
  });

  final double sizeSuggestionsBottomPadding;
  final double sizeSuggestionsChatHeight;
  final double sizeFullMemoryHeight;
  final double sizeLogo;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatInputBloc, ChatInputState>(
        builder: (context, stateChatInputBloc) {
      final chatInputBloc = context.read<ChatInputBloc>();

      final double bottomPaddingFocus = (chatInputBloc.heightWidgetInputBase +
          chatInputBloc.heightTextFieldFocusBase +
          sizeSuggestionsBottomPadding +
          sizeSuggestionsChatHeight -
          sizeFullMemoryHeight / 2 -
          kToolbarHeight);

      final double bottomPaddingNoFocus =
          bottomPaddingFocus + (chatInputBloc.heightTextFieldFocusBase);

      final double bottomPaddingInputNotEmpty = bottomPaddingFocus +
          chatInputBloc.heightTextFieldFocusBase -
          (sizeSuggestionsChatHeight);

      final double sizeHeightInputFocus = chatInputBloc.heightWidgetInputBase +
          chatInputBloc.heightTextFieldFocusBase;

      final double sweepPaddingWithOutAnimation = sizeHeightInputFocus <=
              stateChatInputBloc.sizeContainerInput.height
          ? stateChatInputBloc.sizeContainerInput.height - sizeHeightInputFocus
          : 0;

      return AnimatedPadding(
        duration: const Duration(milliseconds: 0),
        padding: EdgeInsets.only(bottom: sweepPaddingWithOutAnimation),
        child: AnimatedPadding(
          curve: Curves.fastEaseInToSlowEaseOut,
          duration: const Duration(milliseconds: 350),
          padding: EdgeInsets.only(
              bottom: !stateChatInputBloc.isFocus
                  ? (stateChatInputBloc.isInputEmpty
                      ? bottomPaddingFocus
                      : bottomPaddingInputNotEmpty)
                  : (stateChatInputBloc.isInputEmpty
                      ? bottomPaddingNoFocus
                      : bottomPaddingInputNotEmpty)),
          child: SizedBox(
              width: sizeLogo,
              child: Image.asset(
                "assets/images/chatgpt-logo.png",
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
              )),
        ),
      );
    });
  }
}
