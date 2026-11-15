## 11. Phase 8: Consistent Structure & Maintainability

This phase reduces structural drift across the existing feature-first codebase. It is an incremental consistency pass, not a wholesale rewrite: retain the domain/application/infrastructure/presentation boundaries already used by the core fitness features and migrate transitional settings, authentication, and notification code only where a concrete inconsistency or maintenance cost is found.

### 8.1 Scope and Rules

- Inventory representative files in catalog, template, session, analytics, user, portability, settings, authentication, and notification before proposing moves or renames.
- Establish and document practical conventions for file/folder naming, public feature APIs, imports, state naming, repository/use-case boundaries, dependency construction, error handling, and generated-file ownership.
- Keep domain code independent of Flutter and persistence. Keep widgets focused on rendering and user interaction; place feature operations in application code and platform/storage details in infrastructure.
- Reuse existing `Result`, Drift adapters/repositories, Cubit/BLoC, and app-level dependency composition patterns where applicable. Do not add empty layers, wrappers, DI frameworks, or broad renames for cosmetic uniformity.
- Make changes in small feature-scoped batches. Update `docs/architecture.md` when a real boundary or target convention changes; update this plan's tracker only as work is completed.

### 8.2 Execution Status

| Step | Action | Status | Notes |
|---|---|---|---|
| **Step 8.1** | Baseline structure and convention inventory | `[x] COMPLETED` | Confirmed consistent layered boundaries in catalog, template, session, analytics, user, and portability; found authentication presentation/service and notification platform service at feature roots. Settings remains transitional as planned. |
| **Step 8.2** | Agree on maintainable conventions | `[x] COMPLETED` | Documented file/test naming, layer ownership and dependency direction, imports/public APIs, composition, errors, and generated-file ownership in `docs/architecture.md`. |
| **Step 8.3** | Normalize high-value inconsistencies | `[x] COMPLETED` | Moved authentication screens to `presentation/` and its service plus notification service to `infrastructure/`; updated feature exports and call sites without changing behavior. Deferred settings/provider, direct auth construction, and route composition to their assigned migration phases. |
| **Step 8.4** | Validate each refactor batch | `[x] COMPLETED` | Regenerated Mockito mocks, formatted all changed Dart files, and ran `scripts/check.ps1`: analysis passed with no issues, all 229 Dart files passed format verification, and all 127 tests passed. |
| **Step 8.5** | Architecture and change review | `[x] COMPLETED` | Reviewed imports, dependency direction, source/generated ownership, docs, and scope. No new dependencies, abstractions, or unrelated changes. |

### 8.3 Acceptance Criteria

- New and modified code has clear, predictable placement and naming, following the conventions documented in the repository.
- No business logic is moved into widgets, no storage/UI dependencies are introduced into domain types, and feature boundaries remain understandable.
- Each structural refactor has regression protection appropriate to its behavior and passes the relevant checks.
- Any intentionally retained legacy/transitional pattern is documented with its migration trigger; unrelated files are not reformatted or moved.

---
