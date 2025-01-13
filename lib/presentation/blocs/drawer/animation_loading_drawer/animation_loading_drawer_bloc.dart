import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'animation_loading_drawer_event.dart';
part 'animation_loading_drawer_state.dart';

class AnimationLoadingDrawerBloc
    extends Bloc<AnimationLoadingDrawerEvent, AnimationLoadingDrawerState> {
  AnimationLoadingDrawerBloc() : super(const AnimationLoadingDrawerInitial()) {
    on<AnimationDrawerLoadingEvt>((event, emit) {
      emit(AnimationLoadingDrawerState(
          timeAnimation: event.timeAnimation,
          showLoadingSymbol: event.showLoadingSymbol,
          initIntervalRotation: event.initIntervalRotation,
          inLoading: state.inLoading, isScrollingDown: state.isScrollingDown));
    });

    on<AnimationDrawerFinshLoadEvt>((event, emit) {
      emit(AnimationLoadingDrawerState(
          timeAnimation: state.timeAnimation,
          showLoadingSymbol: state.showLoadingSymbol,
          initIntervalRotation: state.initIntervalRotation,
          inLoading: event.inLoading, isScrollingDown: state.isScrollingDown));
    });

    on<AnimationDrawerHideSymbolCauseScrollDownEvt>((event, emit) {
      emit(AnimationLoadingDrawerState(
          timeAnimation: state.timeAnimation,
          showLoadingSymbol: state.showLoadingSymbol,
          initIntervalRotation: state.initIntervalRotation,
          inLoading: state.inLoading, isScrollingDown: event.isScrollingDown));
    });

  }

  void onScroll(ScrollPosition scrollPosition){
    if(scrollPosition.pixels > kToolbarHeight){
      add(const AnimationDrawerHideSymbolCauseScrollDownEvt(isScrollingDown: true));
    }else{
      add(const AnimationDrawerHideSymbolCauseScrollDownEvt(isScrollingDown: false));
    }
  } 

}
