## 7. Phase 4: Comprehensive Details (Materialized Analytics & Drift Projections)

Phase 4 implements the high-performance analytics query engine, projection pipeline, and visual dashboards.

### 7.1 Architecture & Domain Rules

```text
Completed WorkoutSession
          â”‚
          â–¼
WorkoutSessionCompletedEvent
          â”‚
          â–¼
AnalyticsProjector (Transactional)
          â”œâ”€â”€ 1. Daily Summary Record
          â”œâ”€â”€ 2. Exercise Set Metrics
          â”œâ”€â”€ 3. Personal Record Evaluation
          â”œâ”€â”€ 4. Muscle Volume Aggregates
          â””â”€â”€ 5. Rest Interval Adherence
          â”‚
          â–¼
Drift Materialized Tables (SQLite)
          â”‚
          â–¼
fl_chart Reactive Streams
```

1. **Materialized Read Models vs. Source of Truth (Section 2.1 & Rule 2):**
   - The authoritative data is the completed `WorkoutSession` JSON document.
   - Analytics tables in Drift are **derived read models** optimized for filtering, grouping, aggregation, and instant charting.
   - Analytics tables are never used to edit a workout.
2. **Idempotency & Rebuildability (Section 25 & Rule 5):**
   - Projecting the same workout session twice must produce the identical database state without duplicate rows.
   - If analytics data becomes stale, corrupted, or schema changes occur, `RebuildAnalyticsUseCase` clears the relational tables and replays all completed session documents in chronological order.
3. **Personal Record (PR) Calculation Engine (Section 27):**
   - Tracks 5 distinct PR types per exercise:
     - `MAX_WEIGHT`: Heaviest absolute weight lifted.
     - `ESTIMATED_ONE_REP_MAX` (1RM): Calculated using the Brzycki / Epley formulas:
       $$1\text{RM}_{\text{Epley}} = w \times (1 + \frac{r}{30})$$
       $$1\text{RM}_{\text{Brzycki}} = w \times \frac{36}{37 - r}$$
     - `MAX_REPS_AT_WEIGHT`: Most reps completed at a specific weight.
     - `MAX_VOLUME_SET`: $\text{weight} \times \text{reps}$ for a single set.
     - `MAX_VOLUME_SESSION`: Total exercise volume across a session.
4. **Volume & Frequency Aggregations (Section 26):**
   - Calculates weekly set volume per muscle group.
   - Computes daily workout frequency for calendar heatmaps.
5. **Streak Heatmaps and Flexible Windows:** Activity detail views must show consecutive active-day streaks and calendar heatmaps. Chart queries support 7-, 14-, 30-, and 90-day windows, with selected period clearly indicated.
6. **Daily Log Analytics:** Mood, notes, and RPE are available in session/day history. Aggregate RPE only where meaningful; missing RPE or mood remains missing rather than being treated as zero.
7. **Goal-Centric Dashboard:** Show count-based and time-based activities, grouped/sorted by supporting goal with progress against configured targets. Completed workouts and configured activity records remain the source of truth; do not restore generic legacy counter storage.

---

### 7.2 Phase 4 File Manifest

