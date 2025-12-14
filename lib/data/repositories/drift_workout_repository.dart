import 'dart:convert';

import 'package:drift/drift.dart';

import '../../features/workout/model/workout_template.dart' as domain;
import '../services/persistence/app_database.dart';
import 'workout_repository.dart';

class DriftWorkoutRepository implements WorkoutRepository {
  final AppDatabase db;

  DriftWorkoutRepository(this.db);

  @override
  Future<List<domain.WorkoutTemplate>> loadTemplates() async {
    final rows = await db.select(db.workoutTemplates).get();
    return rows
        .map((r) => domain.WorkoutTemplate.fromJson({
              'id': r.id,
              'name': r.name,
              'description': r.description,
              'steps': r.stepsJson == null ? [] : jsonDecode(r.stepsJson!),
              'created_at': r.createdAt.toIso8601String(),
              'updated_at': r.updatedAt?.toIso8601String(),
            }))
        .toList();
  }

  @override
  Future<void> saveTemplate(domain.WorkoutTemplate t) async {
    await db
        .into(db.workoutTemplates)
        .insertOnConflictUpdate(WorkoutTemplatesCompanion(
          id: Value(t.id),
          name: Value(t.name),
          description: Value(t.description),
          stepsJson: Value(jsonEncode(t.steps)),
          createdAt: Value(t.createdAt),
          updatedAt: Value(t.updatedAt),
        ));
  }

  @override
  Future<void> deleteTemplate(String id) async {
    await (db.delete(db.workoutTemplates)..where((t) => t.id.equals(id))).go();
  }
}
