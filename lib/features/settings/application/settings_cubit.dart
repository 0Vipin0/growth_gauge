import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

import '../../common/presentation/theme/theme.dart';
import '../../notification/infrastructure/notification_service.dart';
import '../config/shared_preferences_config.dart';
import '../domain/domain.dart';
import 'settings_state.dart';

class SettingsCubit({
  required final NotificationService _notificationService,
  LocalAuthentication? localAuth,
  FlutterSecureStorage? secureStorage,
}) extends Cubit<SettingsState> {
  final LocalAuthentication _localAuth = localAuth ?? LocalAuthentication();
  final FlutterSecureStorage _secureStorage =
      secureStorage ?? const FlutterSecureStorage();

  this : super(const SettingsState()) {
    unawaited(loadSettingsFromStorage());
  }

  void updateThemeName(AppThemeName themeName) =>
      _updateSettings(state.settings.copyWith(themeName: themeName));

  void updateThemeMode(ThemeMode themeMode) =>
      _updateSettings(state.settings.copyWith(themeMode: themeMode));

  void updateContrastVariant(AppContrastVariant contrastVariant) =>
      _updateSettings(
        state.settings.copyWith(contrastVariant: contrastVariant),
      );

  void updateFontSize(AppFontSize fontSize) =>
      _updateSettings(state.settings.copyWith(fontSize: fontSize));

  void updateFontFamilyChoice(AppFontFamilyChoice fontFamilyChoice) =>
      _updateSettings(
        state.settings.copyWith(fontFamilyChoice: fontFamilyChoice),
      );

  Future<void> updateAuthenticationType(AuthenticationType type) async {
    try {
      if (type == AuthenticationType.none) await _secureStorage.deleteAll();
      _updateSettings(
        state.settings.copyWith(authenticationType: type),
        persist: false,
      );
      await saveSettingsToStorage();
    } catch (error) {
      _emitError('Could not update authentication settings: $error');
    }
  }

  Future<void> updateNotificationTime(TimeOfDay time) async {
    _updateSettings(
      state.settings.copyWith(notificationTime: time),
      persist: false,
    );
    try {
      await _notificationService.scheduleDailyNotification(
        id: 1,
        title: 'Keep the Growth going forever!',
        body: 'Log the items that you have progressed today and keep up the good work!!',
        time: time,
        sound: 'assets/sounds/simple_notification.mp3',
      );
    } catch (error) {
      _emitError('Could not schedule the daily notification: $error');
    }
    await saveSettingsToStorage();
  }

  Future<void> loadSettingsFromStorage() async {
    try {
      final themeName = _enumValue(
        SharedPreferencesHelper.getThemeName(),
        AppThemeName.values,
        AppThemeName.forest,
      );

      final themeMode = _enumValue(
        SharedPreferencesHelper.getThemeMode(),
        ThemeMode.values,
        ThemeMode.system,
      );

      final contrastVariant = _enumValue(
        SharedPreferencesHelper.getContrastVariant.call(),
        AppContrastVariant.values,
        AppContrastVariant.standard,
      );

      final fontSize = _enumValue(
        SharedPreferencesHelper.getFontSize(),
        AppFontSize.values,
        AppFontSize.medium,
      );

      final fontFamilyChoice = _enumValue(
        SharedPreferencesHelper.getFontFamily.call(),
        AppFontFamilyChoice.values,
        AppFontFamilyChoice.manrope,
      );

      final authenticationType = _enumValue(
        SharedPreferencesHelper.getAuthenticationType(),
        AuthenticationType.values,
        AuthenticationType.none,
      );

      final notificationTime = const TimeOfDayConverter().fromJson(
        SharedPreferencesHelper.getNotificationTime(),
      );

      if (!isClosed) {
        emit(
          state.copyWith(
            settings: SettingsModel(
              themeName: themeName,
              themeMode: themeMode,
              contrastVariant: contrastVariant,
              fontSize: fontSize,
              fontFamilyChoice: fontFamilyChoice,
              authenticationType: authenticationType,
              notificationTime: notificationTime,
            ),
            isReady: true,
            clearError: true,
          ),
        );
      }
    } catch (error) {
      if (!isClosed) {
        emit(
          state.copyWith(
            isReady: true,
            error: 'Could not load settings: $error',
          ),
        );
      }
    }
  }

  Future<void> saveSettingsToStorage() async {
    try {
      final settings = state.settings;
      await SharedPreferencesHelper.setThemeName(settings.themeName.name);
      await SharedPreferencesHelper.setThemeMode(settings.themeMode.name);
      await SharedPreferencesHelper.setContrastVariant.call(
        settings.contrastVariant.name,
      );
      await SharedPreferencesHelper.setFontSize(settings.fontSize.name);
      await SharedPreferencesHelper.setFontFamilyChoice.call(
        settings.fontFamilyChoice.name,
      );
      await SharedPreferencesHelper.setAuthenticationType(
        settings.authenticationType.name,
      );
      final time = const TimeOfDayConverter().toJson(settings.notificationTime);
      if (time != null) await SharedPreferencesHelper.setNotificationTime(time);
    } catch (error) {
      _emitError('Could not save settings: $error');
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

  void _updateSettings(SettingsModel settings, {bool persist = true}) {
    if (isClosed) return;
    emit(state.copyWith(settings: settings, clearError: true));
    if (persist) unawaited(saveSettingsToStorage());
  }

  T _enumValue<T extends Enum>(String? name, List<T> values, T fallback) {
    if (name == null) return fallback;
    for (final value in values) {
      if (value.name == name) return value;
    }
    return fallback;
  }

  void _emitError(String error) {
    if (!isClosed) emit(state.copyWith(error: error));
  }
}
