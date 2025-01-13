import 'package:flutter/material.dart';

class GlobalTheme {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static const ColorScheme _lightColorScheme = ColorScheme(
    primary: Colors.white, // Azul más brillante
    onPrimary: Color(0xFF141218),
    secondary: Color(0xFF6750A4), // Azul más brillante
    onSecondary: Colors.transparent,
    tertiary: Color(0xFFF46B22),
    primaryContainer: Colors.transparent,
    error: Colors.redAccent,
    onError: Colors.white,
    surface: Colors.transparent, // Gris claro
    onSurface: Colors.transparent, // Gris oscuro
    brightness: Brightness.light,
  );

  static const ColorScheme _darkColorScheme = ColorScheme(
    primary: Color.fromARGB(255, 55, 55, 55), // Azul brillante
    onPrimary: Colors.white,
    secondary: Color.fromARGB(255, 199, 179, 255), // Azul más brillante
    onSecondary: Colors.transparent,
    tertiary: Color(0xFFF46B22),
    primaryContainer: Colors.transparent,
    error: Colors.redAccent,
    onError: Colors.white,
    surface: Colors.transparent, // Gris muy oscuro
    onSurface: Colors.transparent,
    brightness: Brightness.dark,
  );

  static ThemeData lightThemeData =
      _themeData(_lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData =
      _themeData(_darkColorScheme, _darkFocusColor);

  static ThemeData _themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
        colorScheme: colorScheme,
        canvasColor: colorScheme.surface,
        scaffoldBackgroundColor: colorScheme.surface,
        highlightColor: Colors.transparent,
        focusColor: focusColor,
        iconTheme: _iconTheme(colorScheme),
        textTheme: _textTheme(colorScheme),
        appBarTheme: _appBarTheme(colorScheme),
        textButtonTheme: _textButtonTheme(colorScheme),
        inputDecorationTheme: _inputDecorationTheme(colorScheme));
  }

  static AppBarTheme _appBarTheme(ColorScheme colorScheme) {
    return AppBarTheme(iconTheme: _iconTheme(colorScheme));
  }

  static TextButtonThemeData _textButtonTheme(ColorScheme colorScheme) {
    return TextButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: colorScheme.secondary,      )
    );
  }

  static IconThemeData _iconTheme(ColorScheme colorScheme) {
    return IconThemeData(color: colorScheme.onPrimary, size: 25);
  }

  static TextTheme _textTheme(ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: TextStyle(
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
          color: colorScheme.onPrimary),
      displayMedium: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: colorScheme.onPrimary,
      ),
      displaySmall: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: colorScheme.onPrimary,
      ),
      headlineLarge: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: colorScheme.onPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: colorScheme.onPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: colorScheme.onPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: colorScheme.onPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: colorScheme.onPrimary,
      ),
      titleSmall: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: colorScheme.onPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
        color: colorScheme.onPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: colorScheme.onPrimary,
      ),
      bodySmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: colorScheme.onPrimary,
      ),
      labelLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: colorScheme.onPrimary,
      ),
      labelMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: colorScheme.onPrimary,
      ),
      labelSmall: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
        color: colorScheme.onPrimary,
      ),
    );
  }

  static InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) {
    return InputDecorationTheme(
      fillColor: colorScheme.onPrimary.withOpacity(0.05),
      filled: true,
      contentPadding: const EdgeInsets.all(0),
      hintStyle: TextStyle(color: colorScheme.onPrimary.withOpacity(0.6)),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }
}
