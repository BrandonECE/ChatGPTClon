part of 'chat_input_thump_bloc.dart';

sealed class ChatInputThumpEvent extends Equatable {
  const ChatInputThumpEvent();

  @override
  List<Object> get props => [];
}

final class ChatInputThumpUpdatePositionEvent extends ChatInputThumpEvent {
  final double position;
  const ChatInputThumpUpdatePositionEvent({required this.position});

  @override
  List<Object> get props => [position];
}

final class ChatInputThumpUpdateSizeThumpEvent extends ChatInputThumpEvent {
  final double sizeThump;
  const ChatInputThumpUpdateSizeThumpEvent({required this.sizeThump});

  @override
  List<Object> get props => [sizeThump];
}

final class ChatInputThumpUpdateVisbilityThumpEvent extends ChatInputThumpEvent {
  final bool thumpVisibility;
  const ChatInputThumpUpdateVisbilityThumpEvent({required this.thumpVisibility});

  @override
  List<Object> get props => [thumpVisibility];
}


final class ChatInputHiddeThumpByScrollThumpEvent extends ChatInputThumpEvent {
  final bool hiddeThump;
  const ChatInputHiddeThumpByScrollThumpEvent({required this.hiddeThump});

  @override
  List<Object> get props => [hiddeThump];
}



