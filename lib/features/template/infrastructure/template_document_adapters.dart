import '../../../core/database/document_adapter.dart';
import '../domain/workout_template.dart';
import '../domain/workout_template_revision.dart';

class WorkoutTemplateDocumentAdapter implements DocumentAdapter<WorkoutTemplate> {
  const WorkoutTemplateDocumentAdapter();
  @override
  String get collection => 'workout_templates';
  @override
  int get schemaVersion => 1;
  @override
  String getId(WorkoutTemplate entity) => entity.id;
  @override
  DateTime? getCreatedAt(WorkoutTemplate entity) => entity.createdAt;
  @override
  DateTime? getUpdatedAt(WorkoutTemplate entity) => entity.updatedAt;
  @override
  WorkoutTemplate fromJson(Map<String, dynamic> json) => WorkoutTemplate.fromJson(json);
  @override
  Map<String, dynamic> toJson(WorkoutTemplate entity) => entity.toJson();
}

class WorkoutTemplateRevisionDocumentAdapter implements DocumentAdapter<WorkoutTemplateRevision> {
  const WorkoutTemplateRevisionDocumentAdapter();
  @override
  String get collection => 'workout_template_revisions';
  @override
  int get schemaVersion => 1;
  @override
  String getId(WorkoutTemplateRevision entity) => entity.id;
  @override
  DateTime? getCreatedAt(WorkoutTemplateRevision entity) => entity.createdAt;
  @override
  DateTime? getUpdatedAt(WorkoutTemplateRevision entity) => null;
  @override
  WorkoutTemplateRevision fromJson(Map<String, dynamic> json) => WorkoutTemplateRevision.fromJson(json);
  @override
  Map<String, dynamic> toJson(WorkoutTemplateRevision entity) => entity.toJson();
}
