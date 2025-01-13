import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/di/service_locator.dart';
import 'package:flutter_application_alon2/domain/use_cases/get_all_chats_use_case.dart';
import 'package:flutter_application_alon2/presentation/blocs/drawer/animation_loading_drawer/animation_loading_drawer_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/drawer/api_request_drawer/api_request_drawer_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/drawer/scroll_drawer/scroll_drawer_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/drawer/thump_drawer/thump_drawer_bloc.dart';
import 'package:flutter_application_alon2/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDrawerContent extends StatelessWidget {
  const MyDrawerContent({super.key});

  static const double sizeHeightAccountBottom = kToolbarHeight * 1.2;
  static const double sizeHeightSpaceBtwSearchAndChat = kToolbarHeight + 4;
  final double sizeHeightOptions = 47;
  final double sizeHeightSpaceBtwOptions = 4;
  final double sizeHeightTitleGpts = 34;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ApiRequestDrawerBloc(getAllChatsUseCase: getIt<GetAllChatsUseCase>())),
        BlocProvider(create: (_) => AnimationLoadingDrawerBloc()),
        BlocProvider(create: (_) => ThumpDrawerBloc(spaceChatScroll: 0)),
        BlocProvider(
          create: (context) => ScrollDrawerBloc(
            apiRequestDrawerBloc: context.read<ApiRequestDrawerBloc>(),
            animationLoadingDrawerBloc:
                context.read<AnimationLoadingDrawerBloc>(),
            thumpDrawerBloc: context.read<ThumpDrawerBloc>(),
          ),
        ),
      ],
      child: BlocListener<ApiRequestDrawerBloc, ApiRequestDrawerState>(
        listener: _handleApiRequestState,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final spaceChatScroll =
                _calculateSpaceChatScroll(context, constraints);
            _updateThumpBloc(context, spaceChatScroll);

            return Container(
              color: Theme.of(context).colorScheme.primary,
              alignment: Alignment.center,
              child: Stack(
                children: [

                  MyDrawerContentMoreApisOptionFake(
                    sizeHeightOptions: sizeHeightOptions,
                    sizeHeightSpaceBtwOptions: sizeHeightSpaceBtwOptions,
                    sizeHeightTitleGpts: sizeHeightTitleGpts,
                      sizeHeightSpaceBtwSearchAndChat:
                          sizeHeightSpaceBtwSearchAndChat),

                  Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top),
                        child: const MyLoadSymbol(size: 32),
                      )),

                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top),
                      child:  MyDrawerContentChats(
                        sizeHeightSpaceBtwSearchAndChat:
                            sizeHeightSpaceBtwSearchAndChat,
                            sizeHeightOptions: sizeHeightOptions,
                            sizeHeightSpaceBtwOptions: sizeHeightSpaceBtwOptions,
                            sizeHeightTitleGpts: sizeHeightTitleGpts,
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: MyDrawerContentSearch(),
                  ),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: MyDrawerContentAccount(
                        sizeHeightAccountBottom: sizeHeightAccountBottom),
                  ),
                  const MyDrawerScrollThump(
                    sizeHeightSpaceBtwSearchAndChat:
                        sizeHeightSpaceBtwSearchAndChat,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleApiRequestState(
      BuildContext context, ApiRequestDrawerState state) {
    final animationBloc = context.read<AnimationLoadingDrawerBloc>();
    if (state is SuccessfulResponse || state is ErrorResponse) {
      animationBloc.add(const AnimationDrawerFinshLoadEvt(inLoading: false));
    }
  }

  double _calculateSpaceChatScroll(
      BuildContext context, BoxConstraints constraints) {
    return constraints.maxHeight -
        sizeHeightAccountBottom -
        sizeHeightSpaceBtwSearchAndChat -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).viewInsets.bottom;
  }

  void _updateThumpBloc(BuildContext context, double spaceChatScroll) {
    final thumpBloc = context.read<ThumpDrawerBloc>();
    if (spaceChatScroll != thumpBloc.spaceChatScroll) {
      thumpBloc.updateSpaceChatScroll(spaceChatScroll);
    }
  }
}

