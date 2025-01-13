import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_message_space_expand/chat_message_space_expand_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_message_gpt_status/chat_message_gpt_status_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_messages_thump/chat_messages_thump_bloc.dart';
import 'package:flutter_application_alon2/presentation/widgets/utils/measure_size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyMessageChatGptResponseTextEffectLoading extends StatefulWidget {
  const MyMessageChatGptResponseTextEffectLoading(
      {super.key,
      required this.message,
      required this.calculateSpaceExpandedForListElement});
  final String message;
  final bool calculateSpaceExpandedForListElement;
  @override
  State<MyMessageChatGptResponseTextEffectLoading> createState() =>
      _MyMessageChatGptResponseTextEffectLoadingState();
}

class _MyMessageChatGptResponseTextEffectLoadingState
    extends State<MyMessageChatGptResponseTextEffectLoading>
    with AutomaticKeepAliveClientMixin {
  late final List<String> listMss;
  Timer? timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    listMss = widget.message.split(RegExp(r"(?<=\s)|(?=—)|(?<=—)"));
    _addNewWordAfterAnimation();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _addNewWordAfterAnimation() {
    timer?.cancel();
    timer = Timer(
      const Duration(milliseconds: 60),
      () {
        if (_currentIndex <= listMss.length - 1) {
          setState(() {
            _currentIndex++;
          });

          if (_currentIndex != listMss.length) {
            _addNewWordAfterAnimation();
          }
        }
      },
    );
  }

  void _updateTextProccesed(String word, BuildContext context) {
    context.read<ChatMessageGptStatusBloc>().updateTextProccesed(word);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _effect(context);
  }

  Widget _effect(BuildContext context) {
    final chatMessagesGptStatusBloc = context.read<ChatMessageGptStatusBloc>();
    return MeasureSize(
      onSizeChange: (size) {
        final bool condition =
            chatMessagesGptStatusBloc.calculateSpaceExpandedForListElement ==
                widget.calculateSpaceExpandedForListElement;
        if (condition) {
          updateChatMessageSpace(context, _currentIndex, size);
        }
      },
      child: _myWidget(context, chatMessagesGptStatusBloc),
    );
  }

  Expanded _myWidget(BuildContext context,
      ChatMessageGptStatusBloc chatMessagesGptStatusBloc) {
    final chatMessageSpaceExpandBloc =
        context.read<ChatMessageSpaceExpandBloc>();
    return Expanded(
        child: Wrap(
      children: List.generate(
        _currentIndex + 1,
        (index) {
          String word = listMss[index == listMss.length ? (index - 1) : index];
          double opacity = index == _currentIndex ? 0 : 1;

          if (index == _currentIndex - 1 &&
              widget.calculateSpaceExpandedForListElement) {
;
            if (chatMessageSpaceExpandBloc.sizeSpaceExpanded <= 0) {
              context
                  .read<ChatMessagesThumpBloc>()
                  .scrollController
                  .position
                  .notifyListeners();
            }
            _updateTextProccesed(word, context);
          }

          return AnimatedOpacity(
              onEnd: () {
                if (listMss.length == index + 1 &&
                    widget.calculateSpaceExpandedForListElement) {
                  context.read<ChatMessageGptStatusBloc>().add(
                      const ChatMessageGptSetStatusTextEffectLoadedEvent());
                }
              },
              opacity: opacity,
              duration: const Duration(milliseconds: 300),
              child: index != _currentIndex
                  ? _myWord(word)
                  : const SizedBox.shrink());
        },
      ),
    ));
  }

  void updateChatMessageSpace(
      BuildContext context, int currentIndex, Size size) {
    // Log para depuración
    // print("ACTUALIZANDO_WORD | INDEX: $currentIndex | size: ${size.height}");

    // Obtener el Bloc
    final chatMessageSpaceExpandBloc =
        context.read<ChatMessageSpaceExpandBloc>();

    // Actualizar la altura mínima si el índice actual es 1
    if (currentIndex == 1) {
      chatMessageSpaceExpandBloc.updateMinSizeHeightMssUser(size.height);
    }

    // Obtener tamaño actual del mensaje miniatura para ChatGPT
    final double sizeHeightMiniatureChatGpt =
        chatMessageSpaceExpandBloc.state.sizeHeightMiniatureChatGpt;

    // Calcular la nueva altura del mensaje
    final double calculatedHeight = size.height > sizeHeightMiniatureChatGpt
        ? size.height -
            (sizeHeightMiniatureChatGpt -
                chatMessageSpaceExpandBloc.minSizeHeightMssUser)
        : sizeHeightMiniatureChatGpt;

    // Emitir el evento para actualizar el tamaño del mensaje
    chatMessageSpaceExpandBloc.add(
      ChatMessagesSetSizeHeightMssChatGptEvent(sizeHeight: calculatedHeight),
    );
  }

  Text _myWord(String word) {
    return Text(
      word,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onPrimary),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
