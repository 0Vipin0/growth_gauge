import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_template.freezed.dart';
part 'workout_template.g.dart';

/// The stable aggregate root that holds identity and metadata for a program.
///
/// The actual prescribed content lives inside [WorkoutTemplateRevision]
/// objects. The template itself is a lightweight envelope: once a revision
/// is published it is immutable; editing creates a new revision.
@freezed
abstract class WorkoutTemplate with _$WorkoutTemplate {
  const factory({
    required String id,
    required String name,
    @Default('') String description,

    /// The ID of the currently active (latest published or active draft) revision.
    String? currentRevisionId,
    required String createdById,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isArchived,
    @Default([]) List<String> tags,
  }) = _WorkoutTemplate;

  factory fromJson(Map<String, dynamic> json) =>
      _$WorkoutTemplateFromJson(json);
}
