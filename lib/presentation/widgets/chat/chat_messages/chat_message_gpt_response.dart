import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_message_gpt_status/chat_message_gpt_status_bloc.dart';
import 'package:flutter_application_alon2/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyMessageChatGPTResponseContainer extends StatelessWidget {
  const MyMessageChatGPTResponseContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatMessageGptStatusBloc, ChatMessageGptStatusState>(
      builder: (context, state) {
        if (state is ChatMessageWithOutStatus || state is ChatMessageError) {
          return const SizedBox.shrink();
        }
        return const MyMessageChatGPTResponse();
      },
    );
  }
}

class MyMessageChatGPTResponse extends StatelessWidget {
  const MyMessageChatGPTResponse({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatMessageGptStatusBloc, ChatMessageGptStatusState>(
      builder: (context, state) {
        final chatMessageGptStatusBloc =
            context.read<ChatMessageGptStatusBloc>();
        return Align(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: state is ChatMessageLoading
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                const MyChatGptLogo(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.025,
                ),
                _myStatusChatGptResponse(
                    state, chatMessageGptStatusBloc, context)
              ],
            ));
      },
    );
  }

  Widget _myStatusChatGptResponse(ChatMessageGptStatusState state,
      ChatMessageGptStatusBloc chatMessageGptStatusBloc, BuildContext context) {
    final chatMessageGptStatusBloc = context.read<ChatMessageGptStatusBloc>();

    if (state is ChatMessageTextEffectLoading) {
      return MyMessageChatGptResponseTextEffectLoading(
        message: chatMessageGptStatusBloc.messageChatGpt,
        calculateSpaceExpandedForListElement: true,
      );
    }
    return const MyMessageChatGptResponseLoading();
  }
}
