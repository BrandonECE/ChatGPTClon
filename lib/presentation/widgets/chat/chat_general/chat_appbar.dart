import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_messages/chat_messages_bloc.dart';
import 'package:flutter_application_alon2/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppBarCustom extends StatelessWidget {
  const MyAppBarCustom(
      {super.key, required this.lambda, required this.sizeFullMemoryHeight});

  final double sizeFullMemoryHeight;
  final void Function() lambda;

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
        padding: EdgeInsets.only(
            bottom: 0,
            right: 0,
            left: 0,
            top: MediaQuery.of(context).padding.top),
        blur: 20,
        color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
        borderRadius: const BorderRadius.all(Radius.circular(0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyAppBar(lambda: lambda),
            MyWarningFullMemory(sizeFullMemoryHeight: sizeFullMemoryHeight),
          ],
        ));
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
    required this.lambda,
  });

  final void Function() lambda;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.015),
      decoration: BoxDecoration(
          border: Border(
      bottom: BorderSide(
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.05)),
      )),
      height: kToolbarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: lambda,
              icon: const Icon(
                Icons.menu,
              )),
          BlocBuilder<ChatMessagesBloc, ChatMessagesState>(
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: state.messagesList.isEmpty 
                  ? const MyGetPlusOption(key: ValueKey('emptyOption')) 
                  : const MyTitleChatGpt(key: ValueKey('titleChat')),
            );
          },
        ),

          IconButton(
              onPressed: null,
              icon: Icon(
                Icons.edit_note_sharp,
                size: 30,
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
              ))
        ],
      ),
    );
  }
}
