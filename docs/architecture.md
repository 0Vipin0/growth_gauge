# Growth Gauge: Target Architecture

**Status:** Target architecture and implementation guidance. Reviewed 2026-10-04 against [`implementation-plan.md`](implementation-plan.md) and the current repository.  
**Authority:** Follow explicit user direction, this target reference, the implementation plan, then the code for existing behavior and migration detail. This file describes the intended architecture, not a claim that every listed feature is already complete.

## Product direction

Growth Gauge is being refactored into an offline-first strength and conditioning tracker. The counter/timer application is legacy and deprecated: do not use it as a design reference for new work or extend it unless a migration step explicitly requires it. Existing code remains useful for understanding compatibility and migration needs.

The architecture is a feature-first modular monolith with consistent feature boundaries and clean separation of domain, application, infrastructure and presentation concerns. Catalog, template, session and analytics form the implemented foundation described by the plan. User/profile/goals/measurements and portability are planned phases. Settings, notification and authentication are also planned for rewrite into the target conventions; the plan's module list should be extended to include them as work is sequenced. Do not copy their legacy implementations as patterns.

## Target structure

```text
lib/
├── app/                         # Bootstrap, routing, composition root, global theme
├── core/
│   ├── concurrency/             # Isolate support when needed (planned)
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
    ├── portability/             # Versioned backup/restore and conflict handling (planned)
    ├── settings/                # Rewritten app/user configuration (planned)
    ├── notification/            # Rewritten notification scheduling/preferences (planned)
    └── authentication/          # Rewritten local authentication (planned)
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

- Use `flutter_bloc`/`bloc` with Cubits or BLoCs for application state. Keep state transitions and user operations in the application layer, not in widgets.
- Domain types should not depend on Flutter or persistence packages. Use immutable Freezed models where appropriate; use `Result<T, Failure>` for expected repository/use-case outcomes following the existing core convention.
- Build feature screens from presentation widgets that invoke application operations and render state.
- The current app uses `Navigator`, named routes and `page_transition`. The plan targets an `app/` composition area but does not specify a replacement router. Until routing is explicitly redesigned, preserve working navigation behavior while moving route ownership into the app boundary; do not add a router dependency without a stated need.

## Persistence and data flow

The planned app remains local-first and offline-first. No remote networking/API layer is specified by the plan; do not assume one exists or introduce one without a separate architecture decision.

- Drift/SQLite is the persistence engine for the authoritative document store and relational analytics read models.
- Store hierarchical exercise, template/revision and session aggregates as versioned JSON documents in the Drift `documents` table through typed adapters and repositories. Keep database schema migrations distinct from document-format migrations.
- Treat source documents as authoritative. Analytics tables are derived/materialized read models and must be rebuildable from source history. Use domain events/projectors for incremental updates and a rebuild use case for recovery/import.
- Keep repository contracts oriented around domain/application needs. Infrastructure implements storage and platform details; presentation does not issue SQL or serialize storage documents.
- User/profile/preferences/goals/equipment/measurements are in the target design. The implementation plan's User feature is not yet marked started.

## Dependency composition and platform services

Use an explicit application composition root under `app/` to initialize platform capabilities and construct database, event dispatch, repositories, use cases and feature state providers. The current `main.dart` and Provider-based wiring predate this target and are transitional, not the target pattern. Avoid route-local ad hoc construction as modules are migrated; inject feature dependencies at the app boundary. No DI package is mandated by the implementation plan.

Authentication, notification and settings are planned rewrites. Keep authentication credentials in the security boundary, notification scheduling behind an infrastructure service, and settings as typed configuration/preferences with explicit persistence. Their detailed contracts and sequencing are not yet defined in `implementation-plan.md`; establish those during the relevant design/implementation phase rather than treating current service/provider code as precedent.

## Domain rules already established by the plan

- Template revisions are immutable after publication. Editing produces a new draft revision.
- Starting a session creates an independent copy of the selected template revision; live changes never mutate the template.
- Session lifecycle, rest intervals, interruptions, recovery and append-only audit history are explicit domain concepts.
- Persist session changes so interrupted workouts can be recovered after restart.
- Analytics are projections, not the editing source of truth.
- Portability is planned as versioned export/import with validation, sequential migrations, explicit conflict policy and analytics rebuild after import.

## Dependencies and code generation

Use dependencies already selected by the plan and present in the project: `flutter_bloc`/`bloc`, Drift, Freezed/JSON serialization, and `fl_chart` for visualizations. The plan also describes file picker and path provider for portability and isolate work for expensive tasks. Do not add dependencies just because they appear in a proposal; confirm the target feature needs them and check `pubspec.yaml`/lockfile. Avoid retaining dependencies used only by deprecated counter/timer code after that legacy cleanup is performed.

Edit source declarations, not generated files. Drift, Freezed, JSON serialization and Mockito artifacts are generated with `build_runner`; use `./scripts/generate.ps1` on PowerShell or the documented equivalent.

## Tests and validation

Organize tests under `test/core/` and `test/features/<feature>/` following the implementation plan and nearby current tests. Cover domain invariants, use cases/repositories, persistence, event-driven projections and presentation behavior at the appropriate boundary. The plan calls for an end-to-end workout and portability round-trip suite during hardening. Do not treat current full-suite failures in deprecated areas as a reason to reproduce their implementation patterns; record and address them as part of the migration.

- `./scripts/check.ps1`: analysis, format verification and Flutter tests.
- `./scripts/generate.ps1`: code generation.

## Status and source distinctions

The implementation plan marks phases 1–4 complete and phases 5–7 not started. Its own execution log reports legacy full-suite compile failures. These statuses are planning assertions, not independent verification of the current checkout. Inspect source and tests before describing a particular capability as complete. The implemented architecture document [`application-architecture.md`](application-architecture.md) and persona documents contain broader design/reference material; use the implementation plan and this target reference for direction, and verify details against code where behavior matters.

The implementation plan currently omits explicit design and sequencing for the settings, notification and authentication rewrites and uses a projected `app/` tree not yet reflected in `lib/`. Treat these as open plan gaps to resolve during refactoring, not as permission to retain legacy patterns.

## Updating this reference

Update this document and the implementation plan when target module boundaries, dependency decisions or rollout status change. Label facts as implemented, in progress or planned, and keep legacy code clearly marked as deprecated until its removal is complete.
