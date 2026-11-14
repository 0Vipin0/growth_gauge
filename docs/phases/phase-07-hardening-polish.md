## 10. Phase 7: Comprehensive Details (Hardening, Polish & Legacy Cleanup)

Phase 7 hardens the entire system for production release, ensures 60/120 FPS UI smoothness, accessibility, and cleanly purges obsolete legacy code.

### 7.1 Architecture & Polish Rules
1. **Background Isolate Offloading (Section 40 & Performance Strategy):**
   - Large export payload parsing/sorting, JSON serialization, SHA-256 checksums, import JSON validation, and completed-session rebuild ordering run through `Isolate.run()` using primitive messages and top-level worker functions.
   - Drift reads, writes, and analytics projections stay on the owning isolate because the active Drift database/SQLite connection cannot be sent to a worker isolate. A 1,000-session stress test now records elapsed time and event-loop pulse gaps; device frame pacing remains a release verification item.
2. **Accessibility (a11y) & Haptics:**
   - Full screen reader semantics labels on active workout controls.
   - Light/dark high-contrast color schemes use Material contrast levels and test text contrast pairs against WCAG AA (4.5:1).
   - Haptic vibration patterns on rest timer completion.
3. **Legacy Pruning:**
   - Safely remove legacy counter/timer features (`lib/features/counter/`, `lib/features/timer/`, legacy routes) without leaving dead dependencies.
4. **End-to-End Integration Suite:**
   - Automated Flutter test flow verifies: Seed Catalog -> Create Template -> Run Workout -> Log 4 Sets -> Complete a Rest Interval -> Complete -> Verify Analytics/PRs -> Export -> Clear Documents and Read Models -> Import -> Verify Identical Stats.
5. **Dynamic Training Hub Analytics & Calorie Estimation (Step 7.5):**
   - No hardcoded metrics in presentation cards (`3,240 kcal`, `85%`, `workoutHistory: const []`).
   - Training Hub cards derive all statistics dynamically from `Stream<List<DailyWorkoutSummary>>` emitted by `AnalyticsQueries.watchWorkoutHistory`.
   - Calorie expenditure for resistance training follows a metabolic equivalent (MET 6.0) base rate combined with mechanical volume work scaling:
     $$\text{Calories}_{\text{base}} = \left(\frac{\text{MET} \times 3.5 \times \text{weightKg}}{200}\right) \times \text{activeMinutes}$$
     $$\text{Calories}_{\text{volume}} = \text{volumeLoadKg} \times 0.015 \text{ kcal/kg}$$
     $$\text{Calories}_{\text{total}} = \text{round}(\text{Calories}_{\text{base}} + \text{Calories}_{\text{volume}})$$
   - "This Week" aggregates active sessions between Monday 00:00:00 and Sunday 23:59:59 of the current week.
   - The "Details" header action navigates deterministically via GoRouter to `/analytics` (`appRouteAnalytics`).
6. **Clean Entity Hydration in Session & Analytics Views (Step 7.5):**
   - Session summary screens and PR badges must not display raw opaque database identifiers (e.g. `exercise-barbell-curl-001`, `exercise-squat-001`).
   - Components resolve names asynchronously via `IExerciseRepository.findById()` with a human-readable title fallback (`Barbell Curl`, `Squat`).
   - Repetition statistics in completed workout timelines must compute the true sum of logged repetitions (`s.actualReps ?? s.targetReps ?? 0`) across sets rather than artificial placeholder multipliers (`sets.length * 8`).

---

### 7.2 Phase 7 File Manifest & Cleanup Actions

#### Legacy Files to Remove
- `lib/features/counter/` (all counter pages, providers, widgets)
- `lib/features/timer/` (all legacy timer pages, providers, widgets)
- `lib/features/splash/` and `lib/features/onboarding/` (refactored to point to new fitness flow)
- Legacy shared preferences repositories (`shared_preferences_counter_repository.dart`, etc.)

#### New Hardening Files
- `lib/core/concurrency/isolate_runner.dart`: Wrapper around `Isolate.run()` for background tasks.
- `lib/core/theme/fitness_theme.dart`: Polished dark/light Material 3 theme.
- `integration_test/end_to_end_workout_journey_test.dart`: Complete end-to-end user journey test.

