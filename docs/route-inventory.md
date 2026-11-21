# Application Route Inventory

**Status:** Audit snapshot 2026-11-21. GoRouter configuration is in [`lib/core/routing/app_router.dart`](../lib/core/routing/app_router.dart); route registration and feature dependency composition currently live in [`lib/core/routing/app_routes.dart`](../lib/core/routing/app_routes.dart) (untracked in the inspected working tree). Previous paths `lib/app/app_routes.dart` and `lib/core/app/app_routes.dart` do not match the current route file. The working tree also reports deletions of `lib/core/app/app_routes.dart` and two theme files; these pre-existing changes were preserved.

All application screens are registered as declarative GoRouter routes and navigated via `context.push(routePath, extra: ...)` or `context.go(routePath)`. Only transient modal popups (such as `showDialog` or `showModalBottomSheet`) use `Navigator.pop`.

---

## Route Registry

| Destination | Path Constant | Route Path | Navigation Method | Parameters (`state.extra`) | Back-stack Behavior |
|---|---|---|---|---|---|
| **Fitness Launch** | `appRouteLaunch` | `/launch` | Initial location | None | Initial destination |
| **Splash** | `appRouteSplash` | `/splash` | Registered | None | Runtime transition needs verification |
| **Home / Training Hub** | `appRouteHome` | `/home` | `context.go` | None | Primary destination; root of navigation stack |
| **Settings** | `appRouteSettings` | `/settings` | Route registered | None | Separate route destination |
| **PIN Authentication** | `appRoutePinAuth` | `/pin_auth` | `context.go` / `push` | None | Replaced by `go(appRouteHome)` on success |
| **Biometric Auth** | `appRouteBiometricAuth` | `/biometric_auth` | `context.go` / `push` | None | Replaced by `go(appRouteHome)` on success |
| **Exercise Catalog** | `appRouteExerciseCatalog` | `/exercise_catalog` | `context.push` | None | Pushed over Home; back returns to Home |
| **Custom Exercise** | `appRouteCustomExercise` | `/custom_exercise` | `context.push` | None | Registered destination |
| **Exercise Detail** | `appRouteExerciseDetail` | `/exercise_detail` | `context.push` | `Exercise` required | Builder uses typed `state.extra` cast |
| **Workout Templates** | `appRouteWorkoutTemplates` | `/workout_templates` | `context.push` | None | Pushed over Home; back returns to Home |
| **Template Detail** | `appRouteTemplateDetail` | `/template_detail` | `context.push` | `WorkoutTemplate` required | Builder uses typed `state.extra` cast |
| **Template Editor** | `appRouteTemplateEditor` | `/template_editor` | `context.push` | `WorkoutTemplateRevision` required | Builder uses typed `state.extra` cast; prior optional args claim was stale |
| **Active Session** | `appRouteActiveSession` | `/active_session` | `context.push` | `WorkoutSession` required | Screen handles back confirmation |
| **Session Summary** | `appRouteSessionSummary` | `/session_summary` | `context.push` | `WorkoutSession` required | Typed extra; save navigation needs runtime verification |
| **Analytics Dashboard** | `appRouteAnalytics` | `/analytics` | `context.push` | None | Pushed over Home; back returns to Home |
| **PR Trophy Shelf** | `appRoutePrTrophies` | `/pr_trophies` | `context.push` | Optional `AnalyticsCubit` | Top-level registered path |
| **Exercise Progression**| `appRouteExerciseProgression`| `/exercise_progression` | `context.push` | Optional `AnalyticsCubit` or map `{cubit, initialExerciseId}` | Flexible extra; builder creates fallback Cubit |
| **User Profile** | `appRouteProfile` | `/profile` | `context.push` | None | Pushed over Home/Settings; back returns to caller |
| **Training Goals** | `appRouteGoals` | `/goals` | `context.push` | None | Pushed over Home; back returns to Home |
| **Physical Measurements**| `appRouteMeasurements` | `/measurements` | `context.push` | None | Pushed over Home; back returns to Home |
| **Backup and Restore** | `appRouteBackupRestore` | `/backup_restore` | `context.push` | None | Pushed over Settings; back returns to Settings |
| **Onboarding Wizard** | `appRouteOnboarding` | `/onboarding` | Registered; launch handoff requires runtime verification | None | First-launch destination |
| **Notification Settings** | `appRouteNotificationSettings` | `/notification_settings` | `context.push` | None | Pushed from Settings |
| **Notification History** | `appRouteNotificationHistory` | `/notification_history` | Registered | None | Back returns to caller |

---

## Planned Routes (Phase 15 and 17)

| Destination | Target Phase | Planned Path | Navigation Method | Parameters (`state.extra`) |
|---|---|---|---|---|
| **Growth Reminders** | Phase 15 | `/settings/reminders` | `context.push` | None |
| **Edit Reminder** | Phase 15 | `/settings/reminders/edit`| `context.push` | `ReminderItem?` |
| **Appearance Settings**| Phase 17 (Step 17.5)| `/settings/appearance` | `context.push` | None |

Audit note: the route registry uses typed `state.extra` casts for session, exercise, template and revision objects; progression accepts an `AnalyticsCubit` or a map carrying a cubit and optional `initialExerciseId`. The current working-tree `test/core/app/app_router_test.dart` imports the relocated registry but its setup omits the newly required `notifications` argument to `createAppRoutes`, and its `NotificationCubit` construction omits `notificationRepository`; analyzer reports both as errors. The source scan run with PowerShell found no `Navigator.of` in `lib/` or `test/`. The attached review stopped before test execution, so path/extra/back-stack runtime behavior remains unverified.
