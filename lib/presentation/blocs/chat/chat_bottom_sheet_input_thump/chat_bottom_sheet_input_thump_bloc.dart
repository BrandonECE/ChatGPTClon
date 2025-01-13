import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'chat_bottom_sheet_input_thump_event.dart';
part 'chat_bottom_sheet_input_thump_state.dart';

class ChatBottomSheetInputThumpBloc extends Bloc<ChatBottomSheetInputThumpEvent,
    ChatBottomSheetInputThumpState> {
  final ScrollController scrollController;
  double scrollSpaceAvailable;
  bool cancelVisibility = false;
  Timer? _visibilityTimer;
  ChatBottomSheetInputThumpBloc({required this.scrollSpaceAvailable})
      : scrollController = ScrollController(),
        super(const ChatBottomSheetInputThumpInitial()) {
    scrollController.addListener(_scrollControllerListener);

    on<BottomSheetUpdatePositionSrollThumpEvent>((event, emit) {
      emit(ChatBottomSheetInputThumpState(
          position: event.position,
          sizeHeightThumpDynamic: state.sizeHeightThumpDynamic,
          visibility: state.visibility));
    });

    on<BottomSheetUpdateSizeThumpEvent>((event, emit) {
      emit(ChatBottomSheetInputThumpState(
          position: state.position,
          sizeHeightThumpDynamic: event.sizeThump,
          visibility: state.visibility));
    });

    on<BottomSheetUpdateVisibilityEvent>((event, emit) {
      emit(ChatBottomSheetInputThumpState(
          position: state.position,
          sizeHeightThumpDynamic: state.sizeHeightThumpDynamic,
          visibility: event.visibility));
    });
  }

  void _scrollControllerListener() {
    final double maxScrollExtent = scrollController.position.maxScrollExtent;
    final double positionOriginal = scrollController.position.pixels;
    final double fractionPosition =
        (positionOriginal / maxScrollExtent).clamp(0, 1);

    ((positionOriginal / maxScrollExtent) * scrollSpaceAvailable)
        .clamp(0, scrollSpaceAvailable);

    if(cancelVisibility){
      _setVisibility(false);
      _resetVisibilityTimer();
    }

    if (positionOriginal < 0) {
      _handleOverscroll(positionOriginal.abs(), fractionPosition);
    } else if (positionOriginal > maxScrollExtent) {
      _handleOverdrag(positionOriginal, maxScrollExtent, fractionPosition);
    } else {
      _updatePosition(fractionPosition *
          (scrollSpaceAvailable - state.maxSizeHeightThumpDynamic));
    }
  }

  void _setVisibility(bool visibility) {
    add(BottomSheetUpdateVisibilityEvent(visibility: visibility));
  }

  void _resetVisibilityTimer() {
    _visibilityTimer?.cancel();
    _visibilityTimer = Timer(const Duration(seconds: 1), () {
      _setVisibility(true);
      updateCancelVisibility(false);
    });
  }

    void updateCancelVisibility(bool newValueCancelVisibility) {
    cancelVisibility = newValueCancelVisibility;
  }

  void _handleOverdrag(double positionOriginal, double maxScrollExtent,
      double fractionPosition) {
    const double sensitivity = 0.8;
    final double newSizeThump = (state.maxSizeHeightThumpDynamic -
            ((positionOriginal - maxScrollExtent) / sensitivity))
        .clamp(
            state.minSizeHeightThumpDynamic, state.maxSizeHeightThumpDynamic);
    _updatePosition(fractionPosition * (scrollSpaceAvailable - newSizeThump));
    add(BottomSheetUpdateSizeThumpEvent(sizeThump: newSizeThump));
  }

  void _handleOverscroll(double positionOriginal, double fractionPosition) {
    const double sensitivity = 0.8;

    final double newSizeThump = (state.maxSizeHeightThumpDynamic -
            (positionOriginal / sensitivity))
        .clamp(
            state.minSizeHeightThumpDynamic, state.maxSizeHeightThumpDynamic);

    _updatePosition(fractionPosition * (scrollSpaceAvailable - newSizeThump));
    add(BottomSheetUpdateSizeThumpEvent(sizeThump: newSizeThump));
  }

  void _updatePosition(double adjustedPosition) {
    add(BottomSheetUpdateSizeThumpEvent(
        sizeThump: state.maxSizeHeightThumpDynamic));
    add(BottomSheetUpdatePositionSrollThumpEvent(position: adjustedPosition));
  }

  void updateHeightSpaceBottomSheetScroll(double newScrollSpaceAvailable) {
    scrollSpaceAvailable = newScrollSpaceAvailable;
  }

    @override
    Future<void> close() {
      scrollController.dispose();
      _visibilityTimer?.cancel();
      return super.close();
}

}
