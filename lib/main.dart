import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/config/theme/global_theme.dart';
import 'package:flutter_application_alon2/di/service_locator.dart';
import 'package:flutter_application_alon2/presentation/layout/app_structure.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: GlobalTheme.darkThemeData,
      theme: GlobalTheme.lightThemeData,
      home: const MyAppStructure(),
    );
  }
}
