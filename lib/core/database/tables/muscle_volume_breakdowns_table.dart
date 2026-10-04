import 'package:drift/drift.dart';

/// Materialized read model: weekly muscle-group volume aggregation.
///
/// One row per (userId, muscleGroup, isoWeek). Enables the weekly volume
/// bar chart broken down by muscle group without scanning session documents.
@DataClassName('MuscleVolumeBreakdownRow')
class MuscleVolumeBreakdowns extends Table {
  /// Composite key: "{userId}_{muscleGroup}_{isoYear}_{isoWeek}"
  TextColumn get id => text()();

  TextColumn get userId => text()();

  /// Muscle group string matching [MuscleGroup] enum name.
  TextColumn get muscleGroup => text()();

  /// ISO 8601 year number of the week.
  IntColumn get isoYear => integer()();

  /// ISO 8601 week number (1–53).
  IntColumn get isoWeek => integer()();

  /// Monday midnight UTC for this ISO week (for date-range filtering).
  DateTimeColumn get weekStartDate => dateTime()();

  /// Total volume load in kg for this muscle group in this week.
  RealColumn get totalVolumeKg => real()();

  /// Total working sets for this muscle group in this week.
  IntColumn get totalSets => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
