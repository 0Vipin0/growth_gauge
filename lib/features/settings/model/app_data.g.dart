// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppData _$AppDataFromJson(Map<String, dynamic> json) => _AppData(
  version: (json['version'] as num?)?.toInt() ?? 1,
  counters:
      (json['counters'] as List<dynamic>?)
          ?.map((e) => CounterModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  timers:
      (json['timers'] as List<dynamic>?)
          ?.map((e) => TimerModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$AppDataToJson(_AppData instance) => <String, dynamic>{
  'version': instance.version,
  'counters': instance.counters,
  'timers': instance.timers,
};
