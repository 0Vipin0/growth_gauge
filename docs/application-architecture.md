# Application Architecture 

**Document status:** Working Architecture Reference  
**Purpose:** Canonical system design combining the architectural structure, object model, import/export strategy, and the expanded domain model from the current .

---

## 1. Executive Summary

This document defines a application core architecture supporting:

- rich exercise cataloging;
- reusable workout templates;
- immutable template revisions;
- user profiles, goals, preferences, equipment and measurements;
- active workout sessions;
- copy-on-write session execution;
- first-class rest and recovery tracking;
- session interruption and recovery;
- append-only audit history;
- domain events;
- statistics and interactive visualizations;
- materialized analytics;
- versioned export/import;
- schema migration;
- deterministic conflict resolution;
- crash recovery and analytics rebuild.

The architecture retains the original architectural principle:

> **Use a document-oriented model as the authoritative source for hierarchical workout definitions and execution history, and a materialized relational model for fast analytics and visualization.**

The system should initially be implemented as a **modular monolith using clean architecture**. Module boundaries should be explicit enough that synchronization or server-side services can be introduced later without redesigning the core domain.

---

# 2. Architectural Principles

## 2.1 Source of truth vs read models

The authoritative domain consists of:

- users and their configuration;
- exercise definitions;
- workout templates and revisions;
- workout sessions;
- execution history;
- audit history;
- historical measurements.

Analytics are derived data.

```text
Authoritative Domain
        │
        ▼
 Domain Events
        │
        ▼
Analytics Projectors
        │
        ▼
SQLite / IndexedDB Read Models
        │
        ▼
Charts / Statistics
```

Analytics can therefore be deleted and rebuilt without losing workout history.

## 2.2 Four categories of information

The domain explicitly separates:

| Category | Examples |
|---|---|
| Definition | Exercise, equipment, template revision |
| Configuration | User preferences, goals, equipment inventory |
| Historical/runtime facts | Session, execution set, rest, interruption, audit |
| Derived facts | Volume, PRs, progression, goal progress |

This prevents large "god objects" and makes evolution safer.

## 2.3 Historical correctness

Historical workout meaning must not change because a catalog item or template changes later.

Therefore:

- published template revisions are immutable;
- completed sessions retain the template revision used;
- relevant exercise/category context is snapshotted when required;
- audit history is append-only;
- historical measurements are immutable;
- derived analytics are rebuildable.

---

# 3. High-Level Architecture

```text
                         ┌──────────────────────────────┐
                         │          UI / API            │
                         └──────────────┬───────────────┘
                                        │
                         ┌──────────────▼───────────────┐
                         │       Application Layer      │
                         │ Commands / Queries / DTOs    │
                         └──────────────┬───────────────┘
                                        │
          ┌─────────────────────────────┼──────────────────────────┐
          │                             │                          │
          ▼                             ▼                          ▼
 ┌────────────────┐            ┌────────────────┐         ┌────────────────┐
 │ Domain Modules │            │ Portability    │         │ Analytics      │
 │                │            │                │         │ Query/Project  │
 │ User           │            │ Export         │         │                │
 │ Exercise       │            │ Import         │         │ Projectors     │
 │ Template       │            │ Migration      │         │ Read Services  │
 │ Session        │            │ Conflicts      │         │                │
 └───────┬────────┘            └───────┬────────┘         └───────┬────────┘
         │                             │                          │
         ▼                             ▼                          ▼
 ┌────────────────┐            ┌────────────────┐         ┌────────────────┐
 │ Repositories   │            │ Import Engine  │         │ SQLite /       │
 │ / Transactions │            │                │         │ IndexedDB      │
 └───────┬────────┘            └───────┬────────┘         └────────────────┘
         │                             │
         ▼                             ▼
 ┌─────────────────────────────────────────────────────────────────────────┐
 │                 Document / KV / NoSQL Authoritative Store               │
 └─────────────────────────────────────────────────────────────────────────┘
```

---

# 4. Module Structure

```text
fitness/
│
├── user/
│   ├── domain/
│   ├── application/
│   └── persistence/
│
├── exercise/
│   ├── domain/
│   ├── application/
│   └── persistence/
│
├── template/
│   ├── domain/
│   ├── application/
│   └── persistence/
│
├── session/
│   ├── domain/
│   ├── application/
│   └── persistence/
│
├── analytics/
│   ├── projection/
│   ├── queries/
│   └── persistence/
│
├── portability/
│   ├── export/
│   ├── import/
│   ├── migration/
│   └── conflict/
│
└── shared/
    ├── ids/
    ├── time/
    ├── validation/
    ├── events/
    ├── authorization/
    └── persistence/
```

