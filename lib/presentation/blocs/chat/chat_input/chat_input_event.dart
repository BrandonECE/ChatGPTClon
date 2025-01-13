part of 'chat_input_bloc.dart';

@immutable
sealed class ChatInputEvent extends Equatable {
  const ChatInputEvent();
}

final class ChangeInputValueEvent extends ChatInputEvent {
  final String text;
  const ChangeInputValueEvent({required this.text});

  @override
  List<Object?> get props => [text];
}

final class ChatFocusInputEvent extends ChatInputEvent {
  final bool isFocus;
  const ChatFocusInputEvent({required this.isFocus});

  @override
  List<Object?> get props => [isFocus];
}

final class ChatCalSizeContainerInputEvent extends ChatInputEvent {
  final Size sizeContainerInput;
  const ChatCalSizeContainerInputEvent({required this.sizeContainerInput});

  @override
  List<Object?> get props => [sizeContainerInput];
}

final class ChatExpandedEnabledOptionEvent extends ChatInputEvent {
  final bool hiddeChatExpandedEnabledOption;
  const ChatExpandedEnabledOptionEvent({required this.hiddeChatExpandedEnabledOption});

  @override
  List<Object?> get props => [hiddeChatExpandedEnabledOption];
}


final class ChatShowBottomSheetEvent extends ChatInputEvent {
  final bool showBottomSheet;
  const ChatShowBottomSheetEvent({required this.showBottomSheet});

  @override
  List<Object?> get props => [showBottomSheet];
}

final class ChatSetMaxHeightConstraintEvent extends ChatInputEvent {
  final double sizeMaxHeightSingleChildScrollView;
  const ChatSetMaxHeightConstraintEvent({required this.sizeMaxHeightSingleChildScrollView});

  @override
  List<Object?> get props => [sizeMaxHeightSingleChildScrollView];
}

final class ChatSetSizeContainerInputMinEvent extends ChatInputEvent {
  final bool setSizeContainerInputMin;
  const ChatSetSizeContainerInputMinEvent({required this.setSizeContainerInputMin});

  @override
  List<Object?> get props => [setSizeContainerInputMin];
}






