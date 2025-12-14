import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/counter_model.dart';
import '../../data/services/persistence/app_database.dart';
import '../models/activity.dart' show ActivityType;
import 'counter_repository.dart';

class DriftCounterRepository implements CounterRepository {
  final AppDatabase db;

  DriftCounterRepository(this.db);

  @override
  Future<List<CounterModel>> loadCounters() async {
    // 1. Get countBased activities
    final List<Activity> activities = await (db.select(db.activities)
          ..where((t) => t.type.equals(ActivityType.countBased.index)))
        .get();

    final List<CounterModel> counters = [];

    for (final act in activities) {
      // 2. Get logs
      final List<ActivityLog> logsRows = await (db.select(db.activityLogs)
            ..where((l) => l.activityId.equals(act.id))
            ..orderBy([(t) => OrderingTerm(expression: t.timestamp)]))
          .get();

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
        final goal = await (db.select(db.goals)
              ..where((g) => g.id.equals(act.goalId!)))
            .getSingleOrNull();
        if (goal != null && goal.targetValue != null) {
          target = goal.targetValue!.toInt();
        }
      }

      // 4. Tags
      List<String>? tags;
      if (act.tags != null) {
        try {
          tags = (jsonDecode(act.tags!) as List).cast<String>();
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
    return counters;
  }

  @override
  Future<void> saveCounters(List<CounterModel> counters) async {
    await db.transaction(() async {
      for (final counter in counters) {
        // Upsert Activity
        // Check if goal exists or needs creation
        String? goalId;
        final existingActivity = await (db.select(db.activities)
              ..where((a) => a.id.equals(counter.id)))
            .getSingleOrNull();
        goalId = existingActivity?.goalId;

        if (counter.target != null) {
          if (goalId == null) {
            goalId = const Uuid().v4();
            await db.into(db.goals).insert(GoalsCompanion(
                  id: Value(goalId),
                  name: Value('Goal for ${counter.name}'),
                  type: const Value('count'),
                  targetValue: Value(counter.target!.toDouble()),
                  startDate: Value(DateTime.now()),
                ));
          } else {
            // Update goal target if changed
            await (db.update(db.goals)..where((g) => g.id.equals(goalId!)))
                .write(GoalsCompanion(
              targetValue: Value(counter.target!.toDouble()),
            ));
          }
        }

        await db.into(db.activities).insertOnConflictUpdate(ActivitiesCompanion(
              id: Value(counter.id),
              name: Value(counter.name),
              description: Value(counter.description),
              type: Value(ActivityType.countBased.index),
              unit: const Value('count'), // Default unit
              goalId: Value(goalId),
              tags:
                  Value(counter.tags != null ? jsonEncode(counter.tags) : null),
            ));

        // Upsert Logs
        for (final log in counter.logs) {
          // Verify if log exists to avoid overwriting unchanged logs unnecessarily?
          // ActivityLogs primary key is ID.
          // insertOnConflictUpdate handles Upsert.

          double value = 0;
          if (log.action == 'Increased') {
            value = 1.0;
          } else if (log.action == 'Decreased') value = -1.0;

          await db
              .into(db.activityLogs)
              .insertOnConflictUpdate(ActivityLogsCompanion(
                id: Value(log.id),
                activityId: Value(counter.id),
                timestamp: Value(log.timestamp),
                value: Value(value),
                notes: Value(
                    log.action != 'Increased' && log.action != 'Decreased'
                        ? log.action
                        : null),
              ));
        }
      }
    });
  }
}
