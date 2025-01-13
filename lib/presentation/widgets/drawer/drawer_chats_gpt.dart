import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/drawer/layout_drawer/layout_drawer_bloc.dart';
import 'package:flutter_application_alon2/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MyDrawerContentChatGptOption extends StatelessWidget {
  const MyDrawerContentChatGptOption({
    super.key,
    required this.sizeHeightOptions,
  });

  final double sizeHeightOptions;

  @override
  Widget build(BuildContext context) {
    final layoutDrawerBlocState = context.watch<LayoutDrawerBloc>().state;

    return Container(
      width: MediaQuery.of(context).size.width * 0.79,
      height: sizeHeightOptions,
      decoration: BoxDecoration(
        color: !layoutDrawerBlocState.isFocus
            ? Theme.of(context).colorScheme.onPrimary.withOpacity(0.06)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Alinea a la izquierda
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: MyMiniatureLogoChatGpt(size: 17.5, backgroundColor: Theme.of(context).colorScheme.onPrimary, colorLogo: Theme.of(context).colorScheme.primary, interPadding: 5.5,)
            ),
            const SizedBox(width: 12), // Espacio entre el icono y el texto
            Text(
              'ChatGPT',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}


class MyDrawerContentMoreApisOption extends StatelessWidget {
  const MyDrawerContentMoreApisOption({
    super.key,
    required this.sizeHeightOptions,
  });

  final double sizeHeightOptions;
  @override
  Widget build(BuildContext context) {
    return Container(
      height:  sizeHeightOptions,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Alinea a la izquierda
          children: [
            const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Icon(
                  Icons.grid_view_outlined,
                  size: 19,
                )),
            const SizedBox(width: 17), // Espacio entre el icono y el texto
            Text(
              'Explore GPTs',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
