import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/utils/transform_color_with_opacity.dart';

class MyChatSuggestion extends StatelessWidget {
  const MyChatSuggestion(
      {super.key,
      required this.title,
      required this.description,
      this.isLast = false});

  final String title;
  final String description;
  final bool isLast;

  @override
  Widget build(BuildContext context) {

    final Color colorContainer = transformWithOpacity(
        Theme.of(context).colorScheme.onPrimary,
        Theme.of(context).colorScheme.primary,
        0.05);

    return Padding(
      padding: EdgeInsets.only(right: !isLast ? 14 : 0),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: colorContainer,
          borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.6)),
                ),
              ],
            )),
      ),
    );
  }
}