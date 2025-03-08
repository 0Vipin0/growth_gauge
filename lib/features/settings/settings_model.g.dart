// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsModelImpl _$$SettingsModelImplFromJson(Map<String, dynamic> json) =>
    _$SettingsModelImpl(
      themeColor: const ColorConverter().fromJson(json['themeColor'] as String),
      fontSize: (json['fontSize'] as num?)?.toDouble() ?? FontSizeConfig.medium,
      themeMode: $enumDecode(_$AppThemeModeEnumMap, json['themeMode']),
      exportPath: json['exportPath'] as String?,
      importPath: json['importPath'] as String?,
    );

Map<String, dynamic> _$$SettingsModelImplToJson(_$SettingsModelImpl instance) =>
    <String, dynamic>{
      'themeColor': const ColorConverter().toJson(instance.themeColor),
      'fontSize': instance.fontSize,
      'themeMode': _$AppThemeModeEnumMap[instance.themeMode]!,
      'exportPath': instance.exportPath,
      'importPath': instance.importPath,
    };

const _$AppThemeModeEnumMap = {
  AppThemeMode.light: 'light',
  AppThemeMode.lightMediumContrast: 'lightMediumContrast',
  AppThemeMode.lightHighContrast: 'lightHighContrast',
  AppThemeMode.dark: 'dark',
  AppThemeMode.darkMediumContrast: 'darkMediumContrast',
  AppThemeMode.darkHighContrast: 'darkHighContrast',
};
