import '../../../core/database/document_adapter.dart';
import '../domain/exercise.dart';

/// Bridges [Exercise] aggregate root to the [DriftDocumentStore] JSON contract.
///
/// Collection name: `'exercises'`
class const ExerciseDocumentAdapter() implements DocumentAdapter<Exercise> {
  @override
  String get collection => 'exercises';

  @override
  int get schemaVersion => 1;

  @override
  String getId(Exercise entity) => entity.id;

  @override
  DateTime? getCreatedAt(Exercise entity) => entity.createdAt;

  @override
  DateTime? getUpdatedAt(Exercise entity) => entity.updatedAt;

  @override
  Exercise fromJson(Map<String, dynamic> json) => Exercise.fromJson(json);

  @override
  Map<String, dynamic> toJson(Exercise entity) => entity.toJson();
}
