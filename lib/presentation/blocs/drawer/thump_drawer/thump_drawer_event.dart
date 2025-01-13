part of 'thump_drawer_bloc.dart';

sealed class ThumpDrawerEvent extends Equatable {
  const ThumpDrawerEvent();
  @override
  List<Object> get props => [];
}

final class ThumpDrawerPositionEvt extends ThumpDrawerEvent {
  final double scrollPosition;
  const ThumpDrawerPositionEvt({required this.scrollPosition});
  @override
  List<Object> get props => [scrollPosition];
}

final class ThumpDrawerHeightThumpEvt extends ThumpDrawerEvent {
  final double sizeHeightThump;
  const ThumpDrawerHeightThumpEvt({required this.sizeHeightThump});
  @override
  List<Object> get props => [sizeHeightThump];
}

final class ThumpDrawerVisibilityThumpEvt extends ThumpDrawerEvent {
  final bool visibility;
  const ThumpDrawerVisibilityThumpEvt({required this.visibility});
  @override
  List<Object> get props => [visibility];
}
