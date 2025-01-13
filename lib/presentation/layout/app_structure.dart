import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/di/service_locator.dart';
import 'package:flutter_application_alon2/domain/use_cases/get_all_chats_use_case.dart';
import 'package:flutter_application_alon2/domain/use_cases/send_message_use_case.dart';
import 'package:flutter_application_alon2/presentation/blocs/bottom_sheet_effect/bottom_sheet_effect_bloc.dart';

import 'package:flutter_application_alon2/presentation/blocs/chat/chat_message_error_conection/chat_message_error_conection_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_message_space_expand/chat_message_space_expand_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_input_thump/chat_input_thump_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_bottom_sheet_input_drag/chat_bottom_sheet_input_drag_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_input/chat_input_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_message_gpt_status/chat_message_gpt_status_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_messages/chat_messages_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_messages_thump/chat_messages_thump_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/structure/app_structure/app_structure_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/drawer/layout_drawer/layout_drawer_bloc.dart';
import 'package:flutter_application_alon2/presentation/views/chat_view.dart';
import 'package:flutter_application_alon2/presentation/widgets/widgets.dart';
import 'package:flutter_application_alon2/utils/transform_to_range.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppStructure extends StatelessWidget {
  const MyAppStructure({super.key});

  final double opacityBackgroundBottomSheetGeneral = 0.95;
  final double scaleBackgroundBottomSheetGeneral = 0.92;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LayoutDrawerBloc(),),
          BlocProvider(create: (context) => BottomSheetEffectBloc(), ),
          BlocProvider(create: (context) => LayoutDrawerBloc(),),
          BlocProvider(create: (context) => AppStructureBloc(layoutDrawerBloc: context.read<LayoutDrawerBloc>()),),
          BlocProvider(create: (context) => ChatInputThumpBloc(scrollSpaceAvailable: 0)),
          BlocProvider(create: (context) => ChatMessagesBloc(),),    
          BlocProvider(create: (context) => ChatMessageSpaceExpandBloc(),),
          BlocProvider(create: (context) => ChatMessagesThumpBloc(chatMessagesBloc: context.read<ChatMessagesBloc>()),),
          BlocProvider(create: (context) => ChatInputBloc(
            chatMessagesThumpBloc:  context.read<ChatMessagesThumpBloc>(),
                  chatInputThumpBloc: context.read<ChatInputThumpBloc>(),
                  opacityBackgroundBottomSheet: opacityBackgroundBottomSheetGeneral,
                  scaleBackgroundBottomSheetGeneral: scaleBackgroundBottomSheetGeneral,
                  bottomSheetEffectBloc: context.read<BottomSheetEffectBloc>())),
          BlocProvider(create: (context) => ChatBottomSheetInputDragBloc(
                opacityBackgroundBottomSheet: opacityBackgroundBottomSheetGeneral,
                scaleBackgroundBottomSheetGeneral: scaleBackgroundBottomSheetGeneral,
                chatInputBloc: context.read<ChatInputBloc>(),
                bottomSheetEffectBloc: context.read<BottomSheetEffectBloc>()),
          ),
          BlocProvider(create: (context) => ChatMessageGptStatusBloc(chatMessagesThumpBloc: context.read<ChatMessagesThumpBloc>(), chatInputBloc: context.read<ChatInputBloc>(), chatMessagesBloc: context.read<ChatMessagesBloc>(), getAllChatsUseCase: getIt<GetAllChatsUseCase>(), sendMessageUseCase: getIt<SendMessageUseCase>())),          
          BlocProvider(create: (context) => ChatMessageErrorConectionBloc(chatMessageGptStatusBloc: context.read<ChatMessageGptStatusBloc>(), chatMessageSpaceExpandBloc: context.read<ChatMessageSpaceExpandBloc>(), chatMessagesThumpBloc: context.read<ChatMessagesThumpBloc>(),)),
        ],
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: MyBackgroundContentBehindBottomSheet(
                  scaleBackgroundBottomSheetGeneral:
                      scaleBackgroundBottomSheetGeneral),
            ),
            BlocBuilder<ChatInputBloc, ChatInputState>(
              builder: (context, stateChatInput) {
                return BlocBuilder<ChatBottomSheetInputDragBloc,
                    ChatBottomSheetInputDragState>(
                  builder: (context, stateBottomSheetDrag) {
                    return MyChatInputBottomSheetDrag(
                      stateBottomSheetDrag: stateBottomSheetDrag,
                      stateChatInput: stateChatInput,
                    );
                  },
                );
              },
            ),
          ],
        ));
  }
}

