import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/drawer/layout_drawer/layout_drawer_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/drawer/scroll_drawer/scroll_drawer_bloc.dart';
import 'package:flutter_application_alon2/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDrawerContentChats extends StatelessWidget {
  const MyDrawerContentChats({
    super.key,
    required this.sizeHeightSpaceBtwSearchAndChat,
    required this.sizeHeightOptions,
    required this.sizeHeightSpaceBtwOptions,
    required this.sizeHeightTitleGpts
  });


  final double sizeHeightSpaceBtwOptions;
  final double sizeHeightOptions;
  final double sizeHeightTitleGpts;

  final double sizeHeightSpaceBtwSearchAndChat;

  @override
  Widget build(BuildContext context) {

    final scrollDrawerBloc = context.read<ScrollDrawerBloc>();


    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(
        scrollbars: false,
      ), // Desactiva el thumb predeterminado
      child: ListView(
        controller: scrollDrawerBloc.scrollController,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          
          const MyLoadChatEffect(),
          Padding(
            padding: EdgeInsets.only(top: sizeHeightSpaceBtwSearchAndChat),
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.topLeft,
                height: sizeHeightTitleGpts,
                child: Text(
                  "GPTs",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.5)),
                )),
          ),
          MyDrawerContentChatGptOption(sizeHeightOptions: sizeHeightOptions),
          SizedBox(
            height: sizeHeightSpaceBtwOptions,
          ),
          BlocBuilder<LayoutDrawerBloc, LayoutDrawerState>(
            builder: (context, stateLayoutDrawer) {
              return AnimatedOpacity(
                opacity: !stateLayoutDrawer.hiddeOriginalOption ? 1 : 0,
                duration: const Duration(milliseconds: 0),
                child: AnimatedContainer(
                    onEnd: () {
                      final layoutDrawerBloc = context.read<LayoutDrawerBloc>();
                      if (!stateLayoutDrawer.isFocus) {
                        layoutDrawerBloc.add(const LayoutDrawerHiddeFakeEvent(
                            hiddeFakeOption: true));
                        layoutDrawerBloc.add(
                            const LayoutDrawerHiddeOriginalEvent(
                                hiddeOriginalOption: false));
                      }
                    },
                    curve: Curves.decelerate,
                    height: !stateLayoutDrawer.isFocus ? 47 : 0,
                    duration: const Duration(milliseconds: 375),
                    child: MyDrawerContentMoreApisOption(sizeHeightOptions: sizeHeightOptions,)),
              );
            },
          ),
          const MyLongDivider(),
          const MyChatsDate(
            date: "Today",
          ),
          const MyChatTitle(
            text: "Eliminar y clonar proyecto",
          ),
          const MyChatTitle(
            text: "Commit Refactor Ejemplo",
          ),
          const MyChatTitle(
            text: "Uso de stick",
            isLast: true,
          ),
          const MyLongDivider(),
          const MyChatsDate(
            date: "Yesterday",
          ),
          const MyChatTitle(
            text: "GetView en GextFlutter",
          ),
          const MyChatTitle(
            text: "Uso de Bloc en Flutter",
          ),
          const MyChatTitle(
            text: "Privacidad en Dart",
            isLast: true,
          ),
          const MyLongDivider(),
          const MyChatsDate(
            date: "2 days ago",
          ),
          const MyChatTitle(
            text: "Ejemplo de dieta",
          ),
          const MyChatTitle(
            text: "Flet y python",
          ),
          const MyChatTitle(
            text: "Lenguaje isoterico",
            isLast: true,
          ),
          const MyLongDivider(),
          const MyChatsDate(
            date: "4 days ago",
          ),
          const MyChatTitle(
            text: "GetView en GextFlutter",
          ),
          const MyChatTitle(
            text: "Uso de Bloc en Flutter",
          ),
          const MyChatTitle(
            text: "Privacidad en Dart",
            isLast: true,
          ),
          const MyLongDivider(),
          const MyChatsDate(
            date: "5 days ago",
          ),
          const MyChatTitle(
            text: "Ejemplo de dieta",
          ),
          const MyChatTitle(
            text: "Flet y python",
          ),
          const MyChatTitle(
            text: "Lenguaje isoterico",
            isLast: true,
          ),
          const MyLongDivider(),
          const MyChatsDate(
            date: "7 days ago",
          ),
          const MyChatTitle(
            text: "GetView en GextFlutter",
          ),
          const MyChatTitle(
            text: "Uso de Bloc en Flutter",
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: kToolbarHeight * 1.2),
            child: MyChatTitle(
              text: "Privacidad en Dart",
              isLast: true,
            ),
          ),
        ],
      ),
    );
  }
}
