import 'package:flutter/material.dart';

class MyChatTitle extends StatelessWidget {
  const MyChatTitle({super.key, required this.text, this.isLast = false});

  final String text;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: !isLast ? 4 : 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        height: 47,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          // color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.06),
          borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            text,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ),
    );
  }
}