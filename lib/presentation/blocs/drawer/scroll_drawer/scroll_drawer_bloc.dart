import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/drawer/animation_loading_drawer/animation_loading_drawer_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/drawer/api_request_drawer/api_request_drawer_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/drawer/thump_drawer/thump_drawer_bloc.dart';
import 'package:flutter_application_alon2/utils/transform_to_range.dart';
part 'scroll_drawer_event.dart';
part 'scroll_drawer_state.dart';

class ScrollDrawerBloc extends Bloc<ScrollDrawerEvent, ScrollDrawerState> {
  final ScrollController scrollController;
  final AnimationLoadingDrawerBloc animationLoadingDrawerBloc;
  final ApiRequestDrawerBloc apiRequestDrawerBloc;
  final ThumpDrawerBloc thumpDrawerBloc;
  bool onceRequest;

  ScrollDrawerBloc(
      {required this.apiRequestDrawerBloc,
      required this.animationLoadingDrawerBloc,
      required this.thumpDrawerBloc})
      : scrollController = ScrollController(),
        onceRequest = false,
        super(const ScrollDrawerInitial()) {
    scrollController.addListener(
      () {
        _onScroll();
        animationLoadingDrawerBloc.onScroll(scrollController.position);
        thumpDrawerBloc.onScroll(scrollController.position);
      },
    );

    on<ScrollDrawerHandle>((event, emit) {
      if (!event.loadChat) onceRequest = false;
      emit(ScrollDrawerState(
          position: event.position, loadChat: event.loadChat));
    });
  }

  //
  void _onScroll() {
    final double pixels = scrollController.position.pixels;
    if (pixels < -state.sizeRangeExpanded && !state.loadChat && !onceRequest) {
      //Load
      onceRequest = true;
      _triggerLoadChat(pixels);
    } else if (pixels < -state.sizeRangeExpanded == false &&
        state.loadChat &&
        (!onceRequest || onceRequest) &&
        !animationLoadingDrawerBloc.state.showLoadingSymbol) {
      //Restart if there is a bug
      add(ScrollDrawerHandle(position: pixels, loadChat: false));
    } else {
      //Just update position
      _updatePosition(pixels);
    }
  }

  //
  void _triggerLoadChat(double pixels) async {
    add(ScrollDrawerHandle(position: pixels, loadChat: true));
    final double velocity = transformToRange(
        pixels.abs(), kToolbarHeight, kToolbarHeight * 1.05, 0.5, 0.85,
        reverseOutput: true);

    animationLoadingDrawerBloc
        .add(const AnimationDrawerFinshLoadEvt(inLoading: true));
    animationLoadingDrawerBloc.add(AnimationDrawerLoadingEvt(
        timeAnimation: 2000,
        showLoadingSymbol: true,
        initIntervalRotation: velocity));

    await Future.delayed(const Duration(milliseconds: 2000));
    apiRequestDrawerBloc.add(ApiRequestDrawerLoadEvent());
  }

  //
  void _updatePosition(double pixels) {
    add(ScrollDrawerHandle(position: pixels, loadChat: state.loadChat));
  }

  //
  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
