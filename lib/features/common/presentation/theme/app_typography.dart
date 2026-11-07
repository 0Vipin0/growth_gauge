import 'package:flutter/material.dart';

enum AppFontSize() {
  small,
  medium,
  large,
  extraLarge,
}

extension AppFontSizeExtension on AppFontSize {
  double get multiplier {
    switch (this) {
      case AppFontSize.small:
        return 0.85;
      case AppFontSize.medium:
        return 1.0;
      case AppFontSize.large:
        return 1.15;
      case AppFontSize.extraLarge:
        return 1.3;
    }
  }

  String getLabel() {
    switch (this) {
      case AppFontSize.small:
        return 'Small';
      case AppFontSize.medium:
        return 'Medium';
      case AppFontSize.large:
        return 'Large';
      case AppFontSize.extraLarge:
        return 'Extra Large';
    }
  }
}

enum AppFontFamilyChoice() {
  manrope,
  openDyslexic,
  roboto,
  openSans,
  lato,
  montserrat,
  ceraPro,
  systemDefault,
}

extension AppFontFamilyChoiceExtension on AppFontFamilyChoice {
  String get fontFamilyName {
    switch (this) {
      case AppFontFamilyChoice.manrope:
        return 'Manrope';
      case AppFontFamilyChoice.openDyslexic:
        return 'OpenDyslexic';
      case AppFontFamilyChoice.roboto:
        return 'Roboto';
      case AppFontFamilyChoice.openSans:
        return 'OpenSans';
      case AppFontFamilyChoice.lato:
        return 'Lato';
      case AppFontFamilyChoice.montserrat:
        return 'Montserrat';
      case AppFontFamilyChoice.ceraPro:
        return 'CeraPro';
      case AppFontFamilyChoice.systemDefault:
        return '';
    }
  }

  String getLabel() {
    switch (this) {
      case AppFontFamilyChoice.manrope:
        return 'Manrope (Default)';
      case AppFontFamilyChoice.openDyslexic:
        return 'Open Dyslexic (Accessibility)';
      case AppFontFamilyChoice.roboto:
        return 'Roboto';
      case AppFontFamilyChoice.openSans:
        return 'Open Sans';
      case AppFontFamilyChoice.lato:
        return 'Lato';
      case AppFontFamilyChoice.montserrat:
        return 'Montserrat';
      case AppFontFamilyChoice.ceraPro:
        return 'CeraPro';
      case AppFontFamilyChoice.systemDefault:
        return 'System Default';
    }
  }

  /// Extension method replacing static text theme builders
  TextTheme buildTextTheme(AppFontSize fontSize) {
    final double mult = fontSize.multiplier;
    final String? family = this == AppFontFamilyChoice.systemDefault
        ? null
        : fontFamilyName;

    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: family,
        fontSize: 48.0 * mult,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
      displayMedium: TextStyle(
        fontFamily: family,
        fontSize: 40.0 * mult,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        fontFamily: family,
        fontSize: 36.0 * mult,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: TextStyle(
        fontFamily: family,
        fontSize: 32.0 * mult,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontFamily: family,
        fontSize: 28.0 * mult,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        fontFamily: family,
        fontSize: 24.0 * mult,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontFamily: family,
        fontSize: 20.0 * mult,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        fontFamily: family,
        fontSize: 16.0 * mult,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontFamily: family,
        fontSize: 14.0 * mult,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontFamily: family,
        fontSize: 16.0 * mult,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        fontFamily: family,
        fontSize: 14.0 * mult,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        fontFamily: family,
        fontSize: 12.0 * mult,
        fontWeight: FontWeight.normal,
      ),
      labelLarge: TextStyle(
        fontFamily: family,
        fontSize: 14.0 * mult,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        fontFamily: family,
        fontSize: 12.0 * mult,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        fontFamily: family,
        fontSize: 11.0 * mult,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
