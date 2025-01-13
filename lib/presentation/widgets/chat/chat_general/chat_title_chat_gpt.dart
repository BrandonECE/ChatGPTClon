import 'package:flutter/material.dart';

class MyTitleChatGpt extends StatelessWidget {
  const MyTitleChatGpt({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("ChatGPT",
            style: Theme.of(context)
                .textTheme
                .labelLarge!),
      
        Icon(
          Icons.keyboard_arrow_right_rounded,
          size: 20,
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
        ),
      ],
    );
  }
}
