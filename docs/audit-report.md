# Growth Gauge Codebase Audit

**Audit date:** 2026-11-21  
**Scope:** `lib/`, `test/`, `scripts/`, `docs/implementation-plan.md`, all 18 phase specifications, design system specification, legacy crosswalk, route and test inventories, application architecture, package/platform configuration and CI workflows.  
**Policy:** Observe-only for application, test, dependency, platform and configuration files. Only roadmap, phase, inventory and report documentation was edited. The audit treats Phases 1–18 and all non-`NA` legacy crosswalk requirements as MVP scope.

## Executive Summary

**MVP readiness: NOT READY.** There is substantial implementation across Drift, catalog/templates, workout sessions, analytics, profiles, portability, GoRouter, Bloc/Cubit, notifications and responsive widgets, but the supplied serial suite failed: **124 passed, 21 failed, exit code 1**. Analysis **failed with 22 issues**, formatting **passed with 344 files and zero changes**, navigation scan found zero matches, and strict template validation **failed with 3 warning categories**. MVP requires all 18 roadmap phases and legacy parity. Significant planned functionality remains incomplete or partially evidenced: onboarding launch behavior, template archival/deletion, dynamic training summary, comprehensive exercise execution steps, biometrics intelligence, secure auth gates, TTS/reminder management, design-system appearance configuration, and Phase 16 release evidence. All phases remain in progress.

**UI completeness: PARTIAL.** Eight named common components exist, as do responsive primitives, but existence does not establish spec compliance. Design-system typography/palettes, A11y targets, focus/semantics and breakpoint behavior need systematic tests and device verification. Existing docs themselves record hardcoded home summary metrics, raw exercise IDs and duplicate analytics sections as open work. Route inventory paths were stale and have been corrected.

**Release configuration: NOT VERIFIED.** PR and release workflows plus Windows/Bash build wrappers exist. The release and analyze workflows pin different Flutter versions (3.47.8 vs 3.44.0). The shared check wrapper mutates repository files before checking them, making it unsafe as a CI gate until separated from cleanup. No platform build was attempted. Signing, artifact paths and release credentials need workflow-level verification.

## Validation Criteria and Gate Results

The check workflow requires dependency resolution, fatal Flutter analysis, non-writing format verification, forbidden `Navigator.of` scan and serial tests. The wrapper itself was not run: both `check.ps1` and `check.sh` remove citation tags by rewriting files before executing checks.

| Gate | Exact command / evidence | Result | Readiness impact |
|---|---|---|---|
| Dependency resolution | `flutter pub get` not run | **Not run**: it can rewrite `pubspec.lock` and `.dart_tool`, which violates the observe-only policy for non-documentation files. | Analyzer/tests/build gates remain unverified against a fresh resolution. |
| Static analysis | `flutter analyze --fatal-infos --fatal-warnings` (attached review output, 2026-11-21 20:53 UTC) | **Failed: 22 issues** (9 errors, 2 warnings, 11 infos; analyzer reported 22 issues in 2.4s). Review script printed an empty `EXIT_CODE=` field, so numeric exit code was not captured. | Analysis gate fails. Compile blockers are concentrated in Phases 10, 11, 15 and 17; no phase may be promoted to complete. |
| Format | `dart format --output=none --set-exit-if-changed .` | **Passed:** `Formatted 344 files (0 changed) in 1.79 seconds.` Script's numeric `EXIT_CODE` field was empty. | Formatting gate passes for this snapshot. |
| Navigation enforcement | Attached script attempted `rg -n 'Navigator\.of' lib test`, but `rg` was not installed in the caller's PowerShell PATH; command-not-found aborted the script. A follow-up PowerShell `Select-String` scan of Dart files in `lib/` and `test/` found no matches. | Navigation source check passes on the follow-up scan; script needed a built-in fallback and has been updated. |
| Serial test suite | `flutter test --concurrency=1`; supplied capture `%TEMP%\growth-gauge-test-output.txt` | **Failed, exit 1:** 124 passed, 21 failed. Failures span compile-time test wiring/mock errors, six analytics Cubit close/init race cases, home widgets, session exercise-name display, and three Deprecated assertions (migration v3, catalog count 7, compact-only label expectation). | Test gate fails. See full case-level triage below; valid failures block their owning phases, while the three stale assertions are classified Deprecated and need test maintenance. |
| Template validation | `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validateTemplates.ps1 --strict --show-all --no-color` | **Failed, exit 1.** Zero errors and 3 warning categories. All 108 template exercise references resolve; 122 exercise definitions and 83 templates are registered; IDs/links and names are unique; execution profiles are complete. Warnings: duplicate `Doorway Chest Stretch` name (2 occurrences), 14 defined exercises unused by templates, and 225 sets with `targetReps: 0`. | Strict MVP gate fails. Review whether unused definitions and zero-rep targets are intentional catalog/interval cases; resolve or document semantics, fix duplicate display name, rerun strict validation. |
| Safe overview | `Get-Command flutter,dart`; `rg --files lib test .github scripts docs/phases` | Flutter/Dart launchers available at `H:\Programs\flutter\bin`; inventory commands completed. 31 `*test.dart` test files and 2 generated mock files found. | Static inventory evidence available. |

