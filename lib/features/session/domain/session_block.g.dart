// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SessionBlock _$SessionBlockFromJson(Map<String, dynamic> json) =>
    _SessionBlock(
      id: json['id'] as String,
      sourceTemplateBlockId: json['sourceTemplateBlockId'] as String,
      name: json['name'] as String,
      type:
          $enumDecodeNullable(_$WorkoutBlockTypeEnumMap, json['type']) ??
          WorkoutBlockType.standard,
      rounds: (json['rounds'] as num?)?.toInt() ?? 1,
      timeCapSeconds: (json['timeCapSeconds'] as num?)?.toInt(),
      transitionSeconds: (json['transitionSeconds'] as num?)?.toInt(),
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => SessionItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$SessionBlockToJson(_SessionBlock instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sourceTemplateBlockId': instance.sourceTemplateBlockId,
      'name': instance.name,
      'type': _$WorkoutBlockTypeEnumMap[instance.type]!,
      'rounds': instance.rounds,
      'timeCapSeconds': instance.timeCapSeconds,
      'transitionSeconds': instance.transitionSeconds,
      'items': instance.items,
      'notes': instance.notes,
    };

const _$WorkoutBlockTypeEnumMap = {
  WorkoutBlockType.standard: 'STANDARD',
  WorkoutBlockType.superset: 'SUPERSET',
  WorkoutBlockType.triset: 'TRISET',
  WorkoutBlockType.circuit: 'CIRCUIT',
  WorkoutBlockType.amrap: 'AMRAP',
  WorkoutBlockType.emom: 'EMOM',
  WorkoutBlockType.forTime: 'FOR_TIME',
  WorkoutBlockType.tabata: 'TABATA',
  WorkoutBlockType.warmup: 'WARMUP',
  WorkoutBlockType.cooldown: 'COOLDOWN',
  WorkoutBlockType.rest: 'REST',
};
