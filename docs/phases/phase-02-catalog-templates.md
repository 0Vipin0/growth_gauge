## 5. Phase 2: Comprehensive Details (Exercise Catalog & Workout Templates)

Phase 2 builds the reusable program definitions: the **Exercise Catalog** and **Workout Templates with Immutable Revisions**.

### 5.1 Key Architecture & Domain Rules
1. **Taxonomy & Classification:** Exercises support multi-dimensional classification (Body Region, Movement Pattern, Muscle Group, Equipment, Measurement Profile) and relationship links (alternatives, regressions, progressions).
2. **Immutable Template Revisions:** Published revisions are frozen and strictly immutable. Editing a template creates a new revision with `revisionNumber = current + 1` in `DRAFT` status.
3. **Standard Seed Fixtures:** Standard system exercises are auto-seeded on initial app launch if the catalog is empty.

### 5.2 Phase 2 File Manifest
- `lib/features/catalog/domain/`: `exercise.dart`, `exercise_enums.dart`, `exercise_classification.dart`, `exercise_execution.dart`, `exercise_equipment.dart`, `exercise_relationship.dart`, `measurement_profile.dart`.
- `lib/features/catalog/application/`: `catalog_use_cases.dart`, `catalog_cubit.dart`.
- `lib/features/catalog/infrastructure/`: `exercise_document_adapter.dart`, `exercise_repository.dart`, `seed/exercise_seed_data.dart`, `catalog_seeder.dart`.
- `lib/features/catalog/presentation/`: `catalog_screen.dart`, `exercise_detail_screen.dart`, `custom_exercise_screen.dart`.
- `lib/features/template/domain/`: `workout_template.dart`, `workout_template_revision.dart`, `workout_block.dart`, `template_item.dart`, `target_set.dart`, `rest_policy.dart`, `template_enums.dart`.
- `lib/features/template/application/`: `template_use_cases.dart`.
- `lib/features/template/infrastructure/`: `template_document_adapters.dart`, `template_repository.dart`.
- `lib/features/template/presentation/`: `template_list_screen.dart`, `template_detail_screen.dart`, `template_editor_screen.dart`.
- Tests under `test/features/catalog/` and `test/features/template/`.

### 5.3 Phase 2 Execution Status

| Step | Action | Status | Notes |
|---|---|---|---|
| **Step 2.1** | Catalog domain and document persistence | `[x] COMPLETED` | Exercise taxonomy, JSON adapter, and Drift-backed repository are present. Seed fixture constructor fields were aligned with the current model. |
| **Step 2.2** | Catalog seeding and use cases | `[x] COMPLETED` | Added empty-catalog seeding, catalog filters, custom exercise creation, and guarded archive behavior for system exercises. |
| **Step 2.3** | Template document persistence | `[x] COMPLETED` | Added separate document adapters and repository for stable templates and immutable revision snapshots. |
| **Step 2.4** | Draft and publish lifecycle | `[x] COMPLETED` | Added template creation, draft-from-current, draft updates, and publication; repository rejects edits to already-published revisions. |
| **Step 2.5** | Catalog presentation | `[x] COMPLETED` | Search and taxonomy filters cover body region, movement pattern, muscle group, and equipment. Custom exercise creation captures classification and metric data; owners can add/remove exercise relationships. |
| **Step 2.6** | Template presentation | `[x] COMPLETED` | Template list/detail/editor support immutable draft revisions, block types and rounds, ordering, exercise selection, and per-set rep, weight, duration, distance, calorie, and rest targets. |
| **Step 2.7** | Phase 2 integration and acceptance checks | `[x] COMPLETED` | Catalog auto-seeds on app startup and catalog/templates are reachable from Training navigation. All 13 catalog/template tests pass; scoped Flutter analysis reports no issues. |
| **Step 2.8** | Template archival and deletion management | `[ ] PLANNED` | Add UI affordance to archive (soft-delete via `isArchived`) and permanently delete workout templates from `TemplateListScreen`, `TemplateDetailScreen`, and `TemplateEditorScreen`. Expose `archiveTemplate` and `deleteTemplate` use cases, wire confirmation dialogs, and provide an archived templates filter/restore toggle. |

---


## Audit status note — 2026-11-21

This phase is not promoted to fully complete by this audit. The supplied checks report analyzer failure (22 issues: 9 errors, 2 warnings, 11 infos), formatter pass (344 files, zero changes), no `Navigator.of` matches in `lib/` or `test/`, strict template validation failure (3 warning categories), and serial tests failed (124 passed, 21 failed, exit 1). See [the audit report](../audit-report.md) for case-level test triage and [master plan](../implementation-plan.md) for current priorities.


## Strict template validation — 2026-11-21

Strict template validation completed and exited 1: structural/reference checks passed (108 references resolve, 122 exercise IDs and 83 templates registered, identifiers/revisions unique, all exercise profiles complete), but three warning categories failed strict mode: duplicate exercise name Doorway Chest Stretch (2 occurrences), 14 unused exercise definitions, and 225 sets with targetReps: 0. Review whether orphan catalog entries and zero-rep cardio/interval targets are intentional, resolve/document their semantics, and rerun strict validation. This is in addition to the still-open archival/deletion step.


## Serial test result — 2026-11-21

The seed idempotence test expects 7 exercises, but the current catalog registers 122. Classify that fixed count as a Deprecated assertion; retain the idempotence behavior check using a current/derived count. Strict validator warnings remain an independent Phase 2/13 gate.