import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

/// Provides theme configurations for the Growth Gauge design system,
/// combining seed palettes, M3 surface hierarchies, and typography scales.
class AppTheme._() {
  /// Generates an authoritative [ThemeData] instance tailored for the application.
  ///
  /// - [themeName]: The curated seed palette to derive colors from (defaults to [AppThemeName.forest]).
  /// - [brightness]: The brightness mode ([Brightness.dark] or [Brightness.light]).
  /// - [contrastVariant]: The accessibility contrast level ([AppContrastVariant.standard],
  ///   [AppContrastVariant.mediumContrast], or [AppContrastVariant.highContrast]).
  /// - [fontFamilyChoice]: The active typography font family (defaults to [AppFontFamilyChoice.manrope]).
  /// - [fontSize]: The global font scaling preference ([AppFontSize.medium]).
  static ThemeData buildTheme({
    AppThemeName themeName = AppThemeName.forest,
    Brightness brightness = Brightness.dark,
    AppContrastVariant contrastVariant = AppContrastVariant.standard,
    AppFontFamilyChoice fontFamilyChoice = AppFontFamilyChoice.manrope,
    AppFontSize fontSize = AppFontSize.medium,
  }) {
    // Generate the color scheme using our theme extension
    final ColorScheme colorScheme = themeName.createColorScheme(
      brightness: brightness,
      contrastVariant: contrastVariant,
    );

    // Generate the text theme using our font family extension
    final TextTheme textTheme = fontFamilyChoice.buildTextTheme(fontSize);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: brightness == Brightness.dark
          ? kAppDarkCanvas
          : colorScheme.surface,
      textTheme: textTheme,
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainer,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }

  /// A convenience getter for the default Dark Forest theme.
  static ThemeData get defaultDarkTheme => buildTheme();

  /// A convenience getter for the default Light Forest theme.
  static ThemeData get defaultLightTheme =>
      buildTheme(brightness: Brightness.light);
}
