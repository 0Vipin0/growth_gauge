import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesKeys {
  static const String hasCompletedOnboarding = 'hasCompletedOnboarding';
  static const String themeName = 'themeName';
  static const String fontSize = 'fontSize';
  static const String fontFamily = 'fontFamily';
  static const String exportFormat = 'exportFormat';
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
          'SharedPreferencesHelper has not been initialized. Call init() first.');
    }
    return _prefs!;
  }

  static Future<bool> getHasCompletedOnboarding() async {
    return instance.getBool(SharedPreferencesKeys.hasCompletedOnboarding) ??
        true;
  }

  static Future<bool> setHasCompletedOnboarding(bool value) {
    return instance.setBool(
        SharedPreferencesKeys.hasCompletedOnboarding, value);
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
}