Dependency direction:

```text
UI/API
  ↓
Application
  ↓
Domain
  ↓
Repository / Infrastructure adapters
```

The domain must not depend directly on JSON, SQLite, IndexedDB, UI frameworks, or transport protocols.

---

# 5. Persistence Architecture

## 5.1 Authoritative document store

Use JSON/KV or a document/NoSQL store for:

- User domain aggregates;
- exercises;
- templates;
- template revisions;
- workout sessions;
- audit history;
- runtime execution state.

The document model is appropriate because these structures are hierarchical and evolve over time.

## 5.2 Materialized relational analytics

Use SQLite/IndexedDB for:

- workout history;
- progression;
- volume;
- frequency;
- personal records;
- rest statistics;
- muscle/category breakdowns;
- goal progress.

The relational model is optimized for filtering, grouping, indexing and visualization.

## 5.3 Consistency rule

Never use analytics tables as the source of truth for editing a workout.

```text
Session Document
      │
      ▼
Analytics Projection
      │
      ▼
SQLite Read Model
```

---

# 6. User Domain Module

The User module is a first-class domain boundary.

```text
User
├── Account
├── Profile
├── TrainingProfile
├── WorkoutPreferences
├── TrainingGoals
├── EquipmentInventory
├── ExercisePreferences
└── Measurements
```

## 6.1 UserAccount

```text
UserAccount
{
    id
    status
    createdAt
    updatedAt
    lastActiveAt
}
```

Statuses:

```text
ACTIVE
SUSPENDED
DELETED
PENDING
```

Authentication credentials should remain in the security/authentication subsystem rather than the fitness domain.

## 6.2 UserProfile

```text
UserProfile
{
    userId

    displayName
    firstName
    lastName

    dateOfBirth
    profileImageId

    timezone
    locale

    unitPreferences

    createdAt
    updatedAt
}
```

Unit preferences:

```text
UnitPreferences
{
    weight: KG | LB
    distance: KM | MI
    height: CM | FT_IN
    temperature: C | F
}
```

The domain should use canonical units internally and convert at the presentation boundary.

## 6.3 TrainingProfile

```text
TrainingProfile
{
    userId

    trainingExperience
    primaryTrainingStyle

    preferredSessionDurationMinutes
    preferredTrainingDays[]

    experienceByCategory[]

    notes

    updatedAt
}
```

Experience:

```text
BEGINNER
INTERMEDIATE
ADVANCED
```

## 6.4 WorkoutPreferences

```text
WorkoutPreferences
{
    userId

    defaultRestSeconds
    defaultWarmupEnabled
    defaultCooldownEnabled

    autoStartRestTimer

    soundEnabled
    vibrationEnabled
    keepScreenAwake

    showRpe
    showRir

    defaultSessionDurationMinutes
}
```

Preferences are configuration and must not overwrite historical session facts.

---

# 7. User Goals

Goals are independent aggregates/records.

```text
TrainingGoal
{
    id
    userId

    type
    name
    description

    startValue
    targetValue
    unit

    startDate
    targetDate

    status

    createdAt
    completedAt
}
```

Goal types:

```text
STRENGTH
ENDURANCE
WORKOUT_FREQUENCY
VOLUME
REPETITION
DURATION
DISTANCE
CUSTOM
```

Goal progress is derived from authoritative workout and measurement history.

---

# 8. User Equipment

```text
UserEquipment
{
    id
    userId

    equipmentType
    name
    quantity
    available

    properties
    notes
}
```

Example:

```text
Adjustable Dumbbell
{
    minWeightKg
    maxWeightKg
    incrementKg
}
```

This allows future queries such as:

```text
"Which workouts can I perform with my current equipment?"
```

---

# 9. User Exercise Preferences

Do not mutate the global exercise catalog for personal preferences.

```text
UserExercisePreference
{
    userId
    exerciseId

    favorite
    hidden
    preferred

    personalNotes

    defaultWeight
    defaultRepRange

    updatedAt
}
```

---

# 10. User Measurements

