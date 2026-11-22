# Test Coverage Inventory

Audit snapshot 2026-11-21 (repository-wide serial run supplied by user, before Phase 4/5 follow-up tests). This is a risk map of the automated suite, not a line-coverage target. That baseline contained 33 `*test.dart` test files and 2 generated mock files (35 files total). The repository-wide `flutter test --concurrency=1` baseline completed with **124 passed, 21 failed, exit 1**. Since then, focused Phase 4 passed **32/32**, Phase 5 user-feature tests passed **32/32**, and startup-route tests passed **2/2**. Failures and deprecated assertions are triaged in [`audit-report.md`](audit-report.md#serial-test-failure-triage); the repository-wide gate has not been rerun.

| Risk area / behavior | Existing automated coverage | Remaining check or gap |
|---|---|---|
| Catalog seeding, search/filtering, custom ownership, relationships | `test/features/catalog/catalog_feature_test.dart` | Idempotence now uses the actual first-run inserted count rather than a fixed historical count; catalog feature suite passes. |
| Template creation, validation, publication, immutable history and new draft revisions | `test/features/template/template_feature_test.dart`, `test/features/template/template_management_widget_test.dart` | Feature tests cover lifecycle/archive/restore/cascade deletion; widget tests cover list archive/filter/restore/delete and detail exercise names plus prescribed set targets. Focused Phase 2 suite passes 18/18. |
| Session copy-on-write, lifecycle, set/rest runtime, recovery, interval sequences and summary log | `test/features/session/session_feature_test.dart`, `test/features/session/session_summary_screen_test.dart`, `test/features/session/active_session_interval_widget_test.dart` | Focused suite passes 17/17. Covers RPE/mood/notes persistence, audit and JSON round-trip; interval phase order, auto-advance, skip, extension, pause/resume and cold recovery; and resolved/fallback summary exercise names after scrolling the lazy timeline. |
| Session snapshot isolation, set validation, skip/delete transitions, rest bounds, audit events, interruption timing, recovery, cancellation and completion recovery | `test/features/session/session_feature_test.dart` | Phase 9 covers retry conflicts and prevents deleting a set while its rest interval is active. |
| Analytics calculations, persistence, event projection, idempotency, rebuild parity and large rebuild workload | `test/features/analytics/pr_calculator_test.dart`, `calorie_calculator_test.dart`, `analytics_dao_test.dart`, `analytics_projector_test.dart`, `analytics_performance_test.dart`, `analytics_widgets_test.dart` | Focused analytics suite passes 32/32 after Cubit close/init race fix. Streak test covers empty history, duplicate same-day events, consecutive UTC dates and gaps. Per user direction, selectable chart windows are deferred with existing behavior retained. Hardware-rendered frame pacing remains the Phase 7 manual/release profile check. |
| User/profile/preferences/goals/equipment/measurement persistence, onboarding, Cubit validation and widgets | `test/features/user/user_repository_test.dart`, `user_use_cases_test.dart`, `user_cubits_test.dart`, `user_widgets_test.dart`, `onboarding_flow_test.dart` | User feature suite passes 32/32, including profile/measurement/goal persistence, required-input rejection, and step-widget input binding. Two `test/core/routing/launch_route_resolver_test.dart` cases cover onboarding and returning-user destinations. Broader accessibility and responsive viewport checks belong to Phase 12. |
| Portability checksum, sequential migration, import/export, overwrite/keep/duplicate conflict strategies, typed equipment, invalid owner IDs, analytics rebuild, RFC 4180 CSV activity export, Cubit state and BackupRestoreScreen widget flows | `test/features/portability/portability_test.dart`, `test/integration/end_to_end_workout_journey_test.dart` | Phase 6 test suite covers unsupported formats/migration paths, tampered import rejection, RFC 4180 CSV export (empty DB, set metrics, exercise name resolution, escaping), Cubit export/import states, and BackupRestoreScreen widget actions. |
| Document store persistence, schema upgrades and core utility invariants | `test/core/database/drift_document_store_test.dart`, `test/core/database/app_database_migration_test.dart`, plus `test/core/{error,events,ids,time,units,theme}/` | Updated v1-to-v5 migration test verifies schema version 5, the notification preference/log tables and the muscle-volume index; it passes in targeted Phase 1 validation. |
| Settings, authentication and notification transitional services | `test/features/settings/settings_cubit_test.dart`, `test/features/authentication/authentication_service_test.dart`, `test/features/notification/notification_service_test.dart` | Settings tests omit required `notificationRepository`; generated notification mocks have obsolete method signatures. Theme test imports deleted `fitness_theme.dart` and references undefined `FitnessTheme`. Update fixtures/mocks and resolve the current theme/test contract, then rerun. |
| Application routing and launch outcomes | `test/core/app/app_router_test.dart`, `test/core/routing/launch_route_resolver_test.dart`; `test/integration/end_to_end_workout_journey_test.dart` | Launch resolver passes 2/2 tests for first-run onboarding vs. returning-user launch. Broader router test still fails to compile because its fixture omits `notifications` and `notificationRepository`; typed route extras and full back-stack integration remain unverified. |
| Home summary widgets | `test/features/home/week_summary_section_test.dart`, `activity_trends_section_test.dart` | Valid failures: missing Details CTA, month/quarter views and period navigation; desktop layout overflows. Compact-width “This Week” label assertion is **Deprecated** because the card hides that desktop label at compact width. Independently verify dynamic data and checkmarks. |
| Notification UI/state | `test/features/notification/notification_service_test.dart`, `test/features/settings/settings_cubit_test.dart` | No notification-settings/history widget tests were found in the file inventory; add interaction and permission/scheduling behavior tests. |
| Design system and responsive layout | `test/core/theme/fitness_theme_test.dart`, `test/features/common/responsive_layout_test.dart`, `test/features/analytics/analytics_widgets_test.dart` | No broad per-screen keyboard, semantics, 200% text scaling, compact/medium/expanded viewport, high-contrast or touch-target suite found. Manual/device evidence required. |

## Current serial run triage — 2026-11-21

- **124 passed / 21 failed / exit 1.** The test gate fails; the previous local timeout note is superseded.
- **Valid failures from the supplied baseline:** AnalyticsCubit emitted after close in six DAO cases (resolved; Phase 4 suite now passes); absent home period controls/month/quarter views and Details CTA; week-summary layout overflows; session summary omits resolved/fallback exercise names; router/settings test constructors are stale; generated notification mocks do not match service API. Equipment widget harness lacked GoRouter in that baseline and is now resolved; Phase 5 tests pass.
- **Deprecated assertions in the original baseline:** migration test schema-v3 expectation (now fixed and v1-to-v5 test passes); catalog hardcoded seed count 7 (now replaced with a derived count); compact Activity Trends “This Week” label expectation (label is desktop-only and remains to be reviewed). Keep migration behavior, catalog idempotence and workout-day checkmarks covered.
- Full test-level evidence, case names and phase impact are in the [audit report](audit-report.md#serial-test-failure-triage).

## Phase 4 additions

- `AnalyticsCubit` now safely closes while its initial projection rebuild is pending. Initialization is retained, teardown prevents new stream subscriptions, all callbacks guard emissions, and close cancels streams before and after initialization settles.
- The weekly-volume DAO fixture now uses a current UTC date, keeping the asserted four-week window meaningful over time.
- Focused `flutter test --concurrency=1 test/features/analytics` passes 32/32. The latest performance run reports 12.55 ms median and 14.60 ms p95 for the 52-week query.
- The old six post-close failures are resolved. Selectable chart period controls are explicitly deferred by the user; heatmap streak behavior is covered with UTC date grouping and gap cases.

## Phase 5 additions

- Onboarding now persists account, profile, training metrics, preferences, equipment, goals, and append-only baseline/circumference measurements. Profile data includes age and optional biological sex; training profile includes baseline height/weight/resting heart rate, daily activity level and injury/limitation notes.
- Completion validates required inputs and checks every `Result` plus the SharedPreferences write before setting the completed flag. Stable onboarding IDs make measurement and goal saves safe to retry after partial persistence.
- The effective onboarding flag now flows from `main` / `main_dev` through app route composition to the splash decision. Route tests cover first-run and returning-user choices; `DEV_FORCE_ONBOARDING` is honored.
- Phase 5 user tests pass 32/32; route resolver tests pass 2/2; scoped fatal analysis passes.
- The equipment sheet test now mounts the sheet under a GoRouter route. It passes in the full Phase 5 suite.

## Phase 2 additions

- Catalog idempotence test asserts against the first-run inserted count, not a fixed catalog size.
- Template use-case tests cover archive, restore, and transactional deletion of a template plus all immutable revisions.
- Template management widget tests cover list archive/filter/restore/confirmed-delete actions and template-detail target rendering. The first run exposed a popup-menu overflow, fixed with flexible labels; the focused Phase 2 suite now passes 18/18.
- Seeded RPE-only sets now leave the repetition target absent rather than rendering a target of zero; a seed-level regression assertion protects this contract.

## Phase 9 additions

- `MigrationRegistry` now has explicit regression coverage for a missing step, a downgrade, and a non-advancing step.
- Import tests verify future format versions and invalid typed documents are rejected without writing documents.
- Session tests verify that completing an already completed session returns a conflict and preserves persisted terminal state.
- Session transition tests cover skip events and audit entries, repeated-skip conflicts, active-rest deletion guards, and removal of completed rest history with its parent set.
- Portability tests cover overwrite conflicts, typed equipment inventories, and empty owner IDs in addition to malformed-document rejection.
- A real on-disk SQLite fixture now verifies migration from version 1 through current schema version 5, including the muscle-volume index and notification tables introduced in versions 4 and 5.
- The end-to-end workout/analytics/backup journey also verifies that a tampered backup is rejected without changing existing source documents before a valid restore.

Tests remain designed to be deterministic: fixed export timestamps/checksums, in-memory Drift, controlled clocks for session behavior, and no timing sleeps as pass/fail thresholds. The analytics stress test's timing data remains diagnostic. The supplied baseline had valid failures and three deprecated assertions, as classified below. The migration and catalog assertions are now fixed and their focused suites pass; only the compact-label expectation remains to be reviewed.

Coverage output was reviewed as a diagnostic after the suite. It exposed untested set skip/delete and typed-equipment/overwrite branches, which were covered by the Phase 9 additions. Remaining uncovered paths are mostly generated-ID collision retries and legacy timestamp/enum normalization fallbacks; they are not release gates and should be covered when those import behaviors change.
