import 'package:drift/drift.dart';

/// Materialized read model: one row per completed workout session.
///
/// Stores pre-aggregated session-level totals for fast dashboard queries.
/// This table is derived — the source of truth is the WorkoutSession JSON document.
@DataClassName('DailyWorkoutSummaryRow')
class DailyWorkoutSummaries extends Table {
  /// Primary key: composite of sessionId and summary tag.
  TextColumn get id => text()();

  /// Session wall-clock date, normalized to midnight UTC.
  DateTimeColumn get date => dateTime()();

  /// Foreign reference to the source WorkoutSession ID.
  TextColumn get sessionId => text()();

  /// ID of the user who performed the session.
  TextColumn get userId => text()();

  /// Template name for display purposes.
  TextColumn get templateName => text()();

  /// Total wall-clock elapsed seconds.
  IntColumn get durationSeconds => integer()();

  /// Total active training seconds (wall-clock minus interruptions).
  IntColumn get activeSeconds => integer()();

  /// Total volume load in kg (sum of weightKg * reps over all completed sets).
  RealColumn get volumeLoadKg => real()();

  /// Total number of completed sets.
  IntColumn get totalCompletedSets => integer()();

  /// Total number of completed reps.
  IntColumn get totalCompletedReps => integer()();

  /// Average RPE across all sets that recorded one, or null if none did.
  RealColumn get averageRpe => real().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
