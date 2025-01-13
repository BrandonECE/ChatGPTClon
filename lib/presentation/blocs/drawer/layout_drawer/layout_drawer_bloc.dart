import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'layout_drawer_event.dart';
part 'layout_drawer_state.dart';

class LayoutDrawerBloc extends Bloc<LayoutDrawerEvent, LayoutDrawerState> {
  final FocusNode focusNode;
  LayoutDrawerBloc()
      : focusNode = FocusNode(),
        super(const LayoutDrawerInitial()) {
    focusNode.addListener(_onFocusNode);

  
    on<LayoutDrawerHiddeOriginalEvent>((event, emit) {
      emit(LayoutDrawerState(
          isFocus: state.isFocus, allowFocusLoss: state.allowFocusLoss, hiddeFakeOption: state.hiddeFakeOption, hiddeOriginalOption: event.hiddeOriginalOption));
    });

     on<LayoutDrawerHiddeFakeEvent>((event, emit) {
      emit(LayoutDrawerState(
          isFocus: state.isFocus, allowFocusLoss: state.allowFocusLoss, hiddeFakeOption: event.hiddeFakeOption, hiddeOriginalOption:state.hiddeOriginalOption));
    });

    on<LayoutDrawerExpandedEvent>((event, emit) {
      emit(LayoutDrawerState(
          isFocus: event.isFocus, allowFocusLoss: state.allowFocusLoss, hiddeFakeOption: state.hiddeFakeOption, hiddeOriginalOption: state.hiddeOriginalOption));
    });

    on<LayoutDrawerAllowFocusEvent>((event, emit) {
      emit(LayoutDrawerState(isFocus: state.isFocus, allowFocusLoss: event.allowFocusLoss, hiddeFakeOption: state.hiddeFakeOption, hiddeOriginalOption: state.hiddeOriginalOption));
      focusNode.unfocus();
    });


  }

  void _onFocusNode() {
    if (!state.allowFocusLoss) {
      focusNode.requestFocus();
      add(const LayoutDrawerExpandedEvent(isFocus: true));
      add(const LayoutDrawerHiddeOriginalEvent(hiddeOriginalOption: true));
      add(const LayoutDrawerHiddeFakeEvent(hiddeFakeOption: false));
    } else {
      add(const LayoutDrawerExpandedEvent(isFocus: false));
      add(const LayoutDrawerAllowFocusEvent(allowFocusLoss: false));
    }
  }

  @override
  Future<void> close() {
    focusNode.removeListener(_onFocusNode);
    focusNode.dispose();
    return super.close();
  }
}
