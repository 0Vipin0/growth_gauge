// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Exercise _$ExerciseFromJson(Map<String, dynamic> json) => _Exercise(
      id: json['id'] as String,
      name: json['name'] as String,
      aliases: (json['aliases'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      description: json['description'] as String? ?? '',
      status: $enumDecodeNullable(_$ExerciseStatusEnumMap, json['status']) ??
          ExerciseStatus.active,
      sourceType: $enumDecodeNullable(
              _$ExerciseSourceTypeEnumMap, json['sourceType']) ??
          ExerciseSourceType.system,
      createdById: json['createdById'] as String?,
      forkedFromExerciseId: json['forkedFromExerciseId'] as String?,
      version: (json['version'] as num?)?.toInt() ?? 1,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      classification: json['classification'] == null
          ? const ExerciseClassification()
          : ExerciseClassification.fromJson(
              json['classification'] as Map<String, dynamic>),
      execution: json['execution'] == null
          ? const ExerciseExecutionProfile()
          : ExerciseExecutionProfile.fromJson(
              json['execution'] as Map<String, dynamic>),
      equipment: json['equipment'] == null
          ? const ExerciseEquipmentProfile()
          : ExerciseEquipmentProfile.fromJson(
              json['equipment'] as Map<String, dynamic>),
      relationships: (json['relationships'] as List<dynamic>?)
              ?.map((e) =>
                  ExerciseRelationship.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      measurementProfile: json['measurementProfile'] == null
          ? const ExerciseMeasurementProfile()
          : ExerciseMeasurementProfile.fromJson(
              json['measurementProfile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExerciseToJson(_Exercise instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'aliases': instance.aliases,
      'description': instance.description,
      'status': _$ExerciseStatusEnumMap[instance.status]!,
      'sourceType': _$ExerciseSourceTypeEnumMap[instance.sourceType]!,
      'createdById': instance.createdById,
      'forkedFromExerciseId': instance.forkedFromExerciseId,
      'version': instance.version,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'classification': instance.classification,
      'execution': instance.execution,
      'equipment': instance.equipment,
      'relationships': instance.relationships,
      'measurementProfile': instance.measurementProfile,
    };

const _$ExerciseStatusEnumMap = {
  ExerciseStatus.draft: 'DRAFT',
  ExerciseStatus.active: 'ACTIVE',
  ExerciseStatus.archived: 'ARCHIVED',
};

const _$ExerciseSourceTypeEnumMap = {
  ExerciseSourceType.system: 'SYSTEM',
  ExerciseSourceType.userCreated: 'USER_CREATED',
  ExerciseSourceType.userForked: 'USER_FORKED',
};
