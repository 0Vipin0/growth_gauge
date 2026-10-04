import 'package:freezed_annotation/freezed_annotation.dart';

part 'muscle_volume_stat.freezed.dart';

/// Immutable read model: weekly volume for a single muscle group.
@freezed
abstract class MuscleVolumeStat with _$MuscleVolumeStat {
  const factory MuscleVolumeStat({
    required String muscleGroup,
    required int isoYear,
    required int isoWeek,
    required DateTime weekStartDate,
    required double totalVolumeKg,
    required int totalSets,
  }) = _MuscleVolumeStat;
}
