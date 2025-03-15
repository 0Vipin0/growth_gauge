import 'package:flutter/material.dart';

import 'config/config.dart';

class AppTheme {
  final AppThemeName themeName;
  final AppFontTheme fontTheme;

  AppTheme({required this.themeName, required this.fontTheme});

  ThemeData getThemeData() {
    final appColorTheme =
        appColorThemes.firstWhere((theme) => theme.name == themeName);
    return ThemeData(
      useMaterial3: true,
      brightness: appColorTheme.colorScheme.brightness,
      colorScheme: appColorTheme.colorScheme,
      textTheme: fontTheme.textTheme.apply(
        bodyColor: appColorTheme.colorScheme.onSurface,
        displayColor: appColorTheme.colorScheme.onSurface,
      ),
      scaffoldBackgroundColor: appColorTheme.colorScheme.surface,
      canvasColor: appColorTheme.colorScheme.surface,
    );
  }
}
