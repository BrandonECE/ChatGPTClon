import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/widgets/widgets.dart';

class MyChatGptLogo extends StatelessWidget {
  const MyChatGptLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .onPrimary
                    .withOpacity(0.25))),
        child: const MyMiniatureLogoChatGptGlobal());
  }
}
