import 'package:flutter/material.dart';

class MyWarningFullMemory extends StatelessWidget {
  const MyWarningFullMemory({
    super.key,
    required this.sizeFullMemoryHeight,
  });

  final double sizeFullMemoryHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeFullMemoryHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Memory Full",
              style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(
            width: 6,
          ),
          Icon(
            Icons.info,
            color: Theme.of(context)
                .colorScheme
                .onPrimary
                .withOpacity(0.6),
            size: 18,
          )
        ],
      ),
    );
  }
}

