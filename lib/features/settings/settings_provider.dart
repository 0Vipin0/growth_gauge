import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../counter/counter.dart';
import '../timer/timer.dart';
import 'app_data.dart';
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

    _settings = SettingsModel(
      themeName: themeName,
      fontSize: fontSize,
      fontFamily: fontFamily,
    );
    notifyListeners();
  }

  Future<void> saveSettingsToStorage() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('themeName', _settings.themeName.name);
    await prefs.setString('fontSize', _settings.fontSize.name);
    await prefs.setString('fontFamily', _settings.fontFamily.name);
  }

  Future<void> exportData(
      List<CounterModel> counters, List<TimerModel> timers) async {
    try {
      final appData =
          await _prepareAppDataForExport(counters, timers); // Pass parameters
      final exportJson = jsonEncode(appData.toJson());

      String? filePath = await _getSaveFilePath();
      if (filePath == null) {
        throw Exception('Export Cancelled');
      }

      final file = File(filePath);
      await file.writeAsString(exportJson);
    } catch (e) {
      rethrow;
    }
  }

  Future<AppData> _prepareAppDataForExport(
      List<CounterModel> counters, List<TimerModel> timers) async {
    return AppData(
      version: 1,
      counters: counters,
      timers: timers,
    );
  }

  Future<String?> _getSaveFilePath() async {
    String? filePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save Export File',
      allowedExtensions: ['json'],
      type: FileType.custom,
      fileName: 'DataExport.json', // Default filename
    );
    return filePath;
  }

  Future<void> importData(
    Function(List<CounterModel>) counterImporter,
    Function(List<TimerModel>) timerImporter,
  ) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null && result.files.isNotEmpty) {
        File file = File(result.files.single.path!);
        String importJson = await file.readAsString();
        await _processImportData(
            importJson, counterImporter, timerImporter); // Pass providers
      } else {
        throw Exception('Import Cancelled');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _processImportData(
    String importJson,
    Function(List<CounterModel>) counterImporter,
    Function(List<TimerModel>) timerImporter,
  ) async {
    final Map<String, dynamic> jsonData = json.decode(importJson);
    final AppData appData = AppData.fromJson(jsonData);

    if (appData.version == 1) {
      _importVersion1Data(
        appData: appData,
        counterImporter: counterImporter,
        timerImporter: timerImporter,
      );
    } else {
      throw UnsupportedError('Unsupported data version: ${appData.version}');
    }
  }

  void _importVersion1Data({
    required AppData appData,
    required Function(List<CounterModel>) counterImporter,
    required Function(List<TimerModel>) timerImporter,
  }) {
    if (appData.counters.isNotEmpty) {
      counterImporter(appData.counters);
    }
    if (appData.timers.isNotEmpty) {
      timerImporter(appData.timers);
    }
  }
}
