part of 'app_structure_bloc.dart';

sealed class AppStructureEvent extends Equatable {
  const AppStructureEvent();
  @override
  List<Object> get props => [];
}

final class ToggleDrawer extends AppStructureEvent {
  final BuildContext context;
  final double drawerWidth;
  const ToggleDrawer({required this.drawerWidth, required this.context});

  @override
  List<Object> get props => [drawerWidth, context];
}

final class HandleDragUpdate extends AppStructureEvent {
  final double drawerWidth;
  final DragUpdateDetails details;
  const HandleDragUpdate({required this.drawerWidth, required this.details});

  @override
  List<Object> get props => [drawerWidth, details];
}

final class HandleDragEnd extends AppStructureEvent {
  final BuildContext context;
  final double drawerWidth;
  final DragEndDetails details;
  const HandleDragEnd({required this.drawerWidth, required this.details, required this.context});

  @override
  List<Object> get props => [drawerWidth, details, context];
}