Measurements are time-series historical facts.

```text
UserMeasurement
{
    id
    userId

    type
    value
    unit

    recordedAt
    source
    notes
}
```

Types:

```text
BODY_WEIGHT
BODY_FAT_PERCENT
WAIST
CHEST
ARM
THIGH
CUSTOM
```

Never store only a mutable `currentWeight` field when historical trends are required.

---

# 11. Exercise Catalog

The exercise catalog is a reusable global/user-owned definition system.

```text
Exercise
├── Identity
├── Ownership / Versioning
├── Classification
├── Execution
├── Equipment
├── Measurement
├── Programming
├── Relationships
└── Media
```

## 11.1 Exercise identity

```text
Exercise
{
    id
    name
    aliases[]
    description
    status

    sourceType
    createdById

    forkedFromExerciseId
    version

    createdAt
    updatedAt
}
```

Statuses:

```text
DRAFT
ACTIVE
ARCHIVED
```

Ownership/source:

```text
SYSTEM
USER_CREATED
USER_FORKED
```

System exercises are read-only to ordinary users.

## 11.2 Exercise classification

Use structured taxonomy rather than a single category.

```text
ExerciseClassification
{
    bodyRegions[]
    primaryMuscles[]
    secondaryMuscles[]
    movementPatterns[]
    exerciseTypes[]
    laterality
}
```

Examples:

```text
Body region:
UPPER_BODY
LOWER_BODY
FULL_BODY
CORE

Movement:
HORIZONTAL_PUSH
VERTICAL_PUSH
HORIZONTAL_PULL
VERTICAL_PULL
SQUAT
HINGE
LUNGE
CARRY
ROTATION
```

## 11.3 Exercise execution

```text
ExerciseExecutionProfile
{
    setupInstructions[]
    executionInstructions[]
    breathingInstructions
    techniqueCues[]

    tempo
    rangeOfMotion
}
```

## 11.4 Equipment requirements

```text
ExerciseEquipmentProfile
{
    requiredEquipment[]
    optionalEquipment[]
}
```

## 11.5 Exercise relationships

```text
ExerciseRelationship
{
    sourceExerciseId
    targetExerciseId

    type
    reason
}
```

Types:

```text
ALTERNATIVE
REGRESSION
PROGRESSION
VARIATION_OF
WARMUP_FOR
COOLDOWN_FOR
```

## 11.6 Measurement profile

```text
ExerciseMeasurementProfile
{
    defaultMetricType
    supportedMetricTypes[]

    supportsWeight
    supportsReps
    supportsDuration
    supportsDistance
    supportsCalories

    supportsRpe
    supportsRir
    supportsTempo
}
```

Metric types can include:

```text
WEIGHT_AND_REPS
TIME_BASED
COUNT_BASED
DISTANCE_BASED
CALORIES
PACE
```

---

# 12. Workout Templates

A workout template is a reusable program definition.

```text
WorkoutTemplate
{
    id
    name
    description

    currentRevisionId

    createdById
    createdAt
    updatedAt
}
```

## 12.1 Immutable template revisions

```text
WorkoutTemplateRevision
{
    id
    templateId
    revisionNumber

    blocks[]

    createdById
    createdAt

    changeSummary
}
```

Published revisions are immutable.

```text
Template
   │
   ├── Revision 1 — archived
   ├── Revision 2 — archived
   └── Revision 3 — current
```

A completed session references the exact revision used.

---

# 13. Workout Block

```text
WorkoutBlock
{
    id
    name
    type

    rounds

    timing:
    {
        timeCapSeconds
        transitionSeconds
    }

    completion:
    {
        roundsRequired
        durationTarget
        repetitionsTarget
    }

    items[]
}
```

Block types:

```text
STANDARD
SUPERSET
TRISET
CIRCUIT
AMRAP
EMOM
FOR_TIME
TABATA
WARMUP
COOLDOWN
REST
```

The block model should remain data-driven instead of introducing an inheritance class for every workout format.

---

# 14. Template Item

```text
TemplateItem
{
    id

    exerciseId

    order

    targets[]
    notes

    substitutionRules[]
}
```

An item can reference an exercise and one or more target sets.

---

# 15. Target Set

