import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

import '../counter/counter.dart';
import '../timer/timer.dart';
import 'config/config.dart';
import 'model/model.dart';

class SettingsProvider with ChangeNotifier {
  SettingsModel _settings;

  final CounterListProvider _counterListProvider;
  final TimerListProvider _timerListProvider;

  bool _isExporting = false;

  bool get isExporting => _isExporting;

  String exportMessage = '';

  bool _isImporting = false;

  bool get isImporting => _isImporting;

  String importMessage = '';

  late bool isOnboardingComplete;

  final LocalAuthentication _localAuth = LocalAuthentication();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  SettingsProvider({
    required CounterListProvider counterListProvider,
    required TimerListProvider timerListProvider,
  })  : _settings = const SettingsModel(themeName: AppThemeName.light),
        _counterListProvider = counterListProvider,
        _timerListProvider = timerListProvider {
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

  void updateExportFormat(ExportFormat value) {
    _settings = _settings.copyWith(exportFormat: value);
    saveSettingsToStorage();
    notifyListeners();
  }

  void updateAuthenticationType(AuthenticationType type) {
    if (type == AuthenticationType.none) {
      _secureStorage.deleteAll();
    }
    _settings = _settings.copyWith(authenticationType: type);
    saveSettingsToStorage();
    notifyListeners();
  }

  TimeOfDay? get notificationTime => _settings.notificationTime;

  void updateNotificationTime(TimeOfDay time) {
    _settings = _settings.copyWith(notificationTime: time);
    saveSettingsToStorage();
    notifyListeners();
  }

  Future<void> loadSettingsFromStorage() async {
    isOnboardingComplete =
        await SharedPreferencesHelper.getHasCompletedOnboarding() ?? true;

    final String? themeNameString = SharedPreferencesHelper.getThemeName();
    AppThemeName themeName = AppThemeName.light; // Default
    if (themeNameString != null) {
      try {
        themeName = AppThemeName.values.byName(themeNameString);
      } catch (e) {
        debugPrint(
          'Error loading themeName from storage: $e, using default Light theme.',
        );
        themeName = AppThemeName.light; // Fallback if name is invalid
      }
    }

    final String? fontSizeString = SharedPreferencesHelper.getFontSize();
    AppFontSize fontSize = AppFontSize.medium; // Default
    if (fontSizeString != null) {
      try {
        fontSize = AppFontSize.values.byName(fontSizeString);
      } catch (e) {
        debugPrint(
          'Error loading fontSize from storage: $e, using default Medium font size.',
        );
        fontSize = AppFontSize.medium; // Fallback if name is invalid
      }
    }

    final String? fontFamilyString = SharedPreferencesHelper.getFontFamily();
    AppFontFamily fontFamily = AppFontFamily.roboto; // Default
    if (fontFamilyString != null) {
      try {
        fontFamily = AppFontFamily.values.byName(fontFamilyString);
      } catch (e) {
        debugPrint(
          'Error loading fontFamily from storage: $e, using default Roboto font family.',
        );
        fontFamily = AppFontFamily.roboto; // Fallback if name is invalid
      }
    }

    final String? exportFormatString =
        SharedPreferencesHelper.getExportFormat();
    ExportFormat exportFormat = ExportFormat.json; // Default
    if (exportFormatString != null) {
      try {
        exportFormat = ExportFormat.values.byName(exportFormatString);
      } catch (e) {
        debugPrint(
          'Error loading fontFamily from storage: $e, using default Roboto font family.',
        );
        exportFormat = ExportFormat.json; // Fallback if name is invalid
      }
    }

    final String? authenticationTypeString =
        SharedPreferencesHelper.getAuthenticationType();
    AuthenticationType authenticationType = AuthenticationType.none; // Default
    if (authenticationTypeString != null) {
      try {
        authenticationType =
            AuthenticationType.values.byName(authenticationTypeString);
      } catch (e) {
        debugPrint(
          'Error loading authenticationType from storage: $e, using default None authentication type.',
        );
        authenticationType =
            AuthenticationType.none; // Fallback if name is invalid
      }
    }

    final String? notificationTimeString = SharedPreferencesHelper.getNotificationTime();
    TimeOfDay? notificationTime;
    if (notificationTimeString != null) {
      final parts = notificationTimeString.split(':');
      if (parts.length == 2) {
        final hour = int.tryParse(parts[0]);
        final minute = int.tryParse(parts[1]);
        if (hour != null && minute != null) {
          notificationTime = TimeOfDay(hour: hour, minute: minute);
        }
      }
    }

    _settings = SettingsModel(
      themeName: themeName,
      fontSize: fontSize,
      fontFamily: fontFamily,
      exportFormat: exportFormat,
      authenticationType: authenticationType,
      notificationTime: notificationTime,
    );
    notifyListeners();
  }

  Future<void> saveSettingsToStorage() async {
    await SharedPreferencesHelper.setThemeName(_settings.themeName.name);
    await SharedPreferencesHelper.setFontSize(_settings.fontSize.name);
    await SharedPreferencesHelper.setFontFamily(_settings.fontFamily.name);
    await SharedPreferencesHelper.setExportFormat(_settings.exportFormat.name);
    await SharedPreferencesHelper.setAuthenticationType(
        _settings.authenticationType.name);
    await SharedPreferencesHelper.setNotificationTime(
        '${_settings.notificationTime?.hour}:${_settings.notificationTime?.minute}');
  }

  Future<void> exportData() async {
    _isExporting = true;
    notifyListeners();
    try {
      final appData = await _prepareAppDataForExport(
        _counterListProvider.counters,
        _timerListProvider.timers,
      ); // Pass parameters
      final exportJson = jsonEncode(appData.toJson());

      final String? filePath = await _getSaveFilePath();
      if (filePath == null) {
        exportMessage = 'Export Cancelled';
        return;
      }

      final file = File(filePath);
      await file.writeAsString(exportJson);
      exportMessage = 'Data exported successfully!';
    } catch (e) {
      exportMessage = 'Error exporting data: $e';
    } finally {
      _isExporting = false;
      notifyListeners();
    }
  }

  Future<AppData> _prepareAppDataForExport(
    List<CounterModel> counters,
    List<TimerModel> timers,
  ) async {
    return AppData(counters: counters, timers: timers);
  }

  Future<String?> _getSaveFilePath() async {
    final String? filePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save Export File',
      allowedExtensions: ['json'],
      type: FileType.custom,
      fileName: 'DataExport.json', // Default filename
    );
    return filePath;
  }

