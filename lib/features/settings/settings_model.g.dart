// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsModelImpl _$$SettingsModelImplFromJson(Map<String, dynamic> json) =>
    _$SettingsModelImpl(
      themeColor: const ColorConverter().fromJson(json['themeColor'] as String),
      fontSize: (json['fontSize'] as num?)?.toDouble() ?? FontSizeConfig.medium,
      exportPath: json['exportPath'] as String?,
      importPath: json['importPath'] as String?,
    );

Map<String, dynamic> _$$SettingsModelImplToJson(_$SettingsModelImpl instance) =>
    <String, dynamic>{
      'themeColor': const ColorConverter().toJson(instance.themeColor),
      'fontSize': instance.fontSize,
      'exportPath': instance.exportPath,
      'importPath': instance.importPath,
    };
