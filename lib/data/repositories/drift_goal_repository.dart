import '../../data/models/activity.dart';
import '../services/persistence/app_database.dart';
import 'goal_repository.dart';

class DriftGoalRepository implements GoalRepository {
  final GoalDao dao;

  DriftGoalRepository(this.dao);

  @override
  Future<Goal?> loadGoalById(String id) async {
    return await dao.getGoalById(id);
  }

  @override
  Future<List<Goal>> loadGoals() {
    return dao.getAllGoals();
  }

  @override
  Future<void> saveGoal(Goal goal) async {
    await dao.insertGoal(goal);
  }

  @override
  Future<void> updateGoal(Goal goal) async {
    await dao.updateGoal(goal);
  }
}
