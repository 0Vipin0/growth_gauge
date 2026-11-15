// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment_inventory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EquipmentInventory _$EquipmentInventoryFromJson(Map<String, dynamic> json) =>
    _EquipmentInventory(
      userId: json['userId'] as String,
      ownedEquipment:
          (json['ownedEquipment'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$EquipmentTypeEnumMap, e))
              .toList() ??
          const [],
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$EquipmentInventoryToJson(_EquipmentInventory instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'ownedEquipment': instance.ownedEquipment
          .map((e) => _$EquipmentTypeEnumMap[e]!)
          .toList(),
      'updatedAt': instance.updatedAt.toIso8601String(),
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
