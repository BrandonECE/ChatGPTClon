import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_input/chat_input_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_message_gpt_status/chat_message_gpt_status_bloc.dart';
import 'package:flutter_application_alon2/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyInputChatFake extends StatelessWidget {
  const MyInputChatFake({
    super.key,
    required this.inputExpanded,
    required this.sizePaddingVerticalInputFocus,
    required this.chatInputState,
  });

  final bool inputExpanded;
  final double sizePaddingVerticalInputFocus;
  final ChatInputState chatInputState;

  @override
  Widget build(BuildContext context) {
    final chatInputBloc = context.read<ChatInputBloc>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 6),
          child: Icon(
            Icons.add,
            size: 30,
          ),
        ),
        Expanded(
            child: Offstage(
                offstage: inputExpanded,
                child: MeasureSize(
                  onSizeChange: (size) {
                    _measureSizeHandle(chatInputBloc, size.height);
                  },
                  child: GestureDetector(
                    onTap: () {
                      if (!chatInputBloc.focusNodeReal.hasFocus) {
                        chatInputBloc.requestFocusForInputFocus();
                      }
                    },
                    child: AbsorbPointer(
                      child: MyTextFormField(
                        mainInput: false,
                        inputExpanded: inputExpanded,
                        focusNode: null,
                        textEditingController: null,
                      ),
                    ),
                  ),
                ))),
        MyWidgetsSelectIconToView(chatInputState: chatInputState,)
      ],
    );
  }

  void _measureSizeHandle(ChatInputBloc chatInputBloc, double height) {
    chatInputBloc.setheightTextFieldFocusBase(height +
        sizePaddingVerticalInputFocus +
        sizePaddingVerticalInputFocus / 2);
    chatInputBloc.setheightTextFieldFakeBase(height);
  }
}

class MyWidgetsSelectIconToView extends StatelessWidget {
  const MyWidgetsSelectIconToView({super.key, required this.chatInputState});
  final ChatInputState chatInputState;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatMessageGptStatusBloc, ChatMessageGptStatusState>(
      builder: (context, state) {
        if (state is ChatMessageWithOutStatus || state is ChatMessageError) {
          return chatInputState.isInputEmpty
              ? const MyIconsOptionInput()
              : MyWidgetIconSendMsj(
                  textEditingController:
                      context.watch<ChatInputBloc>().textEditingController,
                );
        }
        return const MyWidgetIconStopResponse();
      },
    );
  }
}

