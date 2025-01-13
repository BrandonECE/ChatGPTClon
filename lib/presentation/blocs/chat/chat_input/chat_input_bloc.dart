import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/bottom_sheet_effect/bottom_sheet_effect_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_input_thump/chat_input_thump_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_messages_thump/chat_messages_thump_bloc.dart';
import 'package:meta/meta.dart';

part 'chat_input_event.dart';
part 'chat_input_state.dart';

class ChatInputBloc extends Bloc<ChatInputEvent, ChatInputState> {
  // Dependencies
  final ChatInputThumpBloc chatInputThumpBloc;
  final BottomSheetEffectBloc bottomSheetEffectBloc;
  final ChatMessagesThumpBloc chatMessagesThumpBloc;

  // Focus and input management
  final FocusNode focusNodeReal = FocusNode();
  final FocusNode focusNodeBottomSheet = FocusNode();
  final TextEditingController textEditingController = TextEditingController();

  // Configuration constants
  final double opacityBackgroundBottomSheet;
  final double scaleBackgroundBottomSheetGeneral;
  final int maxLinesToShowExpandednIcon = 3;
  final int maxLinesToScrollInput = 9;

  // State management
  double heightAllContainerInput = 0;
  double heightWidgetInputBase = 0;
  double heightTextFieldFakeBase = 0;
  double heightTextFieldFocusBase = 0;
  bool inputWasInFocus = false;

  ChatInputBloc({
    required this.chatMessagesThumpBloc,
    required this.bottomSheetEffectBloc,
    required this.opacityBackgroundBottomSheet,
    required this.scaleBackgroundBottomSheetGeneral,
    required this.chatInputThumpBloc,
  }) : super(const ChatInputInitial()) {
    _initAddListeners();
    _initStartFocus();

    on<ChangeInputValueEvent>((event, emit) {
      emit(state.copyWith(isInputEmpty: event.text.trim().isEmpty));
    });

    on<ChatFocusInputEvent>((event, emit) {
      emit(state.copyWith(isFocus: event.isFocus));
    });

    on<ChatCalSizeContainerInputEvent>((event, emit) {
      emit(state.copyWith(sizeContainerInput: event.sizeContainerInput));
    });

    on<ChatExpandedEnabledOptionEvent>((event, emit) {
      emit(state.copyWith(
          hiddeChatExpandedEnabledOption:
              event.hiddeChatExpandedEnabledOption));
    });

    on<ChatShowBottomSheetEvent>((event, emit) {
      emit(state.copyWith(showBottomSheet: event.showBottomSheet));
    });

    on<ChatSetMaxHeightConstraintEvent>((event, emit) {
      emit(state.copyWith(
          sizeMaxHeightSingleChildScrollView:
              event.sizeMaxHeightSingleChildScrollView));
    });

    on<ChatSetSizeContainerInputMinEvent>((event, emit) {
      emit(state.copyWith(
          setSizeContainerInputMin: event.setSizeContainerInputMin));
    });
  }

  void _initAddListeners() {
    focusNodeReal.addListener(_listenerFocusNodeReal);
    textEditingController.addListener(_listenerTextController);
  }

