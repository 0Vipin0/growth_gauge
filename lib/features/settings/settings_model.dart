import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'color_converter.dart';
import 'color_utils.dart';
import 'font_size_config.dart';

part 'settings_model.freezed.dart';

part 'settings_model.g.dart';

@freezed
class SettingsModel with _$SettingsModel {
  const factory SettingsModel({
    @ColorConverter() required Color themeColor,
    @Default(FontSizeConfig.medium) double fontSize,
    String? exportPath,
    String? importPath,
  }) = _SettingsModel;

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);
}

extension SettingsModelExtension on SettingsModel {
  MaterialColor get materialThemeColor => createMaterialColor(themeColor);

  TextTheme get textTheme {
    switch (fontSize) {
      case FontSizeConfig.small:
        return FontSizeConfig.smallTextTheme;
      case FontSizeConfig.large:
        return FontSizeConfig.largeTextTheme;
      case FontSizeConfig.medium:
      default:
        return FontSizeConfig.mediumTextTheme;
    }
  }
}
