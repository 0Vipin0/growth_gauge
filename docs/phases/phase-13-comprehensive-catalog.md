## 16. Phase 13: Comprehensive Exercise Catalog

Expand the existing catalog seed data into a broad, balanced, searchable exercise library that exercises the taxonomy and measurement model already implemented. The deliverable is a high-quality maintained catalog with verified classifications, equipment, instructions, and metrics, rather than an uncurated maximum-count list. Preserve custom user-created exercises and the current idempotent catalog seeding behavior.

### 13.1 Catalog Coverage and Data Rules

- Build a coverage matrix across movement patterns, body regions, primary/secondary muscle groups, equipment, and supported measurement profiles; identify meaningful combinations currently missing from seed data.
- Include varied exercise families where supported by the current domain: compound and isolation strength, bodyweight, barbell/dumbbell/kettlebell, cable, machine, bands, conditioning/cardio, mobility, and power/plyometric movements. Do not force categories the domain cannot represent; record any model changes as a separate justified design decision.
- Provide consistent names, concise execution instructions, setup/safety cues where appropriate, aliases/search terms, equipment requirements, classification, and measurement fields required by the existing execution model.
- Review classification and metric values for consistency, duplicate entries, unsuitable measurements, and invalid relationships. Add alternatives/regressions/progressions only when the relationship is meaningful and valid.
- Keep seed data versioned, deterministic, and offline-first. Seeding must remain idempotent, must not overwrite user edits or custom exercises, and must define how newly added/updated system entries are reconciled on an existing installation.
- Track data provenance and licensing for any externally sourced descriptions or media; use original/appropriately licensed text and do not add images or network dependencies without a separate requirement.

### 13.2 Execution Status

| Step | Action | Status | Notes |
|---|---|---|---|
| **Step 13.1** | Audit current seed library and taxonomy | `[ ] PLANNED` | Count and classify current seeded exercises; identify supported taxonomy gaps and duplicate/weak records. |
| **Step 13.2** | Define coverage matrix and metadata standard | `[ ] PLANNED` | Establish category coverage, required fields, naming/search conventions, and provenance rules. |
| **Step 13.3** | Curate and validate exercise entries | `[ ] PLANNED` | Add balanced exercise families with consistent instructions, classifications, equipment, metrics, and valid relationships. |
| **Step 13.4** | Reconcile versioned seed data safely | `[ ] PLANNED` | Ensure repeat seeding and upgrades add/update system-owned records without overwriting custom or user-modified data. |
| **Step 13.5** | Add catalog quality and seeding tests | `[ ] PLANNED` | Verify taxonomy coverage, uniqueness, serialization, filter/search behavior, relationship integrity, and idempotent upgrade behavior. |
| **Step 13.6** | Review catalog usability and documentation | `[ ] PLANNED` | Confirm catalog browsing/filtering remains usable and document coverage, provenance, and known taxonomy limitations. |
| **Step 13.7** | Exercise step-by-step guidance and custom step builder | `[ ] PLANNED` | Display structured sequential steps (`setupInstructions` and `executionInstructions`) as numbered steps with an interactive timeline/stepper in `ExerciseDetailScreen`. Update `CustomExerciseScreen` with a dynamic step builder (add/remove/reorder steps), and surface step-by-step guidance cues in the active workout session HUD modal. |

### 13.3 Acceptance Criteria

- The maintained catalog has a reviewed coverage matrix spanning each supported movement pattern, body region, equipment family, and measurement profile, with gaps explicitly justified.
- Every seeded record passes validation for unique stable identity, required fields, valid classifications/metrics, and any referenced exercise relationships.
- Seeding is repeatable and upgrade-safe, preserving user-created exercises and user edits while making new system entries available offline.
- Search/filter and catalog detail behavior remain usable with the larger dataset; automated tests cover seed integrity, filters, and upgrade safety.

---