  void _initStartFocus() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        requestFocusForInputFocus();
        chatMessagesThumpBloc.scrollControllerJumpToBottom();
      },
    );
  }

  void showBottomSheet(bool show) {
    _inputFocusHandle(show);
    _bottomSheetHandle(show);
  }

  void buttonSendHandle() {
    inputWasInFocus = false;
    _bottomSheetHandle(false);
  }

  void _bottomSheetHandle(bool show) {
    add(ChatShowBottomSheetEvent(showBottomSheet: show));
    bottomSheetEffectBloc
      ..add(BottomSheetIgnoreEvent(ignore: show))
      ..add(BottomSheetEffectOpacityEvent(
          opacity: show ? opacityBackgroundBottomSheet : 1))
      ..add(BottomSheetEffectScaleEvent(
          scale: show ? scaleBackgroundBottomSheetGeneral : 1));
  }

  void _inputFocusHandle(bool show) {
    final bool isInputFocus = focusNodeReal.hasFocus;
    if (show) {
      inputWasInFocus = isInputFocus;
      unFocusForInputFocus();
    } else {
      focusNodeBottomSheet.unfocus();
    }

    if (inputWasInFocus && !show) {
      inputWasInFocus = !inputWasInFocus;
      requestFocusForInputFocus();
    }
  }

  void setHeightAllContainerInputValue(double newHeight) {
    //1
    if (heightAllContainerInput != newHeight) {
      heightAllContainerInput = newHeight;
      chatMessagesThumpBloc.initScrollControllerAnimatedToBottom();
    }
  }

  void setHeightInputValue(double newHeight) {
    //2
    if (heightWidgetInputBase == 0) heightWidgetInputBase = newHeight;
  }

  void setheightTextFieldFocusBase(double newHeight) {
    //3
    if (heightTextFieldFocusBase == 0) heightTextFieldFocusBase = newHeight;
  }

  void setheightTextFieldFakeBase(double newHeight) {
    //4
    if (heightTextFieldFakeBase == 0) heightTextFieldFakeBase = newHeight;
    _inputHandle();
  }

  void _inputHandle() {
    final double sizeHeightToEnabledExpandedOption =
        _getSizeHeightBasedOnNumLines(maxLinesToShowExpandednIcon);

    final double sizeMaxHeightConstraintToScroll =
        _getSizeMaxHeightConstraintToScrollBasedOnNumLine(
            maxLinesToScrollInput);

    _sizeHeightScrollHandle(sizeMaxHeightConstraintToScroll);
    _chatExpandedEnabledOption(sizeHeightToEnabledExpandedOption);
  }

  void _sizeHeightScrollHandle(double sizeHeight) {
    chatInputThumpBloc.updateScrollSpaceAvailableToScroll(sizeHeight);
    _hiddeThumpCauseTheresNoScroll(sizeHeight);
    add(ChatSetMaxHeightConstraintEvent(
        sizeMaxHeightSingleChildScrollView: sizeHeight));
  }

  void _hiddeThumpCauseTheresNoScroll(double sizeMaxHeightConstraintToScroll) {
    final double sizeHeightConstraint = (sizeMaxHeightConstraintToScroll +
        heightWidgetInputBase +
        (heightTextFieldFocusBase - heightTextFieldFakeBase));
    final bool hiddeThumpCondition =
        sizeHeightConstraint != (state.sizeContainerInput.height);
    chatInputThumpBloc.hiddeThumpCauseTheresNoScroll(hiddeThumpCondition);
  }

  void _chatExpandedEnabledOption(double sizeHeightToEnabledExpandedOption) {
    final bool conditionToEnabledExpandedOption =
        (state.sizeContainerInput.height) < (sizeHeightToEnabledExpandedOption);
    add(ChatExpandedEnabledOptionEvent(
        hiddeChatExpandedEnabledOption: conditionToEnabledExpandedOption));
  }

  void _listenerTextController() {
    // chatInputThumpBloc.cancelVisibilityThump();
    add(ChangeInputValueEvent(text: textEditingController.text));
  }

  void _listenerFocusNodeReal() {
    final hasFocus = focusNodeReal.hasFocus;
    if (hasFocus) {
      add(const ChatSetSizeContainerInputMinEvent(
          setSizeContainerInputMin: false));
      chatMessagesThumpBloc.initScrollControllerAnimatedToBottom();
    }
    if (hasFocus != state.isFocus) {
      add(ChatFocusInputEvent(isFocus: hasFocus));
    }
  }

  void requestFocusForInputFocus() => focusNodeReal.requestFocus();

  void unFocusForInputFocus() => focusNodeReal.unfocus();

  double _getSizeMaxHeightConstraintToScrollBasedOnNumLine(int numLines) {
    numLines = numLines <= 0 ? 1 : numLines;
    return (heightTextFieldFocusBase) +
        (heightTextFieldFakeBase * (numLines - 1) -
            (heightTextFieldFocusBase - heightTextFieldFakeBase));
  }

  double _getSizeHeightBasedOnNumLines(int numLines) {
    numLines = numLines <= 0 ? 1 : numLines;
    return (heightWidgetInputBase + heightTextFieldFocusBase) +
        (heightTextFieldFakeBase * (numLines - 1));
  }

  @override
  Future<void> close() {
    textEditingController.dispose();
    focusNodeReal.dispose();
    focusNodeBottomSheet.dispose();
    return super.close();
  }
}
