import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

import '../notification/infrastructure/notification_service.dart';
import 'config/config.dart';
import 'model/model.dart';

class SettingsProvider({required final NotificationService notificationService})
    with ChangeNotifier {
  final NotificationService _notificationService = notificationService;
  final LocalAuthentication _localAuth = LocalAuthentication();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  SettingsModel _settings = const SettingsModel(themeName: AppThemeName.light);
  bool _isReady = false;

  bool get isReady => _isReady;

  this {
    loadSettingsFromStorage();
  }

  SettingsModel get settings => _settings;

  ThemeData getThemeData() => settings.appTheme.getThemeData();

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

  void updateAuthenticationType(AuthenticationType type) {
    if (type == AuthenticationType.none) _secureStorage.deleteAll();
    _settings = _settings.copyWith(authenticationType: type);
    saveSettingsToStorage();
    notifyListeners();
  }

  TimeOfDay? get notificationTime => _settings.notificationTime;

  void updateNotificationTime(TimeOfDay time) {
    _settings = _settings.copyWith(notificationTime: time);
    _notificationService.scheduleDailyNotification(
      id: 1,
      title: 'Keep the Growth going forever!',
      body: 'Log the items that you have progressed today and keep up the good work!!',
      time: time,
      sound: 'assets/sounds/simple_notification.mp3',
    );
    saveSettingsToStorage();
    notifyListeners();
  }

  Future<void> loadSettingsFromStorage() async {
    final themeName = _enumValue(
      SharedPreferencesHelper.getThemeName(),
      AppThemeName.values,
      AppThemeName.light,
    );
    final fontSize = _enumValue(
      SharedPreferencesHelper.getFontSize(),
      AppFontSize.values,
      AppFontSize.medium,
    );
    final fontFamily = _enumValue(
      SharedPreferencesHelper.getFontFamily(),
      AppFontFamily.values,
      AppFontFamily.roboto,
    );
    final authenticationType = _enumValue(
      SharedPreferencesHelper.getAuthenticationType(),
      AuthenticationType.values,
      AuthenticationType.none,
    );
    final notificationTime = const TimeOfDayConverter().fromJson(
      SharedPreferencesHelper.getNotificationTime(),
    );
    _settings = SettingsModel(
      themeName: themeName,
      fontSize: fontSize,
      fontFamily: fontFamily,
      authenticationType: authenticationType,
      notificationTime: notificationTime,
    );
    _isReady = true;
    notifyListeners();
  }

  T _enumValue<T extends Enum>(String? name, List<T> values, T fallback) {
    for (final value in values) {
      if (value.name == name) return value;
    }
    return fallback;
  }

  Future<void> saveSettingsToStorage() async {
    await SharedPreferencesHelper.setThemeName(_settings.themeName.name);
    await SharedPreferencesHelper.setFontSize(_settings.fontSize.name);
    await SharedPreferencesHelper.setFontFamily(_settings.fontFamily.name);
    await SharedPreferencesHelper.setAuthenticationType(
      _settings.authenticationType.name,
    );
    final time = const TimeOfDayConverter().toJson(_settings.notificationTime);
    if (time != null) {
      await SharedPreferencesHelper.setNotificationTime(time);
    }
  }

  Future<bool> isBiometricAvailable() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } catch (error) {
      debugPrint('Error checking biometric availability: $error');
      return false;
    }
  }
}
