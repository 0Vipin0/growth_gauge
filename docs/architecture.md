# Growth Gauge: Target Architecture

**Status:** Target architecture and implementation guidance. Reviewed 2026-10-18 against [`implementation-plan.md`](implementation-plan.md) and the current repository.
**Authority:** Follow explicit user direction, this target reference, the implementation plan, then the code for existing behavior and migration detail. This file describes the intended architecture, not a claim that every listed feature is already complete.

## Product direction

Growth Gauge is an offline-first strength and conditioning tracker. Legacy counter/timer/chart/splash/onboarding feature trees and routes have been removed. Do not reintroduce them as patterns for new work.

The architecture is a feature-first modular monolith with consistent feature boundaries and clean separation of domain, application, infrastructure and presentation concerns. Catalog, template, session, analytics, user/profile/goals/measurements, and portability are implemented. Settings, notification, and authentication remain existing app services/providers rather than fully migrated feature layers; evolve them incrementally without restoring counter/timer behavior.

## Target structure

```text
lib/
├── app/                         # Bootstrap, routing, composition root, global theme
├── core/
│   ├── concurrency/             # IsolateRunner for serializable CPU-heavy work
│   ├── database/                # Drift database, document store and read-model tables
│   ├── error/                   # Failures and Result
│   ├── events/                  # Domain events and dispatcher
│   ├── ids/                     # IDs
│   ├── time/                    # Clock and UTC helpers
│   └── units/                   # Canonical unit conversions
└── features/
    ├── user/                    # Profile, training preferences, goals, equipment, measurements
    ├── catalog/                 # Exercises and taxonomy
    ├── template/                # Workout definitions and immutable revisions
    ├── session/                 # Live workout, recovery and audit history
    ├── analytics/               # Projections, queries and visualizations
    ├── portability/             # Versioned backup/restore, migrations and conflict handling
    ├── settings/                # Appearance and access preferences
    ├── notification/            # Platform notification scheduling service
    └── authentication/          # Local PIN and biometric flows
```

Feature modules should use the same layer names where those concerns apply:

```text
feature/
├── domain/          # Entities/value objects, invariants, domain events
├── application/     # Use cases, commands/queries, Cubit/BLoC state
├── infrastructure/  # Repository implementations, adapters, platform services
└── presentation/    # Screens and widgets
```

Keep a feature simple when a layer is not needed; consistency means consistent boundaries and dependency direction, not empty folders or unnecessary abstractions. Shared domain support belongs in `core/` only when genuinely cross-feature. Shared presentation widgets may live under a common presentation location.

## State management, presentation and navigation

- Use `flutter_bloc`/`bloc` with Cubits or BLoCs for feature and application state. Use Flutter framework primitives for strictly local UI state; do not add another third-party state-management package. Phase 11 of `implementation-plan.md` removes the transitional `provider` package after its state and composition uses are migrated.
- Domain types should not depend on Flutter or persistence packages. Use immutable Freezed models where appropriate; use `Result<T, Failure>` for expected repository/use-case outcomes following the existing core convention.
- Build feature screens from presentation widgets that invoke application operations and render state.
- The current app uses `Navigator`, named routes and `page_transition`; these are transitional and are still the implemented behavior. Phase 10 of `implementation-plan.md` explicitly targets `go_router` and moves application route ownership into `lib/app/`. Until that phase is implemented, preserve the current navigation behavior. During migration, keep local dialogs and transient feature pushes on Flutter navigation when they are not application destinations.
- Presentation should adapt to available constraints across phone, tablet and laptop/desktop form factors. Phase 12 of `implementation-plan.md` defines the responsive layout, keyboard, semantics, and accessibility rollout; avoid device-model-specific layout assumptions.

## Persistence and data flow

The planned app remains local-first and offline-first. No remote networking/API layer is specified by the plan; do not assume one exists or introduce one without a separate architecture decision.

