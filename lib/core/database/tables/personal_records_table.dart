import 'package:drift/drift.dart';

/// Materialized read model: one row per personal record achievement.
///
/// Maintained idempotently by [AnalyticsProjector]. When a new PR supersedes
/// an existing one the [replacesRecordId] field links the chain. Old PR rows
/// are kept for historical display ("previous best").
@DataClassName('PersonalRecordRow')
class PersonalRecords extends Table {
  /// UUID generated at projection time.
  TextColumn get id => text()();

  /// Catalog exercise this record belongs to.
  TextColumn get exerciseId => text()();

  /// User who achieved the record.
  TextColumn get userId => text()();

  /// PR type string matching [PrType] enum name.
  /// e.g. 'maxWeight', 'estimated1Rm', 'maxRepsAtWeight', 'maxVolumeSet', 'maxVolumeSession'
  TextColumn get prType => text()();

  /// The numeric record value (kg, reps, or kg*reps depending on prType).
  RealColumn get value => real()();

  /// Session where this record was achieved.
  TextColumn get sessionId => text()();

  /// The specific [ExecutionSet] that achieved this record (null for session-level PRs).
  TextColumn get setId => text().nullable()();

  /// Wall-clock timestamp of the session completion.
  DateTimeColumn get achievedAt => dateTime()();

  /// ID of the previous best record this one replaced (null if first ever).
  TextColumn get replacesRecordId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