### Serial test failure triage

The user's complete serial capture reports `+124 -21: Some tests failed` and `FLUTTER_TEST_EXIT_CODE=1`. The prior local no-output timeout is superseded by this completed run.

| Classification | Test case(s) | Evidence and status impact |
|---|---|---|
| Valid failure — compile/test wiring | `test/core/app/app_router_test.dart` (file load); `test/features/settings/settings_cubit_test.dart` (file load); `test/features/notification/notification_service_test.dart` (file load); `test/core/theme/fitness_theme_test.dart` (file load) | Router test omits `createAppRoutes.notifications` and `NotificationCubit.notificationRepository`; settings test omits the repository twice; generated notification mocks do not implement current service method signatures; theme test imports a deleted `fitness_theme.dart` and references undefined `FitnessTheme`. Suite cannot compile these areas; Phases 9–11/15/17 remain blocked. Regenerate/update test doubles and fixtures, then rerun. |
| Valid failure — app lifecycle | Six `test/features/analytics/analytics_dao_test.dart` cases: history stream/order, date range, progression ordering, recent sets, personal records, weekly muscle volume | Each reports `Bad state: Cannot emit new states after calling close` from `AnalyticsCubit._initStreams`; asynchronous initialization can subscribe/emit after close. Fix lifecycle race and test close during pending initialization (Phases 4, 9, 11). |
| Deprecated test assertion | `test/core/database/app_database_migration_test.dart`: “upgrades a schema version 1 database through version 3” | Expects `user_version == 3`; current `AppDatabase.schemaVersion` is 5. The version assertion is obsolete, not evidence of migration failure against current schema. Update fixture to assert/cover v5, then rerun (Phase 1). |
| Deprecated test assertion | `test/features/catalog/catalog_feature_test.dart`: “seeds standard exercises once and leaves a non-empty catalog alone” | Expects 7 seeded exercises while current valid registry contains 122. The hardcoded historical count is obsolete; retain idempotence assertions using the current/derived count (Phases 2, 13). |
| Deprecated responsive assertion (limited) | `test/features/home/activity_trends_section_test.dart`: “renders week view with workout checkmarks and days” | Failure is specifically absence of “This Week” at default compact width; current card displays that label only on desktop. Treat only the label expectation as deprecated unless product spec requires it on compact; verify checkmarks independently. |
| Valid failure — missing UI behavior | `activity_trends_section_test.dart`: “renders month and quarter views”; “triggers onPrevious and onNext on navigation buttons” | Month/quarter marker `W1` and expected navigation controls are absent. Implement period views/navigation required by analytics scope or document an approved scope revision (Phases 4, 7, 12). |
| Valid failure — missing UI behavior | `test/features/home/week_summary_section_test.dart`: zero state; Details callback; desktop layout | Zero state expects a Details CTA absent from `WeekSummarySection`; callback case cannot tap it. Desktop layout produces RenderFlex overflows of 178, 70 and 93 px. Implement CTA and responsive layout, retain tests (Phases 7, 9, 12). |
| Valid failure — user-facing data | Two `test/features/session/session_summary_screen_test.dart` cases: repository name resolution and slug fallback | Both expected exercise names render as zero matching widgets. Restore visible resolved/fallback names and verify summary presentation (Phases 3, 7, 9). |
| Valid failure — test harness | `test/features/user/user_widgets_test.dart`: equipment sheet save | `No GoRouter found in context` at `equipment_inventory_sheet.dart:79` when `context.pop()` executes. Configure a GoRouter-backed widget harness and re-evaluate; test currently does not establish production navigation behavior (Phases 5, 9, 10, 12). |

