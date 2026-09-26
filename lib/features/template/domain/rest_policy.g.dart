// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_policy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RestPolicy _$RestPolicyFromJson(Map<String, dynamic> json) => _RestPolicy(
      id: json['id'] as String,
      name: json['name'] as String? ?? 'Standard Rest',
      targetSeconds: (json['targetSeconds'] as num).toInt(),
      minimumSeconds: (json['minimumSeconds'] as num?)?.toInt(),
      maximumSeconds: (json['maximumSeconds'] as num?)?.toInt(),
      autoStart: json['autoStart'] as bool? ?? true,
      allowSkip: json['allowSkip'] as bool? ?? true,
      allowExtend: json['allowExtend'] as bool? ?? true,
    );

Map<String, dynamic> _$RestPolicyToJson(_RestPolicy instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'targetSeconds': instance.targetSeconds,
      'minimumSeconds': instance.minimumSeconds,
      'maximumSeconds': instance.maximumSeconds,
      'autoStart': instance.autoStart,
      'allowSkip': instance.allowSkip,
      'allowExtend': instance.allowExtend,
    };
