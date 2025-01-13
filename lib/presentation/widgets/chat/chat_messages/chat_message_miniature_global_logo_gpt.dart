import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/widgets/utils/chat_gpt_miniature_logo.dart';

class MyMiniatureLogoChatGptGlobal extends StatelessWidget {
  const MyMiniatureLogoChatGptGlobal({super.key});

  @override
  Widget build(BuildContext context) {
    return MyMiniatureLogoChatGpt(
              size: 20,
              backgroundColor: Theme.of(context).colorScheme.primary,
              colorLogo: Theme.of(context).colorScheme.onPrimary,
              interPadding: 4.5,
     );
  }
}