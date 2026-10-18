# Test Coverage Inventory

Reviewed for Phase 9 on 2026-10-18. This is a risk map of the current automated suite, not a line-coverage target.

| Risk area / behavior | Existing automated coverage | Remaining check or gap |
|---|---|---|
| Catalog seeding, search/filtering, custom ownership, relationships | `test/features/catalog/catalog_feature_test.dart` | Catalog seed reconciliation after future seed-version changes needs coverage when that behavior is introduced. |
| Template creation, validation, publication, immutable history and new draft revisions | `test/features/template/template_feature_test.dart` | No high-risk gap found for current revision rules. |
| Session snapshot isolation, set validation, skip/delete transitions, rest bounds, audit events, interruption timing, recovery, cancellation and completion recovery | `test/features/session/session_feature_test.dart` | Phase 9 covers retry conflicts and prevents deleting a set while its rest interval is active. |
| Analytics calculations, persistence, event projection, idempotency, rebuild parity and large rebuild workload | `test/features/analytics/pr_calculator_test.dart`, `analytics_dao_test.dart`, `analytics_projector_test.dart`, `analytics_performance_test.dart` | Hardware-rendered frame pacing remains the Phase 7 manual/release profile check. |
| User/profile/preferences/goals/equipment/measurement persistence, orchestration, Cubit validation and widgets | `test/features/user/user_repository_test.dart`, `user_use_cases_test.dart`, `user_cubits_test.dart`, `user_widgets_test.dart` | Broader platform accessibility and responsive viewport checks belong to Phase 12. |
| Portability checksum, sequential migration, import/export, overwrite/keep/duplicate conflict strategies, typed equipment, invalid owner IDs, analytics rebuild and no-partial-write behavior | `test/features/portability/portability_test.dart`, `test/integration/end_to_end_workout_journey_test.dart` | Phase 9 covers unsupported formats/migration paths and tampered import preservation alongside successful restore. |
| Document store persistence, schema upgrades and core utility invariants | `test/core/database/drift_document_store_test.dart`, `test/core/database/app_database_migration_test.dart`, plus `test/core/{error,events,ids,time,units,theme}/` | The schema fixture covers v1-to-v3 upgrade and the v3 index. Future migration steps must extend the fixture when schema evolves. |
| Settings, authentication and notification transitional services | `test/features/settings/settings_provider_test.dart`, `test/features/authentication/authentication_service_test.dart`, `test/features/notification/notification_service_test.dart` | These mostly verify service interactions; user-facing settings/auth and platform notification journeys are retained for their state-management/authentication/notification phases. |
| Application routing and launch outcomes | Current integration journey covers workout and portability flow; route table is still legacy named routing. | Route outcome/back-stack coverage is scheduled in Phase 10 alongside router migration. |

## Phase 9 additions

- `MigrationRegistry` now has explicit regression coverage for a missing step, a downgrade, and a non-advancing step.
- Import tests verify future format versions and invalid typed documents are rejected without writing documents.
- Session tests verify that completing an already completed session returns a conflict and preserves persisted terminal state.
- Session transition tests cover skip events and audit entries, repeated-skip conflicts, active-rest deletion guards, and removal of completed rest history with its parent set.
- Portability tests cover overwrite conflicts, typed equipment inventories, and empty owner IDs in addition to malformed-document rejection.
- A real on-disk SQLite fixture verifies schema migration from version 1 through version 3, including index creation.
- The end-to-end workout/analytics/backup journey also verifies that a tampered backup is rejected without changing existing source documents before a valid restore.

Tests remain deterministic: fixed export timestamps/checksums, in-memory Drift, controlled clocks for session behavior, and no timing sleeps as pass/fail thresholds. The analytics stress test's timing data remains diagnostic.

Coverage output was reviewed as a diagnostic after the suite. It exposed untested set skip/delete and typed-equipment/overwrite branches, which were covered by the Phase 9 additions. Remaining uncovered paths are mostly generated-ID collision retries and legacy timestamp/enum normalization fallbacks; they are not release gates and should be covered when those import behaviors change.
