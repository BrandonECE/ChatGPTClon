import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'thump_drawer_event.dart';
part 'thump_drawer_state.dart';

class ThumpDrawerBloc extends Bloc<ThumpDrawerEvent, ThumpDrawerState> {
  double spaceChatScroll;
  Timer? _visibilityTimer;

  ThumpDrawerBloc({required this.spaceChatScroll})
      : super(const ThumpDrawerInitial()) {
    on<ThumpDrawerPositionEvt>((event, emit) {
      emit(ThumpDrawerState(
        scrollPosition: event.scrollPosition,
        sizeHeightThump: state.sizeHeightThump,
        visibility: state.visibility,
      ));
    });

    on<ThumpDrawerHeightThumpEvt>((event, emit) {
      emit(ThumpDrawerState(
        scrollPosition: state.scrollPosition,
        sizeHeightThump: event.sizeHeightThump,
        visibility: state.visibility,
      ));
    });

    on<ThumpDrawerVisibilityThumpEvt>((event, emit) {
      emit(ThumpDrawerState(
        scrollPosition: state.scrollPosition,
        sizeHeightThump: state.sizeHeightThump,
        visibility: event.visibility,
      ));
    });
  }


  void updateSpaceChatScroll(double newSpaceChatScroll) {
    if (newSpaceChatScroll != spaceChatScroll) {
      spaceChatScroll = newSpaceChatScroll;
    }
  }

  void onScroll(ScrollPosition scrollPosition) {
    final double scrollFraction =
        (scrollPosition.pixels / scrollPosition.maxScrollExtent).clamp(0.0, 1.0);

    _setVisibility(false);
    _resetVisibilityTimer();

    if (scrollPosition.pixels < 0) {
      _handleOverscroll(scrollPosition.pixels.abs(), scrollFraction);
    } else if (scrollPosition.pixels > scrollPosition.maxScrollExtent) {
      _handleOverdrag(scrollPosition.pixels - scrollPosition.maxScrollExtent);
    } else {
      _handleNormalScroll(scrollFraction);
    }
  }

  void _handleOverscroll(double overscroll, double scrollFraction) {
    const double sensitivity = 0.8;
    final double newHeight = (state.sizeHeightThumpMax - (overscroll / sensitivity))
        .clamp(state.sizeHeightThumpMin, state.sizeHeightThumpMax);

    add(ThumpDrawerHeightThumpEvt(sizeHeightThump: newHeight));
    add(ThumpDrawerPositionEvt(
      scrollPosition: scrollFraction * (spaceChatScroll - newHeight),
    ));
  }


  void _handleOverdrag(double overdrag) {
    const double sensitivity = 0.8;
    final double newHeight = (state.sizeHeightThumpMax - (overdrag / sensitivity))
        .clamp(state.sizeHeightThumpMin, state.sizeHeightThumpMax);
    add(ThumpDrawerHeightThumpEvt(sizeHeightThump: newHeight));
    add(ThumpDrawerPositionEvt(scrollPosition: spaceChatScroll - newHeight));
  }


  void _handleNormalScroll(double scrollFraction) {
    if (state.sizeHeightThump != state.sizeHeightThumpMax) {
      add(ThumpDrawerHeightThumpEvt(sizeHeightThump: state.sizeHeightThumpMax));
    }
    add(ThumpDrawerPositionEvt(
      scrollPosition: scrollFraction * (spaceChatScroll - state.sizeHeightThump),
    ));
  }


  void _setVisibility(bool visibility) {
    add(ThumpDrawerVisibilityThumpEvt(visibility: visibility));
  }


  void _resetVisibilityTimer() {
    _visibilityTimer?.cancel();
    _visibilityTimer = Timer(const Duration(seconds: 1), () {
      _setVisibility(true);
    });
  }

  @override
  Future<void> close() {
    _visibilityTimer?.cancel();
    return super.close();
  }
}
