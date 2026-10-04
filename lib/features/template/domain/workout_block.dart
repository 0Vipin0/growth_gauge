import 'package:freezed_annotation/freezed_annotation.dart';

import 'template_enums.dart';
import 'template_item.dart';

part 'workout_block.freezed.dart';
part 'workout_block.g.dart';

/// A logical grouping of exercises within a [WorkoutTemplateRevision].
///
/// A block may be a straight set sequence, a superset, a circuit, or a
/// timed AMRAP/EMOM. The [rounds] field controls how many times the full
/// item list is cycled during execution.
@freezed
abstract class WorkoutBlock with _$WorkoutBlock {
  const factory WorkoutBlock({
    required String id,
    required String name,
    @Default(WorkoutBlockType.standard) WorkoutBlockType type,
    @Default(1) int rounds,
    int? timeCapSeconds,
    int? transitionSeconds,
    @Default([]) List<TemplateItem> items,
    String? notes,
  }) = _WorkoutBlock;

  factory WorkoutBlock.fromJson(Map<String, dynamic> json) =>
      _$WorkoutBlockFromJson(json);
}
