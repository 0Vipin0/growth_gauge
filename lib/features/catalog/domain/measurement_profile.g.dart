// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExerciseMeasurementProfile _$ExerciseMeasurementProfileFromJson(
  Map<String, dynamic> json,
) => _ExerciseMeasurementProfile(
  defaultMetricType:
      $enumDecodeNullable(_$MetricTypeEnumMap, json['defaultMetricType']) ??
      MetricType.weightAndReps,
  supportedMetricTypes:
      (json['supportedMetricTypes'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$MetricTypeEnumMap, e))
          .toList() ??
      const [MetricType.weightAndReps],
  supportsWeight: json['supportsWeight'] as bool? ?? true,
  supportsReps: json['supportsReps'] as bool? ?? true,
  supportsDuration: json['supportsDuration'] as bool? ?? false,
  supportsDistance: json['supportsDistance'] as bool? ?? false,
  supportsCalories: json['supportsCalories'] as bool? ?? false,
  supportsRpe: json['supportsRpe'] as bool? ?? true,
  supportsRir: json['supportsRir'] as bool? ?? true,
  supportsTempo: json['supportsTempo'] as bool? ?? false,
);

Map<String, dynamic> _$ExerciseMeasurementProfileToJson(
  _ExerciseMeasurementProfile instance,
) => <String, dynamic>{
  'defaultMetricType': _$MetricTypeEnumMap[instance.defaultMetricType]!,
  'supportedMetricTypes': instance.supportedMetricTypes
      .map((e) => _$MetricTypeEnumMap[e]!)
      .toList(),
  'supportsWeight': instance.supportsWeight,
  'supportsReps': instance.supportsReps,
  'supportsDuration': instance.supportsDuration,
  'supportsDistance': instance.supportsDistance,
  'supportsCalories': instance.supportsCalories,
  'supportsRpe': instance.supportsRpe,
  'supportsRir': instance.supportsRir,
  'supportsTempo': instance.supportsTempo,
};

const _$MetricTypeEnumMap = {
  MetricType.weightAndReps: 'WEIGHT_AND_REPS',
  MetricType.timeBased: 'TIME_BASED',
  MetricType.countBased: 'COUNT_BASED',
  MetricType.distanceBased: 'DISTANCE_BASED',
  MetricType.calories: 'CALORIES',
  MetricType.pace: 'PACE',
};
