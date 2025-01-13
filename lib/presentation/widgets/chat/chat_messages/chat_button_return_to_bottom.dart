import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_messages/chat_messages_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_messages_thump/chat_messages_thump_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyButtonReturnToBottomChat extends StatelessWidget {
  const MyButtonReturnToBottomChat({
    super.key,
    required this.sizeSuggestionsChatHeight,
  });

  final double sizeSuggestionsChatHeight;
  final double buttonSize = 37.5;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatMessagesThumpBloc, ChatMessagesThumpState>(
      builder: (context, state) {
        final chatMessagesBlocState = context.watch<ChatMessagesBloc>().state;
        final bool conditionToShow = !state.showButtonReturnToBottomChat &&
            chatMessagesBlocState.messagesList.isNotEmpty;
        final bool conditionToAbsorbPointer =
            state.showButtonReturnToBottomChat &&
                chatMessagesBlocState.messagesList.isNotEmpty;
        return Padding(
          padding: EdgeInsets.only(top: sizeSuggestionsChatHeight - buttonSize),
          child: AbsorbPointer(
            absorbing: conditionToAbsorbPointer,
            child: GestureDetector(
              onTap: () {
                final chatMessagesThumpBloc =
                    context.read<ChatMessagesThumpBloc>();
                chatMessagesThumpBloc.buttonReturnToBottomChat();
              },
              child: AnimatedScale(
                alignment: Alignment.bottomCenter,
                duration: const Duration(milliseconds: 160),
                scale: conditionToShow ? 1 : 0.25,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 160),
                  curve: !state.showButtonReturnToBottomChat
                      ? ButtonShowCustomSlowStartCurve()
                      : ButtonHiddenCustomSlowStartCurve(),
                  opacity: conditionToShow ? 1 : 0,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 1),
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(0.25),
                              blurRadius: 3,
                              spreadRadius: 1)
                        ],
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle),
                    width: buttonSize,
                    height: buttonSize,
                    child: const Icon(
                      Icons.arrow_downward_rounded,
                      size: 22,
                    ),
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

class ButtonShowCustomSlowStartCurve extends Curve {
  @override
  double transform(double t) {
    const double intervalStatic = 0.35;
    const double intervalRemaining = 1 - intervalStatic;

    if (t < intervalStatic) {
      return 0.0;
    } else {
      final double adjustedT = (t - intervalStatic) / intervalRemaining;
      return Curves.linear.transform(adjustedT.clamp(0, 1));
    }
  }
}

class ButtonHiddenCustomSlowStartCurve extends Curve {
  @override
  double transform(double t) {
    const double intervalStatic = 0.2;
    const double intervalRemaining = 1 - intervalStatic;

    if (t < intervalStatic) {
      return 0.0;
    } else {
      final double adjustedT = (t - intervalStatic) / intervalRemaining;
      return Curves.linear.transform(adjustedT.clamp(0, 1));
    }
  }
}
