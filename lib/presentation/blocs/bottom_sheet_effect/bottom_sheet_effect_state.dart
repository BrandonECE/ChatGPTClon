part of 'bottom_sheet_effect_bloc.dart';

 class BottomSheetEffectState extends Equatable {
  final double opacity;
  final double scale;
  final bool ignore;
  const BottomSheetEffectState(
      {required this.opacity, required this.scale, required this.ignore});

  @override
  List<Object> get props => [opacity, scale, ignore];
}

final class BottomSheetEffectInitial extends BottomSheetEffectState {
  const BottomSheetEffectInitial() : super(opacity: 1, scale: 1, ignore: false);
}
