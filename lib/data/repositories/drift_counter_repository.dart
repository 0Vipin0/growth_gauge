import 'package:uuid/uuid.dart';

import '../../data/repositories/drift_activity_repository.dart';
import '../../data/repositories/drift_goal_repository.dart';
import '../models/models.dart';
import 'counter_repository.dart';

class DriftCounterRepository implements CounterRepository {
  final DriftActivityRepository db;
  final DriftGoalRepository dgr;

  DriftCounterRepository(this.db, this.dgr);

  @override
  Future<List<CounterModel>> loadCounters() async {
    final List<Activity> activities = await db.loadActivities();

    final List<CounterModel> counters = [];

    for (final Activity act in activities) {
      // 1. Get countBased activities
      if (act is CountBasedActivity) {
        // 2. Get logs
        final List<ActivityLog> logsRows = await db.loadLogs(act.id);

        // Calculate count (sum of values)
        double total = 0;
        final logs = logsRows.map((r) {
          total += r.value;
          String action;
          if (r.value == 1.0) {
            action = 'Increased';
          } else if (r.value == -1.0) {
            action = 'Decreased';
          } else {
            action = r.notes ?? 'Updated'; // fallback
          }
          return CounterLog(
            id: r.id,
            action: action,
            timestamp: r.timestamp,
          );
        }).toList();

        // 3. Get Goal
        int? target;
        if (act.goalId != null) {
          final goal = await dgr.loadGoalById(act.goalId!);
          if (goal != null && goal.targetValue != null) {
            target = goal.targetValue!.toInt();
          }
        }

        // 4. Tags
        List<String>? tags;
        if (act.tags != null) {
          try {
            tags = act.tags;
          } catch (_) {}
        }

        counters.add(CounterModel(
          id: act.id,
          name: act.name,
          description: act.description ?? '',
          count: total.toInt(),
          logs: logs,
          target: target,
          tags: tags,
        ));
      }
    }
    return counters;
  }

  @override
  Future<void> saveCounters(List<CounterModel> counters) async {
    for (final counter in counters) {
      // Upsert Activity
      // Check if goal exists or needs creation
      String? goalId;
      final existingActivity = await db.loadActivityById(counter.id);
      goalId = existingActivity?.goalId;

      if (counter.target != null) {
        if (goalId == null) {
          goalId = const Uuid().v4();
          final goal = Goal(
              id: goalId,
              name: 'Goal for ${counter.name}',
              targetValue: counter.target!.toDouble(),
              type: 'count',
              startDate: DateTime.now());
          await dgr.saveGoal(goal);
        } else {
          // Update goal target if changed
          var goal = await dgr.loadGoalById(goalId);
          goal = goal!.copyWith(targetValue: counter.target!.toDouble());
          await dgr.updateGoal(goal);
        }
      }

      final activity = Activity.countBased(
        id: counter.id,
        name: counter.name,
        description: counter.description,
        unit: 'count',
        // Default unit
        goalId: goalId,
        tags: counter.tags,
        count: counter.count,
      );
      await db.saveActivity(activity);

      // Upsert Logs
      for (final log in counter.logs) {
        double value = 0;
        if (log.action == 'Increased') {
          value = 1.0;
        } else if (log.action == 'Decreased') {
          value = -1.0;
        }
        final item = ActivityLog(
            id: log.id,
            activityId: counter.id,
            timestamp: log.timestamp,
            value: value,
            notes: (log.action != 'Increased' && log.action != 'Decreased'
                ? log.action
                : null));
        await db.saveLog(item);
      }
    }
  }
}