#### Step 7.5 Implementation Files
- `lib/features/analytics/domain/calorie_calculator.dart`: Pure domain utility calculating MET-based calorie burn from active training seconds, volume load, and body weight.
- `lib/features/home/presentation/widgets/week_summary_section.dart`: Refactored `CaloriesCard` and `WeekSummarySection` taking dynamic burned calories, goals, and `onDetailsTap` navigation callback.
- `lib/features/home/presentation/screen/fitness_hub_screen.dart`: Wires `workoutHistory` and `onAnalyticsTap` to `WeekSummarySection`.
- `lib/features/home/presentation/screen/home_screen.dart`: Propagates reactive analytics stream to `FitnessHubScreen`.
- `lib/features/session/presentation/screen/session_summary_screen.dart`: Resolves exercise IDs to catalog names and computes exact logged reps.
- `lib/core/app/app_routes.dart`: Injects `exerciseRepository` into `SessionSummaryScreen` route.
- `test/features/analytics/calorie_calculator_test.dart`: Comprehensive unit tests for calorie calculations.
- `test/features/home/week_summary_section_test.dart`: Widget tests asserting zero/empty and active weekly data states, formatting, and details button tap.
- `test/features/home/activity_trends_section_test.dart`: Widget tests verifying week, month, and quarter views with pagination offsets.
- `test/features/session/session_summary_screen_test.dart`: Widget tests verifying exercise name resolution and real rep summation.

---

### 7.3 Phase 7 Verification & Acceptance Criteria

| Component | Test Case | Success Criteria |
|---|---|---|
| **Isolate Concurrency** | Rebuild analytics under load | Export/import CPU work and rebuild ordering run in worker isolates; Drift projections remain on the database isolate. The 1,000-session stress test passes and reports elapsed time and event-loop pulse gaps. The device 60 FPS profile acceptance is pending. |
| **End-to-End Journey** | Full lifecycle integration | Completed in `test/integration/end_to_end_workout_journey_test.dart`; workout, rest, four logged sets, analytics/PRs, backup roundtrip, and restored stats are asserted. |
| **Static Analysis** | `scripts/check.ps1` | Passed: zero analyzer infos/warnings/errors and format verification. Full test suite passed (127+ tests). |
| **Legacy Removal** | Unused code verification | Counter/timer/chart/splash/onboarding feature trees, routes, tests, shared-preference repositories, and direct-only CSV/heatmap/Lottie dependencies removed. `path_provider` remains transitive through dependencies, not direct. |
| **Calorie Domain Model** | MET 6.0 + Volume work formula | `CalorieCalculator.estimateBurned` correctly calculates kcal for zero values, standard 45-min workouts (300-450 kcal), and heavy volume sessions; scales with user weight. |
| **Dynamic Week Summary** | Training Hub "This Week" card | Displays exact active hours/minutes, completed workout count, and estimated calories burned. Replaces hardcoded `3,240` and `85%`. |
| **Details Navigation** | Tap "Details" in Training Hub | Invokes `onDetailsTap` and routes via GoRouter to `appRouteAnalytics` (`/analytics`). |
| **Activity Trends** | Week / Month / Quarter views | Accurately highlights days with completed sessions, counts weekly workouts in month view, and monthly sessions in quarter view. Responds to `timeOffset` chevrons. |
| **Exercise ID Resolution** | `SessionSummaryScreen` timeline | Displays catalog exercise names (e.g. "Barbell Bench Press") instead of raw IDs ("exercise-bench-press-001"); sums actual logged reps instead of sets * 8. |

---

### 7.4 Phase 7 Execution Status

