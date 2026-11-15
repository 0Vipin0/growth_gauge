// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkoutTemplate _$WorkoutTemplateFromJson(Map<String, dynamic> json) =>
    _WorkoutTemplate(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      currentRevisionId: json['currentRevisionId'] as String?,
      createdById: json['createdById'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isArchived: json['isArchived'] as bool? ?? false,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
    );

Map<String, dynamic> _$WorkoutTemplateToJson(_WorkoutTemplate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'currentRevisionId': instance.currentRevisionId,
      'createdById': instance.createdById,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isArchived': instance.isArchived,
      'tags': instance.tags,
    };