- Drift/SQLite is the persistence engine for the authoritative document store and relational analytics read models.
- Store hierarchical exercise, template/revision and session aggregates as versioned JSON documents in the Drift `documents` table through typed adapters and repositories. Keep database schema migrations distinct from document-format migrations.
- Treat source documents as authoritative. Analytics tables are derived/materialized read models and must be rebuildable from source history. Use domain events/projectors for incremental updates and a rebuild use case for recovery/import.
- Keep repository contracts oriented around domain/application needs. Infrastructure implements storage and platform details; presentation does not issue SQL or serialize storage documents.
- User/profile/preferences/goals/equipment/measurements are implemented in `features/user/`; see Phase 5 in the implementation plan for the current verification status.

## Dependency composition and platform services

Use an explicit application composition root under `app/` to initialize platform capabilities and construct database, event dispatch, repositories, use cases and feature state objects. The current `main.dart` and Provider-based wiring predate this target and are transitional, not the target pattern. Avoid route-local ad hoc construction as modules are migrated; inject feature dependencies at the app boundary. No DI package is mandated by the implementation plan.

Authentication credentials stay in secure storage, notification scheduling stays behind its service, and appearance/access preferences remain typed settings backed by shared preferences. The fitness launch route checks saved authentication settings before opening the home flow. Phase 14 of `implementation-plan.md` completes the local biometric/PIN fallback and hardens PIN verification/storage; Phase 15 completes opt-in, preference-controlled progress sounds and local notifications. These modules are not yet fully migrated to feature-layered Cubits/repositories; do not infer such a migration from the fitness feature modules.

## Domain rules already established by the plan

- Template revisions are immutable after publication. Editing produces a new draft revision.
- Starting a session creates an independent copy of the selected template revision; live changes never mutate the template.
- Session lifecycle, rest intervals, interruptions, recovery and append-only audit history are explicit domain concepts.
- Persist session changes so interrupted workouts can be recovered after restart.
- Analytics are projections, not the editing source of truth.
- Portability uses a versioned JSON envelope with SHA-256 validation, sequential migrations, typed document validation, explicit conflict policy, atomic document writes and analytics rebuild after session imports.

## Dependencies and code generation

Use dependencies already selected by the plan and present in the project: `flutter_bloc`/`bloc`, Drift, Freezed/JSON serialization, and `fl_chart` for visualizations. Portability uses `file_picker` for JSON file access and `crypto` for checksums. `IsolateRunner` accepts top-level workers and serializable messages for CPU-heavy parsing, serialization, checksums, and rebuild ordering. Drift queries and projection transactions must stay on the isolate that owns the database connection. Direct-only CSV, heatmap, and Lottie dependencies from removed features have been pruned; `path_provider` remains transitive through other packages.

Edit source declarations, not generated files. Drift, Freezed, JSON serialization and Mockito artifacts are generated with `build_runner`; use `./scripts/generate.ps1` on PowerShell or the documented equivalent.

## Tests and validation

Organize tests under `test/core/`, `test/features/<feature>/`, and `test/integration/`. The integration test uses the real in-memory Drift repositories/use cases to cover catalog seeding, template creation, four logged sets, rest completion, analytics/PRs, and export/clear/import parity. Device-level frame pacing for a 1,000-session analytics rebuild remains a release-profile check.

- `./scripts/check.ps1`: analysis, format verification and Flutter tests.
- `./scripts/generate.ps1`: code generation.
- Phase 16 of `implementation-plan.md` aligns GitHub Actions with the supported SDK and these local validation scripts, while hardening release permissions and artifacts.

## Status and source distinctions

The implementation plan marks phases 1–6 complete and Phase 7 in progress pending device frame-pacing validation. The current repository passes `scripts/check.ps1` (analysis, formatting, and tests). The implemented architecture document [`application-architecture.md`](application-architecture.md) and persona documents contain broader design/reference material; use the implementation plan and this target reference for direction, and verify details against code where behavior matters.

The implementation plan's projected `app/` tree is not yet reflected in `lib/`; `main.dart` and named routes remain the composition boundary. Settings, notifications and authentication remain app services/providers and can be migrated incrementally if future work requires it.

## Updating this reference

Update this document and the implementation plan when target module boundaries, dependency decisions or rollout status change. Label facts as implemented, in progress or planned, and keep legacy code clearly marked as deprecated until its removal is complete.
