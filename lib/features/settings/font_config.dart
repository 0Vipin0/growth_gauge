import 'package:flutter/material.dart';

enum AppFontSize {
  small,
  medium,
  large,
  extraLarge,
}

extension AppFontSizeExtension on AppFontSize {
  double getSize() {
    switch (this) {
      case AppFontSize.small:
        return 12.0;
      case AppFontSize.medium:
        return 16.0;
      case AppFontSize.large:
        return 20.0;
      case AppFontSize.extraLarge:
        return 24.0;
      default:
        return 16.0; // Default medium
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
      default:
        return name;
    }
  }
}

enum AppFontFamily {
  roboto,
  openSans,
  lato,
  montserrat,
  ceraPro,
}

extension AppFontFamilyExtension on AppFontFamily {
  String get fontFamilyName {
    switch (this) {
      case AppFontFamily.roboto:
        return 'Roboto';
      case AppFontFamily.openSans:
        return 'OpenSans';
      case AppFontFamily.lato:
        return 'Lato';
      case AppFontFamily.montserrat:
        return 'Montserrat';
      case AppFontFamily.ceraPro:
        return 'CeraPro';
      default:
        return 'Roboto'; // Default font family
    }
  }

  String getLabel() {
    switch (this) {
      case AppFontFamily.roboto:
        return 'Roboto';
      case AppFontFamily.openSans:
        return 'Open Sans';
      case AppFontFamily.lato:
        return 'Lato';
      case AppFontFamily.montserrat:
        return 'Montserrat';
      case AppFontFamily.ceraPro:
        return 'CeraPro';
      default:
        return name;
    }
  }
}

class AppFontTheme {
  final AppFontFamily fontFamily;
  final AppFontSize fontSize;
  final TextTheme textTheme;

  AppFontTheme({required this.fontFamily, required this.fontSize})
      : textTheme = _buildTextTheme(fontFamily, fontSize);

  static TextTheme _buildTextTheme(
      AppFontFamily fontFamily, AppFontSize fontSize) {
    final baseFontSize = fontSize.getSize();
    return TextTheme(
      displayLarge: TextStyle(
          fontFamily: fontFamily.fontFamilyName,
          fontSize: baseFontSize * 2.8,
          fontWeight: FontWeight.bold),
      displayMedium: TextStyle(
          fontFamily: fontFamily.fontFamilyName,
          fontSize: baseFontSize * 2.5,
          fontWeight: FontWeight.bold),
      displaySmall: TextStyle(
          fontFamily: fontFamily.fontFamilyName,
          fontSize: baseFontSize * 2.2,
          fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(
          fontFamily: fontFamily.fontFamilyName,
          fontSize: baseFontSize * 2.0,
          fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(
          fontFamily: fontFamily.fontFamilyName,
          fontSize: baseFontSize * 1.8,
          fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(
          fontFamily: fontFamily.fontFamilyName,
          fontSize: baseFontSize * 1.6,
          fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
          fontFamily: fontFamily.fontFamilyName,
          fontSize: baseFontSize * 1.4,
          fontWeight: FontWeight.bold),
      titleMedium: TextStyle(
          fontFamily: fontFamily.fontFamilyName,
          fontSize: baseFontSize * 1.2,
          fontWeight: FontWeight.bold),
      titleSmall: TextStyle(
          fontFamily: fontFamily.fontFamilyName,
          fontSize: baseFontSize * 1.0,
          fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(
          fontFamily: fontFamily.fontFamilyName, fontSize: baseFontSize * 1.0),
      bodyMedium: TextStyle(
          fontFamily: fontFamily.fontFamilyName, fontSize: baseFontSize * 0.9),
      bodySmall: TextStyle(
          fontFamily: fontFamily.fontFamilyName, fontSize: baseFontSize * 0.8),
      labelLarge: TextStyle(
          fontFamily: fontFamily.fontFamilyName,
          fontSize: baseFontSize * 0.9,
          fontWeight: FontWeight.bold),
      labelMedium: TextStyle(
          fontFamily: fontFamily.fontFamilyName,
          fontSize: baseFontSize * 0.8,
          fontWeight: FontWeight.bold),
      labelSmall: TextStyle(
          fontFamily: fontFamily.fontFamilyName,
          fontSize: baseFontSize * 0.7,
          fontWeight: FontWeight.bold),
    );
  }
}
