import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'chat_input_thump_event.dart';
part 'chat_input_thump_state.dart';

class ChatInputThumpBloc
    extends Bloc<ChatInputThumpEvent, ChatInputThumpState> {
  final ScrollController scrollController;

  bool cancelVisibility = false;
  double maxScrollExtentToCompare = 0;
  double scrollSpaceAvailable;
  Timer? timerToVisibility;
  ChatInputThumpBloc({required this.scrollSpaceAvailable})
      : scrollController = ScrollController(),
        super(const ChatInputThumpInitial()) {
    scrollController.addListener(_scrollListener);

    on<ChatInputThumpUpdatePositionEvent>((event, emit) {
      emit(ChatInputThumpState(
          hiddeThumpByScroll: state.hiddeThumpByScroll,
          position: event.position,
          sizeThumpDynamic: state.sizeThumpDynamic,
          thumpVisibility: state.thumpVisibility));
    });

    on<ChatInputThumpUpdateSizeThumpEvent>((event, emit) {
      emit(ChatInputThumpState(
          hiddeThumpByScroll: state.hiddeThumpByScroll,
          position: state.position,
          sizeThumpDynamic: event.sizeThump,
          thumpVisibility: state.thumpVisibility));
    });

    on<ChatInputThumpUpdateVisbilityThumpEvent>((event, emit) {
      emit(ChatInputThumpState(
          hiddeThumpByScroll: state.hiddeThumpByScroll,
          position: state.position,
          sizeThumpDynamic: state.sizeThumpDynamic,
          thumpVisibility: event.thumpVisibility));
    });

    on<ChatInputHiddeThumpByScrollThumpEvent>((event, emit) {
      emit(ChatInputThumpState(
          hiddeThumpByScroll: event.hiddeThump,
          position: state.position,
          sizeThumpDynamic: state.sizeThumpDynamic,
          thumpVisibility: state.thumpVisibility));
    });
  }

  void hiddeThumpCauseTheresNoScroll(bool hiddeThump) {
    if (hiddeThump != state.hiddeThumpByScroll) {
      add(ChatInputHiddeThumpByScrollThumpEvent(hiddeThump: hiddeThump));
    }
  }

  void _scrollListener() {
    final double position = scrollController.position.pixels;
    final double maxScrollExtent = scrollController.position.maxScrollExtent;
    final double fraction =
        (position.clamp(0, maxScrollExtent) / maxScrollExtent).clamp(0, 1);
    const double sensibility = 0.8;

    if (maxScrollExtentToCompare == 0) {
      maxScrollExtentToCompare = maxScrollExtent;
    }

    // cancelVisibilityThump();

    // if (position == maxScrollExtent) {
    //   print("ACTUALIZACION");
    // }

    if (cancelVisibility) {
      _setVisibility(false);
      _resetVisibilityTimer();
    }

    if (position < 0) {
      _handleOverScroll(position, sensibility, fraction);
    } else if (position > maxScrollExtent) {
      _handleOverDrag(position, maxScrollExtent, sensibility);
    } else {
      add(ChatInputThumpUpdateSizeThumpEvent(sizeThump: state.sizeThumpMax));
      _updatePosition(
          fraction * (scrollSpaceAvailable - state.sizeThumpDynamic));
    }
  }

  void _resetVisibilityTimer() {
    timerToVisibility?.cancel();
    timerToVisibility = Timer(const Duration(seconds: 1), () {
      _setVisibility(true);
      updateCancelVisibility(false);
    });
  }

  void _setVisibility(bool isVisible) {
    add(ChatInputThumpUpdateVisbilityThumpEvent(thumpVisibility: isVisible));
  }

  void updateCancelVisibility(bool newValueCancelVisibility) {
    cancelVisibility = newValueCancelVisibility;
  }

  void _handleOverDrag(
      double position, double maxScrollExtent, double sensibility) {
    final double newSizeThump =
        (state.sizeThumpMax - ((position - maxScrollExtent) / sensibility))
            .clamp(state.sizeThumpMin, state.sizeThumpMax);
    add(ChatInputThumpUpdateSizeThumpEvent(sizeThump: newSizeThump));
    _updatePosition(scrollSpaceAvailable - newSizeThump);
  }

  void _handleOverScroll(double position, double sensibility, double fraction) {
    final double newSizeThump =
        (state.sizeThumpMax - (position.abs() / sensibility))
            .clamp(state.sizeThumpMin, state.sizeThumpMax);
    add(ChatInputThumpUpdateSizeThumpEvent(sizeThump: newSizeThump));
    _updatePosition(fraction * (scrollSpaceAvailable - state.sizeThumpDynamic));
  }

  void _updatePosition(double position) {
    add(ChatInputThumpUpdatePositionEvent(position: position));
  }

  void updateScrollSpaceAvailableToScroll(double newScrollSpaceAvailable) {
    if (newScrollSpaceAvailable != scrollSpaceAvailable) {
      scrollSpaceAvailable = newScrollSpaceAvailable;
    }
  }

  void cancelVisibilityThump() {
    if (maxScrollExtentToCompare != scrollController.position.maxScrollExtent) {
      maxScrollExtentToCompare = scrollController.position.maxScrollExtent;
      print(
          "CAMBI2O | MAXSCROLL: ${maxScrollExtentToCompare} | POSITION: ${scrollController.position.pixels}");
      scrollController.jumpTo(scrollController.position.pixels + 27);
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          print(
              "CAMBI2O | MAXSCROLL: ${maxScrollExtentToCompare} | POSITION: ${scrollController.position.pixels}");
        },
      );
    }
  }

  @override
  Future<void> close() {
    timerToVisibility?.cancel();
    scrollController.dispose();
    return super.close();
  }
}
