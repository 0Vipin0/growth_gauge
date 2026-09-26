import 'package:freezed_annotation/freezed_annotation.dart';

part 'rest_interval.freezed.dart';
part 'rest_interval.g.dart';

@freezed
abstract class RestInterval with _$RestInterval {
  const factory RestInterval({
    required String id,
    required String executionSetId,
    required DateTime startedAt,
    DateTime? endedAt,
    required int plannedDurationSeconds,
    int? actualDurationSeconds,
    @Default(0) int minimumDurationSeconds,
    int? maximumDurationSeconds,
    @Default(true) bool allowSkip,
    @Default(true) bool allowExtend,
    @Default(false) bool skipped,
  }) = _RestInterval;

  factory RestInterval.fromJson(Map<String, dynamic> json) =>
      _$RestIntervalFromJson(json);
}
