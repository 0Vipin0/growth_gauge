# Implementation Plan - Step 7.5: Dynamic Analytics Integration for Training Hub

## Executive Summary
Step 7.5 in [`docs/phases/phase-07-hardening-polish.md`](file:///h:/Apps/growth_gauge/docs/phases/phase-07-hardening-polish.md) resolves the remaining hardcoded values, unlinked navigation triggers, and raw identifiers across the Training Hub and Session Summary screens. 

Currently:
1. `CaloriesCard` in `WeekSummarySection` renders static literals (`3,240` kcal, `85%`).
2. The "Details" button in `WeekSummarySection` contains an empty callback (`onPressed: () {}`).
3. `SessionSummaryScreen` renders raw exercise IDs (e.g., `exercise-barbell-curl-001`) and a placeholder rep count (`sets.length * 8`).
4. Calorie burn is not dynamically estimated from session volume and duration.

This plan outlines the architecture, data flow, concrete code modifications, and automated tests to complete Step 7.5.

---

## 1. Architectural Design & Formulas

### 1.1 Calorie Estimation Model
In resistance and functional training, metabolic expenditure can be accurately estimated by combining duration-based METs (Metabolic Equivalent of Task) with mechanical work volume:

$$\text{Energy}_{\text{base}} = \left(\frac{\text{MET} \times 3.5 \times \text{weightKg}}{200}\right) \times \text{activeMinutes}$$

$$\text{Energy}_{\text{volume}} = \text{volumeLoadKg} \times 0.015 \text{ kcal/kg}$$

$$\text{Calories}_{\text{total}} = \text{round}(\text{Energy}_{\text{base}} + \text{Energy}_{\text{volume}})$$

- **Default Parameters:**
  - Resistance Training MET: $6.0$
  - Default Body Weight: $75.0\text{ kg}$ (or user profile weight if present)
  - Work factor: $0.015\text{ kcal/kg}$

We will encapsulate this calculation in a dedicated pure domain utility: [`lib/features/analytics/domain/calorie_calculator.dart`](file:///h:/Apps/growth_gauge/lib/features/analytics/domain/calorie_calculator.dart).

### 1.2 Data Flow Pipeline
```mermaid
flowchart TD
    Drift[AppDatabase: DailyWorkoutSummaries] -->|watchWorkoutHistory| Dao[AnalyticsDao]
    Dao -->|Stream<List<DailyWorkoutSummary>>| Router[app_routes.dart StreamBuilder]
    Router -->|workoutHistory| HomeScreen[HomeScreen]
    HomeScreen -->|workoutHistory & onAnalyticsTap| FitnessHubScreen[FitnessHubScreen]
    FitnessHubScreen -->|summaries & onDetailsTap| WeekSummarySection[WeekSummarySection]
    FitnessHubScreen -->|summaries| ActivityTrendsCard[ActivityTrendsCard]
    WeekSummarySection --> CalorieCalc[CalorieCalculator]
    CalorieCalc -->|computed kcal & goal %| CaloriesCard[CaloriesCard]
    WeekSummarySection -->|onDetailsTap| GoRouter[context.push('/analytics')]
```

---

## 2. Detailed Work Breakdown & Target Changes

### Task 1: Domain Calorie Calculator
- **File:** `lib/features/analytics/domain/calorie_calculator.dart`
- **Implementation:**
  - Implement `CalorieCalculator.estimateBurned({required int activeSeconds, required double volumeLoadKg, double userWeightKg = 75.0}) -> int`.
  - Provide extension `Iterable<DailyWorkoutSummary>.calculateWeeklyCalories({double userWeightKg = 75.0}) -> int`.
- **Unit Tests:** `test/features/analytics/calorie_calculator_test.dart`
  - Zero duration/volume returns 0.
  - Typical 45-minute 5,000kg workout produces $\approx 350-450\text{ kcal}$.
  - Weight scaling tests.

---

### Task 2: Dynamic `WeekSummarySection` & `CaloriesCard`
- **File:** `lib/features/home/presentation/widgets/week_summary_section.dart`
- **Modifications:**
  - Add parameter `final VoidCallback? onDetailsTap` to `WeekSummarySection`.
  - Connect header button: `AppButton.ghost(label: 'Details', onPressed: onDetailsTap)`.
  - Calculate `totalCalories` from `weekSummaries` using `CalorieCalculator`.
  - Refactor `CaloriesCard`:
    - Add parameters: `required int burnedCalories`, `int targetCalories = 3500`.
    - Compute progress: `final progress = targetCalories > 0 ? (burnedCalories / targetCalories).clamp(0.0, 1.0) : 0.0`.
    - Format calorie display with commas (`NumberFormat` or regex helper, e.g. `1,250`).
    - Bind progress ring `CircularProgressIndicator(value: progress)` and label `'${(progress * 100).round()}%'`.
  - Pass dynamic `burnedCalories` into `CaloriesCard` from `WeekSummarySection`.

---

### Task 3: Wiring Training Hub Navigation & Streams
- **Files:**
  - `lib/features/home/presentation/screen/fitness_hub_screen.dart`
  - `lib/features/home/presentation/screen/home_screen.dart`
- **Modifications:**
  - In `FitnessHubScreen`:
    - Pass `onDetailsTap: widget.onAnalyticsTap` to `WeekSummarySection`.
  - In `HomeScreen`:
    - Ensure `onAnalyticsTap: () => context.push(appRouteAnalytics)` is passed into `FitnessHubScreen`.

---

### Task 4: Resolve Exercise IDs & Fix Rep Counters in `SessionSummaryScreen`
- **Files:**
  - `lib/features/session/presentation/screen/session_summary_screen.dart`
  - `lib/core/app/app_routes.dart`
- **Modifications:**
  - In `SessionSummaryScreen`:
    - Add parameter `final IExerciseRepository? exerciseRepository`.
    - In `initState`, query exercise names for all distinct `exerciseId`s present in `widget.session.blocks`, storing them in `Map<String, String> _exerciseNames`.
    - In timeline item:
      - Display resolved name: `_exerciseNames[item.exerciseId] ?? _formatSlug(item.exerciseId)`.
      - Fix rep count calculation: replace `'${item.sets.length * 8} reps'` with:
        `'${item.sets.fold<int>(0, (sum, s) => sum + (s.actualReps ?? s.targetReps ?? 0))} reps'`.
  - In `app_routes.dart`:
    - Update `appRouteSessionSummary` route builder to inject `exerciseRepository: exercises`.

---

### Task 5: Accessibility & Semantic Polish
- **File:** `lib/features/home/presentation/widgets/activity_trends_section.dart`
- **Modifications:**
  - Add semantic labels for day and week slots: e.g. `Semantics(label: '$day: ${hasWorkout ? "Workout completed" : "Rest day"}')`.
  - Ensure 48dp touch targets on navigation chevrons and segmented button items.

---

### Task 6: Verification & Test Suite
- **New Tests:**
  1. `test/features/analytics/calorie_calculator_test.dart`: Formula validation.
  2. `test/features/home/week_summary_section_test.dart`:
     - Empty summaries show `0 kcal`, `0%`, `0h 0m`, `0 workouts`.
     - Populated summaries calculate correct numbers.
     - Tapping "Details" invokes `onDetailsTap`.
  3. `test/features/home/activity_trends_section_test.dart`:
     - Week, Month, and Quarter views with active workouts.
     - Previous/next time offset paging.
  4. `test/features/session/session_summary_screen_test.dart`:
     - Exercise name resolution from `IExerciseRepository`.
     - Correct actual reps summation.
- **Static Analysis & Suite Run:**
  - Run `dart analyze lib/ test/`.
  - Run `flutter test`.
  - Run `./scripts/check.ps1`.

---

## 3. Acceptance Criteria
- [ ] No hardcoded numbers (`3,240`, `85%`, `sets.length * 8`) in `WeekSummarySection` or `SessionSummaryScreen`.
- [ ] Tapping "Details" in `WeekSummarySection` navigates to `/analytics`.
- [ ] Calories card displays dynamically calculated weekly calories and percentage against target.
- [ ] Activity Trends week/month/quarter cards accurately display completed sessions from Drift.
- [ ] Timeline in `SessionSummaryScreen` displays actual exercise names and true completed rep counts.
- [ ] All tests pass with zero static analysis errors or warnings.
- [ ] `docs/phases/phase-07-hardening-polish.md` Step 7.5 updated to completed.
