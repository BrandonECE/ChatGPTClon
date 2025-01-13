import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_sheet_effect_event.dart';
part 'bottom_sheet_effect_state.dart';

class BottomSheetEffectBloc extends Bloc<BottomSheetEffectEvent, BottomSheetEffectState> {
  BottomSheetEffectBloc() : super(const BottomSheetEffectInitial()) {
    on<BottomSheetIgnoreEvent>((event, emit) {
      emit(BottomSheetEffectState(opacity: state.opacity, scale: state.scale, ignore: event.ignore));
    });

    on<BottomSheetEffectOpacityEvent>((event, emit) {
      emit(BottomSheetEffectState(opacity: event.opacity, scale: state.scale, ignore: state.ignore));
    });

    on<BottomSheetEffectScaleEvent>((event, emit) {
      emit(BottomSheetEffectState(opacity: state.opacity, scale: event.scale, ignore: state.ignore));
    });
    
  }
}
