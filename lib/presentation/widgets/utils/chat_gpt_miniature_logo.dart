import 'package:flutter/material.dart';

class MyMiniatureLogoChatGpt extends StatelessWidget {
  const MyMiniatureLogoChatGpt(
      {super.key,
      required this.size,
      required this.backgroundColor,
      required this.colorLogo, required this.interPadding});
  final double size;
  final double interPadding;
  final Color backgroundColor;
  final Color colorLogo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(interPadding),
        child: SizedBox(
          width: size,
          height: size,
          child: Image.asset(
            "assets/images/chatgpt-logo.png",
            color: colorLogo,
          ),
        ),
      ),
    );
  }
}
