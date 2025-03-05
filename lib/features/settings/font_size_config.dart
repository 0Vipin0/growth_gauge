import 'package:flutter/material.dart';

class FontSizeConfig {
  static const double small = 12.0;
  static const double medium = 16.0;
  static const double large = 20.0;

  static TextTheme getTextTheme(double fontSize) {
    return TextTheme(
      displayLarge:
          TextStyle(fontSize: fontSize * 2.8, fontWeight: FontWeight.bold),
      displayMedium:
          TextStyle(fontSize: fontSize * 2.5, fontWeight: FontWeight.bold),
      displaySmall:
          TextStyle(fontSize: fontSize * 2.2, fontWeight: FontWeight.bold),
      headlineLarge:
          TextStyle(fontSize: fontSize * 2.0, fontWeight: FontWeight.bold),
      headlineMedium:
          TextStyle(fontSize: fontSize * 1.8, fontWeight: FontWeight.bold),
      headlineSmall:
          TextStyle(fontSize: fontSize * 1.6, fontWeight: FontWeight.bold),
      titleLarge:
          TextStyle(fontSize: fontSize * 1.4, fontWeight: FontWeight.bold),
      titleMedium:
          TextStyle(fontSize: fontSize * 1.2, fontWeight: FontWeight.bold),
      titleSmall:
          TextStyle(fontSize: fontSize * 1.0, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: fontSize * 1.0),
      bodyMedium: TextStyle(fontSize: fontSize * 0.9),
      bodySmall: TextStyle(fontSize: fontSize * 0.8),
      labelLarge:
          TextStyle(fontSize: fontSize * 0.9, fontWeight: FontWeight.bold),
      labelMedium:
          TextStyle(fontSize: fontSize * 0.8, fontWeight: FontWeight.bold),
      labelSmall:
          TextStyle(fontSize: fontSize * 0.7, fontWeight: FontWeight.bold),
    );
  }

  static TextTheme smallTextTheme = getTextTheme(small);
  static TextTheme mediumTextTheme = getTextTheme(medium);
  static TextTheme largeTextTheme = getTextTheme(large);
}
