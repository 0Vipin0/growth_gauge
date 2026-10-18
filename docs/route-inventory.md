# Application Route Inventory

Reviewed during Phase 10 on 2026-10-18 and refined afterward. Shared GoRouter
behavior and path/name constants live in
[`lib/core/routing/app_router.dart`](../lib/core/routing/app_router.dart);
application destinations and feature dependency composition live in
[`lib/app/app_routes.dart`](../lib/app/app_routes.dart). Routes currently carry
no path, query, or extra data; editor and workout data stays in the local
feature navigation flow that creates those pages.

| Destination | Path | Entry / behavior | Back-stack behavior |
|---|---|---|---|
| Fitness launch | `/launch` | Initial location; waits for saved authentication settings | Replaced with the selected auth or Home location |
| Home | `/home` | Authentication success; workout summary completion | `go` clears prior app destination history |
| Settings | `/settings` | Registered destination; currently embedded in Home's training/settings navigation | Remains in Home; no route push |
| PIN authentication | `/pin_auth` | Launch auth decision or enabling PIN from settings | `go` to Home on success; settings flow goes directly to PIN |
| Biometric authentication | `/biometric_auth` | Launch auth decision | `go` to Home on success |
| Exercise catalog | `/exercise_catalog` | Training hub | `push`; back returns to Home |
| Workout templates | `/workout_templates` | Training hub | `push`; back returns to Home |
| Analytics | `/analytics` | Training hub | `push`; local analytics detail pages remain Navigator pushes |
| Goals | `/goals` | Training hub | `push`; back returns to Home |
| Measurements | `/measurements` | Training hub | `push`; back returns to Home |
| Profile | `/profile` | Training hub | `push`; back returns to Home |
| Backup and restore | `/backup_restore` | Settings | `push`; back returns to the current Home settings surface |

Workout start/recovery and editor/detail screens remain local
`MaterialPageRoute` or Flutter Navigator pushes because they carry feature state
and are transient. Dialogs, sheets, and modal results also remain local. The
route table applies a right-to-left fade transition to app destinations and
displays an explicit unknown-route page for unmatched locations.
