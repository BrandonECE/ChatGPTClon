part of 'chat_input_thump_bloc.dart';

class ChatInputThumpState extends Equatable {
  final double position;
  final double sizeThumpDynamic;
  final double sizeThumpMax;
  final double sizeThumpMin;
  final bool thumpVisibility;
  final bool hiddeThumpByScroll;
  const ChatInputThumpState(
      {required this.position,
      required this.sizeThumpDynamic,
      this.sizeThumpMax = 95,
      this.sizeThumpMin = 10, required this.thumpVisibility, required this.hiddeThumpByScroll});

  @override
  List<Object> get props => [position, sizeThumpDynamic, thumpVisibility, hiddeThumpByScroll];
}

final class ChatInputThumpInitial extends ChatInputThumpState {
  const ChatInputThumpInitial() : super(position: 0, sizeThumpDynamic: 95, thumpVisibility: true, hiddeThumpByScroll: true);
}
