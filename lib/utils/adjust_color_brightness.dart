import 'package:flutter/material.dart';

/// Ajusta el brillo de un color.
///
/// [color] es el color base.
/// [factor] es un valor entre -1.0 y 1.0.
/// Valores negativos acercan el color a negro, y valores positivos lo acercan a blanco.
Color adjustColorBrightness(Color color, double factor) {
  assert(factor >= -1.0 && factor <= 1.0, 'El factor debe estar entre -1.0 y 1.0');

  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  if (factor < 0) {
    // Oscurecer el color hacia negro.
    final newRed = (red * (1 + factor)).clamp(0, 255).toInt();
    final newGreen = (green * (1 + factor)).clamp(0, 255).toInt();
    final newBlue = (blue * (1 + factor)).clamp(0, 255).toInt();
    return Color.fromARGB(color.alpha, newRed, newGreen, newBlue);
  } else {
    // Aclarar el color hacia blanco.
    final newRed = (red + ((255 - red) * factor)).clamp(0, 255).toInt();
    final newGreen = (green + ((255 - green) * factor)).clamp(0, 255).toInt();
    final newBlue = (blue + ((255 - blue) * factor)).clamp(0, 255).toInt();
    return Color.fromARGB(color.alpha, newRed, newGreen, newBlue);
  }
}
