## 4. Phase 1: Comprehensive Details (Dependencies & Core Foundation)

Phase 1 establishes the bedrock for the entire architecture: type-safe core primitives, domain event bus, and the authoritative Drift document store.

### 4.1 Dependency Configuration (`pubspec.yaml`)
```yaml
dependencies:
  # State Management
  flutter_bloc: ^9.0.0
  bloc: ^9.0.0
  equatable: ^2.0.7

  # Persistence Engine (Authoritative Store & Materialized Read Models)
  drift: ^2.24.2
  sqlite3_flutter_libs: ^0.5.28
  drift_flutter: ^0.2.4
  path: ^1.9.1

dev_dependencies:
  # Drift Code Generation
  drift_dev: ^2.24.2
```

### 4.2 Phase 1 File Manifest
- `lib/core/ids/unique_id.dart`: Value object wrapping UUIDv4 with validation and equality.
- `lib/core/time/app_clock.dart`: Deterministic clock abstraction producing ISO-8601 UTC strings.
- `lib/core/error/failures.dart`: `Failure`, `DatabaseFailure`, `NotFoundFailure`, `ValidationFailure`, `ConflictFailure`.
- `lib/core/error/result.dart`: Functional sealed monad `Result<T, Failure>` with `Success` and `Error`.
- `lib/core/units/unit_types.dart`: `WeightUnit`, `DistanceUnit`, `HeightUnit`, `TemperatureUnit`.
- `lib/core/units/unit_converter.dart`: Bidirectional conversions between canonical units (kg, m, cm, Â°C) and display units.
- `lib/core/events/domain_event.dart`: Base `DomainEvent` with `eventId`, `occurredAt`, `aggregateId`, and `eventType`.
- `lib/core/events/domain_event_dispatcher.dart`: In-memory broadcast stream dispatcher with typed subscriptions.
- `lib/core/database/tables/documents_table.dart`: Drift `documents` table definition with composite primary key `(collection, id)`.
- `lib/core/database/app_database.dart`: Main Drift database class with in-memory factory constructor.
- `lib/core/database/document_adapter.dart`: `DocumentAdapter<T>` contract for JSON serialization.
- `lib/core/database/document_store.dart`: Generic `IDocumentStore<T>` interface.
- `lib/core/database/drift_document_store.dart`: Drift-backed implementation of `IDocumentStore<T>`.
- `lib/core/database/app_database.g.dart`: Generated Drift database code.

### 4.3 Phase 1 Execution Log & Step Status

| Step | Action | Status | Notes |
|---|---|---|---|
| **Step 1.1** | Configure Dependencies | `[x] COMPLETED` | Added current Drift dependencies (`drift`/`drift_dev: ^2.35.1`, `drift_flutter: ^0.3.1`, `sqlite3_flutter_libs: ^0.6.0+eol`) alongside `flutter_bloc: ^9.1.1`, `bloc: ^9.2.1`, `equatable: ^2.0.7`, and `path: ^1.9.1`. Upgraded code generation to Freezed `^4.0.2`; removed the unused `build_test: any` constraint that prevented analyzer 14 and Flutter SDK test tooling from resolving together. |
| **Step 1.2** | Core Primitives | `[x] COMPLETED` | Implemented `UniqueId`, `AppClock`, `Failure` hierarchy, `Result<T, Failure>` monad, and `UnitConverter`. |
| **Step 1.3** | Domain Event Dispatcher | `[x] COMPLETED` | Implemented `DomainEvent` and `DomainEventDispatcher` with asynchronous typed subscription handling. |
| **Step 1.4** | Drift Document Store | `[x] COMPLETED` | Defined `Documents` table, `AppDatabase`, `DocumentAdapter<T>`, `IDocumentStore<T>`, and `DriftDocumentStore<T>`. |
| **Step 1.5** | Code Generation | `[x] COMPLETED` | Generated `lib/core/database/app_database.g.dart` via `build_runner`. |
| **Step 1.6** | Test Verification Suite | `[x] COMPLETED` | Implemented 6 test suites across `test/core/`. **27/27 test cases passed (100% success rate)**. |

### 4.4 Phase 1 Test Verification Results

All 27 test cases passed with zero failures in `test/core/`:
- **`test/core/database/drift_document_store_test.dart` (7 tests)**:
  - `upsert and getById retrieve stored entity accurately` (PASSED)
  - `getById returns NotFoundFailure when entity does not exist` (PASSED)
  - `second upsert with same ID updates entity in-place without duplicating rows` (PASSED)
  - `getAll returns all entities in the collection` (PASSED)
  - `delete removes entity from document store` (PASSED)
  - `watchAll emits reactive updates when documents are added` (PASSED)
  - `clearCollection deletes all entities in collection` (PASSED)
- **`test/core/events/domain_event_dispatcher_test.dart` (2 tests)**:
  - `dispatches events to typed subscribers` (PASSED)
  - `cancelled subscription does not receive subsequent events` (PASSED)
- **`test/core/ids/unique_id_test.dart` (4 tests)**:
  - `generate() creates a valid UUIDv4` (PASSED)
  - `from() preserves valid custom IDs` (PASSED)
  - `from() throws ArgumentError for empty or whitespace-only strings` (PASSED)
  - `equality holds for matching values` (PASSED)
- **`test/core/time/app_clock_test.dart` (4 tests)**:
  - `nowUtc() always produces DateTime with isUtc true` (PASSED)
  - `nowIsoUtc() produces ISO-8601 UTC timestamp` (PASSED)
  - `deterministic clock testing using withClock` (PASSED)
  - `parseIsoUtc and formatIsoUtc roundtrip` (PASSED)
- **`test/core/units/unit_converter_test.dart` (6 tests)**:
  - `weight conversions roundtrip with minimal floating-point deviation` (PASSED)
  - `weightToCanonical and weightFromCanonical obey unit selection` (PASSED)
  - `formatWeight produces clean human-readable output` (PASSED)
  - `distance conversions roundtrip correctly` (PASSED)
  - `height conversions (cm to feet/inches) roundtrip accurately` (PASSED)
  - `temperature conversions` (PASSED)
- **`test/core/error/result_test.dart` (4 tests)**:
  - `Success holds data and returns true for isSuccess` (PASSED)
  - `Error holds failure and returns true for isError` (PASSED)
  - `flatMap chains operations correctly` (PASSED)
  - `Failures equality and toString behavior` (PASSED)

---