```text
lib/
â”œâ”€â”€ core/
â”‚   â””â”€â”€ database/
â”‚       â””â”€â”€ tables/
â”‚           â”œâ”€â”€ daily_workout_summaries_table.dart
â”‚           â”œâ”€â”€ exercise_set_metrics_table.dart
â”‚           â”œâ”€â”€ personal_records_table.dart
â”‚           â”œâ”€â”€ muscle_volume_breakdowns_table.dart
â”‚           â””â”€â”€ rest_interval_metrics_table.dart
â”‚
â””â”€â”€ features/
    â””â”€â”€ analytics/
        â”œâ”€â”€ domain/
        â”‚   â”œâ”€â”€ daily_workout_summary.dart     # Freezed DailyWorkoutSummary read model
        â”‚   â”œâ”€â”€ exercise_set_metric.dart       # Freezed ExerciseSetMetric read model
        â”‚   â”œâ”€â”€ personal_record.dart           # Freezed PersonalRecord read model
        â”‚   â”œâ”€â”€ muscle_volume_stat.dart        # Freezed MuscleVolumeStat read model
        â”‚   â”œâ”€â”€ analytics_enums.dart           # PrType (maxWeight, estimated1Rm, maxReps, maxVolume)
        â”‚   â””â”€â”€ pr_calculator.dart             # Formula algorithms for 1RM, volume load, and PR checks
        â”‚
        â”œâ”€â”€ projection/
        â”‚   â”œâ”€â”€ analytics_projector.dart       # Event listener writing to Drift tables transactionally
        â”‚   â””â”€â”€ projection_rebuilder.dart      # Replays historical sessions from DocumentStore
        â”‚
        â”œâ”€â”€ application/
        â”‚   â”œâ”€â”€ analytics_queries.dart         # GetWorkoutHistory, GetExerciseProgression, GetPRs
        â”‚   â””â”€â”€ analytics_cubit.dart           # AnalyticsCubit, AnalyticsState
        â”‚
        â”œâ”€â”€ infrastructure/
        â”‚   â””â”€â”€ analytics_dao.dart             # Drift DAO exposing reactive select streams
        â”‚
        â””â”€â”€ presentation/
            â”œâ”€â”€ screens/
            â”‚   â”œâ”€â”€ analytics_dashboard_screen.dart # Overview: weekly volume, calendar heatmap, recent PRs
            â”‚   â”œâ”€â”€ exercise_progression_screen.dart# 1RM trend line chart & set history
            â”‚   â””â”€â”€ pr_trophy_screen.dart      # Personal record badges grouped by exercise
            â””â”€â”€ widgets/
                â”œâ”€â”€ volume_bar_chart.dart      # fl_chart weekly bar graph
                â”œâ”€â”€ progression_line_chart.dart# fl_chart 1RM progression curve
                â”œâ”€â”€ pr_badge_card.dart         # Trophy card highlighting new PRs
                â””â”€â”€ workout_frequency_heatmap.dart # GitHub-style calendar consistency grid
```

---

### 7.3 Detailed Component Specifications (Phase 4)

#### A. Drift Relational Schema

```dart
// lib/core/database/tables/daily_workout_summaries_table.dart
class DailyWorkoutSummaries extends Table {
  TextColumn get id => text()();                  // UUID or YYYY-MM-DD-sessionId
  DateTimeColumn get date => dateTime()();        // Normalized midnight UTC
  TextColumn get sessionId => text()();
  IntColumn get durationSeconds => integer()();
  RealColumn get volumeLoadKg => real()();
  IntColumn get totalCompletedSets => integer()();
  IntColumn get totalCompletedReps => integer()();
  RealColumn get averageRpe => real().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// lib/core/database/tables/exercise_set_metrics_table.dart
class ExerciseSetMetrics extends Table {
  TextColumn get id => text()();                  // ExecutionSet ID
  TextColumn get sessionId => text()();
  TextColumn get exerciseId => text()();
  DateTimeColumn get timestamp => dateTime()();
  RealColumn get weightKg => real()();
  IntColumn get reps => integer()();
  RealColumn get volumeLoad => real()();          // weightKg * reps
  RealColumn get estimated1Rm => real()();        // Epley formula
  RealColumn get rpe => real().nullable()();
  IntColumn get rir => integer().nullable()();
  TextColumn get setType => text()();             // warmup, working, etc.

  @override
  Set<Column> get primaryKey => {id};
}

// lib/core/database/tables/personal_records_table.dart
class PersonalRecords extends Table {
  TextColumn get id => text()();                  // UUID
  TextColumn get exerciseId => text()();
  TextColumn get prType => text()();              // MAX_WEIGHT, ESTIMATED_1RM, MAX_REPS
  RealColumn get value => real()();
  TextColumn get sessionId => text()();
  TextColumn get setId => text()();
  DateTimeColumn get achievedAt => dateTime()();
  TextColumn get replacesRecordId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
```

