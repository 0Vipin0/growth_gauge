import 'package:flutter/material.dart';
import 'font_size_config.dart';
import 'settings_model.dart';

class SettingsProvider with ChangeNotifier {
  SettingsModel _settings;

  SettingsProvider()
      : _settings = const SettingsModel(
          themeColor: Colors.blue,
          fontSize: FontSizeConfig.medium,
        );

  SettingsModel get settings => _settings;

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
    // _settings = SettingsModel(
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
  }
}
