part of 'animation_loading_drawer_bloc.dart';

class AnimationLoadingDrawerState extends Equatable {
  final int timeAnimation;
  final bool showLoadingSymbol;
  final bool inLoading;
  final double initIntervalRotation;
  final bool isScrollingDown;
  const AnimationLoadingDrawerState(
      {required this.timeAnimation,
      required this.showLoadingSymbol,
      required this.inLoading,
      required this.initIntervalRotation, required this.isScrollingDown});
  @override
  List<Object> get props =>
      [timeAnimation, showLoadingSymbol, inLoading, initIntervalRotation, isScrollingDown];
}

final class AnimationLoadingDrawerInitial extends AnimationLoadingDrawerState {
  const AnimationLoadingDrawerInitial()
      : super(
            timeAnimation: 2000,
            showLoadingSymbol: false,
            inLoading: false,
            initIntervalRotation: 0.5,
            isScrollingDown: false);
}
