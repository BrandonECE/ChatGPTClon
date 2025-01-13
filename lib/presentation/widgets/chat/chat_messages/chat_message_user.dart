import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/chat/chat_message_space_expand/chat_message_space_expand_bloc.dart';
import 'package:flutter_application_alon2/presentation/widgets/utils/measure_size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MyMessageUser extends StatelessWidget {
  const MyMessageUser({super.key, required this.messageUser});

    final String messageUser;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTapDown: (_) {
            FocusScope.of(context).unfocus();
          },
      child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.onPrimary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20)),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7),
            child: Text(
              messageUser,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
          )),
    );
  }
}




class MyMessageUserKeepAlive extends StatefulWidget {
  const MyMessageUserKeepAlive({super.key, required this.messageUser});
  final String messageUser;

  @override
  State<MyMessageUserKeepAlive> createState() => _MyMessageUserState();
}

class _MyMessageUserState extends State<MyMessageUserKeepAlive>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MeasureSize(
      onSizeChange: (size) {
        final chatMessageSpaceExpandBloc = context.read<ChatMessageSpaceExpandBloc>();
        chatMessageSpaceExpandBloc.add(ChatMessagesSetSizeHeightMssUserEvent(sizeHeight: size.height));
      },
      child: Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTapDown: (_) {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20)),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7),
              child: Text(
                widget.messageUser,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}



