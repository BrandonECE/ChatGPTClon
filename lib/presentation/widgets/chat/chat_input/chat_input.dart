import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_input/chat_input_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_messages_thump/chat_messages_thump_bloc.dart';
import 'package:flutter_application_alon2/presentation/widgets/widgets.dart';
import 'package:flutter_application_alon2/utils/transform_color_with_opacity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyInputChatContainer extends StatelessWidget {
  const MyInputChatContainer({
    super.key,
    required this.sizePaddingChatHorizontal,
    required this.containerInputGlobalKey,
    required this.constraintsChat,
    required this.sizeFullMemoryHeight,
  });

  final BoxConstraints constraintsChat;
  final double sizeFullMemoryHeight;

  final double sizePaddingChatHorizontal;
  final GlobalKey containerInputGlobalKey;

  double _calculateSpaceAvailable(
      BuildContext context, BoxConstraints constraints) {
    final chatInputBloc = context.read<ChatInputBloc>();
    return constraints.maxHeight -
        (sizeFullMemoryHeight + MediaQuery.of(context).padding.top +
            kToolbarHeight +
            chatInputBloc.heightAllContainerInput);
  }

  void _updateSpaceAvailable(BuildContext context, double newSpaceAvailable) {
    final chatMessagesThumpBloc = context.read<ChatMessagesThumpBloc>();
    chatMessagesThumpBloc.updateSpaceAvailable(newSpaceAvailable);
  }

  @override
  Widget build(BuildContext context) {
    final Color colorInput = transformWithOpacity(
        Theme.of(context).colorScheme.onPrimary,
        Theme.of(context).colorScheme.primary,
        0.05);

    return BlocBuilder<ChatInputBloc, ChatInputState>(
      builder: (context, state) {
        void updateSizeContainerInput() {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final RenderBox? renderBox = containerInputGlobalKey.currentContext!
                .findRenderObject() as RenderBox?;
            if (renderBox != null &&
                renderBox.size.height != state.sizeContainerInput.height) {
              context.read<ChatInputBloc>().add(ChatCalSizeContainerInputEvent(
                  sizeContainerInput: renderBox.size));
            }
          });
        }

        final chatInputBloc = context.read<ChatInputBloc>();
        final bool inputExpanded = state.isFocus || !state.isInputEmpty;

        return MeasureSize(
          onSizeChange: (size) {
            final chatInputBloc = context.read<ChatInputBloc>();
            chatInputBloc.setHeightAllContainerInputValue(size.height);
            final double spaceScrollAvailable =
                _calculateSpaceAvailable(context, constraintsChat);
            _updateSpaceAvailable(context, spaceScrollAvailable);
          },
          child: BlurryContainer(
            blur: 10,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.75),
            borderRadius: const BorderRadius.all(Radius.circular(0)),
            padding: EdgeInsets.only(
                top: 10,
                bottom: 15,
                left: sizePaddingChatHorizontal,
                right: sizePaddingChatHorizontal),
            child: MeasureSize(
              onSizeChange: (size) {
                chatInputBloc.add(ChatCalSizeContainerInputEvent(sizeContainerInput: size));
              },
              child: MyInputChat(
                  key: containerInputGlobalKey,
                  onTapCallBack: updateSizeContainerInput,
                  chatInputState: state,
                  colorInput: colorInput,
                  inputExpanded: inputExpanded),
            ),
          ),
        );
      },
    );
  }
}

class MyInputChat extends StatelessWidget {
  const MyInputChat(
      {super.key,
      required this.chatInputState,
      required this.colorInput,
      required this.inputExpanded,
      required this.onTapCallBack});

  final ChatInputState chatInputState;
  final Color colorInput;
  final bool inputExpanded;
  final double sizeInputFocusPaddingVertical = 10;
  final double sizePaddingVerticalInputWidget = 7.225;
  final double sizePaddingRightInputWidget = 8;
  final void Function() onTapCallBack;

  @override
  Widget build(BuildContext context) {
    final chatInputBloc = context.read<ChatInputBloc>();

    return MeasureSize(
      onSizeChange: (size) {
        chatInputBloc.setHeightInputValue(size.height);
      },
      child: Container(
        padding: EdgeInsets.only(
            left: 10,
            right: sizePaddingRightInputWidget,
            bottom: sizePaddingVerticalInputWidget,
            top: sizePaddingVerticalInputWidget),
        decoration: BoxDecoration(
          color: colorInput,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            MyInputChatFocus(
                sizePaddingVerticalInputWidget: sizePaddingVerticalInputWidget,
                sizePaddingRightInputWidget: sizePaddingRightInputWidget,
                inputExpanded: inputExpanded,
                sizePaddingVerticalInputFocus: sizeInputFocusPaddingVertical,
                onTapCallBack: onTapCallBack,
                chatInputState: chatInputState),
            MyInputChatFake(
                inputExpanded: inputExpanded,
                sizePaddingVerticalInputFocus: sizeInputFocusPaddingVertical,
                chatInputState: chatInputState),
          ],
        ),
      ),
    );
  }
}
