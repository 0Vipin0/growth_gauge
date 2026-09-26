// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TemplateItem _$TemplateItemFromJson(Map<String, dynamic> json) =>
    _TemplateItem(
      id: json['id'] as String,
      exerciseId: json['exerciseId'] as String,
      order: (json['order'] as num).toInt(),
      targetSets: (json['targetSets'] as List<dynamic>?)
              ?.map((e) => TargetSet.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      substitutionExerciseIds:
          (json['substitutionExerciseIds'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              const [],
      coachNotes: json['coachNotes'] as String?,
    );

Map<String, dynamic> _$TemplateItemToJson(_TemplateItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exerciseId': instance.exerciseId,
      'order': instance.order,
      'targetSets': instance.targetSets,
      'substitutionExerciseIds': instance.substitutionExerciseIds,
      'coachNotes': instance.coachNotes,
    };
