import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_message_space_expand/chat_message_space_expand_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_messages/chat_messages_bloc.dart';
import 'package:flutter_application_alon2/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyChatView extends StatelessWidget {
  const MyChatView(
      {super.key,
      required this.lambda,
      this.sizeLogo = 45,
      this.sizeFullMemoryHeight = kToolbarHeight * 0.75,
      this.sizeSuggestionsChatHeight = 70,
      this.sizeSuggestionsBottomPadding = 12,
      required this.inputChatMainGlobalKey});

  final void Function() lambda;
  final double sizeFullMemoryHeight;
  final double sizeLogo;
  final double sizeSuggestionsChatHeight;
  final double sizeSuggestionsBottomPadding;
  final GlobalKey inputChatMainGlobalKey;
  final String message =
      "Kotlin offers several key benefits for Android development, making it a preferred language for many developers. One of the primary advantages is its conciseness—Kotlin allows developers to write less code compared to Java, reducing boilerplate and making the codebase easier to maintain.One of the primary advantages is its conciseness—Kotlin allows developers to write less code compared to Java, reducing boilerplate and making the codebase easier to maintain.One of the primary advantages is its conciseness—Kotlin allows developers to write less code compared to Java, reducing boilerplate and making the codebase easier to maintain.";

  @override
  Widget build(BuildContext context) {
    final double sizePaddingChat = MediaQuery.of(context).size.width * 0.04;
    return LayoutBuilder(
      builder: (context, constraints) {
        final chatMessagesBlocState = context.watch<ChatMessagesBloc>().state;

        return Scaffold(
          
          body: Stack(
            children: [
              
              Offstage(
                offstage: chatMessagesBlocState.messagesList.isNotEmpty,
                child: _myLogoChatGptNewChat(context),
              ),

              Offstage(
                offstage: chatMessagesBlocState.messagesList.isEmpty,
                child: _myContainerChatMessages(sizePaddingChat),
              ),

              // _myContainerChatMessages(sizePaddingChat),

              MyChatThump(sizeFullMemoryHeight: sizeFullMemoryHeight),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: MyInputAndSuggestionsContainer(
                      mssListIsEmpty:
                          chatMessagesBlocState.messagesList.isEmpty,
                      constraintsChat: constraints,
                      sizeFullMemoryHeight: sizeFullMemoryHeight,
                      inputChatMainGlobalKey: inputChatMainGlobalKey,
                      sizePaddingChat: sizePaddingChat,
                      sizeSuggestionsChatHeight: sizeSuggestionsChatHeight,
                      sizeSuggestionsBottomPadding:
                          sizeSuggestionsBottomPadding),
                ),
              ),

              Align(
                  alignment: Alignment.topCenter,
                  child: MyAppBarCustom(
                    lambda: lambda,
                    sizeFullMemoryHeight: sizeFullMemoryHeight,
                  )),

              
            ],
          ),
        );
      },
    );
  }

  void asdasd(BuildContext context, int currentIndex, Size size) {
    print("ACTUALIZANDO_WORD");
    final chatMessageSpaceExpandBloc =
        context.read<ChatMessageSpaceExpandBloc>();
    if (currentIndex == 1) {
      chatMessageSpaceExpandBloc.updateMinSizeHeightMssUser(size.height);
    }
    final sizeHeightMiniatureChatGpt =
        chatMessageSpaceExpandBloc.state.sizeHeightMiniatureChatGpt;
    final double heightMss = size.height;
    // print(heightMss);
    chatMessageSpaceExpandBloc.add(ChatMessagesSetSizeHeightMssChatGptEvent(
        sizeHeight: heightMss > sizeHeightMiniatureChatGpt
            ? heightMss -
                (sizeHeightMiniatureChatGpt -
                    chatMessageSpaceExpandBloc.minSizeHeightMssUser)
            : sizeHeightMiniatureChatGpt));
  }

  Align _myLogoChatGptNewChat(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: Theme.of(context).colorScheme.primary,
          alignment: Alignment.center,
          child: MyLogoChatGptNewChat(
              sizeSuggestionsBottomPadding: sizeSuggestionsBottomPadding,
              sizeSuggestionsChatHeight: sizeSuggestionsChatHeight,
              sizeFullMemoryHeight: sizeFullMemoryHeight,
              sizeLogo: sizeLogo),
        ),
      ),
    );
  }

  Align _myContainerChatMessages(double sizePaddingChat) {
    return Align(
      alignment: Alignment.center,
      child: MyContainerChatMessages(
          sizePaddingChat: sizePaddingChat,
          sizeFullMemoryHeight: sizeFullMemoryHeight),
    );
  }
}
