import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

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
        ) {
    loadSettingsFromStorage();
  }

  SettingsModel get settings => _settings;

  ThemeData getThemeData() {
    return settings.appTheme.getThemeData();
  }

  void updateThemeName(AppThemeName mode) {
    _settings = _settings.copyWith(themeName: mode);
    saveSettingsToStorage();
    notifyListeners();
  }

  void updateFontSize(AppFontSize fontSize) {
    _settings = _settings.copyWith(fontSize: fontSize);
    saveSettingsToStorage();
    notifyListeners();
  }

  void updateFontFamily(AppFontFamily fontFamily) {
    _settings = _settings.copyWith(fontFamily: fontFamily);
    saveSettingsToStorage();
    notifyListeners();
  }

  void updateExportPath(String path) {
    _settings = _settings.copyWith(exportPath: path);
    saveSettingsToStorage();
    notifyListeners();
  }

  void updateImportPath(String path) {
    _settings = _settings.copyWith(importPath: path);
    saveSettingsToStorage();
    notifyListeners();
  }

  Future<void> loadSettingsFromStorage() async {
    final prefs = await SharedPreferences.getInstance();

    String? themeNameString = prefs.getString('themeName');
    AppThemeName themeName = AppThemeName.light; // Default
    if (themeNameString != null) {
      try {
        themeName = AppThemeName.values.byName(themeNameString);
      } catch (e) {
        debugPrint(
            'Error loading themeName from storage: $e, using default Light theme.');
        themeName = AppThemeName.light; // Fallback if name is invalid
      }
    }

    String? fontSizeString = prefs.getString('fontSize');
    AppFontSize fontSize = AppFontSize.medium; // Default
    if (fontSizeString != null) {
      try {
        fontSize = AppFontSize.values.byName(fontSizeString);
      } catch (e) {
        debugPrint(
            'Error loading fontSize from storage: $e, using default Medium font size.');
        fontSize = AppFontSize.medium; // Fallback if name is invalid
      }
    }

    String? fontFamilyString = prefs.getString('fontFamily');
    AppFontFamily fontFamily = AppFontFamily.roboto; // Default
    if (fontFamilyString != null) {
      try {
        fontFamily = AppFontFamily.values.byName(fontFamilyString);
      } catch (e) {
        debugPrint(
            'Error loading fontFamily from storage: $e, using default Roboto font family.');
        fontFamily = AppFontFamily.roboto; // Fallback if name is invalid
      }
    }

    final exportPath = prefs.getString('exportPath');
    final importPath = prefs.getString('importPath');

    _settings = SettingsModel(
      themeName: themeName,
      fontSize: fontSize,
      fontFamily: fontFamily,
      exportPath: exportPath,
      importPath: importPath,
    );
    notifyListeners();
  }

  Future<void> saveSettingsToStorage() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('themeName', _settings.themeName.name);
    await prefs.setString('fontSize', _settings.fontSize.name);
    await prefs.setString('fontFamily', _settings.fontFamily.name);
    if (_settings.exportPath != null) {
      await prefs.setString('exportPath', _settings.exportPath!);
    }
    if (_settings.importPath != null) {
      await prefs.setString('importPath', _settings.importPath!);
    }
  }
}
