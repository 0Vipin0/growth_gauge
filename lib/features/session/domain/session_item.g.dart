// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SessionItem _$SessionItemFromJson(Map<String, dynamic> json) => _SessionItem(
  id: json['id'] as String,
  sourceTemplateItemId: json['sourceTemplateItemId'] as String,
  exerciseId: json['exerciseId'] as String,
  order: (json['order'] as num).toInt(),
  sets:
      (json['sets'] as List<dynamic>?)
          ?.map((e) => ExecutionSet.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$SessionItemToJson(_SessionItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sourceTemplateItemId': instance.sourceTemplateItemId,
      'exerciseId': instance.exerciseId,
      'order': instance.order,
      'sets': instance.sets,
      'notes': instance.notes,
    };
