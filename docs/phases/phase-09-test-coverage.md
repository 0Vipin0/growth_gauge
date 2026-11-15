## 12. Phase 9: Test Coverage Expansion

This phase adds behavior-focused regression tests where they provide the most risk reduction. Existing coverage includes core primitives, feature acceptance tests, widgets, analytics performance, and one end-to-end workout/portability journey. The next step is to map untested critical behavior and failure paths rather than pursue a raw line-coverage target.

### 9.1 Coverage Strategy

- First inventory current tests and uncovered high-risk behavior; retain the existing `flutter_test`, Mockito, in-memory Drift, and integration-test conventions.
- Prioritize domain invariants and use-case/repository failure paths, persistence/migration boundaries, state transitions and recovery, user-visible loading/empty/error states, and cross-feature workflows.
- Prefer deterministic tests with controlled clocks, in-memory databases, explicit fakes, and stable fixtures. Avoid tests coupled to private implementation details or timing sleeps.
- Add widget tests for important interaction and accessibility semantics where they exercise behavior not already covered by feature acceptance tests.
- Run the current suite before and after each batch; use coverage output as a diagnostic to find unexercised behavior, not as the sole completion criterion.

### 9.2 Execution Status

| Step | Action | Status | Notes |
|---|---|---|---|
| **Step 9.1** | Build behavior-to-test inventory | `[x] COMPLETED` | Added `docs/test-coverage-inventory.md` mapping current critical behaviors, coverage locations, residual manual checks, and prioritized gaps. |
| **Step 9.2** | Expand domain and application tests | `[x] COMPLETED` | Added skip/delete state-transition and terminal-session retry coverage; existing template/session invariants and Cubit validation/error tests are recorded in the inventory. |
| **Step 9.3** | Expand repository and migration tests | `[x] COMPLETED` | Added on-disk Drift v1-to-v3 migration coverage, migration-registry rejection cases, malformed/future/empty-ID import no-write checks, overwrite handling, and typed equipment import. |
| **Step 9.4** | Expand widget and integration tests | `[x] COMPLETED` | Existing empty/active widget states are inventoried; extended the full workout/analytics/backup journey to assert tampered backup rejection preserves existing documents before successful restore. Route-specific behavior stays with Phase 10. |
| **Step 9.5** | Review coverage and test reliability | `[x] COMPLETED` | Reviewed `flutter test --coverage` diagnostically; targeted gaps in session set transitions and portability conflict/import branches were covered without a percentage gate. `scripts/check.ps1` passes analysis, format verification for 230 Dart files, and all 136 tests. New tests use fixed payloads, temporary/on-disk SQLite or in-memory Drift, and no timing thresholds. Hardware frame pacing remains a documented manual/release check. |

### 9.3 Acceptance Criteria

- Every documented critical domain rule and important user journey maps to at least one automated test or an explicitly recorded manual/release check.
- High-risk error, empty, boundary, and recovery paths identified by the inventory have appropriate regression tests.
- The full existing suite remains green, new tests are deterministic, and `scripts/check.ps1` passes; test-only performance/coverage reports do not become brittle timing gates.

---
