import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_input/chat_input_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MySpaceBottomBtwChatAndInput extends StatefulWidget {
  const MySpaceBottomBtwChatAndInput({
    super.key,
    required this.spaceBtwMessages
  });
  final double spaceBtwMessages;
  @override
  State<MySpaceBottomBtwChatAndInput> createState() =>
      _MySpaceBottomBtwChatAndInputState();
}

class _MySpaceBottomBtwChatAndInputState
    extends State<MySpaceBottomBtwChatAndInput>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatInputBloc, ChatInputState>(
      builder: (context, state) {
        final chatInputBloc = context.read<ChatInputBloc>();
        // print(state.sizeContainerInput.height);
        // 47.95min
        super.build(context);
        return AnimatedContainer(
            // color: Colors.red,
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
            height: (state.setSizeContainerInputMin
                    ? chatInputBloc.heightWidgetInputBase
                    : state.sizeContainerInput.height) +
                (widget.spaceBtwMessages / 2));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
