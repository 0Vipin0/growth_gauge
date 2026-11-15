import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/daily_workout_summaries_table.dart';
import 'tables/documents_table.dart';
import 'tables/exercise_set_metrics_table.dart';
import 'tables/muscle_volume_breakdowns_table.dart';
import 'tables/notification_logs_table.dart';
import 'tables/notification_preferences_table.dart';
import 'tables/personal_records_table.dart';
import 'tables/rest_interval_metrics_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Documents,
    DailyWorkoutSummaries,
    ExerciseSetMetrics,
    PersonalRecords,
    MuscleVolumeBreakdowns,
    RestIntervalMetrics,
    NotificationPreferencesTable,
    NotificationLogsTable,
  ],
)
class AppDatabase([QueryExecutor? e]) extends _$AppDatabase {
  this : super(e ?? _openConnection());

  /// Creates an isolated in-memory SQLite database instance for testing.
  factory inMemory() {
    return AppDatabase(NativeDatabase.memory());
  }

  @override
  int get schemaVersion => 5; // Bumped schema version to 5

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(dailyWorkoutSummaries);
        await m.createTable(exerciseSetMetrics);
        await m.createTable(personalRecords);
        await m.createTable(muscleVolumeBreakdowns);
        await m.createTable(restIntervalMetrics);
      }
      if (from < 3) {
        await customStatement(
          'CREATE INDEX IF NOT EXISTS muscle_volume_user_week_start '
          'ON muscle_volume_breakdowns (user_id, week_start_date)',
        );
      }
      if (from < 4) {
        // Create the notification preferences table during upgrade from v3 to v4
        await m.createTable(notificationPreferencesTable);
      }
      if (from < 5) {
        // Create notification logs table during upgrade from v4 to v5
        await m.createTable(notificationLogsTable);
      }
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'growth_gauge_core_db');
  }
}
