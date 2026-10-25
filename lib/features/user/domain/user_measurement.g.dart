// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_measurement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserMeasurement _$UserMeasurementFromJson(Map<String, dynamic> json) =>
    _UserMeasurement(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: $enumDecode(_$MeasurementTypeEnumMap, json['type']),
      value: (json['value'] as num).toDouble(),
      unit: json['unit'] as String,
      recordedAt: DateTime.parse(json['recordedAt'] as String),
      source: json['source'] as String? ?? 'manual',
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$UserMeasurementToJson(_UserMeasurement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$MeasurementTypeEnumMap[instance.type]!,
      'value': instance.value,
      'unit': instance.unit,
      'recordedAt': instance.recordedAt.toIso8601String(),
      'source': instance.source,
      'notes': instance.notes,
    };

const _$MeasurementTypeEnumMap = {
  MeasurementType.bodyWeight: 'BODY_WEIGHT',
  MeasurementType.bodyFatPercent: 'BODY_FAT_PERCENT',
  MeasurementType.waist: 'WAIST',
  MeasurementType.chest: 'CHEST',
  MeasurementType.arm: 'ARM',
  MeasurementType.thigh: 'THIGH',
  MeasurementType.custom: 'CUSTOM',
};
