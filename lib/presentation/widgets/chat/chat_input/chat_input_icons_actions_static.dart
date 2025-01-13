
import 'package:flutter/material.dart';


class MyIconsOptionInput extends StatelessWidget {
  const MyIconsOptionInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.mic_none_rounded, size: Theme.of(context).iconTheme.size),
        const SizedBox(
          width: 10,
        ),
        Container(
            padding: const EdgeInsets.all(5.5),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                shape: BoxShape.circle),
            child: Icon(
              Icons.headset_mic_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 22.5,
            )),
      ],
    );
  }
}