| Step | Action | Status | Notes |
|---|---|---|---|
| **Step 7.1** | Offload portable data CPU work and rebuild ordering | `[~] PARTIAL` | Added `IsolateRunner`; top-level workers receive serializable primitive messages so Drift objects never cross isolate boundaries. Export payload preparation/checksum, import parsing/checksum validation, pretty JSON serialization, and session ordering are offloaded. The 1,000-session stress test passes. Projection writes remain on the Drift isolate; device frame profiling is pending. |
| **Step 7.2** | Accessibility, contrast and rest completion feedback | `[x] COMPLETED` | Active timer, pause/resume and completion controls expose semantics; rest auto-completion triggers medium haptic feedback. Light/dark high-contrast text pairs have WCAG AA contrast tests. |
| **Step 7.3** | Prune legacy features and refactor launch flow | `[x] COMPLETED` | Removed counter/timer/chart/splash/onboarding trees and dead routes/tests/repositories; launch now routes through saved authentication settings into the fitness home. Removed direct-only `csv`, `flutter_heatmap_calendar`, and `lottie` dependencies. |
| **Step 7.4** | End-to-end portability journey and verification | `[x] COMPLETED` | Added `test/integration/end_to_end_workout_journey_test.dart` and a 1,000-session analytics rebuild stress test. `scripts/check.ps1` passes analysis, format check, and all 127 tests. The device-frame profiling portion remains pending and prevents Phase 7 from being fully closed. |
| **Step 7.5** | Dynamic analytics integration for Training Hub ("This Week" & Activity Trends) | `[x] COMPLETED` | Implemented `CalorieCalculator` (MET 6.0 + volume work factor). Replaced hardcoded values in `WeekSummarySection` / `CaloriesCard`, wired GoRouter analytics navigation to "Details", added week/month/quarter semantics, resolved exercise names & true reps in `SessionSummaryScreen`, and added 4 new test suites. |

**Remaining release check:** profile a rebuild of 1,000 completed sessions on a Flutter device and confirm animation frame pacing. The automated stress test runs this rebuild on the test host and reports elapsed time and 16 ms event-loop pulse gaps; its measured pulse gaps are diagnostic and are not a substitute for Flutter device `FrameTiming`. No Android/iOS device or hardware-rendered target was available in this environment. Drift query/projection transactions intentionally stay on the database isolate; only portable CPU processing and rebuild ordering are moved to worker isolates with the current architecture.

---

### 7.5 Step 7.5 Deep-Dive Implementation Specification

#### 7.5.1 Calorie Estimation Mathematical Model & Domain Utility
- **File:** `lib/features/analytics/domain/calorie_calculator.dart`
- **Method Signature:**
  ```dart
  class CalorieCalculator {
    const CalorieCalculator._();

    /// Estimates calories burned during a resistance/functional training session.
    ///
    /// [activeSeconds] Total active training time excluding rest/pause intervals.
    /// [volumeLoadKg] Total weight lifted in kilograms across all completed sets.
    /// [userWeightKg] Body weight in kilograms (defaults to standard 75.0 kg baseline).
    /// [met] Metabolic Equivalent of Task (defaults to 6.0 for resistance training).
    static int estimateBurned({
      required int activeSeconds,
      required double volumeLoadKg,
      double userWeightKg = 75.0,
      double met = 6.0,
    }) {
      if (activeSeconds <= 0 && volumeLoadKg <= 0) return 0;
      final activeMinutes = activeSeconds / 60.0;
      final burnRatePerMinute = (met * 3.5 * userWeightKg) / 200.0;
      final baseCalories = activeMinutes * burnRatePerMinute;
      final volumeCalories = volumeLoadKg * 0.015;
      return (baseCalories + volumeCalories).round();
    }
  }

  extension DailyWorkoutSummaryCalorieX on Iterable<DailyWorkoutSummary> {
    int calculateTotalCalories({double userWeightKg = 75.0}) {
      return fold<int>(
        0,
        (sum, item) => sum + CalorieCalculator.estimateBurned(
          activeSeconds: item.activeSeconds,
          volumeLoadKg: item.volumeLoadKg,
          userWeightKg: userWeightKg,
        ),
      );
    }
  }
  ```

#### 7.5.2 Reactive Training Hub Data Flow
1. **Source of Truth:**
   - Completed workouts produce `DailyWorkoutSummaries` rows via `AnalyticsProjector`.
   - `AnalyticsQueries.watchWorkoutHistory(userId)` emits a reactive stream `Stream<List<DailyWorkoutSummary>>`.
2. **App Router Binding:**
   - In `lib/core/app/app_routes.dart`:
     ```dart
     appGoRoute(
       path: appRouteHome,
       name: appRouteNameHome,
       builder: (_, _) => StreamBuilder<List<DailyWorkoutSummary>>(
         stream: analyticsQueries.watchWorkoutHistory('local-user'),
         builder: (context, snapshot) {
           final workoutHistory = snapshot.data ?? [];
           return HomeScreen(
             sessionRepository: sessions,
             sessionUseCases: sessionUseCases,
             exerciseRepository: exercises,
             templateRepository: templates,
             workoutHistory: workoutHistory,
           );
         },
       ),
     ),
     ```
