part of 'app_structure_bloc.dart';

class AppStructureState extends Equatable {
  final double drawerOffset;
  final bool isDrawerOpen;

  const AppStructureState(
      {required this.drawerOffset, required this.isDrawerOpen});

  @override
  List<Object> get props => [drawerOffset, isDrawerOpen];
}

final class AppStructureInitial extends AppStructureState {
  const AppStructureInitial() : super(drawerOffset: 0, isDrawerOpen: false);
}
