part of 'chat_bottom_sheet_input_thump_bloc.dart';

sealed class ChatBottomSheetInputThumpEvent extends Equatable {
  const ChatBottomSheetInputThumpEvent();

  @override
  List<Object> get props => [];
}

final class BottomSheetUpdatePositionSrollThumpEvent
    extends ChatBottomSheetInputThumpEvent {
  final double position;
  const BottomSheetUpdatePositionSrollThumpEvent({required this.position});
  @override
  List<Object> get props => [position];
}


final class BottomSheetUpdateSizeThumpEvent
    extends ChatBottomSheetInputThumpEvent {
  final double sizeThump;
  const BottomSheetUpdateSizeThumpEvent({required this.sizeThump});
  @override
  List<Object> get props => [sizeThump];
}




final class BottomSheetUpdateVisibilityEvent
    extends ChatBottomSheetInputThumpEvent {
  final bool visibility;
  const BottomSheetUpdateVisibilityEvent({required this.visibility});
  @override
  List<Object> get props => [visibility];
}




