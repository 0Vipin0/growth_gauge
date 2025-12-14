import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:growth_gauge/ui/core/app_theme.dart';
import 'package:growth_gauge/ui/core/font_config.dart';
import 'package:growth_gauge/ui/core/theme_config.dart';

part 'settings_model.freezed.dart';

part 'settings_model.g.dart';

enum ExportFormat { json, csv }

extension ExportFormatExtension on ExportFormat {
  String getLabel() {
    switch (this) {
      case ExportFormat.json:
        return 'JSON';
      case ExportFormat.csv:
        return 'CSV';
    }
  }
}

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
class SettingsModel with _$SettingsModel {
  const factory SettingsModel({
    required AppThemeName themeName,
    @Default(AppFontSize.medium) AppFontSize fontSize,
    @Default(AppFontFamily.roboto) AppFontFamily fontFamily,
    @Default(ExportFormat.json) ExportFormat exportFormat,
    @Default(AuthenticationType.none) AuthenticationType authenticationType,
    @Default(null) @TimeOfDayConverter() TimeOfDay? notificationTime,
    @Default(true) bool ttsEnabled,
  }) = _SettingsModel;

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);
}

extension SettingsModelExtension on SettingsModel {
  AppTheme get appTheme => AppTheme(
        themeName: themeName,
        fontTheme: AppFontTheme(fontFamily: fontFamily, fontSize: fontSize),
      );
}

class TimeOfDayConverter implements JsonConverter<TimeOfDay?, String?> {
  const TimeOfDayConverter();

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
