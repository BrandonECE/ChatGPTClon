import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

class MyDrawerContentAccount extends StatelessWidget {
  const MyDrawerContentAccount({
    super.key,
    required this.sizeHeightAccountBottom,
  });

  final double sizeHeightAccountBottom;

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
        borderRadius: const BorderRadius.all(Radius.circular(0)),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.75),
        blur: 10,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        height: sizeHeightAccountBottom,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.8)),
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text("Brandon Cantu",
                    style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
            Icon(Icons.more_horiz_rounded,
                size: 30,
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.4))
          ],
        ));
  }
}
