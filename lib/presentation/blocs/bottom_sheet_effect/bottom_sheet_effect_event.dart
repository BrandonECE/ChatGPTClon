part of 'bottom_sheet_effect_bloc.dart';

sealed class BottomSheetEffectEvent extends Equatable {
  const BottomSheetEffectEvent();

  @override
  List<Object> get props => [];
}

final class BottomSheetIgnoreEvent extends BottomSheetEffectEvent {
  final bool ignore;
  const BottomSheetIgnoreEvent({required this.ignore});

  @override
  List<Object> get props => [ignore];
}

final class BottomSheetEffectOpacityEvent extends BottomSheetEffectEvent {
  final double opacity;
  const BottomSheetEffectOpacityEvent({required this.opacity});

  @override
  List<Object> get props => [opacity];
}


final class BottomSheetEffectScaleEvent extends BottomSheetEffectEvent {
  final double scale;
  const BottomSheetEffectScaleEvent({required this.scale});

  @override
  List<Object> get props => [scale];
}

