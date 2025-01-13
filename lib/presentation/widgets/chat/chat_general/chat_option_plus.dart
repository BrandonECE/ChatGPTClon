import 'package:flutter/material.dart';

class MyGetPlusOption extends StatelessWidget {
  const MyGetPlusOption({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight * 0.75,
      width: 105,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Get Plus",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Theme.of(context).colorScheme.secondary)),
          const SizedBox(
            width: 5,
          ),
          Icon(
            Icons.star,
            size: 16,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}
