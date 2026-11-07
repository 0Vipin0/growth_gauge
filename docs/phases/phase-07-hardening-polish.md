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

---

### 7.3 Phase 7 Verification & Acceptance Criteria

| Component | Test Case | Success Criteria |
|---|---|---|
| **Isolate Concurrency** | Rebuild analytics under load | Export/import CPU work and rebuild ordering run in worker isolates; Drift projections remain on the database isolate. The 1,000-session stress test passes and reports elapsed time and event-loop pulse gaps. The device 60 FPS profile acceptance is pending. |
| **End-to-End Journey** | Full lifecycle integration | Completed in `test/integration/end_to_end_workout_journey_test.dart`; workout, rest, four logged sets, analytics/PRs, backup roundtrip, and restored stats are asserted. |
| **Static Analysis** | `scripts/check.ps1` | Passed: zero analyzer infos/warnings/errors and format verification. Full test suite passed (127 tests, as recorded in Step 7.4). |
| **Legacy Removal** | Unused code verification | Counter/timer/chart/splash/onboarding feature trees, routes, tests, shared-preference repositories, and direct-only CSV/heatmap/Lottie dependencies removed. `path_provider` remains transitive through dependencies, not direct. |

### 7.4 Phase 7 Execution Status

| Step | Action | Status | Notes |
|---|---|---|---|
| **Step 7.1** | Offload portable data CPU work and rebuild ordering | `[~] PARTIAL` | Added `IsolateRunner`; top-level workers receive serializable primitive messages so Drift objects never cross isolate boundaries. Export payload preparation/checksum, import parsing/checksum validation, pretty JSON serialization, and session ordering are offloaded. The 1,000-session stress test passes. Projection writes remain on the Drift isolate; device frame profiling is pending. |
| **Step 7.2** | Accessibility, contrast and rest completion feedback | `[x] COMPLETED` | Active timer, pause/resume and completion controls expose semantics; rest auto-completion triggers medium haptic feedback. Light/dark high-contrast text pairs have WCAG AA contrast tests. |
| **Step 7.3** | Prune legacy features and refactor launch flow | `[x] COMPLETED` | Removed counter/timer/chart/splash/onboarding trees and dead routes/tests/repositories; launch now routes through saved authentication settings into the fitness home. Removed direct-only `csv`, `flutter_heatmap_calendar`, and `lottie` dependencies. |
| **Step 7.4** | End-to-end portability journey and verification | `[x] COMPLETED` | Added `test/integration/end_to_end_workout_journey_test.dart` and a 1,000-session analytics rebuild stress test. `scripts/check.ps1` passes analysis, format check, and all 127 tests. The device-frame profiling portion remains pending and prevents Phase 7 from being fully closed. |
| **Step 7.5** | Dynamic analytics integration for Training Hub ("This Week" & Activity Trends) | `[ ] PLANNED` | Replace hardcoded values (`3,240 kcal`, `85%`, and empty `workoutHistory: const []`) in `WeekSummarySection` and `ActivityTrendsSection`. Wire `AnalyticsCubit` / `DailySummary` repository stream to `FitnessHubPage`, compute real active time, workouts count, and estimated calories burned, wire the "Details" link button to `context.push(appRouteAnalytics)`, and add regression tests. |

**Remaining release check:** profile a rebuild of 1,000 completed sessions on a Flutter device and confirm animation frame pacing. The automated stress test runs this rebuild on the test host and reports elapsed time and 16 ms event-loop pulse gaps; its measured pulse gaps are diagnostic and are not a substitute for Flutter device `FrameTiming`. No Android/iOS device or hardware-rendered target was available in this environment. Drift query/projection transactions intentionally stay on the database isolate; only portable CPU processing and rebuild ordering are moved to worker isolates with the current architecture.

---
