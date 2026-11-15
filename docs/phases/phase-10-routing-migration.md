## 13. Phase 10: Application Routing Migration

Adopt `go_router` as the application routing package and separate shared router behavior from app-specific route registration. `lib/core/routing/` owns GoRouter lifecycle, route constants, transitions and unmatched-path handling without importing feature modules; `lib/app/` owns destination registration and feature dependency composition. Preserve current authentication launch behavior, screen transitions where supported, and route-local feature dependencies while replacing scattered route strings and ad hoc route construction with a centrally defined, testable route table. This phase changes the routing dependency and therefore updates `docs/architecture.md` when implemented.

### 10.1 Routing Rules

- Put reusable routing behavior under `lib/core/routing/` and app destination registrations/composition under `lib/app/`; keep feature screens and feature operations in their existing feature modules.
- Define stable path constants/names and typed path/query/extra data as needed; avoid passing unvalidated loosely typed arguments when route state can be modeled explicitly.
- Keep dialogs and local transient pushes on Flutter navigation when they are not application destinations; migrate only app-level destinations and navigation flows.
- Preserve launch-to-authentication-to-home decisions, deep-link-safe initial destinations, back-stack semantics, unknown-route handling, and existing feature access.
- Reuse app-level dependencies rather than constructing repositories and use cases ad hoc in route builders. Do not add a second routing abstraction alongside `go_router`.
- Add `go_router` as a direct dependency, remove `page_transition` only if equivalent transitions are implemented without it, and remove `NavigationHelper`/named-route code after all call sites are migrated and verified.

### 10.2 Execution Status

| Step | Action | Status | Notes |
|---|---|---|---|
| **Step 10.1** | Route inventory and behavior baseline | `[x] COMPLETED` | Documented destinations, entries, auth decisions, local transient flows, route data (none currently), and back-stack behavior in [`route-inventory.md`](route-inventory.md). |
| **Step 10.2** | Define app router and dependency composition | `[x] COMPLETED` | Refined into `lib/core/routing/app_router.dart` for GoRouter lifecycle, stable path/name constants, transitions and not-found handling, plus `lib/app/app_routes.dart` for app destinations and feature dependencies. Core routing has no feature imports; route registrations are provided as `RouteBase` entries from app composition. |
| **Step 10.3** | Migrate top-level navigation callers | `[x] COMPLETED` | Migrated launch/authentication, settings and training hub destinations; `go` replaces auth/launch/completion history and `push` preserves Home for feature destinations. |
| **Step 10.4** | Migrate feature destinations and typed route data | `[x] COMPLETED` | Migrated catalog, templates, analytics, profile, goals, measurements, backup/restore, active session, session summary, PR trophies, exercise progression, custom exercise, exercise detail, template detail, and template editor. Replaced all imperative `MaterialPageRoute` instances with `context.push`, `context.pushReplacement`, and `context.pop`, leveraging `appGoRoute` with `state.extra`. |
| **Step 10.5** | Add router and navigation regression tests | `[x] COMPLETED` | Tests cover named paths, saved-auth launch routing, auth selection, unmatched locations and app-destination push/pop behavior. |
| **Step 10.6** | Remove legacy routing and validate | `[x] COMPLETED` | Removed `routes.dart`, `NavigationHelper`, named-route setup and `page_transition`; updated architecture and route inventory. `scripts/check.ps1` passed. |

### 10.3 Acceptance Criteria

- Every application destination has one discoverable route definition in the app boundary; shared routing behavior has no feature imports and uses app-composed routes.
- Current launch/authentication flow, user-visible destinations, required results/data, and back behavior are covered by router/widget tests and remain functional.
- `lib/routes.dart`, named application route calls, and the bespoke `NavigationHelper` are removed when no longer referenced; local dialog/modal navigation remains valid.
- No duplicate routing system remains; analysis, formatting, targeted tests, and `scripts/check.ps1` pass, and `docs/architecture.md` describes the implemented router accurately.

---
