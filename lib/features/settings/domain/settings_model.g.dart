// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettingsModel _$SettingsModelFromJson(Map<String, dynamic> json) =>
    _SettingsModel(
      themeName:
          $enumDecodeNullable(_$AppThemeNameEnumMap, json['themeName']) ??
          AppThemeName.forest,
      themeMode:
          $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
          ThemeMode.system,
      contrastVariant:
          $enumDecodeNullable(
            _$AppContrastVariantEnumMap,
            json['contrastVariant'],
          ) ??
          AppContrastVariant.standard,
      fontSize:
          $enumDecodeNullable(_$AppFontSizeEnumMap, json['fontSize']) ??
          AppFontSize.medium,
      fontFamilyChoice:
          $enumDecodeNullable(
            _$AppFontFamilyChoiceEnumMap,
            json['fontFamilyChoice'],
          ) ??
          AppFontFamilyChoice.manrope,
      exportFormat:
          $enumDecodeNullable(_$ExportFormatEnumMap, json['exportFormat']) ??
          ExportFormat.json,
      authenticationType:
          $enumDecodeNullable(
            _$AuthenticationTypeEnumMap,
            json['authenticationType'],
          ) ??
          AuthenticationType.none,
      notificationTime: json['notificationTime'] == null
          ? null
          : const TimeOfDayConverter().fromJson(
              json['notificationTime'] as String?,
            ),
    );

Map<String, dynamic> _$SettingsModelToJson(
  _SettingsModel instance,
) => <String, dynamic>{
  'themeName': _$AppThemeNameEnumMap[instance.themeName]!,
  'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
  'contrastVariant': _$AppContrastVariantEnumMap[instance.contrastVariant]!,
  'fontSize': _$AppFontSizeEnumMap[instance.fontSize]!,
  'fontFamilyChoice': _$AppFontFamilyChoiceEnumMap[instance.fontFamilyChoice]!,
  'exportFormat': _$ExportFormatEnumMap[instance.exportFormat]!,
  'authenticationType':
      _$AuthenticationTypeEnumMap[instance.authenticationType]!,
  'notificationTime': const TimeOfDayConverter().toJson(
    instance.notificationTime,
  ),
};

const _$AppThemeNameEnumMap = {
  AppThemeName.forest: 'forest',
  AppThemeName.midnight: 'midnight',
  AppThemeName.amber: 'amber',
  AppThemeName.slate: 'slate',
  AppThemeName.rust: 'rust',
  AppThemeName.moss: 'moss',
  AppThemeName.cyan: 'cyan',
  AppThemeName.custom: 'custom',
};

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};

const _$AppContrastVariantEnumMap = {
  AppContrastVariant.standard: 'standard',
  AppContrastVariant.mediumContrast: 'mediumContrast',
  AppContrastVariant.highContrast: 'highContrast',
};

const _$AppFontSizeEnumMap = {
  AppFontSize.small: 'small',
  AppFontSize.medium: 'medium',
  AppFontSize.large: 'large',
  AppFontSize.extraLarge: 'extraLarge',
};

const _$AppFontFamilyChoiceEnumMap = {
  AppFontFamilyChoice.manrope: 'manrope',
  AppFontFamilyChoice.openDyslexic: 'openDyslexic',
  AppFontFamilyChoice.roboto: 'roboto',
  AppFontFamilyChoice.openSans: 'openSans',
  AppFontFamilyChoice.lato: 'lato',
  AppFontFamilyChoice.montserrat: 'montserrat',
  AppFontFamilyChoice.ceraPro: 'ceraPro',
  AppFontFamilyChoice.systemDefault: 'systemDefault',
};

const _$ExportFormatEnumMap = {
  ExportFormat.json: 'json',
  ExportFormat.csv: 'csv',
};

const _$AuthenticationTypeEnumMap = {
  AuthenticationType.none: 'none',
  AuthenticationType.pin: 'pin',
  AuthenticationType.biometric: 'biometric',
};
