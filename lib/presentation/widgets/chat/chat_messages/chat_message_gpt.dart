import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/widgets/widgets.dart';

class MyMessageChatGPT extends StatelessWidget {
  const MyMessageChatGPT({super.key, required this.messageUser});

  final String messageUser;

  @override
  Widget build(BuildContext context) {
    List<String> listMss = messageUser.split(RegExp(r"(?<=\s)|(?=—)|(?<=—)"));

    return GestureDetector(
       onTapDown: (_) {
            FocusScope.of(context).unfocus();
          },
      child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const MyChatGptLogo(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.025,
              ),
              _myTextMessage(context, listMss)
            ],
          )),
    );
  }

  Expanded _myTextMessage(BuildContext context, List<String> listMss) {
    return Expanded(
        child: Wrap(
      children: List.generate(
        listMss.length,
        (index) {
          String word = listMss[index];
          return AnimatedOpacity(
            opacity: 1,
            duration: const Duration(milliseconds: 0),
            child: _myWord(word, context));
        },
      ),
    ));
  }

  Text _myWord(String word, BuildContext context) {
    return Text(
      word,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onPrimary),
    );
  }

}
