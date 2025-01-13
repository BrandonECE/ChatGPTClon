import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_input/chat_input_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_input_thump/chat_input_thump_bloc.dart';
import 'package:flutter_application_alon2/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyInputChatFocus extends StatelessWidget {
  const MyInputChatFocus(
      {super.key,
      required this.inputExpanded,
      required this.sizePaddingVerticalInputFocus,
      required this.onTapCallBack,
      required this.chatInputState,
      required this.sizePaddingRightInputWidget,
      required this.sizePaddingVerticalInputWidget});

  final bool inputExpanded;
  final double sizePaddingVerticalInputFocus;
  final double sizePaddingRightInputWidget;
  final double sizePaddingVerticalInputWidget;
  final void Function() onTapCallBack;
  final ChatInputState chatInputState;
  final double paddingRightIconExpanded = 8;
  final double sizeIconExpanded = 22;

  @override
  Widget build(BuildContext context) {
    final chatInputBloc = context.read<ChatInputBloc>();
    final chatInputThumpBloc = context.read<ChatInputThumpBloc>();

    final double maxHeightConstraint =
        chatInputState.sizeMaxHeightSingleChildScrollView == 0
            ? MediaQuery.of(context).size.height
            : chatInputState.sizeMaxHeightSingleChildScrollView;

    return Offstage(
        offstage: !inputExpanded,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: sizePaddingVerticalInputFocus / 2,
                          bottom: sizePaddingVerticalInputFocus),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(maxHeight: maxHeightConstraint),
                        child: ScrollConfiguration(
                          behavior: const ScrollBehavior()
                              .copyWith(scrollbars: false),
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (notification) {
                              if (notification is UserScrollNotification) {
                                chatInputThumpBloc.updateCancelVisibility(true);
                              } else if (notification
                                  is ScrollUpdateNotification) {
                                chatInputThumpBloc.scrollController.position
                                    .notifyListeners();
                              } else if (notification
                                  is ScrollEndNotification) {
                                chatInputThumpBloc
                                    .updateCancelVisibility(false);
                              }
                              return true;
                            },
                            child: SingleChildScrollView(
                              controller: chatInputThumpBloc.scrollController,
                              physics: const BouncingScrollPhysics(),
                              child: Container(
                                color: Colors.transparent,
                                child: MyTextFormField(
                                  onTapCallBack: onTapCallBack,
                                  mainInput: true,
                                  focusNode: chatInputBloc.focusNodeReal,
                                  textEditingController:
                                      chatInputBloc.textEditingController,
                                  inputExpanded: inputExpanded,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  !chatInputState.hiddeChatExpandedEnabledOption
                      ? _myButtonChatExpanded(context)
                      : const SizedBox.shrink()
                ],
              ),
            ),
            MyInputChatFocusThump(
                sizePaddingVerticalInputWidget: sizePaddingVerticalInputWidget,
                sizePaddingRightInputWidget: sizePaddingRightInputWidget,
                paddingRightIconExpanded: paddingRightIconExpanded,
                sizeIconExpanded: sizeIconExpanded),
          ],
        ));
  }

  Padding _myButtonChatExpanded(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(right: paddingRightIconExpanded, top: 8, left: 10),
      child: MyInputChatFocusOptionExpanded(sizeIconExpanded: sizeIconExpanded),
    );
  }
}
