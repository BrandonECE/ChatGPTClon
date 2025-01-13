import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/drawer/scroll_drawer/scroll_drawer_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyLoadChatEffect extends StatelessWidget {
  const MyLoadChatEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scrollDraweBloc = context.read<ScrollDrawerBloc>();

    return BlocBuilder<ScrollDrawerBloc, ScrollDrawerState>(
      builder: (context, state) {
        return AnimatedContainer(
          
          duration: Duration(milliseconds: state.loadChat ? 300 : 450),
          curve: Curves.linearToEaseOut,
          height:
              state.loadChat ? scrollDraweBloc.state.sizeRangeExpanded : 0,
        );
      },
    );
  }
}
