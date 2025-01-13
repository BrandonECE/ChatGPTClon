import 'package:flutter/material.dart';

class MyChatsDate extends StatelessWidget {
  const MyChatsDate({super.key, required this.date});

  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
        alignment: Alignment.centerLeft,
        child: Text(
          date,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.6)),
        ));
  }
}