The full 21-case failure count includes file-level load/compile failures as reported by Flutter. No other failing cases appear in the supplied output. Deprecated classifications apply to stale test assumptions only; update/quarantine those assertions rather than suppressing valid behavior requirements.

### Analyzer findings from supplied output

- **9 errors:** `test/core/app/app_router_test.dart` omits required `notifications` for `createAppRoutes` and required `notificationRepository` for `NotificationCubit`; `test/features/settings/settings_cubit_test.dart` omits `notificationRepository` in two `NotificationCubit` constructions; `test/core/theme/fitness_theme_test.dart` imports missing `lib/core/theme/fitness_theme.dart` and references undefined `FitnessTheme` twice; `test/features/notification/notification_service_test.mocks.dart` has two invalid overrides for changed notification service signatures.
- **2 warnings:** generated notification mock members no longer override inherited members.
- **11 infos:** nine constructor/declaring-parameter style findings in legacy chart widgets, one empty catch in workout audio service, and one import ordering finding in router test.
- The supplied working-tree snapshot shows route imports changed in `lib/core/app/app_runner.dart` and `test/core/app/app_router_test.dart`; the two old theme files are deleted and `lib/core/routing/app_routes.dart` is untracked. This user-owned working state was preserved. Treat the missing theme import and route test contract errors as current compile/test wiring defects to resolve, not as evidence that the runtime route or theme behavior was exercised.

The review script itself also had two reporting defects revealed by the first attachment: it required external `rg` and stopped before later checks, and its `Start-Process` result line printed an empty exit code. The PowerShell script now falls back to built-in `Select-String`, terminates a process tree on timeout, and reports when launcher exit code is unavailable. Supplied direct command results supersede earlier wrapper timeouts. The complete user-supplied serial test result supersedes the earlier local no-output stall.

## Scripts and Tooling

| Script(s) | Behavior and flags | Safety / parity observations |
|---|---|---|
| `setup.ps1`, `setup.sh` | Dependency fetch | Mutates dependency artifacts; not run. |
| `check.ps1`, `check.sh` | Citation-tag stripping; `flutter pub get`; fatal analyze; format check; `Navigator.of` scan; `flutter test --concurrency=1` | **Unsafe for observe-only audit** because they rewrite source/docs before checks. Bash uses `git grep`, PowerShell recursively scans files (including scripts); both may match their own navigation-check text. |
| `review.ps1`, `review.sh` | Read-only 18-phase source/test inventory, bounded analyze/format/navigation/test/template checks; skip dependency resolution and code generation. | Direct command output completed analyze, format, navigation and strict template validation; the first wrapper output aborted because `rg` was unavailable, and fallback was added. Bash version was inspected but not executed on this Windows host. |
| `validateTemplates.ps1`, `.sh`, `.dart` | Shared Dart validator; `--strict`, `--show-all`, `--no-color`, `--exercise-file`, `--template-file`; PowerShell translates `-Strict`, `-ShowAll`, `-NoColor`, `-ExerciseFile`, `-TemplateFile`. Exit 0 pass, 1 validation failure, 2 usage/input error. `DART`, `FLUTTER_ROOT`, `VALIDATE_TEMPLATES_DART` affect lookup. | Thin wrappers aim for common Dart behavior. Windows and Bash wrappers inspected; Windows invocation attempted and stalled. Linux counterpart inspected, not executed. |
| `generate.ps1`, `generate.sh` | `dart run build_runner build --delete-conflicting-outputs` | Mutates generated code; not run. |
| `build.ps1`, `build.sh` | `flutter pub get`, then builds `apk`, `appbundle`, `web`, `windows`, `linux`, or `macos`, forwards build args | Mutates dependency/build artifacts; neither platform wrapper executed. |
| `runDev.ps1`, `runDev.sh` | `lib/main_dev.dart`; auth bypass and onboarding define; optional local data clear | PowerShell switches `-ClearStorage`, `-BypassAuth`, `-Onboarding`; Bash `-c/--clear-storage`, `-b/--bypass-auth`, `-o/--onboarding`. Clearing is destructive; not run. Bash currently consumes all args as these switches and does not forward arbitrary Flutter args (unlike PowerShell). |
| `run.ps1`, `run.sh` | Normal app run; optional Flutter args | Inspected via script inventory, not run. |
| `formatAdd.sh`, `launcherIcons.sh` | Formatting/import sorting and launcher icon generation helpers | Inspected by filename; not run because these may rewrite source/assets. |
| `scripts/README.md` | documents Windows and Bash entry points and examples | Historical overview omits some helper scripts and should distinguish the mutating check behavior. |

