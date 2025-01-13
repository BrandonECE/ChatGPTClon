part of 'layout_drawer_bloc.dart';

sealed class LayoutDrawerEvent extends Equatable {
  const LayoutDrawerEvent();

  @override
  List<Object> get props => [];
}

final class LayoutDrawerExpandedEvent extends LayoutDrawerEvent {
  final bool isFocus;
  const LayoutDrawerExpandedEvent({required this.isFocus});

  @override
  List<Object> get props => [isFocus];
}

final class LayoutDrawerAllowFocusEvent extends LayoutDrawerEvent {
  final bool allowFocusLoss;
  const LayoutDrawerAllowFocusEvent({required this.allowFocusLoss});

  @override
  List<Object> get props => [allowFocusLoss];
}

class LayoutDrawerHiddeFakeEvent extends LayoutDrawerEvent {
  final bool hiddeFakeOption;
  const LayoutDrawerHiddeFakeEvent({required this.hiddeFakeOption});
  @override
  List<Object> get props => [hiddeFakeOption];
}

// class LayoutDrawerHiddeFakeEvent extends LayoutDrawerEvent {
//   final bool hiddeFakeOption;
//   const LayoutDrawerHiddeFakeEvent({required this.hiddeFakeOption});
//   @override
//   List<Object> get props => [hiddeFakeOption];
// }


class LayoutDrawerHiddeOriginalEvent extends LayoutDrawerEvent {
  final bool hiddeOriginalOption;
  const LayoutDrawerHiddeOriginalEvent({required this.hiddeOriginalOption});
  @override
  List<Object> get props => [hiddeOriginalOption];
}
