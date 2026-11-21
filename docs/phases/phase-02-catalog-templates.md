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
| **Step 2.7** | Phase 2 integration and acceptance checks | `[x] COMPLETED` | Catalog auto-seeds on app startup and catalog/templates are reachable from Training navigation. Catalog/template feature suites pass 16/16; scoped fatal Flutter analysis reports no issues; strict template validation exits 0 with zero warnings. |
| **Step 2.8** | Template archival and deletion management | `[x] COMPLETED` | Archive/restore filters, popup actions and confirmation dialogs exist in list/detail/editor. Permanent deletion transactionally removes revisions and the template. Focused widget coverage passes archive/filter/restore/delete, and verifies detail view shows exercise name and prescribed set targets. |

---


## Audit status note — 2026-11-21

The repository-wide baseline has analyzer and full-suite failures in other phases. Phase 2 scoped gates pass: catalog/template unit and widget tests 18/18, fatal analysis with no issues, format verification, and strict template validation with zero errors or warnings. See [the audit report](../audit-report.md) for the baseline/global gate context.


## Strict template validation — 2026-11-21

Strict template validation now exits 0: all 108 exercise references resolve; 122 exercise IDs and 83 template definitions register; IDs/revisions are consistent; profiles are complete; and there are zero warnings. The duplicate display name was changed to `Doorway Pectoral Stretch`. The 225 RPE-guided sets no longer serialize a misleading `targetReps: 0`; no rep target is encoded for those sets. Fourteen valid selectable catalog exercises are not included in a default seeded plan; the validator reports these as informational rather than warnings because catalog breadth does not require every exercise to appear in a routine.


## Serial test result — 2026-11-21

The seed idempotence assertion now compares stored count with the seeder's actual first-run insertion count instead of historical fixed count 7. Archive/restore/cascade-delete unit coverage was added. The original compact Activity Trends label expectation remains a separately Deprecated assertion under Phase 7; it does not apply to Phase 2.

## Phase 2 implementation verification — 2026-11-21

- `flutter test --no-pub --concurrency=1 test/features/template/template_management_widget_test.dart test/features/template/template_feature_test.dart test/features/catalog/catalog_feature_test.dart`: **passed, 18 tests** (2 widget, 16 catalog/template feature tests).
- `flutter analyze --fatal-infos --fatal-warnings lib/features/catalog lib/features/template test/features/catalog test/features/template scripts/validateTemplates.dart`: **passed, no issues**.
- `scripts/validateTemplates.ps1 --strict --show-all --no-color`: **passed, exit 0; 0 errors, 0 warnings**. The 14 unused catalog entries are informational; no zero-rep targets remain.
- Added `TemplateListScreen` management coverage for archive, archived filter, restore, and confirmed permanent deletion; the regression exposed a 24px popup-menu overflow, fixed with flexible labels. Added detail-screen assertion for exercise names and prescribed reps, weight, and rest. Both pass in the focused 18-test run.
