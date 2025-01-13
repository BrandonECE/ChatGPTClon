import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/drawer/layout_drawer/layout_drawer_bloc.dart';

part 'app_structure_event.dart';
part 'app_structure_state.dart';

class AppStructureBloc extends Bloc<AppStructureEvent, AppStructureState> {
  final LayoutDrawerBloc layoutDrawerBloc;
  AppStructureBloc({required this.layoutDrawerBloc})
      : super(const AppStructureInitial()) {
    on<ToggleDrawer>((event, emit) {

      if (!layoutDrawerBloc.state.isFocus) {
        final bool isDrawerOpen = !state.isDrawerOpen;
        final double drawerOffset = isDrawerOpen ? event.drawerWidth : 0;
        if(isDrawerOpen) FocusScope.of(event.context).unfocus();
        emit(AppStructureState( isDrawerOpen: isDrawerOpen, drawerOffset: drawerOffset));
      }
    });

    on<HandleDragUpdate>((event, emit) {
      final double drawerOffset = state.drawerOffset + event.details.primaryDelta!;
      drawerOffset.clamp(0, event.drawerWidth);

      if (drawerOffset <= event.drawerWidth && drawerOffset >= 0) {
        emit(AppStructureState(drawerOffset: drawerOffset, isDrawerOpen: state.isDrawerOpen));
      }
    });

    on<HandleDragEnd>((event, emit) {

      layoutDrawerBloc .add(const LayoutDrawerAllowFocusEvent(allowFocusLoss: true));

      double drawerOffset = state.drawerOffset;
      bool isDrawerOpen = state.isDrawerOpen;

      if (event.details.velocity.pixelsPerSecond.dx > 0) {
        FocusScope.of(event.context).unfocus();
        drawerOffset = event.drawerWidth;
        isDrawerOpen = true;
      } else {
        drawerOffset = 0;
        isDrawerOpen = false;
      }

      emit(AppStructureState(
          isDrawerOpen: isDrawerOpen, drawerOffset: drawerOffset));
    });
  }
}
