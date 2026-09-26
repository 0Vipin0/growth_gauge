import '../../../core/database/document_adapter.dart';
import '../domain/workout_session.dart';

class SessionDocumentAdapter implements DocumentAdapter<WorkoutSession> {
  const SessionDocumentAdapter();

  @override
  String get collection => 'workout_sessions';
  @override
  int get schemaVersion => 1;
  @override
  String getId(WorkoutSession entity) => entity.id;
  @override
  DateTime? getCreatedAt(WorkoutSession entity) => entity.createdAt;
  @override
  Map<String, dynamic> toJson(WorkoutSession entity) => entity.toJson();
  @override
  WorkoutSession fromJson(Map<String, dynamic> json) =>
      WorkoutSession.fromJson(json);
}