```text
TargetSet
{
    id
    setNumber
    setType

    target:
    {
        weight
        repetitions
        durationSeconds
        distance
        calories
    }

    intensity:
    {
        targetRpe
        targetRir
        percentageOf1Rm
    }

    tempo:
    {
        eccentricSeconds
        pauseSeconds
        concentricSeconds
    }

    rest:
    {
        policyId
        plannedSeconds
    }

    notes
}
```

Set types:

```text
WARMUP
WORKING
BACKOFF
DROP_SET
AMRAP
FAILURE
COOLDOWN
OTHER
```

---

# 16. Rest and Recovery Model

Rest must be modeled independently from target sets because actual rest is historical runtime data.

## 16.1 RestPolicy

```text
RestPolicy
{
    id
    name

    minimumSeconds
    targetSeconds
    maximumSeconds

    startTrigger
    completionTrigger

    allowSkip
    allowExtend

    notes
}
```

## 16.2 RestInterval

```text
RestInterval
{
    id
    sessionId

    precedingSetId
    followingSetId

    plannedDurationSeconds
    actualDurationSeconds

    startedAt
    endedAt

    reason
    status
}
```

Reasons:

```text
PLANNED
EARLY_RETURN
EXTENDED_REST
EQUIPMENT_WAIT
COACHING
INTERRUPTION
UNKNOWN
```

This supports rest compliance and recovery analytics.

---

# 17. Workout Session

A workout session is the historical execution of a specific template revision.

```text
WorkoutSession
{
    id
    userId

    templateId
    templateRevisionId

    status

    startedAt
    pausedAt
    resumedAt
    completedAt

    currentBlockId
    currentItemId
    currentSetId

    elapsedActiveSeconds
    elapsedWallClockSeconds

    deviceId
    applicationVersion

    sessionNotes

    blocks[]
    interruptions[]
    restIntervals[]
    audits[]
}
```

---

# 18. Session Lifecycle

Recommended state machine:

```text
DRAFT
  │
  ▼
STARTING
  │
  ▼
IN_PROGRESS ◄─────────────┐
  │                       │
  │ pause                 │ resume
  ▼                       │
PAUSED ───────────────────┘
  │
  ├──────────────► CANCELLED
  │
  ├──────────────► ABANDONED
  │
  ▼
COMPLETING
  │
  ▼
COMPLETED
```

A `RECOVERABLE` state can be used when the application detects an interrupted session that can safely be resumed.

---

# 19. Session Interruption

```text
SessionInterruption
{
    id

    startedAt
    endedAt
    durationSeconds

    reason
    userInitiated
}
```

Reasons:

```text
USER_PAUSE
APPLICATION_BACKGROUND
PHONE_CALL
EQUIPMENT_PROBLEM
OTHER
```

This allows active training time to be distinguished from wall-clock session duration.

---

# 20. Runtime Session Hierarchy

The runtime copy-on-write hierarchy is:

```text
WorkoutSession
    │
    ├── SessionBlock
    │       │
    │       └── SessionItem
    │               │
    │               └── ExecutionSet
    │
    ├── RestInterval
    ├── SessionInterruption
    ├── AuditLog
    └── Domain Events
```

When a session starts, the relevant template revision is copied into a session-owned runtime structure.

The user can then modify session targets without mutating the template.

---

# 21. Execution Set

```text
ExecutionSet
{
    id
    setNumber
    setType

    actual:
    {
        weight
        repetitions
        durationSeconds
        distance
        calories
    }

    intensity:
    {
        rpe
        rir
    }

    tempo:
    {
        eccentricSeconds
        pauseSeconds
        concentricSeconds
    }

    startedAt
    completedAt

    status
    notes

    plannedRestSeconds
    actualRestSeconds

    audits[]
}
```

The model should permit partially populated measurements according to the exercise measurement profile.

---

# 22. Audit Model

Audit history is append-only.

```text
AuditLog
{
    id

    timestamp

    actorType
    actorId

    action

    entityType
    entityId

    field

    previousValue
    newValue

    reason
    correlationId
}
```

Example:

```text
ExecutionSet.completedReps
    4 → 5

actorType:
    USER

reason:
    Corrected entry
```

Audit entries should never be overwritten.

---

# 23. Domain Events

Domain events are separate from audits.

Examples:

```text
WorkoutSessionStarted
WorkoutSessionPaused
WorkoutSessionResumed
ExecutionSetCompleted
RestStarted
RestCompleted
WorkoutSessionCompleted
TemplateRevisionCreated
GoalCompleted
MeasurementRecorded
```