  Future<void> importData() async {
    _isImporting = true;
    notifyListeners();
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null && result.files.isNotEmpty) {
        final File file = File(result.files.single.path!);
        final String importJson = await file.readAsString();
        await _processImportData(
          importJson,
          _counterListProvider.importCountersFromData,
          _timerListProvider.importTimersFromData,
        );
        importMessage = 'Data imported successfully!';
      } else {
        importMessage = 'Import Cancelled';
        return;
      }
    } catch (e) {
      importMessage = 'Error exporting data: $e';
    } finally {
      _isImporting = false;
      notifyListeners();
    }
  }

  Future<void> _processImportData(
    String importJson,
    Function(List<CounterModel>) counterImporter,
    Function(List<TimerModel>) timerImporter,
  ) async {
    final Map<String, dynamic> jsonData =
        json.decode(importJson) as Map<String, dynamic>;
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

  Future<void> toggleOnboarding(bool value) async {
    isOnboardingComplete = value;
    await SharedPreferencesHelper.setHasCompletedOnboarding(
      isOnboardingComplete,
    );
    notifyListeners();
  }

  Future<void> exportDataToCsv() async {
    _isExporting = true;
    notifyListeners();
    try {
      // Export counters to CSV
      await _exportCountersToCsv();
      // Export timers to CSV
      await _exportTimersToCsv();

      exportMessage = 'Data exported successfully to CSV!';
    } catch (e) {
      exportMessage = 'Error exporting data to CSV: $e';
    } finally {
      _isExporting = false;
      notifyListeners();
    }
  }

  Future<void> _exportCountersToCsv() async {
    if (_counterListProvider.counters.isEmpty) return;

    try {
      final String? filePath = await _getCsvSaveFilePath(
        suggestedName: 'counters.csv',
      );
      if (filePath == null) {
        exportMessage = 'Export Cancelled';
        return;
      }

      final file = File(filePath);
      await file.writeAsString(_counterListProvider.convertToCSV());
      exportMessage = 'Counter Data exported successfully!';
    } catch (e) {
      exportMessage = 'Error exporting counter data: $e';
    }
    notifyListeners();
  }

  Future<void> _exportTimersToCsv() async {
    if (_timerListProvider.timers.isEmpty) return;

    try {
      final String? filePath = await _getCsvSaveFilePath(
        suggestedName: 'timers.csv',
      );
      if (filePath == null) {
        exportMessage = 'Export Cancelled';
        return;
      }

      final file = File(filePath);
      await file.writeAsString(_timerListProvider.convertToCSV());
      exportMessage = 'Timer Data exported successfully!';
    } catch (e) {
      exportMessage = 'Error exporting timer data: $e';
    }
    notifyListeners();
  }

  Future<String?> _getCsvSaveFilePath({String? suggestedName}) async {
    final String? filePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save Export File',
      allowedExtensions: ['json'],
      type: FileType.custom,
      fileName: suggestedName,
    );
    return filePath;
  }

  void clearAppData() {
    _counterListProvider.clearCounters();
    _timerListProvider.clearTimers();
    notifyListeners();
  }

  Future<bool> isBiometricAvailable() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } catch (e) {
      debugPrint('Error checking biometric availability: $e');
      return false;
    }
  }
}
