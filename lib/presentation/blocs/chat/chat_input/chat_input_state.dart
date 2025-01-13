part of 'chat_input_bloc.dart';

@immutable
class ChatInputState extends Equatable {
  final Size sizeContainerInput;
  final double sizeMaxHeightSingleChildScrollView;
  final bool setSizeContainerInputMin;
  final bool isInputEmpty;
  final bool isFocus;
  final bool hiddeChatExpandedEnabledOption;
  final bool showBottomSheet;

  const ChatInputState({
    required this.setSizeContainerInputMin,
    required this.isInputEmpty,
    required this.isFocus,
    required this.sizeContainerInput,
    required this.hiddeChatExpandedEnabledOption,
    required this.showBottomSheet,
    required this.sizeMaxHeightSingleChildScrollView,
  });

  ChatInputState copyWith({
    Size? sizeContainerInput,
    double? sizeMaxHeightSingleChildScrollView,
    bool? isInputEmpty,
    bool? isFocus,
    bool? hiddeChatExpandedEnabledOption,
    bool? showBottomSheet,
    bool? setSizeContainerInputMin

  }) {
    return ChatInputState(
      sizeContainerInput: sizeContainerInput ?? this.sizeContainerInput,
      sizeMaxHeightSingleChildScrollView: sizeMaxHeightSingleChildScrollView ??
          this.sizeMaxHeightSingleChildScrollView,
      isInputEmpty: isInputEmpty ?? this.isInputEmpty,
      isFocus: isFocus ?? this.isFocus,
      hiddeChatExpandedEnabledOption:
          hiddeChatExpandedEnabledOption ?? this.hiddeChatExpandedEnabledOption,
      showBottomSheet: showBottomSheet ?? this.showBottomSheet,
      setSizeContainerInputMin: setSizeContainerInputMin ?? this.setSizeContainerInputMin
    );
  }

  @override
  List<Object?> get props => [
        isInputEmpty,
        isFocus,
        sizeContainerInput,
        hiddeChatExpandedEnabledOption,
        showBottomSheet,
        sizeMaxHeightSingleChildScrollView,
        setSizeContainerInputMin
      ];
}

class ChatInputInitial extends ChatInputState {
  const ChatInputInitial()
      : super(
          isInputEmpty: true,
          isFocus: false,
          sizeContainerInput: const Size(0, 0),
          hiddeChatExpandedEnabledOption: true,
          showBottomSheet: false,
          sizeMaxHeightSingleChildScrollView: 0,
          setSizeContainerInputMin: false
        );
}
