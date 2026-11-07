// ignore_for_file: use_primary_constructors

import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../common/presentation/theme/theme.dart';

part 'settings_model.freezed.dart';
part 'settings_model.g.dart';

enum ExportFormat { json, csv }

enum AuthenticationType { none, pin, biometric }

extension AuthenticationTypeExtension on AuthenticationType {
  String getLabel() {
    switch (this) {
      case AuthenticationType.none:
        return 'None';
      case AuthenticationType.pin:
        return 'PIN';
      case AuthenticationType.biometric:
        return 'Biometric';
    }
  }
}

@freezed
abstract class SettingsModel with _$SettingsModel {
  const factory({
    @Default(AppThemeName.forest) AppThemeName themeName,
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(AppContrastVariant.standard) AppContrastVariant contrastVariant,
    @Default(AppFontSize.medium) AppFontSize fontSize,
    @Default(AppFontFamilyChoice.manrope) AppFontFamilyChoice fontFamilyChoice,
    @Default(ExportFormat.json) ExportFormat exportFormat,
    @Default(AuthenticationType.none) AuthenticationType authenticationType,
    @Default(null) @TimeOfDayConverter() TimeOfDay? notificationTime,
  }) = _SettingsModel;

  factory fromJson(Map<String, dynamic> json) => _$SettingsModelFromJson(json);
}

extension SettingsModelExtension on SettingsModel {
  /// Resolves and builds the authoritative ThemeData using AppTheme.buildTheme.
  ThemeData toThemeData(BuildContext context) {
    final brightness = themeMode == ThemeMode.system
        ? MediaQuery.platformBrightnessOf(context)
        : (themeMode == ThemeMode.dark ? Brightness.dark : Brightness.light);

    return AppTheme.buildTheme(
      themeName: themeName,
      brightness: brightness,
      contrastVariant: contrastVariant,
      fontFamilyChoice: fontFamilyChoice,
      fontSize: fontSize,
    );
  }
}

class TimeOfDayConverter implements JsonConverter<TimeOfDay?, String?> {
  const new();

  @override
  TimeOfDay? fromJson(String? json) {
    if (json == null) return null;
    final parts = json.split(':');
    if (parts.length != 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  String? toJson(TimeOfDay? object) {
    if (object == null) return null;
    return '${object.hour}:${object.minute}';
  }
}
