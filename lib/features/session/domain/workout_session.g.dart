// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkoutSession _$WorkoutSessionFromJson(Map<String, dynamic> json) =>
    _WorkoutSession(
      id: json['id'] as String,
      userId: json['userId'] as String,
      templateId: json['templateId'] as String,
      templateRevisionId: json['templateRevisionId'] as String,
      templateName: json['templateName'] as String,
      status:
          $enumDecodeNullable(_$SessionStatusEnumMap, json['status']) ??
          SessionStatus.draft,
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      pausedAt: json['pausedAt'] == null
          ? null
          : DateTime.parse(json['pausedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      blocks:
          (json['blocks'] as List<dynamic>?)
              ?.map((e) => SessionBlock.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      interruptions:
          (json['interruptions'] as List<dynamic>?)
              ?.map(
                (e) => SessionInterruption.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      restIntervals:
          (json['restIntervals'] as List<dynamic>?)
              ?.map((e) => RestInterval.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      audits:
          (json['audits'] as List<dynamic>?)
              ?.map((e) => AuditEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      sessionNotes: json['sessionNotes'] as String?,
    );

Map<String, dynamic> _$WorkoutSessionToJson(_WorkoutSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'templateId': instance.templateId,
      'templateRevisionId': instance.templateRevisionId,
      'templateName': instance.templateName,
      'status': _$SessionStatusEnumMap[instance.status]!,
      'startedAt': instance.startedAt?.toIso8601String(),
      'pausedAt': instance.pausedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'blocks': instance.blocks,
      'interruptions': instance.interruptions,
      'restIntervals': instance.restIntervals,
      'audits': instance.audits,
      'sessionNotes': instance.sessionNotes,
    };

const _$SessionStatusEnumMap = {
  SessionStatus.draft: 'draft',
  SessionStatus.starting: 'starting',
  SessionStatus.inProgress: 'inProgress',
  SessionStatus.paused: 'paused',
  SessionStatus.completing: 'completing',
  SessionStatus.completed: 'completed',
  SessionStatus.cancelled: 'cancelled',
  SessionStatus.abandoned: 'abandoned',
};
