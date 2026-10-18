import 'package:flutter/material.dart';

import '../../core/theme/fitness_theme.dart';
import 'config/config.dart';

class AppTheme({
  required final AppThemeName themeName,
  required final AppFontTheme fontTheme,
}) {
  ThemeData getThemeData() {
    final dark = themeName.name.startsWith('dark');
    final contrastLevel = themeName.name.endsWith('HighContrast')
        ? 1.0
        : themeName.name.endsWith('MediumContrast')
        ? 0.5
        : 0.0;
    final textTheme = fontTheme.textTheme;
    return dark
        ? FitnessTheme.dark(textTheme: textTheme, contrastLevel: contrastLevel)
        : FitnessTheme.light(
            textTheme: textTheme,
            contrastLevel: contrastLevel,
          );
  }
}
