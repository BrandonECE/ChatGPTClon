
import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_bottom_sheet_input_drag/chat_bottom_sheet_input_drag_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_bottom_sheet_input_thump/chat_bottom_sheet_input_thump_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_input/chat_input_bloc.dart';
import 'package:flutter_application_alon2/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyChatInputBottomSheetDrag extends StatelessWidget {
  const MyChatInputBottomSheetDrag(
      {super.key,
      required this.stateBottomSheetDrag,
      required this.stateChatInput});

  final ChatInputState stateChatInput;
  final ChatBottomSheetInputDragState stateBottomSheetDrag;

  @override
  Widget build(BuildContext context) {
    final chatBottomSheetInputDragBloc =
        context.read<ChatBottomSheetInputDragBloc>();

    return MeasureSize(
      onSizeChange: (size) {
        chatBottomSheetInputDragBloc.updateHeightBottomSheet(size.height);
      },
      child: AnimatedPositioned(
        onEnd: () {
          if (stateChatInput.showBottomSheet) {
            final chatBottomSheetInputBloc = context.read<ChatInputBloc>();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              chatBottomSheetInputBloc.focusNodeBottomSheet.requestFocus();
            });
          }
        },
        curve: Curves.fastLinearToSlowEaseIn,
        duration: const Duration(milliseconds: 900),
        top: stateChatInput.showBottomSheet
            ? 50 + stateBottomSheetDrag.bottomSheetOffset
            : MediaQuery.of(context).size.height,
        bottom: stateChatInput.showBottomSheet
            ? -stateBottomSheetDrag.bottomSheetOffset
            : -(MediaQuery.of(context).size.height - 50),
        left: 0,
        right: 0,
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            chatBottomSheetInputDragBloc.add(
              ChatBottomSheetHandleDragUpdateEvent(details: details),
            );
          },
          onVerticalDragEnd: (details) {
            chatBottomSheetInputDragBloc.add(
              ChatBottomSheetHandleHandleDragEndEvent(details: details),
            );
          },
          child: const MyChatInputBottomSheet(),
        ),
      ),
    );
  }
}

class MyChatInputBottomSheet extends StatelessWidget {
  const MyChatInputBottomSheet({super.key});
  final double iconMinimizeSize = 25;
  final double paddingIcons = 15;
  final double iconSendMsjSize = 22.5;
  final double iconSendMsjPadding = 5.5;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChatBottomSheetInputThumpBloc(scrollSpaceAvailable: 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: LayoutBuilder(
            builder: (context, constraints) {
              final double spaceBottomSheetScroll =
                  _calcultateSpaceBottomSheetScroll(constraints);
              _updateHeightSpaceBottomSheetScroll(
                  context, spaceBottomSheetScroll);
              return MyChatInputBottomSheetContent(
                  iconSendMsjPadding: iconSendMsjPadding,
                  iconSendMsjSize: iconSendMsjSize,
                  paddingIcons: paddingIcons,
                  iconMinimizeSize: iconMinimizeSize);
            },
          ),
        ),
      ),
    );
  }

  double _calcultateSpaceBottomSheetScroll(BoxConstraints constraints) {
    return (constraints.maxHeight) -
        ((paddingIcons * 4) +
            (iconSendMsjPadding * 2) +
            (iconMinimizeSize + iconSendMsjSize) -
            10);
  }

  void _updateHeightSpaceBottomSheetScroll(
      BuildContext context, double spaceBottomSheetScroll) {
    final chatBottomSheetInputThumpBloc =
        context.read<ChatBottomSheetInputThumpBloc>();
    if (chatBottomSheetInputThumpBloc.scrollSpaceAvailable !=
        spaceBottomSheetScroll) {
      chatBottomSheetInputThumpBloc
          .updateHeightSpaceBottomSheetScroll(spaceBottomSheetScroll);
    }
  }
}

class MyChatInputBottomSheetContent extends StatelessWidget {
  const MyChatInputBottomSheetContent({
    super.key,
    required this.iconSendMsjPadding,
    required this.iconSendMsjSize,
    required this.paddingIcons,
    required this.iconMinimizeSize,
  });

  final double iconSendMsjPadding;
  final double iconSendMsjSize;
  final double paddingIcons;
  final double iconMinimizeSize;

  @override
  Widget build(BuildContext context) {
    final chatBottomSheetInputBlocThump =
        context.read<ChatBottomSheetInputThumpBloc>();

    final chatInputBloc = context.read<ChatInputBloc>();

    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Stack(
        children: [
          Positioned.fill(child: GestureDetector(onTap: () {
            chatInputBloc.focusNodeBottomSheet.requestFocus();
          })),
          Align(
            alignment: Alignment.topCenter,
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(scrollbars: false),
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is UserScrollNotification) {
                    chatBottomSheetInputBlocThump.updateCancelVisibility(true);
                  } else if (notification is ScrollUpdateNotification) {
                    chatBottomSheetInputBlocThump.scrollController.position .notifyListeners();
                  } else if (notification is ScrollEndNotification) {
                    chatBottomSheetInputBlocThump.updateCancelVisibility(false);
                  }
                  return true;
                },
                child: SingleChildScrollView(
                  controller: chatBottomSheetInputBlocThump.scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      MyTextFormFieldBottomSheet(
                        textEditingController:
                            context.watch<ChatInputBloc>().textEditingController,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 15,
            top: 15,
            child: MyChatInputBottomSheetContentButtonMinimize(chatInputBloc: chatInputBloc),
          ),
          Positioned(
              right: 15,
              bottom: 15,
              child: MyWidgetIconSendMsj(
                textEditingController: chatInputBloc.textEditingController,
                padding: iconSendMsjPadding,
                sizeIcon: iconSendMsjSize,
              )),
          BlocBuilder<ChatBottomSheetInputThumpBloc,
              ChatBottomSheetInputThumpState>(
            builder: (context, state) {
              return Positioned(
                top: (paddingIcons * 2) + iconMinimizeSize + state.position,
                right: 2.8,
                child: AnimatedOpacity(
                  opacity: state.visibility ? 0 : 1,
                  duration: Duration(milliseconds: state.visibility ? 100 : 25),
                  child: Container(
                    width: 3.5,
                    height: state.sizeHeightThumpDynamic,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.425),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}


class MyTextFormFieldBottomSheet extends StatelessWidget {
  const MyTextFormFieldBottomSheet(
      {super.key,
      required this.textEditingController,
      this.onTapCallBack = _defaultCallback});

  final TextEditingController? textEditingController;
  final void Function() onTapCallBack;

  static void _defaultCallback() {}

  @override
  Widget build(BuildContext context) {
    final chatBottomSheetInputBloc = context.read<ChatInputBloc>();

    return Material(
      child: TextFormField(
        focusNode: chatBottomSheetInputBloc.focusNodeBottomSheet,
        maxLines: null,
        controller: textEditingController,
        cursorColor: Theme.of(context).colorScheme.secondary,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(right: 20, left: 20, top: 110, bottom: 0),
          fillColor: Theme.of(context).colorScheme.primary,
          // fillColor: Colors.blue,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
