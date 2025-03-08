// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsModelImpl _$$SettingsModelImplFromJson(Map<String, dynamic> json) =>
    _$SettingsModelImpl(
      themeName: $enumDecode(_$AppThemeNameEnumMap, json['themeName']),
      fontSize: $enumDecodeNullable(_$AppFontSizeEnumMap, json['fontSize']) ??
          AppFontSize.medium,
      fontFamily:
          $enumDecodeNullable(_$AppFontFamilyEnumMap, json['fontFamily']) ??
              AppFontFamily.roboto,
      exportPath: json['exportPath'] as String?,
      importPath: json['importPath'] as String?,
    );

Map<String, dynamic> _$$SettingsModelImplToJson(_$SettingsModelImpl instance) =>
    <String, dynamic>{
      'themeName': _$AppThemeNameEnumMap[instance.themeName]!,
      'fontSize': _$AppFontSizeEnumMap[instance.fontSize]!,
      'fontFamily': _$AppFontFamilyEnumMap[instance.fontFamily]!,
      'exportPath': instance.exportPath,
      'importPath': instance.importPath,
    };

const _$AppThemeNameEnumMap = {
  AppThemeName.light: 'light',
  AppThemeName.lightMediumContrast: 'lightMediumContrast',
  AppThemeName.lightHighContrast: 'lightHighContrast',
  AppThemeName.dark: 'dark',
  AppThemeName.darkMediumContrast: 'darkMediumContrast',
  AppThemeName.darkHighContrast: 'darkHighContrast',
};

const _$AppFontSizeEnumMap = {
  AppFontSize.small: 'small',
  AppFontSize.medium: 'medium',
  AppFontSize.large: 'large',
  AppFontSize.extraLarge: 'extraLarge',
};

const _$AppFontFamilyEnumMap = {
  AppFontFamily.roboto: 'roboto',
  AppFontFamily.openSans: 'openSans',
  AppFontFamily.lato: 'lato',
  AppFontFamily.montserrat: 'montserrat',
  AppFontFamily.ceraPro: 'ceraPro',
};
