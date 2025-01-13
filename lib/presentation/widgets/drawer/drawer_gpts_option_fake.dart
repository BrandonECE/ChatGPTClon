import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/drawer/layout_drawer/layout_drawer_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/drawer/scroll_drawer/scroll_drawer_bloc.dart';
import 'package:flutter_application_alon2/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDrawerContentMoreApisOptionFake extends StatelessWidget {
  const MyDrawerContentMoreApisOptionFake(
      {super.key, required this.sizeHeightSpaceBtwSearchAndChat, required this.sizeHeightOptions, required this.sizeHeightSpaceBtwOptions, required this.sizeHeightTitleGpts});

  final double sizeHeightSpaceBtwSearchAndChat;
  final double sizeHeightOptions;
  final double sizeHeightSpaceBtwOptions;
  final double sizeHeightTitleGpts;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScrollDrawerBloc, ScrollDrawerState>(
      builder: (context, stateScrollDrawer) {
        return Positioned(
            top: (sizeHeightSpaceBtwSearchAndChat + MediaQuery.of(context).padding.top + sizeHeightOptions + sizeHeightSpaceBtwOptions + sizeHeightTitleGpts) - stateScrollDrawer.position,
            left: 10,
            right: 10,
            child: BlocBuilder<LayoutDrawerBloc, LayoutDrawerState>(
              builder: (context, stateLayoutDrawer) {
                return Opacity(
                  opacity: !stateLayoutDrawer.hiddeFakeOption ? 1 : 0,
                  child: AnimatedOpacity(
                    curve: Curves.decelerate,
                    duration: const Duration(milliseconds: 275),
                    opacity: !stateLayoutDrawer.isFocus ? 1 : 0,
                    child: AnimatedPadding(
                        duration: Duration(
                            milliseconds:
                                stateScrollDrawer.loadChat ? 300 : 450),
                        curve: Curves.linearToEaseOut,
                        padding: EdgeInsets.only(
                            top: stateScrollDrawer.loadChat
                                ? stateScrollDrawer.sizeRangeExpanded
                                : 0),
                        child:  MyDrawerContentMoreApisOption(sizeHeightOptions: sizeHeightOptions,)),
                  ),
                );
              },
            ));
      },
    );
  }
}