The command outputs contain no Windows-only or Linux-only execution evidence beyond the Windows attempts listed above. Bash scripts were inspected but not executed in this Windows environment.

## Phase-by-Phase Audit Matrix

| Phase | Observed implementation and tests | Status / required next evidence |
|---|---|---|
| 1 Foundation & Drift | Drift database, document store, events, results, IDs/units; migration and store tests present. | **In progress** until analyzer and migration tests pass. |
| 2 Catalog & Templates | Catalog/repository/seeds and template revisions/editor/list/detail; feature tests. Validator confirms all references and registrations, but strict mode warns on duplicate exercise name, 14 unused exercises and 225 zero-rep sets. | **In progress**; triage/fix or document seed content warnings. Archival/deletion step remains open. |
| 3 Session Runtime | Session models, use cases, BLoC, persistence, crash recovery; feature, widget and journey tests. | **In progress** pending serial suite and runtime recovery evidence; step cues remain cross-phase. |
| 4 Analytics | Materialized tables/DAO, projector/rebuilder, calculators/charts and extensive tests. | **In progress**; validate tests, period controls and live hub connection. |
| 5 User Profile & Goals | Profile, goals, measurements, preferences/equipment, Cubits and onboarding UI/tests. | **In progress**; ensure launch resolver routes first-use through the wizard and test complete flow. |
| 6 Portability | Versioned export/import, checksums, migrations/conflict strategies and tests. | **In progress**; run tests and manual platform file picker/export/restore checks; legacy CSV requirement needs implementation or explicit documented scope decision. |
| 7 Hardening & Polish | Isolate runner, stress/performance test, home summary test; plan identifies hardcoded metrics, raw IDs and duplicate analytics section. | **In progress**; fix/verify UI defects and profile performance on hardware. |
| 8 Structural Consistency | Feature layer directories/barrels exist. Naming varies (`presentation/screen` and `presentation/screens`; legacy feature names such as `chart`, `splash`). | **In progress**; standardize/document exceptions and verify boundaries. |
| 9 Test Coverage | 31 test files and 2 generated mock files including domain, repository, Cubit, widget and integration tests. | **In progress**; the serial suite completed 124 passed / 21 failed (exit 1). Fix compile/load errors and valid behavior failures, refresh Deprecated assertions, then establish a green test baseline. |
| 10 GoRouter | Router and constants plus route tests exist; current registry is `lib/core/routing/app_routes.dart` in this dirty tree. Onboarding and notification routes are present. | **In progress**; analyzer flags missing `notifications` argument and `notificationRepository` in router test setup. Route runtime remains unverified. |
| 11 Bloc State | `flutter_bloc` Cubit/BLoC usage across features; source search showed no Provider occurrence. | **In progress**; two settings tests instantiate `NotificationCubit` without required repository; align fixtures and rerun. |
| 12 Responsive & A11y | Responsive utilities and common responsive test; selected screens use `ResponsiveContent`. | **In progress**; broad compact/medium/expanded, keyboard, focus, semantics, contrast, hit target and 200% scale checks are unverified. |
| 13 Catalog & Steps | Taxonomy, execution model, seed data and detail/custom screens exist; 122 exercise definitions register and execution profiles pass validation. | **In progress**; validator warns of one duplicate name, 14 unused definitions and 225 zero-rep target sets. Review content semantics; broad catalog coverage, numbered instructions, custom step editor, session cues and tests remain. |
| 14 Secure Local Auth | PIN/biometric pages and service tests; dependencies include `local_auth` and secure storage. | **In progress**; native capability checks, secure PIN lifecycle/throttling and protected route enforcement require source/runtime verification and tests. |
| 15 Sounds, Reminders & TTS | Notification scheduler/settings/history, audio service and Cubit; service tests. | **In progress**; generated service mocks mismatch current method signatures, and Cubit test wiring is stale. TTS and full reminder management remain unverified; notification test file failed to compile. |
| 16 CI/CD | PR analysis and release workflows plus build/check scripts. | **In progress**; SDK pin mismatch (3.44.0 vs 3.47.8), unsafe check mutation, artifact paths, credentials/signing and platform builds require remediation/verification. |
| 17 Modular Design System | Eight requested common widget files and responsive primitives exist; current working tree deletes `lib/core/theme/fitness_theme.dart`. | **In progress**; analyzer reports missing theme import and two undefined `FitnessTheme` references in its test. Resolve source/test contract, then conform palettes/contrast, M3 tokens, typography, Appearance UI and accessibility. |
| 18 Biometric Intelligence | User profile includes body metrics; calorie calculator exists. | **In progress**; HR zones, BMR/TDEE, Navy body-fat estimate, composite score and unit tests remain required. |

