import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_messages/chat_messages_bloc.dart';

part 'chat_messages_thump_event.dart';
part 'chat_messages_thump_state.dart';

class ChatMessagesThumpBloc
    extends Bloc<ChatMessagesThumpEvent, ChatMessagesThumpState> {
  final ScrollController scrollController = ScrollController();

  final ChatMessagesBloc chatMessagesBloc;

  double maxScrollExentConstant = 0;

  // double inputSizeHeightValue = 0;
  bool overDragIsStartingToReturn = false;
  bool isNotOverDragReturnCancelled = false;
  bool cancelVisibilityThump = false;
  bool cancelVisibilityThumpByUserInteraction = true;
  bool isUserInteractionStarted = true;
  bool isUserInteractionEnd = false;
  double _previousNumberToCutCancelVisibility = 0;

  Timer? timerToVisibility;
  Timer? timerToCancelVisibility;

  ChatMessagesThumpBloc({required this.chatMessagesBloc})
      : super(const ChatMessagesThumpInitial()) {
    scrollController.addListener(_scrollListener);

    on<ChatMessagesThumpUpdatePositionEvent>((event, emit) {
      emit(state.copyWith(thumpPosition: event.thumpPosition));
    });

    on<ChatMessagesThumpUpdateSizeThumpEvent>((event, emit) {
      emit(state.copyWith(sizeHeightThumpDynamic: event.sizeThump));
    });

    on<ChatMessagesThumpUpdateSizeSpaceAvailableEvent>((event, emit) {
      emit(state.copyWith(scrollSpaceAvailable: event.sizeSpaceAvailable));
    });

    on<ChatMessagesThumpUpdateAnimatedPositionedEvent>((event, emit) {
      emit(state.copyWith(isAnimatedPositioned: event.isAnimatedPositioned));
    });

    on<ChatMessagesThumpShowButtonReturnToButtonChatEvent>((event, emit) {
      emit(state.copyWith(
          showButtonReturnToBottomChat: event.showButtonReturnToBottomChat));
    });

    on<ChatMessagesHiddeThumpEvent>((event, emit) {
      emit(state.copyWith(isVisibleThump: event.isVisibleThump));
    });
  }

  //FUNCTION
  void scrollControllerJumpToBottom() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      },
    );
  }

  //FUNCTION
  void initScrollControllerAnimatedToBottom() {
    cancelVisibilityThump = true;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        scrollController.animateTo(
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
            scrollController.position.maxScrollExtent);
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            _ensureScrollJumpToBottom();
          },
        );
      },
    );
  }

  //FUNCTION
  void buttonReturnToBottomChat() {
    cancelVisibilityThump = true;
    scrollController.animateTo(
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
        scrollController.position.maxScrollExtent);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _ensureScrollJumpToBottom();
      },
    );
  }

  //FUNCTION
  void _ensureScrollJumpToBottom() {
    // print("ASEGURANDOME");
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (scrollController.position.pixels <
            scrollController.position.maxScrollExtent) {
          _ensureScrollJumpToBottom();
        }
      },
    );
  }

  //FUNCTION
  void _scrollListener() {
    final double position = scrollController.position.pixels;
    final double maxScrollExtent =
        _calculateMaxScrollExtent(scrollController.position.maxScrollExtent);

    if (maxScrollExtent > 0) {
      // print("POSITION: $position | MAXSCROLL: ${maxScrollExtent}");

      final double fraction =
          (position.clamp(0, maxScrollExtent) / maxScrollExtent).clamp(0, 1);
      const double sensibility = 0.8;

      if (position < 0 &&
          !state.isAnimatedPositioned &&
          !cancelVisibilityThump) {
        _handleOverScroll(position, fraction, sensibility);
      } else if (position > maxScrollExtent &&
          !state.isAnimatedPositioned &&
          !cancelVisibilityThump) {
        _handleOverDrag(position, maxScrollExtent, sensibility);
      } else {
        add(ChatMessagesThumpUpdateSizeThumpEvent(
            sizeThump: state.sizeMaxHeightThumpDynamic));
        _updatePosition(fraction *
            (state.scrollSpaceAvailable - state.sizeMaxHeightThumpDynamic));
      }

      _visibilityHandle(position, scrollController.position.maxScrollExtent);
      _showButtonReturnBottomHandle(
          position, scrollController.position.maxScrollExtent);
    } else {
      add(const ChatMessagesThumpShowButtonReturnToButtonChatEvent(
          showButtonReturnToBottomChat: true));
    }
  }

  //FUNCTION
  void _visibilityHandle(double position, double maxScrollExtent) {
    //LOCALFunction
    void setVisibilityHandle() {
      _setVisibility(true);
      _resetVisibilityTimer();
    }

    //LOCALFunction
    bool isGreaterThanPrevious(double currentNumber) {
      bool isGreater = currentNumber > _previousNumberToCutCancelVisibility;
      _previousNumberToCutCancelVisibility = currentNumber;
      return isGreater;
    }

    //LOCALFunction
    void resetVariables() {
      // setCancelVisibilityThumpByUserInteraction(true);

      cancelVisibilityThump = false;
      overDragIsStartingToReturn = false;
      isNotOverDragReturnCancelled = false;
      _previousNumberToCutCancelVisibility = 0;
    }

    //LOCALFunction
    void thumpReturnToBottomDetectWhenItsOver() {
      final bool isGreater = isGreaterThanPrevious(position);
      if (isGreater && !isNotOverDragReturnCancelled) {
        // print("ESTA EMPEZANDO EL INICIO DEL OVER DRAG");
        isNotOverDragReturnCancelled = true;
        overDragIsStartingToReturn = true;
      } else if (isGreater && isNotOverDragReturnCancelled) {
        // print("CANCELACION DEL OVER DRAG / CUT");
        resetVariables();
      }
    }

    //BODY
    if (!cancelVisibilityThump) {
      if (!cancelVisibilityThumpByUserInteraction) {
        setVisibilityHandle();
      }
    } else {
      if (position >= maxScrollExtent) {
        // print("POSICION MAS GRANDE QUE MAXSCROLL");
        thumpReturnToBottomDetectWhenItsOver();
      } else if (overDragIsStartingToReturn && isNotOverDragReturnCancelled) {
        resetVariables();
      }
    }
  }

  void setCancelVisibilityThumpByUserInteraction(bool cancel) {
    cancelVisibilityThumpByUserInteraction = cancel;
  }

  void setIsUserInteractionStarted(bool isStarted) {
    isUserInteractionStarted = isStarted;
  }

  void setIsUserInteractionEnd(bool isEnd) {
    isUserInteractionEnd = isEnd;
  }

  //FUNCTION
  void _resetVisibilityTimer() {
    timerToVisibility?.cancel();
    timerToVisibility = Timer(const Duration(seconds: 1), () {
      _setVisibility(false);
      setCancelVisibilityThumpByUserInteraction(true);
    });
  }

  //FUNCTION
  void _setVisibility(bool isVisible) {
    add(ChatMessagesHiddeThumpEvent(isVisibleThump: isVisible));
  }

  //FUNCTION
  void _handleOverDrag(
      double position, double maxScrollExtent, double sensibility) {
    final double newSizeThump = (state.sizeMaxHeightThumpDynamic -
            ((position - maxScrollExtent) / sensibility))
        .clamp(
            state.sizeMinHeightThumpDynamic, state.sizeMaxHeightThumpDynamic);
    add(ChatMessagesThumpUpdateSizeThumpEvent(sizeThump: newSizeThump));
    _updatePosition(state.scrollSpaceAvailable - newSizeThump);
  }

  //FUNCTION
  void _handleOverScroll(double position, double fraction, double sensibility) {
    final double newSizeThump = (state.sizeMaxHeightThumpDynamic -
            (position.abs() / sensibility))
        .clamp(
            state.sizeMinHeightThumpDynamic, state.sizeMaxHeightThumpDynamic);
    add(ChatMessagesThumpUpdateSizeThumpEvent(sizeThump: newSizeThump));
    _updatePosition(fraction * (state.scrollSpaceAvailable - newSizeThump));
  }

  //FUNCTION
  void _updatePosition(double newPosition) {
    add(ChatMessagesThumpUpdatePositionEvent(thumpPosition: newPosition));
  }

  //FUNCTION
  void updateSpaceAvailable(double newSpaceAvailable) {
    if (state.scrollSpaceAvailable != newSpaceAvailable) {
      add(ChatMessagesThumpUpdateSizeSpaceAvailableEvent(
          sizeSpaceAvailable: newSpaceAvailable));
      add(const ChatMessagesThumpUpdateAnimatedPositionedEvent(
          isAnimatedPositioned: true));
      scrollControllerJumpToBottom();
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          _scrollListener();
          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
              add(const ChatMessagesThumpUpdateAnimatedPositionedEvent(
                  isAnimatedPositioned: false));
            },
          );
        },
      );
    }
  }

  //FUNCTION
  void _showButtonReturnBottomHandle(double position, double maxScrollExtent) {
    print("position ($position) >= maxScrollExtent ($maxScrollExtent)");
    final bool conditionShowButton = position >= maxScrollExtent;
    add(ChatMessagesThumpShowButtonReturnToButtonChatEvent(
        showButtonReturnToBottomChat: conditionShowButton));
  }

  //FUNCTION
  double _calculateMaxScrollExtent(double newMaxScrollExent) {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent ||
        maxScrollExentConstant == 0) {
      maxScrollExentConstant = newMaxScrollExent;
      return maxScrollExentConstant;
    }
    return maxScrollExentConstant;
  }

  // //FUNCTION
  // void detectChangesSizeInput(double sizeHeightInput) {
  //   if (sizeHeightInput != inputSizeHeightValue) {
  //     inputSizeHeightValue = sizeHeightInput;
  //   }
  // }

  // //FUNCTION
  // void resetChangesSizeInput() {
  //   detectChangeSizeInput = false;
  // }

  @override
  Future<void> close() {
    timerToVisibility?.cancel();
    timerToCancelVisibility?.cancel();
    scrollController.dispose();
    return super.close();
  }
}
