import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField(
      {super.key,
      required this.focusNode,
      required this.inputExpanded,
      required this.textEditingController,
      required this.mainInput,
      this.onTapCallBack = _defaultCallback});

  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final bool inputExpanded;
  final bool mainInput;
  final void Function() onTapCallBack;

  static void _defaultCallback() {}

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      scrollPhysics: const BouncingScrollPhysics(),
      focusNode: focusNode,
      maxLines: null,
      minLines: 1,
      onChanged: (value) {
        if (mainInput) onTapCallBack.call();
      },
      controller: textEditingController,
      cursorColor: Theme.of(context).colorScheme.secondary,
      decoration: InputDecoration(
          isDense: true,
          fillColor: Colors.transparent,
          contentPadding: EdgeInsets.only(
              right: 8,
              left: inputExpanded ? 6 : 0),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          hintText: "Message",
          hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.6)),
          prefixIconConstraints: const BoxConstraints(minWidth: 45)),
    );
  }
}
