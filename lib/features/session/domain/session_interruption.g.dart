// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_interruption.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SessionInterruption _$SessionInterruptionFromJson(Map<String, dynamic> json) =>
    _SessionInterruption(
      id: json['id'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
      endedAt: json['endedAt'] == null
          ? null
          : DateTime.parse(json['endedAt'] as String),
      reason:
          $enumDecodeNullable(_$InterruptionReasonEnumMap, json['reason']) ??
              InterruptionReason.other,
      userInitiated: json['userInitiated'] as bool? ?? true,
    );

Map<String, dynamic> _$SessionInterruptionToJson(
        _SessionInterruption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startedAt': instance.startedAt.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
      'reason': _$InterruptionReasonEnumMap[instance.reason]!,
      'userInitiated': instance.userInitiated,
    };

const _$InterruptionReasonEnumMap = {
  InterruptionReason.userPause: 'userPause',
  InterruptionReason.applicationBackground: 'applicationBackground',
  InterruptionReason.phoneCall: 'phoneCall',
  InterruptionReason.equipmentProblem: 'equipmentProblem',
  InterruptionReason.other: 'other',
};
