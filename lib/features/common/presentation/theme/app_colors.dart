import 'package:flutter/material.dart';

enum AppThemeName() {
  forest,
  midnight,
  amber,
  slate,
  rust,
  moss,
  cyan,
  custom,
}

extension AppThemeNameExtension on AppThemeName {
  String getLabel() {
    switch (this) {
      case AppThemeName.forest:
        return 'Forest (Default)';
      case AppThemeName.midnight:
        return 'Midnight';
      case AppThemeName.amber:
        return 'Amber';
      case AppThemeName.slate:
        return 'Slate';
      case AppThemeName.rust:
        return 'Rust';
      case AppThemeName.moss:
        return 'Moss';
      case AppThemeName.cyan:
        return 'Cyan';
      case AppThemeName.custom:
        return 'Custom';
    }
  }

  Color get seedColor {
    switch (this) {
      case AppThemeName.forest:
        return const Color(0xFF00FF66);
      case AppThemeName.midnight:
        return const Color(0xFF5C6BC0);
      case AppThemeName.amber:
        return const Color(0xFFFFB300);
      case AppThemeName.slate:
        return const Color(0xFF78909C);
      case AppThemeName.rust:
        return const Color(0xFFFF5722);
      case AppThemeName.moss:
        return const Color(0xFF4CAF50);
      case AppThemeName.cyan:
        return const Color(0xFF00E5FF);
      case AppThemeName.custom:
        return const Color(0xFF00FF66);
    }
  }
}

enum AppContrastVariant() {
  standard,
  mediumContrast,
  highContrast,
}

extension AppContrastVariantExtension on AppContrastVariant {
  String getLabel() {
    switch (this) {
      case AppContrastVariant.standard:
        return 'Standard';
      case AppContrastVariant.mediumContrast:
        return 'Medium Contrast';
      case AppContrastVariant.highContrast:
        return 'High Contrast';
    }
  }
}

/// M3 Tonal Surfaces (Top-level constants avoiding static class wrapper warnings)
const Color kAppDarkCanvas = Color(0xFF0E1410);
const Color kAppDarkLowest = Color(0xFF090D0A);
const Color kAppDarkLow = Color(0xFF131A14);
const Color kAppDarkSurface = Color(0xFF1A221C);
const Color kAppDarkHigh = Color(0xFF222B24);
const Color kAppDarkHighest = Color(0xFF2A342C);
const Color kAppDarkOnSurface = Color(0xFFDFE3DD);
const Color kAppDarkOnSurfaceVariant = Color(0xFF8E988F);

class const AppColorTheme({
  required final AppThemeName seedName,
  required final Brightness brightness,
  required final AppContrastVariant contrastVariant,
  required final ColorScheme colorScheme,
});

/// Extension on AppThemeName to generate color schemes natively,
/// replacing the need for static factory classes.
extension AppThemeColorSchemeExtension on AppThemeName {
  ColorScheme createColorScheme({
    required Brightness brightness,
    required AppContrastVariant contrastVariant,
    Color? customSeedColor,
  }) {
    final seed = customSeedColor ?? seedColor;

    var baseScheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
    );

    if (brightness == Brightness.dark) {
      baseScheme = baseScheme.copyWith(
        surface: kAppDarkSurface,
        onSurface: kAppDarkOnSurface,
        onSurfaceVariant: kAppDarkOnSurfaceVariant,
        surfaceContainerLowest: kAppDarkLowest,
        surfaceContainerLow: kAppDarkLow,
        surfaceContainer: kAppDarkSurface,
        surfaceContainerHigh: kAppDarkHigh,
        surfaceContainerHighest: kAppDarkHighest,
      );
    }

    if (contrastVariant == AppContrastVariant.highContrast) {
      baseScheme = baseScheme.copyWith(
        onSurface: brightness == Brightness.dark ? Colors.white : Colors.black,
        outline: baseScheme.onSurface,
      );
    }

    return baseScheme;
  }
}

/// Top-level function to build default themes cleanly
List<AppColorTheme> buildDefaultAppThemes() {
  final List<AppColorTheme> themes = [];

  for (final seed in AppThemeName.values) {
    for (final brightness in Brightness.values) {
      for (final contrast in AppContrastVariant.values) {
        themes.add(
          AppColorTheme(
            seedName: seed,
            brightness: brightness,
            contrastVariant: contrast,
            colorScheme: seed.createColorScheme(
              brightness: brightness,
              contrastVariant: contrast,
            ),
          ),
        );
      }
    }
  }
  return themes;
}

final List<AppColorTheme> appColorThemes = buildDefaultAppThemes();
