import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/ids/unique_id.dart';
import 'analytics_enums.dart';

/// Pure formula engine for 1RM estimation and personal record evaluation.
///
/// All calculation methods are pure functions. [evaluatePRs] and
/// [evaluateSessionVolumePR] query the current records in [AppDatabase]
/// and return [PersonalRecordsCompanion] entries to be inserted inside the
/// caller's transaction.
class const PRCalculator() {
  /// Epley formula: w × (1 + r/30).
  ///
  /// Preferred for moderate rep ranges (1–10). Returns null when [reps] < 1.
  static double? epley(double weightKg, int reps) {
    if (reps <= 0 || weightKg <= 0) return null;
    if (reps == 1) return weightKg;
    return weightKg * (1 + reps / 30.0);
  }

  /// Brzycki formula: w × 36 / (37 − r).
  ///
  /// Accurate below 10 reps. Returns null when [reps] >= 37 or [reps] < 1.
  static double? brzycki(double weightKg, int reps) {
    if (reps <= 0 || weightKg <= 0) return null;
    if (reps >= 37) return null;
    if (reps == 1) return weightKg;
    return weightKg * 36.0 / (37.0 - reps);
  }

  /// Returns the higher of the Epley and Brzycki estimates, or null if both
  /// inputs are invalid. Using max prevents deflating user achievements.
  static double? estimated1Rm(double? weightKg, int? reps) {
    if (weightKg == null || reps == null || weightKg <= 0 || reps <= 0) {
      return null;
    }
    final e = epley(weightKg, reps);
    final b = brzycki(weightKg, reps);
    if (e == null) return b;
    if (b == null) return e;
    return e > b ? e : b;
  }

  /// Volume load for a single set: weight × reps.
  static double? setVolumeLoad(double? weightKg, int? reps) {
    if (weightKg == null || reps == null || weightKg <= 0 || reps <= 0) {
      return null;
    }
    return weightKg * reps;
  }

  // ---------------------------------------------------------------------------
  // PR Evaluation (Step 4.2)
  // ---------------------------------------------------------------------------

  /// Evaluates all applicable PR types for a completed set and returns
  /// [PersonalRecordsCompanion] rows for any broken records.
  Future<List<PersonalRecordsCompanion>> evaluatePRs(
    AppDatabase db, {
    required String userId,
    required String exerciseId,
    required String sessionId,
    required String setId,
    required DateTime achievedAt,
    required double? weightKg,
    required int? reps,
    required double? volumeLoad,
    required double? est1Rm,
  }) async {
    final newRows = <PersonalRecordsCompanion>[];

    await _maybeNewPR(
      db: db,
      newRows: newRows,
      userId: userId,
      exerciseId: exerciseId,
      sessionId: sessionId,
      setId: setId,
      achievedAt: achievedAt,
      prType: PrType.maxWeight,
      newValue: weightKg,
    );

    await _maybeNewPR(
      db: db,
      newRows: newRows,
      userId: userId,
      exerciseId: exerciseId,
      sessionId: sessionId,
      setId: setId,
      achievedAt: achievedAt,
      prType: PrType.estimated1Rm,
      newValue: est1Rm,
    );

    await _maybeNewPR(
      db: db,
      newRows: newRows,
      userId: userId,
      exerciseId: exerciseId,
      sessionId: sessionId,
      setId: setId,
      achievedAt: achievedAt,
      prType: PrType.maxVolumeSet,
      newValue: volumeLoad,
    );

    if (weightKg != null && reps != null && reps > 0) {
      await _maybeNewPR(
        db: db,
        newRows: newRows,
        userId: userId,
        exerciseId: exerciseId,
        sessionId: sessionId,
        setId: setId,
        achievedAt: achievedAt,
        prType: PrType.maxRepsAtWeight,
        newValue: reps.toDouble(),
      );
    }

    return newRows;
  }

  /// Evaluates [PrType.maxVolumeSession] after all sets in an exercise have been aggregated.
  Future<List<PersonalRecordsCompanion>> evaluateSessionVolumePR(
    AppDatabase db, {
    required String userId,
    required String exerciseId,
    required String sessionId,
    required DateTime achievedAt,
    required double sessionVolumeKg,
  }) async {
    final newRows = <PersonalRecordsCompanion>[];
    await _maybeNewPR(
      db: db,
      newRows: newRows,
      userId: userId,
      exerciseId: exerciseId,
      sessionId: sessionId,
      setId: null,
      achievedAt: achievedAt,
      prType: PrType.maxVolumeSession,
      newValue: sessionVolumeKg,
    );
    return newRows;
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  Future<void> _maybeNewPR({
    required AppDatabase db,
    required List<PersonalRecordsCompanion> newRows,
    required String userId,
    required String exerciseId,
    required String sessionId,
    required String? setId,
    required DateTime achievedAt,
    required PrType prType,
    required double? newValue,
  }) async {
    if (newValue == null || newValue <= 0) return;

    // Fetch the current best record
    final existing =
        await (db.select(db.personalRecords)
              ..where(
                (t) =>
                    t.userId.equals(userId) &
                    t.exerciseId.equals(exerciseId) &
                    t.prType.equals(prType.name),
              )
              ..orderBy([(t) => OrderingTerm.desc(t.value)])
              ..limit(1))
            .getSingleOrNull();

    final currentBest = existing?.value ?? 0.0;

    if (newValue > currentBest) {
      newRows.add(
        PersonalRecordsCompanion(
          id: Value(UniqueId.generate().value),
          exerciseId: Value(exerciseId),
          userId: Value(userId),
          prType: Value(prType.name),
          value: Value(newValue),
          sessionId: Value(sessionId),
          setId: Value(setId),
          achievedAt: Value(achievedAt),
          replacesRecordId: Value(existing?.id),
        ),
      );
    }
  }
}