The master plan and individual phase files are the detailed step-level source. Historical `[x]` markers cannot be accepted as completion evidence while current tests/checks are unverified or required feature tests/implementation are absent. Counts were not fabricated; the master table now marks planned counts as prior estimates where evidence is insufficient.

## Naming, State, Routing and Architecture Conventions

Feature directories generally use `domain/`, `application/`, `infrastructure/`, `presentation/`; generated Freezed/JSON files are co-located with domain models. State names are mostly `*Cubit`, `*State`, `*Bloc`; session uses `WorkoutSessionBloc` while most features use Cubits, a reasonable distinction but worth documenting. No Provider usage or `Navigator.of` usage was found in source/test searches. Route constants use `appRoute...`, route names use `appRouteName...`, and registration uses `appGoRoute`. Risks: literal `'/home'` fallback in `GoalsScreen`; typed casts on `state.extra` can throw for bad/missing values; progression route uses a flexible map contract. Feature presentation directory singular/plural and `screen`/`screens` vary. Audit and normalize before adding more feature modules.

Working tree context is material: Git reports `D lib/core/app/app_routes.dart`, `D lib/core/theme/fitness_theme.dart`, `D lib/core/theme/theme.dart`, and `?? lib/core/routing/app_routes.dart`. Current route inventory is based on that untracked file and `app_router.dart`; do not interpret its untracked state as committed architecture. Historical plans and tests refer to older paths. Review/resolve those pre-existing changes with the owner before basing a release on this snapshot.

## Design System and Small Widget Audit

The common widget directory contains all named files: `AppButton`, `AppTextField`, `AppDropdown`, `AppCard`, `AppSegmentedControl`, `AppProgressRing`, `AppStatCard`, `AppActivityBadge`, plus `TagInputWidget` and `TimeControlWidget`. The theme directory contains `AppTheme`, `AppColors` and `AppTypography`. This confirms component presence, not full specification compliance.

Concrete drift: `pubspec.yaml` declares Cera, Lato, Montserrat, OpenSans and Roboto, while the design spec requires Manrope, Open Dyslexic and system default. User-selected eight seed palettes and contrast levels, responsive `ResponsiveContent` bounds, M3 tonal token consistency, and full widget hit-target/focus/semantics behavior require direct per-widget review and runtime tests. Broad search shows numerous screen-level raw `fontSize` overrides and literal `SizedBox` spacing; these are audit candidates and need contextual review because some dimensions are valid component-specific sizes. Add tests for minimum 48dp interactive targets, keyboard/focus traversal, semantic labels, reduced motion, contrast and Compact (<600), Medium (600–1024), Expanded (>=1024) bounds. Avoid declaring WCAG compliance from source appearance alone.

Small widgets should remain presentational. The inventory/source spot checks show feature screens and widgets receiving repositories/use cases; perform a targeted dependency-boundary pass on each reusable widget before release. Do not assume UI-only responsibility from filenames.

## Route and Test Inventory Synchronization

`docs/route-inventory.md` now reflects the source path currently observed, adds onboarding and notification routes, and removes onboarding from planned routes. It records remaining planned reminder/appearance destinations and route-parameter verification needs. In particular, progression extras do not match the old inventory's simple optional `String exerciseId`; the current builder accepts an `AnalyticsCubit`, or a map with `cubit` and `initialExerciseId`.

`docs/test-coverage-inventory.md` now distinguishes 31 test files from 2 generated mock files, corrects its stale “legacy named routing” assertion, records home and notification widget gaps, and adds the analyzer compile errors. Existing automated coverage is meaningful in domain/session/analytics/portability, but the current suite result is 124 passed and 21 failed. Case-level Valid/Deprecated triage is recorded above.

