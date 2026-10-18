import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

import '../../notification/infrastructure/notification_service.dart';
import '../config/config.dart';
import '../model/settings_model.dart';
import 'settings_state.dart';

class SettingsCubit({
  required final NotificationService notificationService,
  final LocalAuthentication? localAuth,
  final FlutterSecureStorage? secureStorage,
}) extends Cubit<SettingsState> {
  final NotificationService _notificationService = notificationService;
  final LocalAuthentication _localAuth = localAuth ?? LocalAuthentication();
  final FlutterSecureStorage _secureStorage =
      secureStorage ?? const FlutterSecureStorage();

  this : super(const SettingsState()) {
    unawaited(loadSettingsFromStorage());
  }

  void updateThemeName(AppThemeName themeName) =>
      _updateSettings(state.settings.copyWith(themeName: themeName));

  void updateFontSize(AppFontSize fontSize) =>
      _updateSettings(state.settings.copyWith(fontSize: fontSize));

  void updateFontFamily(AppFontFamily fontFamily) =>
      _updateSettings(state.settings.copyWith(fontFamily: fontFamily));

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
      if (!isClosed) {
        emit(
          state.copyWith(
            settings: SettingsModel(
              themeName: themeName,
              fontSize: fontSize,
              fontFamily: fontFamily,
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
      await SharedPreferencesHelper.setFontSize(settings.fontSize.name);
      await SharedPreferencesHelper.setFontFamily(settings.fontFamily.name);
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
    for (final value in values) {
      if (value.name == name) return value;
    }
    return fallback;
  }

  void _emitError(String error) {
    if (!isClosed) emit(state.copyWith(error: error));
  }
}
