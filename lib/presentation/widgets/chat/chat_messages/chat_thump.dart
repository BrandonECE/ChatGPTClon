import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_messages_thump/chat_messages_thump_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyChatThump extends StatelessWidget {
  const MyChatThump({
    super.key,
    required this.sizeFullMemoryHeight,
  });

  final double sizeFullMemoryHeight;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatMessagesThumpBloc, ChatMessagesThumpState>(
      builder: (context, state) {
        // print(state.thumpPosition);
        // print("ACTUALIZANDOoooooooooooooooooooooooooooooooooo");
        return AnimatedPositioned(
          curve: Curves.linearToEaseOut,
          duration: Duration(
            milliseconds: state.isAnimatedPositioned ? 200 : 0,
          ),
          right: 2.5,
          top: kToolbarHeight +
              sizeFullMemoryHeight +
              state.thumpPosition +
              MediaQuery.of(context).padding.top,
          child: AnimatedOpacity(
            opacity: state.isVisibleThump ? 1 : 0,
            duration: Duration(milliseconds: state.isVisibleThump ? 25 : 100),
            child: Container(
              width: 3.5,
              height: state.sizeHeightThumpDynamic,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        );
      },
    );
  }
}
