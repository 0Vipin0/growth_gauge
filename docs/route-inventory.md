# Application Route Inventory

**Status:** Updated to reflect the complete Phase 10 declarative routing migration on GoRouter. Shared router behavior, path constants, and transition builders live in [`lib/core/routing/app_router.dart`](../lib/core/routing/app_router.dart); application destinations and feature dependency composition live in [`lib/app/app_routes.dart`](../lib/app/app_routes.dart).

All application screens are registered as declarative GoRouter routes and navigated via `context.push(routePath, extra: ...)` or `context.go(routePath)`. Only transient modal popups (such as `showDialog` or `showModalBottomSheet`) use `Navigator.pop`.

---

## Route Registry

| Destination | Path Constant | Route Path | Navigation Method | Parameters (`state.extra`) | Back-stack Behavior |
|---|---|---|---|---|---|
| **Fitness Launch** | `appRouteLaunch` | `/launch` | Initial location | None | Replaced by `go` with auth or Home |
| **Home / Training Hub** | `appRouteHome` | `/home` | `context.go` | None | Primary destination; root of navigation stack |
| **Settings** | `appRouteSettings` | `/settings` | Embedded in Home | None | Tab surface within Home |
| **PIN Authentication** | `appRoutePinAuth` | `/pin_auth` | `context.go` / `push` | None | Replaced by `go(appRouteHome)` on success |
| **Biometric Auth** | `appRouteBiometricAuth` | `/biometric_auth` | `context.go` / `push` | None | Replaced by `go(appRouteHome)` on success |
| **Exercise Catalog** | `appRouteExerciseCatalog` | `/exercise_catalog` | `context.push` | None | Pushed over Home; back returns to Home |
| **Custom Exercise** | `appRouteCustomExercise` | `/exercise_catalog/custom` | `context.push` | None | Pushed over Catalog; back returns to Catalog |
| **Exercise Detail** | `appRouteExerciseDetail` | `/exercise_catalog/detail` | `context.push` | `Exercise` | Pushed over Catalog; back returns to Catalog |
| **Workout Templates** | `appRouteWorkoutTemplates` | `/workout_templates` | `context.push` | None | Pushed over Home; back returns to Home |
| **Template Detail** | `appRouteTemplateDetail` | `/workout_templates/detail` | `context.push` | `WorkoutTemplate` | Pushed over Templates; back returns to Templates |
| **Template Editor** | `appRouteTemplateEditor` | `/workout_templates/editor` | `context.push` | `TemplateEditorArgs` (optional) | Pushed over Templates/Detail; back returns to caller |
| **Active Session** | `appRouteActiveSession` | `/session/active` | `context.push` | `WorkoutSession` | Pushed over Home/Detail; back prompts confirmation |
| **Session Summary** | `appRouteSessionSummary` | `/session/summary` | `context.push` | `WorkoutSession` | Pushed over Active Session; save returns to Home |
| **Analytics Dashboard** | `appRouteAnalytics` | `/analytics` | `context.push` | None | Pushed over Home; back returns to Home |
| **PR Trophy Shelf** | `appRoutePrTrophies` | `/analytics/pr_trophies` | `context.push` | None | Pushed over Analytics; back returns to Analytics |
| **Exercise Progression**| `appRouteExerciseProgression`| `/analytics/progression` | `context.push` | String? `exerciseId` (optional) | Pushed over Analytics; back returns to Analytics |
| **User Profile** | `appRouteProfile` | `/profile` | `context.push` | None | Pushed over Home/Settings; back returns to caller |
| **Training Goals** | `appRouteGoals` | `/goals` | `context.push` | None | Pushed over Home; back returns to Home |
| **Physical Measurements**| `appRouteMeasurements` | `/measurements` | `context.push` | None | Pushed over Home; back returns to Home |
| **Backup and Restore** | `appRouteBackupRestore` | `/backup_restore` | `context.push` | None | Pushed over Settings; back returns to Settings |

---

## Planned Routes (Phases 5, 15, 17)

| Destination | Target Phase | Planned Path | Navigation Method | Parameters (`state.extra`) |
|---|---|---|---|---|
| **Onboarding Wizard** | Phase 5 (Step 5.5) | `/onboarding` | `context.go` | First-launch flag |
| **Growth Reminders** | Phase 15 | `/settings/reminders` | `context.push` | None |
| **Edit Reminder** | Phase 15 | `/settings/reminders/edit`| `context.push` | `ReminderItem?` |
| **Appearance Settings**| Phase 17 (Step 17.5)| `/settings/appearance` | `context.push` | None |
