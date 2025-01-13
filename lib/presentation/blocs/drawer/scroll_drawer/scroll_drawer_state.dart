part of 'scroll_drawer_bloc.dart';

class ScrollDrawerState extends Equatable {
  final double position;
  final bool loadChat;
  final double sizeRangeExpanded = kToolbarHeight + 10;
  const ScrollDrawerState({
    required this.position,
    required this.loadChat,
  });

  @override
  List<Object> get props => [position, loadChat];
}

final class ScrollDrawerInitial extends ScrollDrawerState {
  const ScrollDrawerInitial() : super(position: 0, loadChat: false);
}