class MyBackgroundContentBehindBottomSheet extends StatelessWidget {
  MyBackgroundContentBehindBottomSheet({
    super.key,
    required this.scaleBackgroundBottomSheetGeneral,
  });

  final double scaleBackgroundBottomSheetGeneral;
  final GlobalKey inputChatMainGlobalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<BottomSheetEffectBloc, BottomSheetEffectState>(
      builder: (context, state) {


         final chatBottomSheetInputDragBloc =
            context.watch<ChatBottomSheetInputDragBloc>();


  
        final int durationOpacityCondition =
            chatBottomSheetInputDragBloc.state.bottomSheetOffset != 0 ? 0 : 200;

        final int durationScaleCondition =
            chatBottomSheetInputDragBloc.state.bottomSheetOffset != 0 ? 0 : 800;

        final int durationBorderRadiusCondition =
            chatBottomSheetInputDragBloc.state.bottomSheetOffset != 0 ? 0 : 800;

        final double borderRadiusContent = transformToRange(
            state.scale, scaleBackgroundBottomSheetGeneral, 1, 0, 10,
            reverseOutput: true);

        return AbsorbPointer(
          absorbing: state.ignore,
          child: Container(
            color: Theme.of(context).colorScheme.onPrimary,
            child: AnimatedScale(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: durationScaleCondition),
              scale: state.scale,
              child: AnimatedContainer(
                duration: Duration(milliseconds: durationBorderRadiusCondition),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadiusContent),
                ),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  color: Theme.of(context).colorScheme.onPrimary,
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: durationOpacityCondition),
                    opacity: state.opacity,
                    child: MyPrimaryContent(inputChatMainGlobalKey: inputChatMainGlobalKey,),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MyPrimaryContent extends StatelessWidget {
  const MyPrimaryContent({super.key, required this.inputChatMainGlobalKey});
  final double _sizePour = 0.85;
  final GlobalKey inputChatMainGlobalKey;

  @override
  Widget build(BuildContext context) {
    final double sizeWithDevice = MediaQuery.of(context).size.width;
    final double drawerWidth = sizeWithDevice * _sizePour;

    return BlocBuilder<LayoutDrawerBloc, LayoutDrawerState>(
      builder: (context, stateLayoutDrawe) {
        return BlocBuilder<AppStructureBloc, AppStructureState>(
          builder: (context, stateAppEstructure) {
            void toggleDrawer() {
              context
                  .read<AppStructureBloc>()
                  .add(ToggleDrawer(drawerWidth: drawerWidth, context: context));
            }

            void handleDragUpdate(DragUpdateDetails details) {
              context.read<AppStructureBloc>().add(
                  HandleDragUpdate(drawerWidth: drawerWidth, details: details));
            }

            void handleDragEnd(DragEndDetails details) {
              context.read<AppStructureBloc>().add(
                  HandleDragEnd(drawerWidth: drawerWidth, details: details, context: context));
            }

            return Scaffold(
              body: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastEaseInToSlowEaseOut,
                    left: stateAppEstructure.drawerOffset - drawerWidth,
                    width:
                        stateLayoutDrawe.isFocus ? sizeWithDevice : drawerWidth,
                    top: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onHorizontalDragUpdate: handleDragUpdate,
                      onHorizontalDragEnd: handleDragEnd,
                      child: const MyDrawerContent(), //###
                    ),
                  ),
                  // Pantalla Principal
                  AnimatedPositioned(
                    duration: const Duration(
                        milliseconds: 300), // Duración de la animación
                    curve: Curves
                        .fastEaseInToSlowEaseOut, // Curva para una transición suave
                    top: 0, // Ocupa todo el alto
                    bottom: 0, // Ocupa todo el alto
                    left: stateAppEstructure.drawerOffset +
                        (stateLayoutDrawe.isFocus
                            ? sizeWithDevice - drawerWidth
                            : 0),
                    right: -stateAppEstructure.drawerOffset -
                        (stateLayoutDrawe.isFocus
                            ? sizeWithDevice - drawerWidth
                            : 0),
                    child: GestureDetector(
                      onHorizontalDragUpdate: handleDragUpdate,
                      onHorizontalDragEnd: handleDragEnd,
                      child: Stack(
                        children: [
                          MyChatView(lambda: toggleDrawer, inputChatMainGlobalKey: inputChatMainGlobalKey),
                          IgnorePointer(
                            ignoring: !stateAppEstructure.isDrawerOpen,
                              child: Container(
                            color: Colors.black.withOpacity((0.2 *
                                (stateAppEstructure.drawerOffset /
                                    drawerWidth)).clamp(0,1)),
                          )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
