## 8. Phase 5: Comprehensive Details (User Profile, Goals & Physical Measurements)

Phase 5 establishes user-centric features: training profiles, equipment inventory filtering, goal tracking, and body composition measurements.

### 8.1 Architecture & Domain Rules
1. **User Separation (Section 6 & Rule 6):** User preferences and goals are separate aggregates from workout execution. Modifying a goal or profile never rewrites completed workouts.
2. **Equipment Inventory Filtering (Section 8):** Available equipment restricts exercise selection and routine suggestions without hiding catalog definitions.
3. **Immutable Measurement Log (Section 10):** Historical body weight and caliper/tape measurements are append-only.
4. **Fitness Assessment:** The legacy source requests a composite Fitness Score (examples: vitals, stamina, strength) based on user data and activity history. 
5. **Goal-Centric Dashboard:** Count-based and time-based activities are listed, sorted/grouped by the goal they support, and display progress against target. Detail screens expose recent activity, streaks, charts, and daily logs.

### 8.2 Phase 5 File Manifest
- `lib/features/user/domain/`: `user_account.dart`, `user_profile.dart`, `training_profile.dart`, `workout_preferences.dart`, `training_goal.dart`, `user_measurement.dart`, `equipment_inventory.dart`, `user_enums.dart`.
- `lib/features/user/application/`: `user_use_cases.dart`, `goal_cubit.dart`, `measurement_cubit.dart`.
- `lib/features/user/infrastructure/`: `user_document_adapters.dart`, `user_repository.dart`.
- `lib/features/user/presentation/`: `profile_screen.dart`, `goals_screen.dart`, `measurements_screen.dart`, `equipment_inventory_sheet.dart`, `goal_progress_card.dart`.
- Tests under `test/features/user/` covering unit conversions, goal calculations, and document persistence.
- Extend `TrainingProfile`/profile UI to capture baseline biometrics (at minimum height, weight, and resting heart rate where supplied) and training constraints such as injuries and equipment limitations. These fields inform assessment and exercise suggestions but must not be presented as medical diagnosis.

---

### 8.3 Detailed Specifications (Phase 5)

#### A. Models (`lib/features/user/domain/`)
- **`TrainingGoal`:** `type` (`strength`, `workoutFrequency`, `bodyWeight`, and extensible count/time activity goals), `startValue`, `targetValue`, `currentValue`, `startDate`, `targetDate`, `status` (`active`, `achieved`, `abandoned`).
- **`TrainingProfile`:** include optional baseline height, weight, resting heart rate and other supported baseline metrics, plus constraints/injuries and available-equipment limitations. Record units and timestamps where applicable; do not overwrite historical measurements when profile baselines change.
- **`UserMeasurement`:** `type` (`bodyWeight`, `bodyFatPercentage`, `chestCm`, `waistCm`), `value` (stored in canonical kg/cm), `timestamp`.
- **`EquipmentInventory`:** Selected `List<EquipmentType>` owned by user.

#### B. Execution & Verification
1. Implement domain models with Freezed.
2. Implement `UserRepository` managing `users`, `goals`, and `measurements` collections in Drift.
3. Build UI screens for user profile, goal creation, and body measurement logging.
4. Verify unit conversions match user preferences (`kg` vs `lb`).

### 8.4 Phase 5 Execution Status

| Step | Action | Status | Notes |
|---|---|---|---|
| **Step 5.1** | User domain models and document persistence | `[x] IMPLEMENTED` | Freezed models and Drift document adapters cover accounts, profiles, training profiles, preferences, goals, measurements, and equipment inventories. `UserRepository` now exposes account persistence as well as the existing profile and collection operations. |
| **Step 5.2** | Profile, goals, measurements, and equipment UI | `[x] IMPLEMENTED` | Profile/preferences and equipment inventory, goal management/progress, and append-only measurement logging screens are present and routed from the Training hub. |
| **Step 5.3** | Canonical measurement unit handling | `[x] IMPLEMENTED` | Measurement inputs accept pounds and inches and normalize to kg/cm before persistence; body-fat percentages and custom units retain their appropriate units. Inputs with incompatible units are rejected. |
| **Step 5.4** | User feature regression tests and verification | `[x] COMPLETED` | Repository, use-case, Cubit, and widget coverage passes (29 tests). Strict repository analysis reports no issues; scoped formatting verification passes. |
| **Step 5.5** | First-launch user onboarding flow (3-step wizard) | `[ ] PLANNED` | Implement dedicated `OnboardingScreen` (`Step 1: Body Metrics` with biological sex toggle, imperial/metric unit selector, age/height/weight, and activity level chips; `Step 2: Goals` selection grid; `Step 3: Constraints` with body areas to avoid, equipment checklist, and daily time cap slider). Persist captured data to `UserAccount`, `UserProfile`, and `TrainingProfile`, configure first-launch routing gate in `launch_route_resolver.dart`, and add corresponding widget/flow tests. |

**Verification (2026-10-18):** Phase 5 models, repositories, application state, screens, equipment selector, and navigation were already present. This pass completed the missing account repository operations and canonical measurement input conversion, and added focused regression cases. `flutter analyze --fatal-infos --fatal-warnings` passes repository-wide, all 29 tests in `test/features/user/` pass, and scoped Dart format verification passes. The provided link `design/Implementation_Plan.md` does not exist in this checkout; this canonical plan is `docs/implementation-plan.md`.

---
