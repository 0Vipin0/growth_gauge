# Implementation Plan - Phase 13: Comprehensive Exercise Catalog

## Executive Summary
Phase 13 expands the exercise catalog into a curated, high-quality, offline-first library that exercises the taxonomy and measurement models. 

Following a comprehensive review of [`docs/phases/phase-13-comprehensive-catalog.md`](file:///h:/Apps/growth_gauge/docs/phases/phase-13-comprehensive-catalog.md) against the codebase, several foundation pieces are already operational, while data hygiene, step-by-step form guidance, dynamic custom step creation, and upgrade-safe seed reconciliation remain pending.

---

## 1. Audit: Completed vs. Pending Capabilities

| Step | Capability | Status in Codebase | Concrete Findings & Deficiencies |
|---|---|---|---|
| **13.1** | Audit current seed library & taxonomy | `[~] PARTIAL` | 51 exercises exist in `ExerciseSeedData.all`, but **all 51 entries contain raw `` citation artifacts**. All 51 entries have completely empty `executionInstructions` and `setupInstructions`. |
| **13.2** | Coverage matrix & metadata standards | `[ ] PENDING` | Enums exist (`BodyRegion`, `MovementPattern`, `MuscleGroup`, `EquipmentType`, `MetricType`), but no documented coverage matrix exists. Certain movement patterns (e.g. `olympic`, `carry`, `rotation`) are underrepresented or missing. |
| **13.3** | Curate & validate exercise entries | `[ ] PENDING` | Need to clean all `` tags and enrich foundational movement families with structured `setupInstructions`, `executionInstructions`, `techniqueCues`, and `breathingInstructions`. |
| **13.4** | Reconcile versioned seed data safely | `[ ] PENDING` | `CatalogSeeder.seedIfEmpty()` only inserts when catalog count is 0. If new system exercises are added in updates, existing databases never receive them. Needs `seedOrUpdate()` reconciliation preserving `ExerciseSourceType.userCreated`. |
| **13.5** | Catalog quality & seeding tests | `[~] PARTIAL` | `catalog_feature_test.dart` has an obsolete assertion (`expect(firstSeed.dataOrNull, 7)`) from an older 7-exercise catalog. No tests verify citation cleanliness, instruction validity, or seed reconciliation. |
| **13.6** | Catalog usability & documentation | `[ ] PENDING` | Need documented taxonomy matrix, search verification, and recording known constraints in phase documentation. |
| **13.7** | Step guidance & custom step builder | `[ ] PENDING` | 1. `ExerciseDetailScreen` does not render `setupInstructions` or `executionInstructions`.<br>2. `CustomExerciseScreen` lacks a step builder UI.<br>3. `CatalogUseCases.createCustom()` does not accept instructions.<br>4. `ActiveSessionScreen` has no in-workout exercise guidance sheet. |

---

## 2. Architecture & Data Flow

```mermaid
flowchart TD
    subgraph Data Layer
        SeedData[ExerciseSeedData.all (Clean & Curated)]
        Seeder[CatalogSeeder.seedOrUpdate]
        Repo[ExerciseRepository (Drift Store)]
        SeedData --> Seeder
        Seeder -->|Reconcile system entries| Repo
    end

    subgraph Domain & Application
        CatalogUC[CatalogUseCases.createCustom (with setup & execution steps)]
        Repo --> CatalogUC
    end

    subgraph UI Presentation
        DetailScreen[ExerciseDetailScreen (Step-by-Step Numbered Stepper)]
        CustomScreen[CustomExerciseScreen (Interactive Dynamic Step Builder)]
        ActiveHUD[ActiveExerciseCard -> ExerciseGuidanceSheet Modal]
        CatalogUC --> DetailScreen
        CatalogUC --> CustomScreen
        Repo --> ActiveHUD
    end
```

---

## 3. Work Breakdown & Implementation Steps

### Task 1: Clean Seed Data & Curate Step Guidance (Steps 13.1, 13.2, 13.3)
- **File:** `lib/features/catalog/infrastructure/seed/exercise_seed_data.dart`
- **Actions:**
  1. Strip all `` artifacts across all descriptions in `ExerciseSeedData`.
  2. For foundational compound and isolation exercises (Squat, Deadlift, Bench Press, Overhead Press, Barbell Row, Pull Up, Romanian Deadlift, Incline Bench, Lat Pulldown, Leg Press, Dips, Barbell Hip Thrust, Plank, etc.), enrich `execution: ExerciseExecutionProfile(...)` with:
     - `setupInstructions`: Numbered preparation steps (e.g. rack height, foot placement, grip width).
     - `executionInstructions`: Numbered movement execution steps (eccentric descent, concentric drive, lockout).
     - `techniqueCues`: Key safety tips (e.g. "Brace core", "Knees track over toes", "Chest up").
     - `breathingInstructions`: Breathing guidance (e.g. "Inhale and brace before descent, exhale through concentric sticking point").

---

### Task 2: Upgrade-Safe Seed Reconciliation (Step 13.4)
- **File:** `lib/features/catalog/infrastructure/catalog_seeder.dart`
- **Actions:**
  1. Implement `Future<Result<int, Failure>> seedOrUpdate()` in `CatalogSeeder`:
     - Fetches existing catalog entries.
     - For each system seed exercise in `ExerciseSeedData.all`:
       - If it doesn't exist in the database, inserts it.
       - If it exists and `existing.sourceType == ExerciseSourceType.system`, updates the record with latest descriptions, instructions, and classifications without touching user data.
       - Leaves all `ExerciseSourceType.userCreated` records intact and unperturbed.
  2. Keep `seedIfEmpty()` as a backward-compatible wrapper or migrate startup to `seedOrUpdate()`.

---

### Task 3: Expand `createCustom` with Instructions Support (Step 13.7)
- **File:** `lib/features/catalog/application/catalog_use_cases.dart`
- **Actions:**
  1. Update `createCustom(...)` to accept:
     - `List<String> setupInstructions = const []`
     - `List<String> executionInstructions = const []`
     - `List<String> techniqueCues = const []`
  2. Construct `ExerciseExecutionProfile` with these parameters and attach to the created `Exercise`.

---

### Task 4: Interactive Step-by-Step Display in `ExerciseDetailScreen` (Step 13.7)
- **File:** `lib/features/catalog/presentation/exercise_detail_screen.dart`
- **Actions:**
  1. Add a **"How to Perform" / "Step-by-Step Instructions"** section between the metadata card and technique cues.
  2. Build a numbered step visual component:
     - **Setup Steps**: Numbered pill/avatar badges (1, 2, 3...) with clean instructional text.
     - **Execution Steps**: Numbered badges with step descriptions.
  3. If breathing instructions exist, render a dedicated info card with `Icons.air` and highlighted styling.
  4. Display technique cues with checkmark badges.

---

### Task 5: Dynamic Step Builder in `CustomExerciseScreen` (Step 13.7)
- **File:** `lib/features/catalog/presentation/custom_exercise_screen.dart`
- **Actions:**
  1. Maintain state:
     - `List<String> _setupSteps = []`
     - `List<String> _executionSteps = []`
  2. Implement an editable step builder widget:
     - Input field with an `Add Step` icon button.
     - Reorderable or clean list of added steps with delete (`Icons.delete_outline`) buttons.
  3. Pass `_setupSteps` and `_executionSteps` into `widget.useCases.createCustom()`.

---

### Task 6: In-Workout Form Guidance HUD Modal (Step 13.7)
- **Files:**
  - `lib/features/session/presentation/widgets/active_exercise_card.dart`
  - `lib/features/session/presentation/screen/active_session_screen.dart`
- **Actions:**
  1. In `ActiveExerciseCard`, add an "Info / Form Guidance" button (e.g. `IconButton(icon: Icon(Icons.info_outline), tooltip: 'Form & Execution Guide')`).
  2. Add callback `final VoidCallback? onShowGuidance`.
  3. In `ActiveSessionScreen`, implement `_showExerciseGuidance()`:
     - Looks up the active `Exercise` from `widget.exerciseRepository.findById(...)`.
     - Opens a modal bottom sheet displaying the exercise name, setup steps, execution steps, and technique cues.

---

### Task 7: Comprehensive Testing & Documentation (Steps 13.5, 13.6)
- **Files:**
  - `test/features/catalog/catalog_feature_test.dart` (fix `hasLength(7)` assertion to match actual seed count).
  - `test/features/catalog/catalog_seed_integrity_test.dart` (new suite verifying zero citation tags, valid classifications, non-empty primary muscles, unique IDs).
  - `test/features/catalog/catalog_reconciler_test.dart` (test upgrade safety, custom exercise preservation, idempotent execution).
  - `test/features/catalog/exercise_detail_screen_test.dart` (test step-by-step rendering).
  - `docs/phases/phase-13-comprehensive-catalog.md` (update status, document coverage matrix).

---

## 4. Acceptance Criteria
- [ ] No `` or citation tokens remain in any seed exercise.
- [ ] Core compound and isolation exercises contain verified setup and execution steps.
- [ ] `CatalogSeeder.seedOrUpdate()` safely adds new system exercises without overwriting user-created exercises.
- [ ] `ExerciseDetailScreen` renders setup and execution steps in numbered visual sequences.
- [ ] `CustomExerciseScreen` enables users to add, view, and delete custom setup and execution steps.
- [ ] Active workout session HUD provides an interactive form guide modal sheet for the current exercise.
- [ ] All catalog unit and widget tests pass with zero static analysis warnings.