Events are useful for triggering application behavior and analytics projections.

Audit logs preserve change history.

---

# 24. Session Completion

Completion should be a transactional application operation:

```text
CompleteWorkoutSession
        │
        ├── validate session
        ├── finalize execution
        ├── calculate duration
        ├── append completion event
        ├── persist session
        └── enqueue/project analytics
```

The session remains authoritative even if analytics projection fails.

---

# 25. Analytics Architecture

Analytics are materialized from completed sessions.

```text
Completed Session
       │
       ▼
SessionCompleted
       │
       ▼
Analytics Projector
       │
       ├── daily summary
       ├── exercise metrics
       ├── progression
       ├── volume
       ├── frequency
       ├── personal records
       ├── rest statistics
       ├── muscle breakdown
       └── goal progress
```

Projection must be idempotent.

A session projected twice must not duplicate analytics.

---

# 26. Analytics Read Models

Recommended tables/read models:

```text
daily_workout_summary
exercise_set_metrics
exercise_progression
weekly_training_summary
muscle_group_volume
personal_records
rest_statistics
session_performance
goal_progress
measurement_history
```

## 26.1 Daily workout summary

```text
daily_workout_summary
----------------------
user_id
workout_date
sessions
total_duration_seconds
active_duration_seconds
total_sets
total_volume
```

## 26.2 Exercise set metrics

```text
exercise_set_metrics
---------------------
user_id
session_id
exercise_id
set_id

completed_at

weight
repetitions
duration_seconds
distance
calories

rpe
rir

volume
estimated_1rm
```

Recommended indexes:

```text
(user_id, workout_date)
(user_id, exercise_id, completed_at)
(session_id)
```

---

# 27. Personal Records

```text
PersonalRecord
{
    userId
    exerciseId

    recordType
    value
    unit

    achievedAt
    sessionId
    setId
}
```

Record types:

```text
MAX_WEIGHT
MAX_REPS
ESTIMATED_1RM
MAX_VOLUME
LONGEST_DURATION
MAX_DISTANCE
```

PRs are derived and rebuildable.

---

# 28. Visualization Query Layer

Charts must not query raw workout documents.

Use dedicated query services:

```text
ProgressionQueryService
VolumeQueryService
FrequencyQueryService
MuscleBalanceQueryService
PersonalRecordQueryService
WorkoutHistoryQueryService
RestStatisticsQueryService
GoalProgressQueryService
```

Examples:

```text
getExerciseProgression(userId, exerciseId, from, to)
getWeeklyVolume(userId, from, to)
getTrainingFrequency(userId, from, to)
getMuscleCategoryBreakdown(userId, from, to)
getRestCompliance(userId, from, to)
getPersonalRecords(userId, exerciseId)
getGoalProgress(userId, goalId)
getRecentSessions(userId, limit)
```

---

# 29. Chart DTOs

Return UI-friendly DTOs.

```text
TimeSeriesPoint
├── date
├── value
└── label?

VolumeSeries
├── period
├── volume
├── sets
└── sessions

ExerciseProgressPoint
├── date
├── estimated1RM
├── peakWeight
├── bestReps
└── volume

RestSeriesPoint
├── date
├── plannedSeconds
├── actualSeconds
└── complianceRatio
```

This prevents the UI from depending on database schemas.

---

# 30. Application Contracts

## Catalog

```text
CreateExercise
ForkExercise
UpdateExerciseDraft
ArchiveExercise
GetExercise
ListExercises
SetExercisePreference
```

## Templates

```text
CreateTemplate
CreateTemplateRevision
PublishTemplateRevision
ArchiveTemplate
GetTemplate
ListTemplates
```

## Sessions

```text
StartWorkoutSession
PauseWorkoutSession
ResumeWorkoutSession
AddSessionExercise
ChangeSessionTarget
LogExecutionSet
StartRest
CompleteRest
RecordInterruption
RemoveExecutionSet
CompleteWorkoutSession
CancelWorkoutSession
RecoverWorkoutSession
GetActiveWorkoutSession
GetWorkoutSession
```

## User

```text
CreateUserProfile
UpdateUserProfile
UpdateTrainingProfile
UpdateWorkoutPreferences
CreateTrainingGoal
UpdateTrainingGoal
AddEquipment
UpdateEquipment
RecordMeasurement
```

