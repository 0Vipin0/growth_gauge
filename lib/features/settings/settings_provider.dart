import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'app_theme_mode.dart';
import 'font_size_config.dart';
import 'settings_model.dart';

class SettingsProvider with ChangeNotifier {
  SettingsModel _settings;

  SettingsProvider()
      : _settings = const SettingsModel(
          themeMode: AppThemeMode.light,
          themeColor: Colors.blue,
          fontSize: FontSizeConfig.medium,
        );

  SettingsModel get settings => _settings;

  ThemeData getThemeData(TextTheme textTheme) {
    final appTheme = AppTheme(textTheme); // Or your custom TextTheme
    switch (_settings.themeMode) {
      case AppThemeMode.light:
        return appTheme.light();
      case AppThemeMode.lightMediumContrast:
        return appTheme.lightMediumContrast();
      case AppThemeMode.lightHighContrast:
        return appTheme.lightHighContrast();
      case AppThemeMode.dark:
        return appTheme.dark();
      case AppThemeMode.darkMediumContrast:
        return appTheme.darkMediumContrast();
      case AppThemeMode.darkHighContrast:
        return appTheme.darkHighContrast();
      default:
        return appTheme.light(); // Default to light theme
    }
  }

  // Update Theme Mode
  void updateThemeMode(AppThemeMode mode) {
    _settings = _settings.copyWith(themeMode: mode);
    saveSettingsToStorage(); // Save to storage when theme mode changes
    notifyListeners();
  }

  void updateThemeColor(Color color) {
    _settings = _settings.copyWith(themeColor: color);
    notifyListeners();
  }

  void updateFontSize(double fontSize) {
    _settings = _settings.copyWith(fontSize: fontSize);
    notifyListeners();
  }

  void updateExportPath(String path) {
    _settings = _settings.copyWith(exportPath: path);
    notifyListeners();
  }

  void updateImportPath(String path) {
    _settings = _settings.copyWith(importPath: path);
    notifyListeners();
  }

  // Load settings from persistent storage (e.g., SharedPreferences)
  Future<void> loadSettingsFromStorage() async {
    // Logic to load settings from storage and update the _settings
    // For example, using SharedPreferences or another storage solution.
    // Example:
    // final prefs = await SharedPreferences.getInstance();
    // final themeColorValue = prefs.getInt('themeColor') ?? Colors.blue.value;
    // final fontSize = prefs.getDouble('fontSize') ?? FontSizeConfig.medium;
    // final exportPath = prefs.getString('exportPath');
    // final importPath = prefs.getString('importPath');
    // String? themeModeString = prefs.getString('themeMode');
    // AppThemeMode themeMode = AppThemeMode.light; // Default
    // if (themeModeString != null) {
    //   themeMode = AppThemeMode.values.byName(themeModeString);
    // }

    // _settings = SettingsModel(
    //   themeMode: themeMode,
    //   themeColor: Color(themeColorValue),
    //   fontSize: fontSize,
    //   exportPath: exportPath,
    //   importPath: importPath,
    // );
    notifyListeners();
  }

  // Save settings to persistent storage (e.g., SharedPreferences)
  Future<void> saveSettingsToStorage() async {
    // Logic to save the current settings to storage
    // For example, using SharedPreferences or another storage solution.
    // Example:
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setInt('themeColor', _settings.themeColor.value);
    // await prefs.setDouble('fontSize', _settings.fontSize);
    // if (_settings.exportPath != null) {
    //   await prefs.setString('exportPath', _settings.exportPath!);
    // }
    // if (_settings.importPath != null) {
    //   await prefs.setString('importPath', _settings.importPath!);
    // }
    // await prefs.setString('themeMode', _settings.themeMode.name); // Save theme mode as String
  }
}
