## 9. Phase 6: Comprehensive Details (Portability Engine, Export/Import & Migrations)

Phase 6 implements the external portability contract: versioned JSON export envelope, SHA-256 integrity verification, sequential schema migrations, and atomic import conflict resolution.

### 9.1 Architecture & Domain Rules

```text
Export File (.json)
        â”‚
        â–¼
1. Envelope & Manifest Validation
        â”‚
        â–¼
2. SHA-256 Checksum Verification
        â”‚
        â–¼
3. Sequential Migration Pipeline (v1 -> v2 -> v3)
        â”‚
        â–¼
4. Structural Domain Validation
        â”‚
        â–¼
5. Conflict Detection & User Resolution (Skip / Overwrite / Duplicate)
        â”‚
        â–¼
6. Atomic Drift Transaction (Persist Documents)
        â”‚
        â–¼
7. Rebuild Analytics Read Models (Automatic)
```

1. **Versioned External Contract (Section 32 & Rule 4):**
   - Export schema follows the envelope defined by the reference fixture [`docs/persona-worked-xample.json`](persona-worked-xample.json). The fixture's `sha256:example-only` value is illustrative and is recomputed when testing import:
     ```json
     {
       "manifest": {
         "formatVersion": 3,
         "exportedAt": "2026-09-24T09:15:00Z",
         "appVersion": "1.0.0",
         "generator": "growth-gauge-core",
         "checksum": "sha256:abc...",
         "featureFlags": ["REST_INTERVALS", "SESSION_RECOVERY", "RPE_RIR", "GOALS"]
       },
       "users": [],
       "profiles": [],
       "trainingProfiles": [],
       "preferences": [],
       "goals": [],
       "exercises": [],
       "templates": [],
       "revisions": [],
       "sessions": [],
       "measurements": []
     }
     ```
2. **Checksum Integrity:** Manifest contains SHA-256 computed over the serialized payload to detect file corruption.
3. **Sequential Migrations (Section 34 & Rule 12):**
   - Older backup formats (e.g. v1, v2) pass through chained transformers (`MigrationV1ToV2`, `MigrationV2ToV3`) before ingestion.
4. **Deterministic Conflict Resolution (Section 36):**
   - When an imported entity ID collides with an existing local entity:
     - `KEEP_EXISTING`: Discards incoming entity.
     - `OVERWRITE`: Replaces local document with incoming payload.
     - `DUPLICATE_WITH_NEW_ID`: Generates fresh UUIDs and updates all internal references.
5. **Post-Import Analytics Rebuild:**
   - Imports that add or replace workout sessions trigger `ProjectionRebuilder.rebuildAll()` after the authoritative documents commit. Phase 7 offloads portable CPU processing and session ordering; Drift projection I/O stays on the database isolate, with device frame profiling tracked as the remaining hardening check.
6. **CSV Export:** In addition to the versioned JSON archive used for backup/migration, provide CSV export for analysis in spreadsheet and data tools. CSV is a derived flat representation of activity/session, set metrics, and relevant timestamps/goals; document columns, units, escaping, and handling of optional values. JSON remains the lossless round-trip format.

---

### 9.2 Phase 6 File Manifest

```text
lib/
â””â”€â”€ features/
    â””â”€â”€ portability/
        â”œâ”€â”€ domain/
        â”‚   â”œâ”€â”€ export_manifest.dart           # Manifest model (version, checksum, flags)
        â”‚   â”œâ”€â”€ export_envelope.dart           # Top-level JSON archive structure
        â”‚   â”œâ”€â”€ import_report.dart             # Statistics of imported vs conflicted items
        â”‚   â””â”€â”€ conflict_strategy.dart         # ConflictResolutionStrategy enum
        â”‚
        â”œâ”€â”€ application/
        â”‚   â”œâ”€â”€ export_data_use_case.dart      # Generates envelope & computes SHA-256
        â”‚   â”œâ”€â”€ import_data_use_case.dart      # Full validation, migration & import pipeline
        â”‚   â””â”€â”€ portability_cubit.dart         # UI state for export/import progress
        â”‚
        â”œâ”€â”€ migration/
        â”‚   â”œâ”€â”€ migration_registry.dart        # Chains sequential migration steps
        â”‚   â”œâ”€â”€ migration_step.dart            # Base interface: Future<Map> migrate(Map data)
        â”‚   â”œâ”€â”€ steps/
        â”‚   â”‚   â”œâ”€â”€ migration_v1_to_v2.dart    # Migration example from v1 to v2
        â”‚   â”‚   â””â”€â”€ migration_v2_to_v3.dart    # Migration example from v2 to v3
        â”‚   â””â”€â”€ checksum_validator.dart        # Crypto SHA-256 verification
        â”‚
        â”œâ”€â”€ infrastructure/
        â”‚   â””â”€â”€ file_storage_service.dart      # File picker based JSON read/write
        â”‚
        â””â”€â”€ presentation/
            â”œâ”€â”€ screens/
            â”‚   â””â”€â”€ backup_restore_screen.dart # JSON export/import and CSV export actions, file picker, and progress indicator
            â””â”€â”€ widgets/
                â””â”€â”€ conflict_resolution_dialog.dart # Modal presenting detected collisions
```

---

### 9.2.1 CSV Export Requirements

CSV export is an additional analysis-oriented output; the existing JSON archive remains the backup and restore format.

| Step | Action | Status | Notes |
|---|---|---|---|
| **Step 6.6** | Implement CSV activity/session export | `[ ] PLANNED` | Export relevant activity/session data in CSV for analysis. Exact columns, units, and selection options: **NA â€” not specified in the legacy feature source**. JSON remains the backup/restore format. |
| **Step 6.7** | Validate CSV output | `[ ] PLANNED` | Test CSV formatting and handling of empty or optional values. Detailed compatibility requirements: **NA â€” not specified in the legacy feature source**. |

### 9.3 Phase 6 Verification & Acceptance Criteria

| Component | Test Case | Success Criteria |
|---|---|---|
| **Export Validity** | Schema conformance | Exported JSON contains the version 3 manifest and all declared payload arrays; checksum matches the serialized payload. |
| **Checksum Verification** | Tamper detection | Modifying the JSON payload causes `ChecksumValidator` to reject import with `FormatException` before any documents are written. |
| **Fixture Ingestion** | Ingestion of reference fixture | Importing `docs/persona-worked-xample.json` succeeds after recomputing its illustrative checksum; records are normalized and typed before the atomic write. Session imports invoke the analytics rebuild callback. |
| **Conflict Resolution** | `DUPLICATE_WITH_NEW_ID` check | Importing an existing routine with duplicate strategy produces an independent routine with remapped block/set IDs. |

**Additional acceptance requirements:** Keep CSV export separate from JSON backup/restore. 

**Implemented:** Export, SHA-256 validation, chained v1â†’v2â†’v3 migration, typed payload validation, Drift transaction import, keep/overwrite/duplicate conflict strategies, reference-fixture normalization, file picker UI, and analytics rebuild wiring. Focused coverage lives in `test/features/portability/portability_test.dart`. The fixture test recalculates its placeholder checksum; unmodified placeholder fixtures are rejected as designed. Analytics rebuilding occurs after document commit, so a projection failure does not roll back the imported source documents.

**Legacy parity addition:** Add CSV export as a separate analysis-oriented output, not a replacement for JSON backup/restore. 

---