## Analytics

```text
GetWorkoutHistory
GetExerciseProgression
GetWeeklyVolume
GetTrainingFrequency
GetMuscleCategoryBreakdown
GetPersonalRecords
GetRestStatistics
GetGoalProgress
```

## Portability

```text
ExportData
ValidateImport
PreviewImportConflicts
ImportData
RebuildAnalytics
```

---

# 31. Repository Interfaces

Keep persistence behind interfaces.

```text
UserRepository
ExerciseRepository
TemplateRepository
WorkoutSessionRepository
AuditRepository
AnalyticsRepository
```

Example:

```text
interface WorkoutSessionRepository {
    getById(sessionId)
    save(session)
    listInProgress(userId)
    listCompleted(userId, range)
}
```

The same domain/application layer can therefore work with:

- local JSON/KV;
- IndexedDB;
- SQLite;
- a server-backed repository;
- a future synchronization layer.

---

# 32. Export/Import Architecture

Portable data must use an explicit external contract.

Never export raw internal domain objects directly.

## 32.1 Export envelope

```text
ExportPackage
{
    manifest:
    {
        formatVersion
        exportedAt
        appVersion
        generator
        checksum
        featureFlags[]
    }

    payload:
    {
        users[]
        profiles[]
        preferences[]
        goals[]
        equipment[]

        exercises[]
        exercisePreferences[]

        templates[]
        templateRevisions[]

        sessions[]
        measurements[]
    }
}
```

Analytics should normally not be exported as authoritative data because it can be regenerated.

---

# 33. Versioning Model

Keep these concepts separate.

## Schema version

Defines the structure of a persisted/exported object.

Examples:

```text
ExerciseSchemaVersion
WorkoutSessionSchemaVersion
ExportFormatVersion
```

## Template revision

Identifies the exact workout blueprint used by a session.

```text
templateRevisionId
```

## Export format version

Defines the portable external contract.

```text
formatVersion = 3
```

These values must not be conflated.

---

# 34. Migration Pipeline

Use sequential migrations.

```text
Raw V1
  │
  ▼
Migrator V1 → V2
  │
  ▼
Migrator V2 → V3
  │
  ▼
Current Runtime Schema
  │
  ▼
Validation
  │
  ▼
Conflict Resolution
  │
  ▼
Transactional Import
```

Interface:

```text
interface SchemaMigrator {
    getSourceVersion()
    getTargetVersion()
    migrate(payload)
}
```

If an import is newer than the current supported format, reject it safely rather than guessing.

---

# 35. Import Pipeline

```text
Portable File
     │
     ▼
File Sanitizer
     │
     ▼
Manifest Validation
     │
     ▼
Checksum Validation
     │
     ▼
Schema Migration
     │
     ▼
Structural Validation
     │
     ▼
Domain Validation
     │
     ▼
Reference Resolution
     │
     ▼
Conflict Detection
     │
     ▼
Conflict Resolution
     │
     ▼
ID Remapping
     │
     ▼
Atomic Persistence
     │
     ▼
Analytics Rebuild / Projection
```

Never leave partially imported authoritative records.

---

# 36. Conflict Resolution

Support deterministic strategies:

```text
BIND
FORK
PROMPT
```

For exercise conflicts:

```text
Imported exercise
       │
       ├── existing exact match → bind
       │
       ├── user-owned collision → fork/remap
       │
       └── ambiguous → prompt
```

All imported references must be rewritten through an explicit ID mapping table.

```text
oldId → newId
```

---

# 37. Data Validation

Use three layers.

## Structural validation

- required fields;
- primitive types;
- enum values;
- array/object structure.

## Domain validation

Examples:

- system exercises cannot be edited by ordinary user commands;
- template revisions cannot mutate after publication;
- completed sessions cannot complete twice;
- metric values must match exercise capabilities;
- target and execution relationships must be valid;
- goal units must match goal types;
- referenced exercises must exist.

## Persistence validation

Examples:

- unique IDs;
- non-negative measures;
- valid timestamps;
- transactional consistency;
- relational foreign keys.

---

# 38. Recovery and Reliability

## Crash during workout

Persist session changes incrementally.

An interrupted session can remain:

```text
IN_PROGRESS
```

or become:

```text
RECOVERABLE
```

on startup.

## Crash after session completion

On startup:

