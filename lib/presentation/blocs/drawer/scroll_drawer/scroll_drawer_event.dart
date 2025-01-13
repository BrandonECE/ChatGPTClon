part of 'scroll_drawer_bloc.dart';

sealed class ScrollDrawerEvent extends Equatable {
  const ScrollDrawerEvent();
}

final class ScrollDrawerHandle extends ScrollDrawerEvent {
  final double position;
  final bool loadChat;
  const ScrollDrawerHandle({required this.position, required this.loadChat});
  @override
  List<Object> get props => [position, loadChat];
}

final class ScrollDrawerUpdatePosition extends ScrollDrawerEvent {
  final double position;
  final bool loadChat;
  const ScrollDrawerUpdatePosition(
      {required this.position, required this.loadChat});
  @override
  List<Object> get props => [position, loadChat];
}
