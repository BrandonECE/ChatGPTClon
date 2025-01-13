import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_input/chat_input_bloc.dart';
import 'package:flutter_application_alon2/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyInputAndSuggestionsContainer extends StatelessWidget {
  const MyInputAndSuggestionsContainer(
      {super.key,
      required this.sizeSuggestionsChatHeight,
      required this.sizeSuggestionsBottomPadding,
      required this.sizePaddingChat,
      required this.inputChatMainGlobalKey,
      required this.constraintsChat,
      required this.sizeFullMemoryHeight,
      required this.mssListIsEmpty});

  final bool mssListIsEmpty;
  final BoxConstraints constraintsChat;
  final double sizeFullMemoryHeight;
  final double sizePaddingChat;
  final double sizeSuggestionsChatHeight;
  final double sizeSuggestionsBottomPadding;
  final GlobalKey inputChatMainGlobalKey;
  final double sizeInputFocusPaddingVertical = 10;
  final double sizePaddingVerticalInputWidget = 7.225;
  final double sizePaddingRightInputWidget = 8;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MySuggestionsContainer(
                mssListIsEmpty: mssListIsEmpty,
                sizePaddingChat: sizePaddingChat,
                sizeSuggestionsChatHeight: sizeSuggestionsChatHeight),
            SizedBox(
              height: sizeSuggestionsBottomPadding,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: MyInputChatContainer(
                constraintsChat: constraintsChat,
                sizeFullMemoryHeight: sizeFullMemoryHeight,
                sizePaddingChatHorizontal: sizePaddingChat,
                containerInputGlobalKey: inputChatMainGlobalKey,
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: MyButtonReturnToBottomChat(
              sizeSuggestionsChatHeight: sizeSuggestionsChatHeight),
        )
      ],
    );
  }
}

class MySuggestionsContainer extends StatelessWidget {
  const MySuggestionsContainer({
    super.key,
    required this.mssListIsEmpty,
    required this.sizePaddingChat,
    required this.sizeSuggestionsChatHeight,
  });

  final bool mssListIsEmpty;
  final double sizePaddingChat;
  final double sizeSuggestionsChatHeight;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatInputBloc, ChatInputState>(
      builder: (context, state) {
        return IgnorePointer(
          ignoring: !mssListIsEmpty,
          child: Opacity(
            opacity: mssListIsEmpty ? 1 : 0,
            child: AnimatedOpacity(
              curve: state.isInputEmpty
                  ? Curves.fastEaseInToSlowEaseOut
                  : CustomSlowStartCurve(),
              opacity: !state.isInputEmpty ? 0 : 1,
              duration: const Duration(milliseconds: 350),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: sizePaddingChat),
                child: SizedBox(
                  height: sizeSuggestionsChatHeight,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: const [
                      MyChatSuggestion(
                          title: "Create a cartoon",
                          description: "Illustration of my pet"),
                      MyChatSuggestion(
                          title: "Quiz me on world capitals",
                          description: "to enhance my geography skills"),
                      MyChatSuggestion(
                          title: "Create a chart",
                          description: "based on my data"),
                      MyChatSuggestion(
                        title: "Make up a story",
                        description:
                            "about Sharky, a tooth-brushing shark supe...",
                        isLast: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomSlowStartCurve extends Curve {
  @override
  double transform(double t) {
    const double intervalStatic = 0.325;
    const double intervalRemaining = 1 - intervalStatic;

    if (t < intervalStatic) {
      return 0.0; // Mantén el valor en 0 hasta el 32.25%
    } else {
      // Ajusta `t` al rango del 67.75% restante
      double adjustedT = (t - intervalStatic) / intervalRemaining;
      // Asegúrate de que el valor ajustado esté dentro del rango válido [0.0, 1.0]
      return Curves.fastEaseInToSlowEaseOut.transform(
        adjustedT.clamp(0.0, 1.0),
      );
    }
  }
}
