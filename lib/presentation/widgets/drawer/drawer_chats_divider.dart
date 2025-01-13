import 'package:flutter/material.dart';

class MyLongDivider extends StatelessWidget {
  const MyLongDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.centerLeft,
      child: Divider(
        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.1),
      ),
    );
  }
}