```text
Find completed sessions
with missing/stale analytics projections
        │
        ▼
Re-project
```

## Corrupt analytics database

```text
Delete analytics DB
        │
        ▼
Replay completed sessions
        │
        ▼
Rebuild projections
```

## Failed import

The import transaction must roll back authoritative changes.

---

# 39. Security and Ownership

Application-layer authorization should verify `userId`/`createdById` ownership.

Rules:

- system exercises are read-only;
- users can only modify their own exercises/templates/sessions;
- imported files are untrusted input;
- checksums detect corruption but do not establish authorization;
- exports are sensitive because they contain historical fitness data.

Future cloud synchronization can add:

- authenticated users;
- encrypted transport;
- encrypted storage;
- device identities;
- synchronization conflict resolution.

The core domain does not need to change.

---

# 40. Performance Strategy

## Runtime writes

Optimize for small frequent writes:

```text
Log Set
  ↓
Update Session Document
  ↓
Append Audit
```

Do not recalculate every chart after every set.

## Completion

```text
Completed Session
  ↓
Flatten once
  ↓
Batch analytics write
```

## Analytics

Use compound indexes such as:

```text
(user_id, workout_date)
(user_id, exercise_id, completed_at)
(session_id)
```

## Import

Use batch persistence and one transaction wherever practical.

---

# 41. Maintainability Rules

### Rule 1 — UI never owns persistence logic

UI uses application services.

### Rule 2 — Analytics never becomes the source of truth

Analytics are projections.

### Rule 3 — History is never silently rewritten

Use revisions and audits.

### Rule 4 — Export schema is an external contract

Do not expose internal persistence structures as the portable format.

### Rule 5 — Projections are rebuildable

If analytics cannot be regenerated from authoritative history, the architecture has accidental coupling.

### Rule 6 — Stable IDs everywhere

Never use names as foreign keys.

### Rule 7 — Archive referenced definitions

Do not delete catalog objects required by historical sessions.

### Rule 8 — Domain objects contain no database code

Repositories handle persistence.

### Rule 9 — Configuration does not overwrite history

User preferences affect future sessions, not completed ones.

### Rule 10 — Definitions are separate from execution

Templates and exercises describe intended behavior; sessions describe actual behavior.

---

# 42. Testing Strategy

## Unit tests

Test:

- domain validation;
- session state transitions;
- rest policy;
- exercise measurement compatibility;
- template revision immutability;
- goal validation.

## Integration tests

Test:

- document persistence;
- transaction behavior;
- analytics projection;
- recovery;
- import/export.

## Migration tests

Maintain fixtures:

```text
export-v1.json
export-v2.json
export-v3.json
```

Verify:

```text
V1 → V2 → V3 → Current
```

## Projection tests

Verify:

```text
project(session)
project(session)
```

produces the same final analytics state as:

```text
project(session)
```

This proves idempotency.

## Recovery tests

Simulate:

- application crash during set logging;
- crash during pause;
- crash immediately after completion;
- analytics failure;
- corrupt analytics store;
- interrupted import.

---

# 43. Observability

Recommended operational metrics:

```text
session_completion_count
session_recovery_count
session_recovery_failure_count

analytics_projection_count
analytics_projection_failure_count
analytics_projection_latency

analytics_rebuild_count
analytics_rebuild_duration

import_count
import_failure_count
migration_failure_count

rest_timer_start_count
rest_timer_completion_count
```

Log correlation IDs across:

```text
UI action
 → application command
 → domain event
 → repository write
 → analytics projection
```

---

# 44. Recommended Aggregate Roots

Use a limited set of aggregate roots.

```text
User
Exercise
WorkoutTemplate
WorkoutSession
TrainingGoal
UserMeasurement
```

Child entities such as `ExecutionSet`, `RestInterval`, and `SessionInterruption` should generally be modified through their owning `WorkoutSession`.

This prevents arbitrary cross-module mutations.

---

# 45. Complete Domain Relationship

