part of 'chat_bottom_sheet_input_drag_bloc.dart';

sealed class ChatBottomSheetInputDragEvent extends Equatable {
  const ChatBottomSheetInputDragEvent();

  @override
  List<Object> get props => [];
}

final class ChatBottomSheetHandleDragUpdateEvent
    extends ChatBottomSheetInputDragEvent {
  final DragUpdateDetails details;
  const ChatBottomSheetHandleDragUpdateEvent({required this.details});

  @override
  List<Object> get props => [details];
}

final class ChatBottomSheetHandleHandleDragEndEvent
    extends ChatBottomSheetInputDragEvent {
  final DragEndDetails details;
  const ChatBottomSheetHandleHandleDragEndEvent({required this.details});

  @override
  List<Object> get props => [details];
}