3. **Training Hub Screen Propagation:**
   - `HomeScreen` supplies `workoutHistory` and `onAnalyticsTap: () => context.push(appRouteAnalytics)` to `FitnessHubScreen`.
   - `FitnessHubScreen` forwards `onDetailsTap: widget.onAnalyticsTap` and `summaries: widget.workoutHistory` to `WeekSummarySection`.

#### 7.5.3 WeekSummarySection & CaloriesCard Dynamic Binding
- **Week Window Calculation:**
  ```dart
  final now = DateTime.now();
  final startOfWeek = DateTime(now.year, now.month, now.day)
      .subtract(Duration(days: now.weekday - 1));
  final weekSummaries = summaries.where(
    (s) => !s.date.isBefore(startOfWeek),
  ).toList();
  ```
- **CaloriesCard Contract:**
  ```dart
  class CaloriesCard extends StatelessWidget {
    const CaloriesCard({
      super.key,
      required this.burnedCalories,
      this.targetCalories = 3500,
    });

    final int burnedCalories;
    final int targetCalories;

    @override
    Widget build(BuildContext context) {
      final progress = targetCalories > 0
          ? (burnedCalories / targetCalories).clamp(0.0, 1.0)
          : 0.0;
      final percentageText = '${(progress * 100).round()}%';
      final formattedCalories = NumberFormat.decimalPattern().format(burnedCalories);
      // renders formattedCalories and CircularProgressIndicator(value: progress)
    }
  }
  ```
- **Header Button Binding:**
  ```dart
  AppButton.ghost(
    label: 'Details',
    onPressed: onDetailsTap,
  )
  ```

#### 7.5.4 Activity Trends Multi-Window Aggregation & Date Boundaries
- `_WeekView`: Evaluates days `targetWeekStart.add(Duration(days: index))` from Monday (index 0) to Sunday (index 6). Day slots render checkmarks when `summaries.any((s) => s.date matches day)`.
- `_MonthView`: Groups days into weeks `W1` (1-7), `W2` (8-14), `W3` (15-21), and `W4` (22-end of month) for `targetMonth`. Shows `count workouts`.
- `_QuarterView`: Evaluates the 3 constituent months of `targetQuarter`. Shows `count sessions`.
- Chevrons trigger `_timeOffset--` and `_timeOffset++`, dynamically updating `periodLabel` and re-aggregating the view data.

#### 7.5.5 Entity Hydration & Rep Summation in SessionSummaryScreen
- **Exercise ID Resolution:**
  - `SessionSummaryScreen` accepts `final IExerciseRepository? exerciseRepository`.
  - In `initState`, extracts unique `exerciseId` strings from `widget.session.blocks.expand((b) => b.items.map((i) => i.exerciseId)).toSet()`.
  - Fetches exercise details concurrently via `Future.wait(...)` and populates `Map<String, String> _exerciseNames`.
  - Fallback logic: If repository is null or ID not found, title-cases the exercise slug (`exercise-barbell-curl-001` $\rightarrow$ `Barbell Curl`).
- **Actual Repetition Summation:**
  - Replace the placeholder:
    ```dart
    // Before:
    Text('${item.sets.length * 8} reps')
    // After:
    final totalReps = item.sets.fold<int>(
      0,
      (sum, s) => sum + (s.actualReps ?? s.targetReps ?? 0),
    );
    Text('$totalReps reps')
    ```

#### 7.5.6 Test Suite Specifications
1. **`calorie_calculator_test.dart`:**
   - `estimateBurned` with 0 active seconds and 0 volume returns 0.
   - 1,800 active seconds (30 mins) at 75 kg with 3,000 kg volume yields $\approx 302 \text{ kcal}$.
   - Extension `calculateTotalCalories` aggregates multiple summaries correctly.
2. **`week_summary_section_test.dart`:**
   - Empty summary list renders `0 kcal`, `0%`, `0h 0m`, and `0` workouts.
   - Summaries list renders calculated calories, formatted numbers, active duration, and triggers `onDetailsTap` when tapped.
3. **`activity_trends_section_test.dart`:**
   - Week view displays checkmarks on days with workouts.
   - Paging backwards (`timeOffset = -1`) shows 'Last Week' and queries earlier dates.
   - Switching between Week, Month, and Quarter updates layout accordingly.
4. **`session_summary_screen_test.dart`:**
   - Verifies exercise name from mock `IExerciseRepository` appears in the timeline item.
   - Verifies exact sum of set reps is displayed.

---