```text
                                  USER
                                    │
        ┌───────────────────────────┼────────────────────────────┐
        │                           │                            │
        ▼                           ▼                            ▼
     PROFILE                     GOALS                      PREFERENCES
        │                                                        │
        ▼                                                        ▼
    EQUIPMENT                                          EXERCISE PREFERENCES
        │
        │
        └───────────────────────┐
                                ▼
                         EXERCISE CATALOG
                                │
               ┌────────────────┼────────────────┐
               ▼                ▼                ▼
           TAXONOMY        MEASUREMENT       RELATIONSHIPS
                                │
                                ▼
                         WORKOUT TEMPLATE
                                │
                                ▼
                       TEMPLATE REVISION
                                │
                                ▼
                         WORKOUT SESSION
                                │
       ┌────────────────────────┼──────────────────────────┐
       ▼                        ▼                          ▼
 EXECUTION SET            REST INTERVAL             INTERRUPTION
       │
       ▼
   AUDIT LOG
       │
       ▼
 DOMAIN EVENTS
       │
       ▼
 ANALYTICS PROJECTORS
       │
 ┌─────┼────────┬───────────┬────────────┐
 ▼     ▼        ▼           ▼            ▼
Volume  PRs  Progression  Frequency  Goal Progress
```

---

# 46. End-to-End Workout Flow

```text
User
 │
 ▼
Select Template
 │
 ▼
Select Immutable Template Revision
 │
 ▼
Create WorkoutSession
 │
 ▼
Copy Template Runtime State
 │
 ▼
STARTING
 │
 ▼
IN_PROGRESS
 │
 ├── Log Set
 │      │
 │      ├── Validate metric
 │      ├── Persist execution
 │      └── Append audit
 │
 ├── Start Rest
 │      │
 │      └── RestInterval
 │
 ├── Pause
 │      │
 │      └── SessionInterruption
 │
 └── Resume
 │
 ▼
COMPLETING
 │
 ▼
COMPLETED
 │
 ├── Append WorkoutSessionCompleted
 │
 └── Analytics Projection
          │
          ▼
      SQLite Read Models
          │
          ▼
       Statistics
          │
          ▼
      Visualization
```

---

# 47. Implementation Roadmap

## Phase 1 — Core foundation

Implement:

- stable IDs;
- User;
- Exercise;
- Template;
- immutable TemplateRevision;
- Session;
- copy-on-write runtime;
- audit entries.

## Phase 2 — Session quality

Implement:

- session state machine;
- pause/resume;
- interruption;
- RestPolicy;
- RestInterval;
- richer ExecutionSet;
- session recovery.

## Phase 3 — Catalog richness

Implement:

- exercise taxonomy;
- equipment;
- measurement profiles;
- alternatives;
- progressions/regressions;
- media.

## Phase 4 — User features

Implement:

- goals;
- equipment inventory;
- exercise preferences;
- workout preferences;
- historical measurements.

## Phase 5 — Analytics

Implement:

- session completion events;
- analytics projector;
- history;
- progression;
- volume/frequency;
- muscle/category analysis;
- rest statistics;
- personal records;
- goal progress.

## Phase 6 — Portability

Implement:

- versioned export envelope;
- checksum;
- validation;
- migration registry;
- conflict resolution;
- ID remapping;
- atomic importer;
- projection rebuild.

## Phase 7 — Quality hardening

Implement:

- migration fixtures;
- projection idempotency tests;
- crash/recovery tests;
- authorization tests;
- performance tests;
- observability.

---

# 48. Final Architectural Position

The application should be treated as:

> **One authoritative fitness domain with a rebuildable analytics projection and an explicit portability boundary.**

The most important architectural decisions are:

1. **Exercises and templates are reusable definitions.**
2. **Published template revisions are immutable.**
3. **Sessions are historical instances of exact template revisions.**
4. **Copy-on-write prevents live session edits from changing templates.**
5. **Rest and interruptions are first-class session facts.**
6. **User identity, preferences, goals, equipment and measurements are separate from workout execution.**
7. **Audit history is append-only.**
8. **Domain events are distinct from audit entries.**
9. **Analytics are materialized read models, never authoritative data.**
10. **Analytics projection is idempotent and rebuildable.**
11. **Export/import is a versioned external contract.**
12. **Schema versions, template revisions and export versions are separate concepts.**
13. **Import migrations are sequential and deterministic.**
14. **UI code communicates through application commands and queries.**
15. **Persistence is hidden behind repository interfaces.**
16. **The initial implementation can remain a modular monolith while preserving future extraction boundaries.**

This structure provides a durable foundation for exercise catalog growth, increasingly sophisticated workout programming, accurate workout history, rest/recovery analytics, personalized user experiences, and future synchronization without forcing a disruptive rewrite.
