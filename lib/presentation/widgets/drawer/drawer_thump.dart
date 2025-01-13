import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/drawer/thump_drawer/thump_drawer_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDrawerScrollThump extends StatelessWidget {
  const MyDrawerScrollThump({
    super.key,
    required this.sizeHeightSpaceBtwSearchAndChat,
  });

  final double sizeHeightSpaceBtwSearchAndChat;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThumpDrawerBloc, ThumpDrawerState>(
      builder: (context, state) {
        return Positioned(
          right: 2.8,
          top: sizeHeightSpaceBtwSearchAndChat + MediaQuery.of(context).padding.top +
              state.scrollPosition,
          child: AnimatedOpacity(
            opacity: state.visibility ? 0 : 1,
            duration: Duration(milliseconds: state.visibility ? 100 : 25),
            child: AnimatedContainer(
              duration: const Duration(
                  milliseconds: 0), // Para una transición suave
              width: 3.5,
              height: state.sizeHeightThump, // Altura dinámica del thumb
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .onPrimary
                    .withOpacity(0.425),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        );
      },
    );
  }
}
