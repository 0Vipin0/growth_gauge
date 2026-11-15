import 'package:drift/drift.dart';

/// Materialized read model: one row per completed [ExecutionSet].
///
/// Contains all measurements and derived analytics values (volume load, 1RM)
/// needed to power progression charts and PR evaluation without re-parsing
/// the full session document.
@DataClassName('ExerciseSetMetricRow')
class ExerciseSetMetrics() extends Table {
  /// ExecutionSet ID (matches the session document).
  TextColumn get id => text()();

  /// Session this set belongs to.
  TextColumn get sessionId => text()();

  /// Catalog exercise ID.
  TextColumn get exerciseId => text()();

  /// User who performed the session.
  TextColumn get userId => text()();

  /// Wall-clock timestamp when the set was completed.
  DateTimeColumn get timestamp => dateTime()();

  /// Weight lifted in canonical kg (null for bodyweight/time sets).
  RealColumn get weightKg => real().nullable()();

  /// Actual reps completed (null for time/distance sets).
  IntColumn get reps => integer().nullable()();

  /// Volume load: weightKg * reps (null when either is absent).
  RealColumn get volumeLoad => real().nullable()();

  /// Epley estimated 1RM: weight * (1 + reps/30). Null if reps < 1.
  RealColumn get estimated1Rm => real().nullable()();

  /// Recorded Rate of Perceived Exertion (1–10 scale).
  RealColumn get rpe => real().nullable()();

  /// Recorded Reps In Reserve.
  IntColumn get rir => integer().nullable()();

  /// Set type string matching [SetType] enum name.
  TextColumn get setType => text()();

  @override
  Set<Column> get primaryKey => {id};
}
