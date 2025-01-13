part of 'chat_bottom_sheet_input_drag_bloc.dart';

class ChatBottomSheetInputDragState extends Equatable {
  final double bottomSheetOffset;
  const ChatBottomSheetInputDragState({required this.bottomSheetOffset});

  @override
  List<Object> get props => [bottomSheetOffset];
}

final class ChatBottomSheetInputDragInitial
    extends ChatBottomSheetInputDragState {
  const ChatBottomSheetInputDragInitial() : super(bottomSheetOffset: 0);
}
