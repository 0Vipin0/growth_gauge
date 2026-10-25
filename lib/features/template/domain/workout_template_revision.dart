import 'package:freezed_annotation/freezed_annotation.dart';

import 'template_enums.dart';
import 'workout_block.dart';

part 'workout_template_revision.freezed.dart';
part 'workout_template_revision.g.dart';

/// An immutable snapshot of a [WorkoutTemplate]'s prescribed content.
///
/// Lifecycle: `DRAFT` → `PUBLISHED` → (obsoleted by a newer revision).
/// A `PUBLISHED` revision can never be mutated; creating an edit produces a
/// new revision with `revisionNumber = previous + 1` in `DRAFT` status.
/// The full prescribed blocks are embedded here and stored as a single JSON
/// document via [DriftDocumentStore].
@freezed
abstract class WorkoutTemplateRevision with _$WorkoutTemplateRevision {
  const factory({
    required String id,
    required String templateId,
    required int revisionNumber,
    @Default(TemplateRevisionStatus.draft) TemplateRevisionStatus status,
    @Default([]) List<WorkoutBlock> blocks,
    required String createdById,
    required DateTime createdAt,
    @Default('') String changeSummary,
  }) = _WorkoutTemplateRevision;

  factory fromJson(Map<String, dynamic> json) =>
      _$WorkoutTemplateRevisionFromJson(json);
}
