# Test Coverage Inventory

Audit snapshot 2026-11-21 (complete serial run supplied by user). This is a risk map of the current automated suite, not a line-coverage target. The repository contains 31 `*test.dart` test files and 2 generated mock files under `test/` (33 files total). `flutter test --concurrency=1` completed with **124 passed, 21 failed, exit 1**. Failures and deprecated assertions are triaged in [`audit-report.md`](audit-report.md#serial-test-failure-triage); the test gate fails and no phase depending on it is complete.

| Risk area / behavior | Existing automated coverage | Remaining check or gap |
|---|---|---|
| Catalog seeding, search/filtering, custom ownership, relationships | `test/features/catalog/catalog_feature_test.dart` | Catalog seed reconciliation after future seed-version changes needs coverage when that behavior is introduced. |
| Template creation, validation, publication, immutable history and new draft revisions | `test/features/template/template_feature_test.dart` | No high-risk gap found for current revision rules. |
| Session snapshot isolation, set validation, skip/delete transitions, rest bounds, audit events, interruption timing, recovery, cancellation and completion recovery | `test/features/session/session_feature_test.dart` | Phase 9 covers retry conflicts and prevents deleting a set while its rest interval is active. |
| Analytics calculations, persistence, event projection, idempotency, rebuild parity and large rebuild workload | `test/features/analytics/pr_calculator_test.dart`, `analytics_dao_test.dart`, `analytics_projector_test.dart`, `analytics_performance_test.dart` | Hardware-rendered frame pacing remains the Phase 7 manual/release profile check. |
| User/profile/preferences/goals/equipment/measurement persistence, orchestration, Cubit validation and widgets | `test/features/user/user_repository_test.dart`, `user_use_cases_test.dart`, `user_cubits_test.dart`, `user_widgets_test.dart` | Broader platform accessibility and responsive viewport checks belong to Phase 12. |
| Portability checksum, sequential migration, import/export, overwrite/keep/duplicate conflict strategies, typed equipment, invalid owner IDs, analytics rebuild and no-partial-write behavior | `test/features/portability/portability_test.dart`, `test/integration/end_to_end_workout_journey_test.dart` | Phase 9 covers unsupported formats/migration paths and tampered import preservation alongside successful restore. |
| Document store persistence, schema upgrades and core utility invariants | `test/core/database/drift_document_store_test.dart`, `test/core/database/app_database_migration_test.dart`, plus `test/core/{error,events,ids,time,units,theme}/` | Updated v1-to-v5 migration test verifies schema version 5, the notification preference/log tables and the muscle-volume index; it passes in targeted Phase 1 validation. |
| Settings, authentication and notification transitional services | `test/features/settings/settings_cubit_test.dart`, `test/features/authentication/authentication_service_test.dart`, `test/features/notification/notification_service_test.dart` | Settings tests omit required `notificationRepository`; generated notification mocks have obsolete method signatures. Theme test imports deleted `fitness_theme.dart` and references undefined `FitnessTheme`. Update fixtures/mocks and resolve the current theme/test contract, then rerun. |
| Application routing and launch outcomes | `test/core/app/app_router_test.dart`; `test/integration/end_to_end_workout_journey_test.dart` | Router test fails to compile: missing `notifications` and `notificationRepository`. Fix setup, then verify registered paths, typed `extra`, launch/onboarding redirect and back-stack behavior. |
| Home summary widgets | `test/features/home/week_summary_section_test.dart`, `activity_trends_section_test.dart` | Valid failures: missing Details CTA, month/quarter views and period navigation; desktop layout overflows. Compact-width “This Week” label assertion is **Deprecated** because the card hides that desktop label at compact width. Independently verify dynamic data and checkmarks. |
| Notification UI/state | `test/features/notification/notification_service_test.dart`, `test/features/settings/settings_cubit_test.dart` | No notification-settings/history widget tests were found in the file inventory; add interaction and permission/scheduling behavior tests. |
| Design system and responsive layout | `test/core/theme/fitness_theme_test.dart`, `test/features/common/responsive_layout_test.dart`, `test/features/analytics/analytics_widgets_test.dart` | No broad per-screen keyboard, semantics, 200% text scaling, compact/medium/expanded viewport, high-contrast or touch-target suite found. Manual/device evidence required. |

## Current serial run triage — 2026-11-21

- **124 passed / 21 failed / exit 1.** The test gate fails; the previous local timeout note is superseded.
- **Valid failures:** AnalyticsCubit emits after close in six DAO cases; absent home period controls/month/quarter views and Details CTA; week-summary layout overflows; session summary omits resolved/fallback exercise names; router/settings test constructors are stale; generated notification mocks do not match service API; equipment widget harness lacks GoRouter.
- **Deprecated assertions:** migration test schema-v3 expectation (current schema is v5); catalog hardcoded seed count 7 (registry has 122); compact Activity Trends “This Week” label expectation (label is desktop-only). Keep migration behavior, catalog idempotence and workout-day checkmarks covered.
- Full test-level evidence, case names and phase impact are in the [audit report](audit-report.md#serial-test-failure-triage).

## Phase 9 additions

- `MigrationRegistry` now has explicit regression coverage for a missing step, a downgrade, and a non-advancing step.
- Import tests verify future format versions and invalid typed documents are rejected without writing documents.
- Session tests verify that completing an already completed session returns a conflict and preserves persisted terminal state.
- Session transition tests cover skip events and audit entries, repeated-skip conflicts, active-rest deletion guards, and removal of completed rest history with its parent set.
- Portability tests cover overwrite conflicts, typed equipment inventories, and empty owner IDs in addition to malformed-document rejection.
- A real on-disk SQLite fixture now verifies migration from version 1 through current schema version 5, including the muscle-volume index and notification tables introduced in versions 4 and 5.
- The end-to-end workout/analytics/backup journey also verifies that a tampered backup is rejected without changing existing source documents before a valid restore.

Tests remain designed to be deterministic: fixed export timestamps/checksums, in-memory Drift, controlled clocks for session behavior, and no timing sleeps as pass/fail thresholds. The analytics stress test's timing data remains diagnostic. The completed run has valid failures and three deprecated assertions, as classified below. The stale migration-version assertion is now corrected and its targeted Phase 1 suite passes; catalog count and compact-label assertions remain to be reviewed.

Coverage output was reviewed as a diagnostic after the suite. It exposed untested set skip/delete and typed-equipment/overwrite branches, which were covered by the Phase 9 additions. Remaining uncovered paths are mostly generated-ID collision retries and legacy timestamp/enum normalization fallbacks; they are not release gates and should be covered when those import behaviors change.
