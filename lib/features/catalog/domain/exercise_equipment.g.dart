// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_equipment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExerciseEquipmentProfile _$ExerciseEquipmentProfileFromJson(
        Map<String, dynamic> json) =>
    _ExerciseEquipmentProfile(
      requiredEquipment: (json['requiredEquipment'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$EquipmentTypeEnumMap, e))
              .toList() ??
          const [],
      optionalEquipment: (json['optionalEquipment'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$EquipmentTypeEnumMap, e))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ExerciseEquipmentProfileToJson(
        _ExerciseEquipmentProfile instance) =>
    <String, dynamic>{
      'requiredEquipment': instance.requiredEquipment
          .map((e) => _$EquipmentTypeEnumMap[e]!)
          .toList(),
      'optionalEquipment': instance.optionalEquipment
          .map((e) => _$EquipmentTypeEnumMap[e]!)
          .toList(),
    };

const _$EquipmentTypeEnumMap = {
  EquipmentType.barbell: 'BARBELL',
  EquipmentType.dumbbell: 'DUMBBELL',
  EquipmentType.kettlebell: 'KETTLEBELL',
  EquipmentType.cable: 'CABLE',
  EquipmentType.machine: 'MACHINE',
  EquipmentType.bodyweight: 'BODYWEIGHT',
  EquipmentType.smithMachine: 'SMITH_MACHINE',
  EquipmentType.resistanceBand: 'RESISTANCE_BAND',
  EquipmentType.pullUpBar: 'PULL_UP_BAR',
  EquipmentType.bench: 'BENCH',
};