#### B. Analytics Projector Implementation (`lib/features/analytics/projection/`)

The `AnalyticsProjector` listens to `WorkoutSessionCompletedEvent` from `DomainEventDispatcher`:
```dart
class AnalyticsProjector {
  final AppDatabase _db;
  final PRCalculator _prCalculator;

  AnalyticsProjector(this._db, this._prCalculator);

  Future<void> project(WorkoutSession session) async {
    await _db.transaction(() async {
      // 1. Delete any existing rows for this sessionId (ensuring idempotency)
      await (_db.delete(_db.dailyWorkoutSummaries)..where((t) => t.sessionId.equals(session.id))).go();
      await (_db.delete(_db.exerciseSetMetrics)..where((t) => t.sessionId.equals(session.id))).go();
      await (_db.delete(_db.personalRecords)..where((t) => t.sessionId.equals(session.id))).go();

      // 2. Insert Daily Summary
      await _db.into(_db.dailyWorkoutSummaries).insert(session.toDailySummaryRow());

      // 3. Insert Exercise Set Metrics & Evaluate PRs
      for (final block in session.blocks) {
        for (final item in block.items) {
          for (final set in item.sets) {
            if (set.status == ExecutionSetStatus.completed && (set.actualReps ?? 0) > 0) {
              final metricRow = set.toMetricRow(session.id, item.exerciseId);
              await _db.into(_db.exerciseSetMetrics).insert(metricRow);

              // Check if set broke existing PRs
              final newPRs = await _prCalculator.evaluatePRs(metricRow, _db);
              for (final pr in newPRs) {
                await _db.into(_db.personalRecords).insert(pr);
              }
            }
          }
        }
      }
    });
  }
}
```

---

### 7.3.1 Insight and Activity Detail Requirements

- Provide a detail view for each tracked activity/goal with a calendar heatmap, consecutive-day streak calculation, and charts selectable for **7, 14, 30, or 90 days**. Default chart window: **NA â€” not specified in the legacy source**; allow the user to select a supported window.
- The dashboard must support both activity progress, group/sort activities by the goal they support, and show progress bars against configured targets.
- Daily entries can include mood, notes, and perceived exertion (RPE); show these alongside relevant history and ensure analytics handle missing values correctly.
- Preserve the intent of the legacy weekly chart/heatmap features within the new fitness dashboard. Do not restore the legacy counter/timer pages or their Shared Preferences repositories.
- Acceptance checks: all four chart windows return correctly bounded date ranges; heatmap streaks handle missed days, timezone/date boundaries, and empty history; goal progress handles zero/missing targets without division errors; daily log fields survive restart and JSON export/import.

---

### 7.4 Phase 4 Step-by-Step Execution Sequence

1. **Step 4.1: Drift Analytics Tables & Migration** `[x]`
   - Added all analytical tables and generated Drift code. Schema version 3 adds a composite `(user_id, week_start_date)` index for weekly muscle volume, with an upgrade migration for existing databases. Freezed 4 generates collection constructor parameters accepted by the Flutter compiler; no post-generation normalization is required.
2. **Step 4.2: PR Calculation Engine** `[x]`
   - Implement `PRCalculator` with 1RM formulas and PR comparison logic.
   - Write unit tests verifying 1RM calculation accuracy and tie-breaking.
3. **Step 4.3: Analytics Projector & Event Subscription** `[x]`
   - `AnalyticsProjector` transactionally projects completed sessions, set/rest metrics, summaries, muscle volume, and PRs. App startup starts it on the shared `DomainEventDispatcher`; session start and recovery flows publish through that same dispatcher. Provider teardown stops the subscription.
4. **Step 4.4: Analytics Rebuilder** `[x]`
   - `ProjectionRebuilder` clears analytics read models and replays completed sessions sequentially.
5. **Step 4.5: Analytics DAO & Query Handlers** `[x]`
   - Implemented reactive Drift queries for progression, volume, PRs, workout history/frequency, and rest metrics.
