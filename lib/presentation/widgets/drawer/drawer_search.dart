import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/drawer/layout_drawer/layout_drawer_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDrawerContentSearch extends StatelessWidget {
  const MyDrawerContentSearch({
    super.key,
  });

  final double sizeButtonCancel = 77.5;

  @override
  Widget build(BuildContext context) {
    final LayoutDrawerBloc layoutDrawerBloc = context.read<LayoutDrawerBloc>();

    return BlocBuilder<LayoutDrawerBloc, LayoutDrawerState>(
      builder: (context, state) {

        return BlurryContainer(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8, left: 8, bottom: 8, right: 8),
          blur: 10,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.85),
          borderRadius: const BorderRadius.all(Radius.circular(0)),
          height: kToolbarHeight + MediaQuery.of(context).padding.top,
          child: SizedBox(
              child: Stack(
            children: [
              AnimatedPositioned(
                  curve: Curves.linear,
                  duration: const Duration(milliseconds: 200),
                  left: 0,
                  top: 0,
                  bottom: 0,
                  right: state.isFocus ? sizeButtonCancel : 0,
                  child: const MySearchWidget()),
              AnimatedPositioned(
                curve: Curves.linear,
                duration: const Duration(milliseconds: 200),
                top: 0,
                bottom: 0,
                right: state.isFocus ? 0 : -sizeButtonCancel,
                child: SizedBox(
                  width: sizeButtonCancel,
                  child: TextButton(
                      style: ElevatedButton.styleFrom(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      onPressed: () {
                        layoutDrawerBloc.add(const LayoutDrawerAllowFocusEvent(
                            allowFocusLoss: true));
                      },
                      child: Text("Cancel",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary))),
                ),
              )
            ],
          )),
        );
      },
    );
  }
}

class MySearchWidget extends StatelessWidget {
  const MySearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final layoutDrawerBloc = context.read<LayoutDrawerBloc>();

    return TextFormField(
      focusNode: layoutDrawerBloc.focusNode,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: Theme.of(context).colorScheme.onPrimary),
      cursorColor: Theme.of(context).colorScheme.secondary,
      decoration: InputDecoration(
          prefixIconConstraints: const BoxConstraints(
            minWidth: 30, // Reduce el ancho mínimo del ícono
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 20,
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.6),
          ),
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.6)),
          hintText: "Search"),
    );
  }
}
