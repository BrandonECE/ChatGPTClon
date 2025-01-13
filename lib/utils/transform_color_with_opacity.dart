import 'dart:ui';

Color transformWithOpacity(
    Color baseColor, Color backgroundColor, double opacity) {
  assert(opacity >= 0.0 && opacity <= 1.0,
      'La opacidad debe estar entre 0.0 y 1.0');

  final r =
      ((1 - opacity) * backgroundColor.red + opacity * baseColor.red).round();
  final g = ((1 - opacity) * backgroundColor.green + opacity * baseColor.green)
      .round();
  final b =
      ((1 - opacity) * backgroundColor.blue + opacity * baseColor.blue).round();

  return Color.fromARGB(255, r, g, b);
}
