part of 'chat_bottom_sheet_input_thump_bloc.dart';

class ChatBottomSheetInputThumpState extends Equatable {
  final double position;
  final double sizeHeightThumpDynamic;
  final double maxSizeHeightThumpDynamic;
  final double minSizeHeightThumpDynamic;
  final bool visibility;
  const ChatBottomSheetInputThumpState(
      {required this.position, required this.sizeHeightThumpDynamic, required this.visibility})
      : maxSizeHeightThumpDynamic = 95,
        minSizeHeightThumpDynamic = 10;
  @override
  List<Object> get props => [position, sizeHeightThumpDynamic, visibility];
}

final class ChatBottomSheetInputThumpInitial
    extends ChatBottomSheetInputThumpState {
  const ChatBottomSheetInputThumpInitial()
      : super(position: 0, sizeHeightThumpDynamic: 95, visibility: true);
}
