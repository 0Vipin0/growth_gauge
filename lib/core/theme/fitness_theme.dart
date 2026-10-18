import 'package:flutter/material.dart';

/// High contrast Material 3 color schemes used throughout the fitness flow.
class const FitnessTheme._() {
  static ThemeData light({TextTheme? textTheme, double contrastLevel = 0}) =>
      ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF075E54),
          primary: const Color(0xFF075E54),
          secondary: const Color(0xFF4A3A00),
          onSecondary: Colors.white,
          error: const Color(0xFFBA1A1A),
          onError: Colors.white,
          contrastLevel: contrastLevel,
        ),
        textTheme: textTheme,
      );

  static ThemeData dark({TextTheme? textTheme, double contrastLevel = 0}) =>
      ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF75D7C5),
          brightness: Brightness.dark,
          primary: const Color(0xFF75D7C5),
          onPrimary: const Color(0xFF003731),
          secondary: const Color(0xFFFFD54F),
          onSecondary: const Color(0xFF3B2F00),
          error: const Color(0xFFFFB4AB),
          onError: const Color(0xFF690005),
          contrastLevel: contrastLevel,
        ),
        textTheme: textTheme,
      );
}
