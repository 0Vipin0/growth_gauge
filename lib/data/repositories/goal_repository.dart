import 'package:growth_gauge/data/models/activity.dart';

abstract class GoalRepository {
  Future<List<Goal>> loadGoals();
  Future<Goal?> loadGoalById(String id);
  Future<void> saveGoal(Goal goal);
  Future<void> updateGoal(Goal goal);
}
