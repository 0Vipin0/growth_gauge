import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesKeys {
  static const String countersStorageKey = 'counters';
  static const String timersStorageKey = 'timers';
  static const String hasCompletedOnboarding = 'hasCompletedOnboarding';
  static const String themeName = 'themeName';
  static const String fontSize = 'fontSize';
  static const String fontFamily = 'fontFamily';
  static const String exportFormat = 'exportFormat';
  static const String authenticationType = 'authenticationType';
  static const String notificationTime = 'notificationTime';
  static const String ttsEnabled = 'ttsEnabled';
}

mixin SharedPreferencesHelper {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  static SharedPreferences get instance {
    if (_prefs == null) {
      throw Exception(
        'SharedPreferencesHelper has not been initialized. Call init() first.',
      );
    }
    return _prefs!;
  }

  static String? getCounters() {
    return instance.getString(SharedPreferencesKeys.countersStorageKey);
  }

  static Future<bool> setCounters(String value) {
    return instance.setString(SharedPreferencesKeys.countersStorageKey, value);
  }

  static String? getTimers() {
    return instance.getString(SharedPreferencesKeys.timersStorageKey);
  }

  static Future<bool> setTimers(String value) {
    return instance.setString(SharedPreferencesKeys.timersStorageKey, value);
  }

  static Future<bool> removeTimers() {
    return instance.remove(SharedPreferencesKeys.timersStorageKey);
  }

  static Future<bool?>? getHasCompletedOnboarding() async {
    return instance.getBool(SharedPreferencesKeys.hasCompletedOnboarding);
  }

  static Future<bool> setHasCompletedOnboarding(bool value) {
    return instance.setBool(
      SharedPreferencesKeys.hasCompletedOnboarding,
      value,
    );
  }

  static String? getThemeName() {
    return instance.getString(SharedPreferencesKeys.themeName);
  }

  static Future<bool> setThemeName(String value) {
    return instance.setString(SharedPreferencesKeys.themeName, value);
  }

  static String? getFontSize() {
    return instance.getString(SharedPreferencesKeys.fontSize);
  }

  static Future<bool> setFontSize(String value) {
    return instance.setString(SharedPreferencesKeys.fontSize, value);
  }

  static String? getFontFamily() {
    return instance.getString(SharedPreferencesKeys.fontFamily);
  }

  static Future<bool> setFontFamily(String value) {
    return instance.setString(SharedPreferencesKeys.fontFamily, value);
  }

  static String? getExportFormat() {
    return instance.getString(SharedPreferencesKeys.exportFormat);
  }

  static Future<bool> setExportFormat(String value) {
    return instance.setString(SharedPreferencesKeys.exportFormat, value);
  }

  static String? getAuthenticationType() {
    return instance.getString(SharedPreferencesKeys.authenticationType);
  }

  static Future<bool> setAuthenticationType(String value) {
    return instance.setString(SharedPreferencesKeys.authenticationType, value);
  }

  static String? getNotificationTime() {
    return instance.getString(SharedPreferencesKeys.notificationTime);
  }

  static Future<bool> setNotificationTime(String value) {
    return instance.setString(SharedPreferencesKeys.notificationTime, value);
  }

  static bool? getTtsEnabled() => instance.getBool(SharedPreferencesKeys.ttsEnabled);

  static Future<bool> setTtsEnabled(bool value) => instance.setBool(SharedPreferencesKeys.ttsEnabled, value);
}
