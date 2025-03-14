import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_theme.dart';
import 'font_config.dart';
import 'theme_config.dart';

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

@freezed
class SettingsModel with _$SettingsModel {
  const factory SettingsModel({
    required AppThemeName themeName,
    @Default(AppFontSize.medium) AppFontSize fontSize,
    @Default(AppFontFamily.roboto) AppFontFamily fontFamily,
    @Default(ExportFormat.json) ExportFormat exportFormat,
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
