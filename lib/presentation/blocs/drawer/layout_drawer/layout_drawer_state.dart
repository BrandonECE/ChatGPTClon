part of 'layout_drawer_bloc.dart';

class LayoutDrawerState extends Equatable {
  final bool isFocus;
  final bool allowFocusLoss;
  final bool hiddeOriginalOption;
  final bool hiddeFakeOption;
  const LayoutDrawerState(
      {required this.isFocus, required this.allowFocusLoss, required this.hiddeFakeOption, required this.hiddeOriginalOption});

  @override
  List<Object> get props => [isFocus, allowFocusLoss, hiddeOriginalOption, hiddeFakeOption];
}

final class LayoutDrawerInitial extends LayoutDrawerState {
  const LayoutDrawerInitial() : super(isFocus: false, allowFocusLoss: false, hiddeOriginalOption: false, hiddeFakeOption: true);
}
