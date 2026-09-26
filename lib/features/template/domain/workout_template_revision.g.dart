// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_template_revision.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkoutTemplateRevision _$WorkoutTemplateRevisionFromJson(
        Map<String, dynamic> json) =>
    _WorkoutTemplateRevision(
      id: json['id'] as String,
      templateId: json['templateId'] as String,
      revisionNumber: (json['revisionNumber'] as num).toInt(),
      status: $enumDecodeNullable(
              _$TemplateRevisionStatusEnumMap, json['status']) ??
          TemplateRevisionStatus.draft,
      blocks: (json['blocks'] as List<dynamic>?)
              ?.map((e) => WorkoutBlock.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdById: json['createdById'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      changeSummary: json['changeSummary'] as String? ?? '',
    );

Map<String, dynamic> _$WorkoutTemplateRevisionToJson(
        _WorkoutTemplateRevision instance) =>
    <String, dynamic>{
      'id': instance.id,
      'templateId': instance.templateId,
      'revisionNumber': instance.revisionNumber,
      'status': _$TemplateRevisionStatusEnumMap[instance.status]!,
      'blocks': instance.blocks,
      'createdById': instance.createdById,
      'createdAt': instance.createdAt.toIso8601String(),
      'changeSummary': instance.changeSummary,
    };

const _$TemplateRevisionStatusEnumMap = {
  TemplateRevisionStatus.draft: 'DRAFT',
  TemplateRevisionStatus.published: 'PUBLISHED',
  TemplateRevisionStatus.archived: 'ARCHIVED',
};
