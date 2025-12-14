import '../../features/workout/model/workout_template.dart';

abstract class WorkoutRepository {
  Future<List<WorkoutTemplate>> loadTemplates();
  Future<void> saveTemplate(WorkoutTemplate t);
  Future<void> deleteTemplate(String id);
}