## Legacy Crosswalk Assessment

Treat every non-`NA` crosswalk row as MVP-required. Current architecture preserves Drift rather than legacy Shared Preferences storage, and the roadmap covers sessions/templates, charts, export/import, themes/fonts, biometrics/PIN, notifications, profile/constraints, fitness score, session notes/RPE, interval timers/TTS and release artifacts. Requirements not evidenced as complete include separate CSV export; verified selectable theme/font options; auth security controls and route lock; fully configurable reminder templates; complete profile constraint flow; score calculation; mood/notes/RPE persistence; TTS cues with visual equivalents; and verified release artifacts. Keep the crosswalk explicit about any scope revision rather than silently dropping a row.

## Findings by Required Priority

### 1. MVP Readiness

1. Clear failing gates: fix 22 analyzer issues and the 21 test failures (retain the three Deprecated classifications as stale assertions to update); resolve strict validator warnings; then rerun analysis, format, serial tests and templates with captured exit codes. Dependency resolution was intentionally not run because it can mutate non-doc files.
2. Complete Phase 2 archival/deletion and strict seed/template validation.
3. Complete Phase 5 first-launch/onboarding launch resolution and tests.
4. Complete Phase 7 dynamic analytics summary and fix documented hardcoded metrics, raw IDs and duplicate section.
5. Complete Phase 13 exercise instruction timeline, custom ordered steps, session cues and tests.
6. Complete Phase 14 secure PIN/biometric policy and protected-route enforcement, including platform capability tests.
7. Complete Phase 15 reminder editor/template tokens and TTS/audio lifecycle with widget tests.
8. Complete Phase 18 calculations and documented formula assumptions with domain unit tests.
9. Verify all current and legacy crosswalk behaviors, including CSV, session notes/RPE and recovery paths. Test every user-facing feature with unit and widget coverage before marking complete.

### 2. UI Completeness

1. Finish data wiring and eliminate hardcoded metrics, raw IDs and duplicate analytics content.
2. Complete exercise step UI and Appearance/reminder screens; verify every destination and route stack.
3. Conform theme assets and selectors to the design spec; reconcile required Manrope/Open Dyslexic/System families with declared assets.
4. Audit every shared/feature widget for tokens, 48dp targets, focus, semantics, reduced motion and single responsibility; use a systematic small-widget checklist.
5. Run responsive and accessibility widget tests for all key screens and manual keyboard/screen-reader/large-text checks.

### 3. Release Config

1. Remove citation rewriting from quality check wrappers and keep cleanup as an explicit separate command; make the gate safe to run repeatedly.
2. Align CI Flutter SDK versions with the declared minimum/current supported policy.
3. Verify Windows/Linux build wrappers, Android signing secrets, release artifact paths, permissions and upload/publish flow in CI; document web/macOS coverage decisions.
4. Execute release builds and install/run smoke tests on supported targets; verify database migration, backup/restore and notification behavior on real devices.

## Manual / Runtime Verification and Plan Updates

- Resolve and review the pre-existing route/theme working-tree edits; verify current route source is intentionally tracked and historical file paths are corrected throughout docs/tests.
- On Android/iOS, verify biometric capabilities, secure storage, notification permission/timezone/scheduling, audio lifecycle and file import/export.
- On Windows/Linux, verify directory/file picker behavior, local DB path and recovery, build/sign/package artifacts, keyboard traversal and resize breakpoints.
- Run screen reader, high contrast, reduced motion, 200% text scale, minimum hit target and color contrast checks.
- Update crosswalk, Phase 13–18 requirements and architecture docs if a product owner explicitly defers any non-`NA` MVP requirement. Current audit made no scope deferrals.

## Documentation Edits Made

- `docs/implementation-plan.md`: downgraded completion statuses where gates or required scope are open, updated evidence/remaining work for all phases, and linked this report.
- `docs/route-inventory.md`: corrected current registry path, onboarding/notification route status and stale settings/navigation assumptions; documented extra contracts and source-scan result.
- `docs/test-coverage-inventory.md`: recorded current test-file count and unverified run, corrected route assumptions, and added UI/A11y coverage gaps.
- `docs/audit-report.md`: this standalone report, indexed from the master plan.

Phase specifications remain the detailed step checklists; they should be reconciled with the conservative master statuses and this report before subsequent status promotion. No source, test, dependency, platform, workflow or generated files were changed by this audit.
