import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_message_gpt_status/chat_message_gpt_status_bloc.dart';
import 'package:flutter_application_alon2/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyMessageChatGPTResponseFallbackCalculator extends StatelessWidget {
  const MyMessageChatGPTResponseFallbackCalculator(
      {super.key, required this.sizePaddingChat});

  final double sizePaddingChat;

  @override
  Widget build(BuildContext context) {
    final chatMessageGptStatusBloc = context.read<ChatMessageGptStatusBloc>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizePaddingChat),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MyChatGptLogo(),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.025,
          ),
          _myStatusChatGptResponse(context, chatMessageGptStatusBloc)
        ],
      ),
    );
  }

  Widget _myStatusChatGptResponse(BuildContext context, ChatMessageGptStatusBloc chatMessageGptStatusBloc) {
   final chatMessageGptStatusBloc = context.read<ChatMessageGptStatusBloc>();
    return MyMessageChatGptResponseTextEffectLoading(
      message: chatMessageGptStatusBloc.messageChatGpt,
      calculateSpaceExpandedForListElement: false,
    );
  }
}
