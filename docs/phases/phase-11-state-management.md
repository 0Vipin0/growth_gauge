## 14. Phase 11: Bloc and Framework State Management

Consolidate application state management on the existing `flutter_bloc`/`bloc` packages and Flutter framework primitives. Remove third-party state-management packages such as `provider` once their state and dependency-composition uses have been migrated. This does not mean every local widget state needs a Cubit: use Flutter primitives such as `StatefulWidget`, `ValueNotifier`, and `InheritedWidget` for tightly scoped UI state or lightweight framework composition, and Bloc/Cubit for feature or application state with meaningful transitions.

### 11.1 Migration Rules

- Inventory `Provider`, `ChangeNotifierProvider`, `Consumer`, `context.read/watch`, and other state-management APIs separately from dependency injection/composition uses; the current `provider` package serves both roles.
- Move durable/shared settings state and user-visible asynchronous state to focused Cubits/BLoCs with explicit states and operations. Keep transient form/dialog/animation state local to the widget when it does not need application-level ownership.
- Prefer constructor injection and the app composition root for repositories, services, and use cases. Use framework-provided `InheritedWidget`/`Listenable` only when a small composition or listenable contract is clearer than a Bloc.
- Do not replace Provider with a different third-party state framework or create a parallel custom global state system. Preserve lifecycle cleanup, persistence, notification integration, and testability during each migration.
- Remove the `provider` dependency and its imports only when no state or composition call sites remain; keep `flutter_bloc`/`bloc` as the sole third-party state-management packages.

### 11.2 Execution Status

| Step | Action | Status | Notes |
|---|---|---|---|
| **Step 11.1** | Inventory state and dependency composition | `[x] COMPLETED` | Migrated settings state and identified former Provider service-locator call sites for constructor injection. |
| **Step 11.2** | Define state ownership conventions | `[x] COMPLETED` | Cubit owns shared settings transitions; Flutter state remains local; app composition owns long-lived services and injects them. |
| **Step 11.3** | Migrate settings and app-wide state | `[x] COMPLETED` | Replaced SettingsProvider with SettingsCubit while retaining SharedPreferences, secure-storage, and notification-service boundaries. |
| **Step 11.4** | Migrate remaining feature/composition call sites | `[x] COMPLETED` | Removed Provider-based service lookup from home and template flows and injected session/repository dependencies. |
| **Step 11.5** | Add state migration regression tests | `[x] COMPLETED` | Added Cubit tests for load, emissions, persistence, notification scheduling, secure-storage cleanup, error fallback, and disposal. |
| **Step 11.6** | Remove dependency and verify | `[x] COMPLETED` | Removed the direct dependency and all Provider API call sites; the lockfile retains Provider transitively. `scripts/check.ps1` passes analysis, format verification, and the full test suite. |

### 11.3 Acceptance Criteria

- No third-party state-management package other than `flutter_bloc`/`bloc` remains; `provider` has no imports or direct dependency entry.
- Application and feature state with meaningful shared transitions is owned by Cubits/BLoCs; strictly local UI state uses Flutter framework primitives without unnecessary Cubits.
- Dependency construction is explicit and lifecycle-safe at the app boundary or through constructor injection; state is not used as a service locator.
- Settings, authentication, notification, and feature behavior remain covered by tests, and the repository checks pass.

---
