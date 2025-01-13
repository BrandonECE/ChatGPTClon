part of 'animation_loading_drawer_bloc.dart';

sealed class AnimationLoadingDrawerEvent extends Equatable {
  const AnimationLoadingDrawerEvent();

  @override
  List<Object> get props => [];
}

final class AnimationDrawerLoadingEvt extends AnimationLoadingDrawerEvent {
  final bool showLoadingSymbol;
  final int timeAnimation;
  final double initIntervalRotation;
  const AnimationDrawerLoadingEvt(
      {required this.timeAnimation,
      required this.showLoadingSymbol,
      required this.initIntervalRotation});
  @override
  List<Object> get props =>
      [timeAnimation, showLoadingSymbol, initIntervalRotation];
}

final class AnimationDrawerFinshLoadEvt extends AnimationLoadingDrawerEvent {
  final bool inLoading;
  const AnimationDrawerFinshLoadEvt({required this.inLoading});
  @override
  List<Object> get props => [inLoading];
}


final class AnimationDrawerHideSymbolCauseScrollDownEvt extends AnimationLoadingDrawerEvent {
  final bool isScrollingDown;
  const AnimationDrawerHideSymbolCauseScrollDownEvt({required this.isScrollingDown});
  @override
  List<Object> get props => [isScrollingDown];
}

