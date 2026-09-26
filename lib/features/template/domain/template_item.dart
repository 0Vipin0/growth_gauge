import 'package:freezed_annotation/freezed_annotation.dart';

import 'target_set.dart';

part 'template_item.freezed.dart';
part 'template_item.g.dart';

/// A single exercise slot within a [WorkoutBlock].
///
/// Each item references an exercise from the catalog by ID and carries
/// an ordered list of [TargetSet] prescriptions. Substitution rules list
/// alternative exercise IDs in preference order.
@freezed
abstract class TemplateItem with _$TemplateItem {
  const factory TemplateItem({
    required String id,
    required String exerciseId,
    required int order,
    @Default([]) List<TargetSet> targetSets,
    @Default([]) List<String> substitutionExerciseIds,
    String? coachNotes,
  }) = _TemplateItem;

  factory TemplateItem.fromJson(Map<String, dynamic> json) =>
      _$TemplateItemFromJson(json);
}
