import 'package:flutter/material.dart';

/// High contrast Material 3 color schemes used throughout the fitness flow.
class const FitnessTheme._() {
  /// Light fitness theme variant for daylight use.
  static ThemeData light({TextTheme? textTheme, double contrastLevel = 0}) =>
      ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF008732),
          primary: const Color(0xFF008732),
          onPrimary: Colors.white,
          secondary: const Color(0xFF45633F),
          onSecondary: Colors.white,
          surface: const Color(0xFFF5FBF2),
          onSurface: const Color(0xFF171D17),
          error: const Color(0xFFBA1A1A),
          onError: Colors.white,
          contrastLevel: contrastLevel,
        ),
        textTheme: textTheme,
      );

  /// True deep dark background fitness theme variant matching the dark UI screenshots.
  static ThemeData dark({TextTheme? textTheme, double contrastLevel = 0}) =>
      ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00FF66),
          brightness: Brightness.dark,
          primary: const Color(0xFF00FF66), // Vibrant fitness action green
          onPrimary: const Color(0xFF003913),
          secondary: const Color(0xFFB0CCA8),
          onSecondary: const Color(0xFF1D351A),
          surface: const Color(
            0xFF0E1410,
          ), // True deep dark greenish-black background
          onSurface: const Color(0xFFDFE3DD),
          surfaceContainer: const Color(
            0xFF1A221C,
          ), // Card container dark background
          error: const Color(0xFFFFB4AB),
          onError: const Color(0xFF690005),
          contrastLevel: contrastLevel,
        ),
        textTheme: textTheme,
      );
}
