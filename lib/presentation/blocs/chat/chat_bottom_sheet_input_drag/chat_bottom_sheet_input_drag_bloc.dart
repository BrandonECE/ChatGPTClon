import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/bottom_sheet_effect/bottom_sheet_effect_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_input/chat_input_bloc.dart';
import 'package:flutter_application_alon2/utils/transform_to_range.dart';

part 'chat_bottom_sheet_input_drag_event.dart';
part 'chat_bottom_sheet_input_drag_state.dart';

class ChatBottomSheetInputDragBloc
    extends Bloc<ChatBottomSheetInputDragEvent, ChatBottomSheetInputDragState> {
  double heightBottomSheet = 0;
  final ChatInputBloc chatInputBloc;
  final BottomSheetEffectBloc bottomSheetEffectBloc;
  final double opacityBackgroundBottomSheet;
  final double scaleBackgroundBottomSheetGeneral;

  ChatBottomSheetInputDragBloc(
      {required this.chatInputBloc,
      required this.scaleBackgroundBottomSheetGeneral,
      required this.bottomSheetEffectBloc,
      required this.opacityBackgroundBottomSheet})
      : super(const ChatBottomSheetInputDragInitial()) {
    on<ChatBottomSheetHandleDragUpdateEvent>((event, emit) {
      final double bottomSheetOffset =
          state.bottomSheetOffset + event.details.primaryDelta!;
      bottomSheetOffset.clamp(0, heightBottomSheet);

      if (bottomSheetOffset < heightBottomSheet && bottomSheetOffset > 0) {
        final double opacity = transformToRange(bottomSheetOffset, 0,
            heightBottomSheet, opacityBackgroundBottomSheet, 1);
        final double scale = transformToRange(bottomSheetOffset, 0,
            heightBottomSheet, scaleBackgroundBottomSheetGeneral, 1);
        bottomSheetEffectBloc
            .add(BottomSheetEffectOpacityEvent(opacity: opacity));
        bottomSheetEffectBloc.add(BottomSheetEffectScaleEvent(scale: scale));
        emit(ChatBottomSheetInputDragState(
            bottomSheetOffset:
                state.bottomSheetOffset + event.details.primaryDelta!));
      }
    });

    on<ChatBottomSheetHandleHandleDragEndEvent>((event, emit) {
      if (event.details.velocity.pixelsPerSecond.dy > 0) {
        chatInputBloc
            .add(const ChatShowBottomSheetEvent(showBottomSheet: false));
        bottomSheetEffectBloc
            .add(const BottomSheetEffectOpacityEvent(opacity: 1));
        bottomSheetEffectBloc.add(const BottomSheetIgnoreEvent(ignore: false));
        bottomSheetEffectBloc.add(const BottomSheetEffectScaleEvent(scale: 1));
        chatInputBloc.showBottomSheet(false);
      } else {
        bottomSheetEffectBloc.add(BottomSheetEffectScaleEvent(
            scale: scaleBackgroundBottomSheetGeneral));
        bottomSheetEffectBloc.add(BottomSheetEffectOpacityEvent(
            opacity: opacityBackgroundBottomSheet));
      }

      emit(const ChatBottomSheetInputDragState(bottomSheetOffset: 0));
    });
  }

  void updateHeightBottomSheet(double newHeightBottomSheet) {
    if (heightBottomSheet == 0) {
      heightBottomSheet = newHeightBottomSheet;
    }
  }
}