6. **Step 4.6: Analytics Presentation UI (fl_chart)** `[x]`
   - Implemented analytics dashboard, progression and volume charts, PR trophy UI, and frequency heatmap. Registered the screen in app routing and added an Analytics & Progress entry in the Training hub. Dashboard entry rebuilds projections from completed session documents so existing workouts are included.
7. **Step 4.7: Automated Projection & Rebuild Tests** `[x]`
   - Analytics DAO, projector/rebuilder, PR calculator, widget, and volume-query benchmark tests pass. Coverage includes projection idempotency and rebuild parity.

---

### 7.5 Phase 4 Verification & Acceptance Criteria

| Component | Test Case | Success Criteria |
|---|---|---|
| **Projection Idempotency** | Double projection check | Projecting a session twice produces the exact same number of rows; no duplicates or inflated volume. |
| **PR Detection** | New PR achievement | Logging a 100 kg x 5 squat after a previous 90 kg x 5 correctly records `MAX_WEIGHT` and `ESTIMATED_1RM` records pointing to the new set. |
| **Analytics Rebuild** | Full wipe and replay | Wiping all relational analytics tables and running `RebuildAnalyticsUseCase` reproduces 100% identical analytical read data from session documents. |
| **Chart Query Performance** | Query latency benchmark | Querying 1 year of workout volume metrics executes in $< 15$ ms from SQLite indexed tables. |

**Verification results (2026-10-04):** Dart static analysis exits 0 with no errors (informational lint suggestions remain). `flutter build windows --no-pub` succeeds and produces `build/windows/x64/runner/Release/GrowthGauge.exe`. The five analytics test files pass (26 tests). The 52-week volume query benchmark returned 1,060 rows from 10,400 stored rows, with 5.83 ms median and 8.35 ms p95 over 50 measured reads, meeting the 15 ms target. Freezed 4.0.2 and the compatible Drift toolchain regenerate collection constructor parameters without the previous Windows compiler error.

---

### 7.6 Phase 4 Execution Status

| Step | Action | Status | Notes |
|---|---|---|---|
| **Step 4.1** | Drift analytics tables and schema migration | `[x] COMPLETED` | Added `DailyWorkoutSummaries`, `ExerciseSetMetrics`, `PersonalRecords`, `MuscleVolumeBreakdowns`, and `RestIntervalMetrics` tables with composite index on `(userId, weekStartDate)`. Generated Drift classes with `DataClassName` overrides. |
| **Step 4.2** | PR calculation engine | `[x] COMPLETED` | Implemented `PRCalculator` supporting Epley and Brzycki 1RM estimation, volume load, and automatic PR detection (`maxWeight`, `estimated1Rm`, `maxRepsAtWeight`, `maxVolumeSet`, `maxVolumeSession`) with historical chain linking via `replacesRecordId`. |
| **Step 4.3** | Analytics projector & event subscription | `[x] COMPLETED` | `AnalyticsProjector` listens to `WorkoutSessionCompleted` events and transactionally writes all 5 read models with strict idempotency (delete-before-insert per sessionId). |
| **Step 4.4** | Projection rebuilder | `[x] COMPLETED` | `ProjectionRebuilder` wipes all materialized analytics tables and replays completed session documents in chronological order with 100% data parity. |
| **Step 4.5** | Analytics DAO & query handlers | `[x] COMPLETED` | `AnalyticsDao` and `AnalyticsQueries` provide reactive `watch` queries for workout history, exercise progression, personal records, and weekly muscle volume. |
| **Step 4.6** | Analytics presentation UI (fl_chart) | `[x] COMPLETED` | Built `AnalyticsDashboardScreen`, `ExerciseProgressionScreen`, `PrTrophyScreen`, `VolumeBarChart`, `ProgressionLineChart`, `PrBadgeCard`, and `WorkoutFrequencyHeatmap`. Linked in `routes.dart` and Training hub. |
| **Step 4.7** | Analytics automated test suite | `[x] COMPLETED` | 26 tests pass across PR calculator unit tests, projector idempotency/rebuild parity tests, DAO reactive stream tests, widget UI tests, and 52-week volume query benchmark (<15ms). |

---
