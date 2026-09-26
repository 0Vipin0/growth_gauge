// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuditEntry _$AuditEntryFromJson(Map<String, dynamic> json) => _AuditEntry(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      actorType:
          $enumDecodeNullable(_$AuditActorTypeEnumMap, json['actorType']) ??
              AuditActorType.user,
      actorId: json['actorId'] as String?,
      action: $enumDecode(_$AuditActionEnumMap, json['action']),
      entityType: json['entityType'] as String,
      entityId: json['entityId'] as String,
      field: json['field'] as String?,
      previousValue: json['previousValue'],
      newValue: json['newValue'],
      reason: json['reason'] as String?,
      correlationId: json['correlationId'] as String?,
    );

Map<String, dynamic> _$AuditEntryToJson(_AuditEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp.toIso8601String(),
      'actorType': _$AuditActorTypeEnumMap[instance.actorType]!,
      'actorId': instance.actorId,
      'action': _$AuditActionEnumMap[instance.action]!,
      'entityType': instance.entityType,
      'entityId': instance.entityId,
      'field': instance.field,
      'previousValue': instance.previousValue,
      'newValue': instance.newValue,
      'reason': instance.reason,
      'correlationId': instance.correlationId,
    };

const _$AuditActorTypeEnumMap = {
  AuditActorType.user: 'user',
  AuditActorType.system: 'system',
};

const _$AuditActionEnumMap = {
  AuditAction.created: 'created',
  AuditAction.updated: 'updated',
  AuditAction.deleted: 'deleted',
  AuditAction.started: 'started',
  AuditAction.paused: 'paused',
  AuditAction.resumed: 'resumed',
  AuditAction.completed: 'completed',
  AuditAction.cancelled: 'cancelled',
  AuditAction.abandoned: 'abandoned',
};
