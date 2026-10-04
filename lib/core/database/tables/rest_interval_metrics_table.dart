import 'package:drift/drift.dart';

/// Materialized read model: per-set rest adherence metrics.
///
/// One row per completed [RestInterval]. Supports future rest-adherence
/// analytics (planned vs actual rest, skip rate, average rest by exercise).
@DataClassName('RestIntervalMetricRow')
class RestIntervalMetrics extends Table {
  /// RestInterval ID (matches the session document).
  TextColumn get id => text()();

  TextColumn get sessionId => text()();

  TextColumn get executionSetId => text()();

  TextColumn get exerciseId => text()();

  TextColumn get userId => text()();

  DateTimeColumn get startedAt => dateTime()();

  /// Null if the interval has not yet ended (defensive — projector only writes closed intervals).
  DateTimeColumn get endedAt => dateTime().nullable()();

  /// Prescribed rest duration from the template set.
  IntColumn get plannedDurationSeconds => integer()();

  /// Actual rest duration taken (null if skipped before expiry).
  IntColumn get actualDurationSeconds => integer().nullable()();

  /// True if the rest was skipped before the planned duration elapsed.
  BoolColumn get wasSkipped => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}
