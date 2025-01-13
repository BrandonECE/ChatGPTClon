part of 'thump_drawer_bloc.dart';

class ThumpDrawerState extends Equatable {
  final double scrollPosition;
  final double sizeHeightThump;
  final bool visibility;
  final double sizeHeightThumpMax;
  final double sizeHeightThumpMin;
  const ThumpDrawerState(
      {required this.scrollPosition, required this.sizeHeightThump, required this.visibility})
      : sizeHeightThumpMax = 80,
        sizeHeightThumpMin = 10;

  @override
  List<Object> get props => [scrollPosition, sizeHeightThump, visibility];
}

final class ThumpDrawerInitial extends ThumpDrawerState {
  const ThumpDrawerInitial() : super(scrollPosition: 0, sizeHeightThump: 80, visibility: true);
}
