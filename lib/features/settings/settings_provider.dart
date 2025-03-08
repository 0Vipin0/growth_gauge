import 'package:flutter/material.dart';

import 'font_config.dart';
import 'settings_model.dart';
import 'theme_config.dart';

class SettingsProvider with ChangeNotifier {
  SettingsModel _settings;

  SettingsProvider()
      : _settings = const SettingsModel(
          themeName: AppThemeName.light,
          fontSize: AppFontSize.medium,
          fontFamily: AppFontFamily.roboto,
        );

  SettingsModel get settings => _settings;

  ThemeData getThemeData() {
    return settings.appTheme.getThemeData();
  }

  void updateThemeName(AppThemeName mode) {
    _settings = _settings.copyWith(themeName: mode);
    saveSettingsToStorage(); // Save to storage when theme mode changes
    notifyListeners();
  }

  void updateFontSize(AppFontSize fontSize) {
    _settings = _settings.copyWith(fontSize: fontSize);
    notifyListeners();
  }

  void updateFontFamily(AppFontFamily fontFamily) {
    _settings = _settings.copyWith(fontFamily: fontFamily);
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
    // Implement loading logic here, similar to your previous implementation but using enums
    notifyListeners();
  }

  // Save settings to persistent storage (e.g., SharedPreferences)
  Future<void> saveSettingsToStorage() async {
    // Implement saving logic here, similar to your previous implementation but using enums
  }
}
