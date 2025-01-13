
import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_message_space_expand/chat_message_space_expand_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_input/chat_input_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MySpaceExpandedWhenAMessageIsSent extends StatefulWidget {
  const MySpaceExpandedWhenAMessageIsSent(
      {super.key,
      required this.sizeFullMemoryHeight,
      required this.chatInputBlocState,
      required this.spaceBtwMessages});

  final double sizeFullMemoryHeight;
  final double spaceBtwMessages;
  final ChatInputState chatInputBlocState;

  @override
  State<MySpaceExpandedWhenAMessageIsSent> createState() =>
      _MySpaceExpandedWhenAMessageIsSentState();
}

class _MySpaceExpandedWhenAMessageIsSentState
    extends State<MySpaceExpandedWhenAMessageIsSent>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ChatMessageSpaceExpandBloc, ChatMessageSpaceExpandState>(
      builder: (context, state) {
        final chatInputBlocState = context.watch<ChatInputBloc>().state;
        final chatInputBloc = context.read<ChatInputBloc>();
        final chatMessageSpaceExpandBloc =
            context.read<ChatMessageSpaceExpandBloc>();
        print("EXPANDED_UPDATE");

        print(MediaQuery.of(context).viewPadding.top);

        final keyBoardSizeHeight = EdgeInsets.fromViewPadding(
          View.of(context).viewInsets,
          View.of(context).devicePixelRatio,
        ).bottom;

        final double heightFullSpaceDevice =
            MediaQuery.of(context).size.height -
                keyBoardSizeHeight;

        final double heightAppbarComplete = widget.sizeFullMemoryHeight +
            kToolbarHeight +
            MediaQuery.of(context).viewPadding.top +
            (widget.sizeFullMemoryHeight / 2);

        final double heightInputChat =
            (chatInputBlocState.setSizeContainerInputMin
                    ? chatInputBloc.heightWidgetInputBase
                    : chatInputBlocState.sizeContainerInput.height) +
                (widget.spaceBtwMessages / 2);

        final double sizeHeightMessageUser = state.sizeHeightMessageUser;

        final double sizeMinHeightMessageUser =
            state.sizeBaseOneLineHeightMessageUser;

        final double sizeHeightMessageUserToViewClear =
            sizeMinHeightMessageUser +
                ((state.sizeBaseTwoLineHeightMessageUser -
                        sizeMinHeightMessageUser) *
                    4);

        final double sumHeightOfMessages = state.sizeHeightMessageChatGpt +
            (sizeHeightMessageUser > sizeHeightMessageUserToViewClear
                ? sizeHeightMessageUserToViewClear -
                    (widget.spaceBtwMessages / 2)
                : sizeHeightMessageUser) +
            widget.spaceBtwMessages;

        final double heightSpaceExpanded = heightFullSpaceDevice -
            (heightAppbarComplete +
                heightInputChat +
                widget.spaceBtwMessages +
                sumHeightOfMessages);

        chatMessageSpaceExpandBloc.updateSizeSpaceExpanded(heightSpaceExpanded);

        return state.showSpaceExpandedWhenMssIsSent
            ? SizedBox(
              height: heightSpaceExpanded < 0 ? 0 : heightSpaceExpanded,
            )
            : const SizedBox.shrink();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
