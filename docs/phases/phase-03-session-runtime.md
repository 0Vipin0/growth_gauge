## 6. Phase 3: Comprehensive Details (Active Session Runtime & Copy-on-Write Engine)

Phase 3 implements the live workout tracking engine: copy-on-write execution, deterministic state machines, rest/recovery timers, append-only audits, and crash recovery.

### 6.1 Key Architecture & Domain Rules
1. **Copy-on-Write Runtime Isolation:** A template revision is cloned into an independent `WorkoutSession` aggregate. Live session adjustments never mutate the template revision.
2. **State Machine:** `DRAFT` -> `STARTING` -> `IN_PROGRESS` <-> `PAUSED` -> `COMPLETING` -> `COMPLETED`.
3. **Interruption Tracking:** Wall-clock duration is distinguished from active training duration:
   $$\text{elapsedActiveSeconds} = \text{elapsedWallClockSeconds} - \sum \text{interruptionDurationSeconds}$$
4. **Append-Only Audit Log:** Every set edit or deletion appends an immutable `AuditEntry`.
5. **Crash Recovery:** Every set logged writes through to Drift; cold boot auto-detects uncompleted sessions and prompts recovery.
6. **Interval Timer:** The session runtime must support reusable work, rest, and cooldown intervals for timed circuits/HIIT, with explicit transitions, pause/resume, skip/extend rules, and persisted recovery state. This extends the existing rest timer; it must not revive the removed standalone legacy timer module.
7. **Daily Training Log:** A session/day may store optional mood, free-text notes, and perceived effort (RPE). These fields are persisted with the authoritative session/log record and projected to analytics where useful; RPE is optional and must not block session completion.
8. **Voice Guidance:** Interval templates may provide spoken phase/countdown cues using platform text-to-speech. TTS is optional, configurable, lifecycle-safe, and always paired with visible cues; workout completion must not depend on audio.

### 6.2 Phase 3 File Manifest
- `lib/features/session/domain/`: `workout_session.dart`, `session_block.dart`, `session_item.dart`, `execution_set.dart`, `rest_interval.dart`, `session_interruption.dart`, `audit_entry.dart`, `session_enums.dart`, `session_events.dart`.
- `lib/features/session/application/`: `session_use_cases.dart`, `workout_session_bloc.dart`.
- `lib/features/session/infrastructure/`: `session_document_adapter.dart`, `session_repository.dart`, `crash_recovery_service.dart`.
- `lib/features/session/presentation/`: `active_session_screen.dart`, `session_summary_screen.dart`, `active_exercise_card.dart`, `execution_set_row.dart`, `rest_timer_overlay.dart`, `plate_calculator_sheet.dart`, `session_recovery_dialog.dart`.
- Tests under `test/features/session/` verifying copy-on-write, state transitions, audit trail, and crash recovery.
- Extend session/template models and UI for interval blocks with work/rest/cooldown durations, optional voice cue settings, and daily-log fields (`mood`, `notes`, `RPE`). Keep interval timing distinct from the existing post-set rest policy.

### 6.3 Phase 3 Execution Status

| Step | Action | Status | Notes |
|---|---|---|---|
| **Step 3.1** | Session runtime domain snapshots and serialization | `[x] COMPLETED` | Added immutable session, block, item, execution set, rest interval, interruption, audit, and lifecycle enum models with JSON serialization. |
| **Step 3.2** | Copy-on-write from a template revision | `[x] COMPLETED` | `SessionUseCases.createFromRevision` snapshots template content into session-owned IDs, retains source block, item, and set IDs, and allows active-session target edits without changing the template. |
| **Step 3.3** | Persisted lifecycle state machine | `[x] COMPLETED` | Start, pause, resume, complete, cancel, abandon, app-background interruption, and interrupted `STARTING`/`COMPLETING` recovery persist. Completion timestamps and rest closures are saved before the `COMPLETING` transition so crash recovery preserves the intended finish time. Covered by session acceptance tests. |
| **Step 3.4** | Execution set logging and rest interval runtime | `[x] COMPLETED` | Supported measurements, set target edits, status validation, skip/delete, policy-driven rest auto-start/expiry, manual rest after a completed set, minimum skip duration, bounded extensions, and persisted per-set actual rest totals are implemented and covered by acceptance tests. |
| **Step 3.5** | Append-only audits and domain events | `[x] COMPLETED` | Set edits/deletion, rest creation/closure/deletion, and lifecycle actions append audit entries; lifecycle, rest completion/skip, and set completion/skip/delete events publish after persistence. Audit and event behavior is covered by acceptance tests. |
| **Step 3.6** | Session document repository and crash recovery query | `[x] COMPLETED` | Home cold-start and template flows offer recovery, unfinished-session lookup excludes drafts and scopes to the app's existing single local profile (`local-user`), interrupted transitions are repaired, and active sessions persist a pause on app background. Recovery and user scoping are covered by acceptance tests. The app has no account identity provider; multi-account identity integration is outside its current authentication model. |
| **Step 3.7** | Active session and recovery presentation | `[x] COMPLETED` | Active UI uses `WorkoutSessionBloc` to serialize command state, captures supported measurements, resolves exercise names, offers session target edits, deletion of planned and logged sets, cancel/abandon, manual and automatic rest controls, and recovery. Summary reports elapsed, active, and rest time. |
| **Step 3.8** | Session integration and acceptance checks | `[x] COMPLETED` | Session feature and summary-widget tests pass with the interval runtime suite (17/17); scoped session analysis reports no issues. The supplied full repository suite reports failures in other phases; those do not invalidate these scoped results. |
| **Step 3.9** | Persist daily session log | `[x] COMPLETED` | Summary Save Log persists optional notes, session RPE, and typed mood through `SessionUseCases`; completed-session guard, RPE range validation, audit append, and JSON round-trip are covered by a focused unit test. Summary initializes controls from persisted values. |
| **Step 3.10** | Persisted work/rest/cooldown interval runtime | `[x] COMPLETED` | Added a separate persisted interval schedule for work, between-round rest, and cooldown. The active screen supports setup, countdown, automatic phase advance, skip and 15-second extension. Workout pause/resume and cold-start recovery preserve checkpointed elapsed time; intervals are audited and publish domain events. Unit and widget tests cover phase order, persistence, pause/resume, extension, skip, expiry, and recovery. Optional spoken cues remain in Phase 15. |

### 6.4 Phase 3 Work Started (2026-09-26)

Implemented and verified Phase 3 session lifecycle, copy-on-write snapshots, set/rest commands, crash recovery, daily session logging, and explicit work/rest/cooldown intervals. Session notes, RPE, and mood persist through use cases; interval schedules persist phases, checkpoints, audit entries, and lifecycle transitions. The focused session unit/widget suites pass 17/17, scoped fatal analysis passes, and formatting reports no changes. The supplied full-repository baseline still has failures in other phases. Phase 3 scope is complete; optional spoken cues remain assigned to Phase 15.

---


## Audit status note — 2026-11-21

Phase 3 is complete for its scoped requirements (10/10 steps). Focused session tests and scoped fatal analysis pass. Optional spoken cues remain in Phase 15, while the repository-wide baseline remains failed (124 passed, 21 failed; analyzer 22 issues) due to other phases. See [the audit report](../audit-report.md) for global gate context and [master plan](../implementation-plan.md) for priorities.


## Serial test result — 2026-11-21

Both session summary widget assertions pass after scrolling the lazy timeline into view. The previous failures were test viewport assumptions, not a rendering defect. Exercise labels are still verified in both repository-resolved and slug-fallback cases.
