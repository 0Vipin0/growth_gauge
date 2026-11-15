Below is a concrete persona-driven walkthrough of the architecture. The goal is to make every major component understandable in terms of **what the user does, what the application does, what gets persisted, and what gets derived**.

# Fitness Application — Sample Persona and End-to-End Component Usage

## 1. Sample Persona

### Persona: Sarah Mitchell

| Attribute           | Example                                                               |
| ------------------- | --------------------------------------------------------------------- |
| Name                | Sarah Mitchell                                                        |
| Age                 | 32                                                                    |
| Training experience | Intermediate                                                          |
| Primary goal        | Increase strength while maintaining 4 workouts/week                   |
| Secondary goal      | Improve squat from 70 kg × 5 to 90 kg × 5                             |
| Training style      | Strength + conditioning                                               |
| Typical session     | 45–60 minutes                                                         |
| Training days       | Monday, Tuesday, Thursday, Saturday                                   |
| Units               | Kilograms                                                             |
| Preferred rest      | 120 seconds for compound lifts                                        |
| Experience          | 3 years of resistance training                                        |
| Equipment           | Barbell, squat rack, bench, dumbbells, cable machine                  |
| Typical exercises   | Back squat, bench press, deadlift, cable row, dumbbell shoulder press |
| Device              | Mobile phone                                                          |

Sarah is not just an anonymous workout record.

The system knows:

* who Sarah is,
* her preferences,
* her goals,
* the equipment she has,
* exercises she prefers,
* which workout definition she selected,
* which exact revision of that workout she performed,
* what actually happened during the workout,
* how long she rested,
* whether she paused or was interrupted,
* and what analytics can be derived from those historical facts.

---

# 2. Sarah's Data at a Glance

A simplified representation of her domain data might look like this:

```text
User
└── Sarah Mitchell
    │
    ├── Account
    │   └── status = ACTIVE
    │
    ├── Profile
    │   ├── timezone = Europe/London
    │   └── units = METRIC
    │
    ├── TrainingProfile
    │   ├── experience = INTERMEDIATE
    │   ├── style = STRENGTH_CONDITIONING
    │   └── preferredSessionDuration = 60 min
    │
    ├── Preferences
    │   ├── defaultRest = 120 sec
    │   ├── autoStartRestTimer = true
    │   ├── vibration = true
    │   └── sound = true
    │
    ├── Goals
    │   ├── Squat: 70kg × 5 → 90kg × 5
    │   └── Workout frequency: 4/week
    │
    ├── Equipment
    │   ├── Barbell
    │   ├── Squat Rack
    │   ├── Bench
    │   ├── Dumbbells
    │   └── Cable Machine
    │
    ├── ExercisePreferences
    │   ├── Back Squat = preferred
    │   ├── Bench Press = preferred
    │   └── Burpees = hidden
    │
    └── Measurements
        └── Body Weight = 68.4 kg
```

This illustrates an important architectural principle:

> **The User aggregate describes Sarah. It does not describe a particular workout she performed.**

---

# 3. Phase 1 — Sarah Creates Her Account

Sarah opens the application for the first time.

She creates an account:

```text
CreateUserProfile
        ↓
UserAccount
        ↓
UserProfile
        ↓
TrainingProfile
        ↓
WorkoutPreferences
```

### Application command

```text
CreateUserProfile
{
    displayName: "Sarah Mitchell",
    timezone: "Europe/London",
    locale: "en-GB",
    unitPreferences: "METRIC"
}
```

The application layer validates the request and calls:

```text
UserRepository.save(user)
```

The domain does not know whether the data is ultimately stored in:

* SQLite,
* IndexedDB,
* a document database,
* a remote API,
* or another persistence mechanism.

That is an infrastructure concern.

### Stored result

```text
UserAccount {
    id: "user-001",
    status: ACTIVE
}
```

and:

```text
UserProfile {
    userId: "user-001",
    displayName: "Sarah Mitchell",
    timezone: "Europe/London",
    locale: "en-GB",
    unitPreferences: "METRIC"
}
```

---

# 4. Phase 2 — Sarah Configures Her Training Profile

Sarah tells the application:

```text
Experience:
    INTERMEDIATE

Training style:
    STRENGTH_CONDITIONING

Preferred duration:
    60 minutes

Training days:
    Monday
    Tuesday
    Thursday
    Saturday
```

This becomes:

```text
TrainingProfile
{
    userId: "user-001",
    trainingExperience: INTERMEDIATE,
    primaryTrainingStyle: STRENGTH_CONDITIONING,
    preferredSessionDurationMinutes: 60,
    preferredTrainingDays: [
        MONDAY,
        TUESDAY,
        THURSDAY,
        SATURDAY
    ]
}
```

This information can later be used by application features such as workout discovery or recommendations.

But importantly:

> Changing Sarah's training profile must not rewrite historical workouts.

For example, if Sarah later changes her preference from 60 minutes to 45 minutes, last month's 60-minute workout remains a 60-minute workout.

---

# 5. Phase 3 — Sarah Configures Workout Preferences

Sarah chooses:

```text
Default rest:
    120 seconds

Automatically start rest timer:
    YES

Sound:
    YES

Vibration:
    YES

Keep screen awake:
    YES

Show RPE:
    YES

Show RIR:
    YES
```

The application stores:

```text
WorkoutPreferences
{
    userId: "user-001",
    defaultRestSeconds: 120,
    autoStartRestTimer: true,
    soundEnabled: true,
    vibrationEnabled: true,
    keepScreenAwake: true,
    showRpe: true,
    showRir: true
}
```

This is configuration.

It is **not historical workout data**.

If Sarah changes her default rest from 120 seconds to 90 seconds next month, the application should not change the rest that she actually took in today's workout.

---

# 6. Phase 4 — Sarah Defines Her Goals

Sarah creates two goals.

## Goal A — Squat strength

```text
TrainingGoal
{
    id: "goal-001",
    userId: "user-001",
    type: STRENGTH,
    name: "Back Squat",
    startValue: 70,
    targetValue: 90,
    unit: "kg x 5",
    startDate: "2026-09-01",
    targetDate: "2026-12-01",
    status: ACTIVE
}
```

## Goal B — Training frequency

```text
TrainingGoal
{
    id: "goal-002",
    userId: "user-001",
    type: WORKOUT_FREQUENCY,
    name: "Train four times per week",
    targetValue: 4,
    unit: "sessions/week",
    status: ACTIVE
}
```

These goals become inputs to the analytics layer.

The goals themselves remain authoritative domain data.

---

# 7. Phase 5 — Sarah Adds Her Equipment

Sarah enters:

```text
Barbell
Squat Rack
Bench
Dumbbells
Cable Machine
```

For example:

```text
UserEquipment
{
    id: "equipment-001",
    userId: "user-001",
    equipmentType: BARBELL,
    name: "Olympic Barbell",
    quantity: 1,
    available: true
}
```

and:

```text
UserEquipment
{
    id: "equipment-002",
    userId: "user-001",
    equipmentType: CABLE_MACHINE,
    name: "Cable Machine",
    quantity: 1,
    available: true
}
```

This can later help the application determine which exercises are usable.

---

# 8. Phase 6 — Exercise Catalog

The system already contains a Back Squat exercise.

```text
Exercise
{
    id: "exercise-squat",
    name: "Back Squat",
    status: ACTIVE,
    sourceType: SYSTEM
}
```

Its classification might be:

```text
ExerciseClassification
{
    bodyRegions: [LOWER_BODY],
    primaryMuscles: [QUADRICEPS, GLUTES],
    secondaryMuscles: [HAMSTRINGS, CORE],
    movementPatterns: [SQUAT],
    exerciseTypes: [STRENGTH],
    laterality: BILATERAL
}
```

Its execution profile:

```text
ExerciseExecutionProfile
{
    setupInstructions: [
        "Position bar on upper back",
        "Brace core",
        "Set stance"
    ],

    executionInstructions: [
        "Descend under control",
        "Reach appropriate depth",
        "Drive through the floor"
    ],

    breathingInstructions:
        "Brace before descent and maintain intra-abdominal pressure"
}
```

Its measurement profile:

```text
ExerciseMeasurementProfile
{
    defaultMetricType: WEIGHT_AND_REPS,
    supportedMetricTypes: [
        WEIGHT_AND_REPS
    ],
    supportsWeight: true,
    supportsReps: true,
    supportsRpe: true,
    supportsRir: true
}
```

This tells the application what the exercise **is**.

It does not tell us what Sarah actually did today.

That distinction is fundamental.

---

# 9. Phase 7 — Sarah Personalizes the Exercise

Sarah marks Back Squat as preferred.

```text
UserExercisePreference
{
    userId: "user-001",
    exerciseId: "exercise-squat",
    favorite: true,
    preferred: true,
    hidden: false,
    defaultWeight: 70,
    defaultRepRange: "5"
}
```

This is Sarah's preference.

The global exercise remains unchanged.

Another user could prefer the same exercise differently.

---

# 10. Phase 8 — Sarah Creates a Workout Template

Sarah creates:

```text
WorkoutTemplate
    name = "Lower Strength A"
```

The template might contain:

```text
Block 1
    Back Squat
        4 × 5

Block 2
    Romanian Deadlift
        3 × 8

Block 3
    Cable Row
        3 × 10
```

The template itself is a reusable definition.

---

# 11. Phase 9 — Template Revision

Sarah publishes Revision 1.

```text
WorkoutTemplateRevision
{
    id: "revision-001",
    templateId: "template-lower-A",
    revisionNumber: 1,
    blocks: [...]
}
```

For example:

```text
Block:
    name = "Primary Strength"

TargetSet:
    setNumber = 1
    setType = WORKING
    target:
        weight = 70 kg
        repetitions = 5
    rest:
        plannedSeconds = 120
```

There are four target sets.

The revision is now immutable.

This means:

```text
Revision 1
    ↓
used by Session A
```

If Sarah later changes the workout to:

```text
5 × 5
```

the application creates:

```text
Revision 2
```

rather than modifying Revision 1.

---

# 12. Why Template Revisions Matter

Imagine Sarah performs Revision 1 today:

```text
Back Squat
4 × 5 @ 70 kg
```

Next month she changes the template to:

```text
Back Squat
5 × 5 @ 75 kg
```

Her historical workout must still say:

```text
This workout came from Revision 1.

Planned:
4 × 5 @ 70 kg
```

Otherwise the application could accidentally display the old workout as if Sarah had performed the new program.

Therefore:

```text
WorkoutTemplate
        │
        ├── Revision 1 ── Session 001
        │
        └── Revision 2 ── Session 010
```

This is one of the most important historical integrity rules in the architecture.

---

# 13. Phase 10 — Sarah Starts a Workout

Sarah taps:

```text
Start Workout
```

The application executes:

```text
StartWorkoutSession
```

The system creates:

```text
WorkoutSession
{
    id: "session-001",
    userId: "user-001",
    templateId: "template-lower-A",
    templateRevisionId: "revision-001",
    status: STARTING
}
```

The application transitions it to:

```text
IN_PROGRESS
```

The session now knows exactly which template revision it came from.

---

# 14. Copy-on-Write Runtime State

At this point the application creates a runtime representation.

Conceptually:

```text
WorkoutTemplateRevision
        │
        │ copy / instantiate
        ↓
WorkoutSession
        │
        ├── SessionBlock
        │
        ├── SessionItem
        │
        └── ExecutionSet
```

Sarah can now modify the live session without modifying the template.

For example, today's squat feels heavier than expected.

She changes:

```text
Today's target:
70 kg → 67.5 kg
```

The template remains:

```text
Revision 1:
70 kg
```

The session becomes:

```text
Session 001:
67.5 kg
```

This is copy-on-write behavior.

---

# 15. Phase 11 — First Execution Set

Sarah completes:

```text
Back Squat
Set 1
67.5 kg × 5
RPE 7
```

The application sends:

```text
LogExecutionSet
{
    sessionId: "session-001",
    exerciseId: "exercise-squat",
    setNumber: 1,
    actual: {
        weight: 67.5,
        repetitions: 5
    },
    intensity: {
        rpe: 7
    }
}
```

The domain validates that:

* the session is active,
* the exercise belongs to the session,
* the measurement is compatible,
* the set can be completed,
* required values are valid.

Then:

```text
ExecutionSetCompleted
```

is emitted.

---

# 16. Phase 12 — Rest Becomes a First-Class Object

After the set, the rest timer starts automatically.

Instead of simply storing:

```text
restAfterSeconds = 120
```

the system creates:

```text
RestInterval
{
    id: "rest-001",
    sessionId: "session-001",
    precedingSetId: "set-001",
    followingSetId: "set-002",

    plannedDurationSeconds: 120,

    startedAt: "10:02:00",
    endedAt: "10:03:50",

    actualDurationSeconds: 110,

    reason: EARLY_RETURN,
    status: COMPLETED
}
```

This captures what actually happened.

Sarah returned 10 seconds early.

That is useful historical information.

---

# 17. Why RestInterval Is Separate

Suppose Sarah performs:

```text
Set 1
    67.5 × 5

Rest
    110 sec

Set 2
    67.5 × 5

Rest
    140 sec

Set 3
    67.5 × 5
```

The application can now answer:

* What was the planned rest?
* What was the actual rest?
* How often does Sarah return early?
* How often does she exceed planned rest?
* Does longer rest correlate with better performance?

A single `restAfterSeconds` property could not represent this adequately.

---

# 18. Phase 13 — Sarah Is Interrupted

Sarah receives a phone call.

The workout is paused.

```text
PauseWorkoutSession
```

The session becomes:

```text
IN_PROGRESS
        ↓
PAUSED
```

The application records:

```text
SessionInterruption
{
    id: "interrupt-001",
    startedAt: "10:08:00",
    endedAt: "10:13:30",
    durationSeconds: 330,
    reason: PHONE_CALL,
    userInitiated: false
}
```

Sarah returns and taps Resume.

```text
ResumeWorkoutSession
```

The state becomes:

```text
PAUSED
   ↓
IN_PROGRESS
```

The application can now distinguish:

```text
Active workout time
```

from:

```text
Wall-clock elapsed time
```

For example:

```text
Wall-clock duration = 52 minutes

Active duration = 46.5 minutes

Interruption = 5.5 minutes
```

---

# 19. Phase 14 — Application Crash / Recovery

Imagine Sarah's phone unexpectedly kills the application.

Before that happens, the application has incrementally persisted:

```text
Session status
Current block
Current item
Current set
Completed sets
Rest intervals
Interruption state
```

When Sarah reopens the app:

```text
GetActiveWorkoutSession
```

returns:

```text
session-001
status = RECOVERABLE
```

The application can show:

```text
"Your workout was interrupted.
Resume workout?"
```

Sarah chooses Resume.

```text
RecoverWorkoutSession
```

The session returns to:

```text
IN_PROGRESS
```

This is why the session is persisted incrementally instead of being saved only when the workout finishes.

---

# 20. Phase 15 — Completing the Workout

Sarah completes:

```text
Back Squat
4 × 5 @ 67.5 kg

Romanian Deadlift
3 × 8 @ 60 kg

Cable Row
3 × 10 @ 45 kg
```

The application runs:

```text
CompleteWorkoutSession
```

The session transitions:

```text
IN_PROGRESS
     ↓
COMPLETING
     ↓
COMPLETED
```

The completed session now becomes historical domain data.

It contains:

```text
WorkoutSession
├── Template ID
├── Template Revision ID
├── Session Blocks
├── Session Items
├── Execution Sets
├── Rest Intervals
├── Interruptions
├── Session Notes
└── Audit History
```

---

# 21. Phase 16 — Audit Logging

Suppose Sarah changes the weight of Set 3 from:

```text
67.5 kg
```

to:

```text
65 kg
```

The application does not silently overwrite the history.

An audit entry can record:

```text
AuditLog
{
    timestamp: "...",

    actorType: USER,
    actorId: "user-001",

    action: UPDATE,
    entityType: ExecutionSet,
    entityId: "set-003",

    field: "actual.weight",

    previousValue: 67.5,
    newValue: 65,

    reason: "Reduced load due to fatigue",

    correlationId: "..."
}
```

The important distinction is:

```text
Domain data
    = what the current record says

Audit log
    = how that record got changed
```

---

# 22. Domain Events vs Audit Logs

The system can also emit:

```text
ExecutionSetCompleted
WorkoutSessionCompleted
RestStarted
RestCompleted
WorkoutSessionPaused
WorkoutSessionResumed
```

These are domain events.

They answer:

> "What happened in the domain?"

Audit records answer:

> "Who changed what, when, and from what value to what value?"

They should not be treated as the same mechanism.

---

# 23. Phase 17 — Analytics Projection

The completed session is authoritative.

Analytics are derived from it.

Conceptually:

```text
WorkoutSession
      │
      │ domain events / projection
      ↓
Analytics Projector
      │
      ├── daily_workout_summary
      ├── exercise_set_metrics
      ├── exercise_progression
      ├── weekly_training_summary
      ├── muscle_group_volume
      ├── personal_records
      ├── rest_statistics
      ├── session_performance
      └── goal_progress
```

For example:

```text
ExecutionSet

67.5 kg × 5
```

might produce:

```text
exercise_set_metrics
{
    user_id: "user-001",
    session_id: "session-001",
    exercise_id: "exercise-squat",
    set_id: "set-001",
    weight: 67.5,
    repetitions: 5,
    volume: 337.5
}
```

---

# 24. Daily Workout Summary

The system can aggregate Sarah's completed workout:

```text
daily_workout_summary
{
    user_id: "user-001",
    workout_date: "2026-09-24",
    sessions: 1,
    total_duration_seconds: 3120,
    active_duration_seconds: 2790,
    total_sets: 10,
    total_volume: 3835
}
```

The UI can now quickly display:

```text
Today's workout

Duration
52 min

Active
46.5 min

Sets
10

Volume
3,835 kg
```

The UI does not need to scan every raw session object each time.

---

# 25. Exercise Progression

Suppose Sarah's historical squat data is:

```text
Week 1    65 kg × 5
Week 2    67.5 kg × 5
Week 3    67.5 kg × 5
Week 4    70 kg × 5
Week 5    72.5 kg × 5
```

The analytics read model:

```text
exercise_progression
```

can provide:

```text
Back Squat

65
67.5
67.5
70
72.5
```

The UI can visualize this as a progression chart.

The chart is not authoritative.

If it becomes corrupted, the application can rebuild it from completed sessions.

---

# 26. Personal Records

Suppose Sarah previously achieved:

```text
70 kg × 5
```

and now achieves:

```text
72.5 kg × 5
```

The analytics engine may derive:

```text
PersonalRecord
{
    userId: "user-001",
    exerciseId: "exercise-squat",
    recordType: MAX_WEIGHT,
    value: 72.5,
    unit: "kg",
    achievedAt: "...",
    sessionId: "session-001",
    setId: "set-004"
}
```

The UI can show:

```text
🏆 New Personal Record

Back Squat
72.5 kg × 5
```

The PR itself is derived.

The underlying execution set is authoritative.

---

# 27. Estimated 1RM

From:

```text
72.5 kg × 5
```

the analytics layer may calculate an estimated 1RM.

For example:

```text
estimated_1rm = derived value
```

This belongs in:

```text
exercise_set_metrics
```

rather than the authoritative execution set.

Why?

Because an estimated 1RM is a calculation.

If the calculation algorithm changes, the application can recalculate it.

---

# 28. Rest Statistics

Because rest is modeled explicitly, Sarah can eventually see:

```text
Back Squat

Planned rest:
120 sec

Average actual rest:
128 sec

Median actual rest:
121 sec

Longest rest:
154 sec
```

The system can also distinguish:

```text
PLANNED
EARLY_RETURN
EXTENDED_REST
EQUIPMENT_WAIT
INTERRUPTION
```

This is much richer than merely recording a single rest duration.

---

# 29. Goal Progress

Sarah's goal:

```text
70 kg × 5
       ↓
90 kg × 5
```

Her latest result:

```text
72.5 kg × 5
```

The analytics layer can derive:

```text
Goal progress:
approximately 12.5% of the way
```

depending on the application's defined progress calculation.

The key architecture is:

```text
TrainingGoal
      +
Historical ExecutionSet
      ↓
GoalProgress projection
```

The goal remains domain data.

The progress calculation remains derived data.

---

# 30. Weekly Training Frequency

Sarah's target is:

```text
4 sessions/week
```

Suppose she completes:

```text
Monday
Tuesday
Thursday
Saturday
```

The analytics layer creates:

```text
weekly_training_summary
{
    week: "2026-W39",
    sessions: 4,
    targetSessions: 4
}
```

The UI can show:

```text
Training frequency

████████████████████ 4 / 4

Target achieved
```

Again, this summary can be regenerated.

---

# 31. Muscle Group Volume

Because exercises have classification data, completed sets can be associated with:

```text
Exercise
    ↓
Primary muscles
Secondary muscles
Movement pattern
```

Sarah's week could produce:

```text
Muscle Group Volume

Quadriceps       8,250 kg
Glutes           6,900 kg
Back             7,450 kg
Shoulders        3,200 kg
Hamstrings       4,600 kg
```

This is derived analytics.

The authoritative source remains:

```text
Exercise definitions
+
Execution sets
```

---

# 32. What Happens When Sarah Edits the Template?

Suppose Sarah decides she wants:

```text
Back Squat
5 × 5
```

instead of:

```text
4 × 5
```

The application does:

```text
CreateTemplateRevision
```

creating:

```text
Revision 1
    4 × 5

Revision 2
    5 × 5
```

Now:

```text
Old sessions
    ↓
continue referencing Revision 1

New sessions
    ↓
reference Revision 2
```

Nothing in historical data is rewritten.

---

# 33. What Happens When Sarah Archives an Exercise?

Suppose a system exercise is no longer recommended.

Instead of deleting:

```text
Back Squat
```

the system marks it:

```text
status = ARCHIVED
```

Why?

Because historical sessions may contain:

```text
exerciseId = exercise-squat
```

Deleting the exercise could make historical records impossible to interpret.

Therefore:

```text
Active catalog
    ≠
Historical references
```

An archived definition remains resolvable.

---

# 34. What Happens When Sarah Creates a Custom Exercise?

Sarah creates:

```text
Paused Back Squat
```

The application creates:

```text
Exercise
{
    id: "exercise-987",
    name: "Paused Back Squat",
    sourceType: USER_CREATED,
    createdById: "user-001",
    status: ACTIVE
}
```

Sarah could later create another variation based on an existing exercise.

The relationship could be:

```text
Paused Back Squat
       │
       └── VARIATION_OF
              ↓
          Back Squat
```

This is represented using:

```text
ExerciseRelationship
```

rather than hard-coding relationships into the Exercise entity.

---

# 35. Equipment-Aware Exercise Selection

Sarah has:

```text
Barbell
Squat Rack
Bench
Dumbbells
Cable Machine
```

Suppose an exercise requires:

```text
Required:
Olympic Barbell
Squat Rack
```

It is compatible with Sarah's equipment.

Another exercise requiring:

```text
Required:
Leg Press Machine
```

would not be available unless Sarah adds one.

The architecture therefore supports:

```text
ExerciseEquipmentProfile
          +
UserEquipment
          ↓
Equipment compatibility
```

This can be used by higher-level application features without modifying the Exercise domain itself.

---

# 36. Measurement Tracking

Sarah records:

```text
Body weight = 68.4 kg
```

The application creates:

```text
UserMeasurement
{
    id: "measurement-001",
    userId: "user-001",
    type: BODY_WEIGHT,
    value: 68.4,
    unit: "kg",
    recordedAt: "...",
    source: USER
}
```

Three months later:

```text
Body weight = 67.8 kg
```

Both records remain available.

This allows:

```text
Measurement history
```

to be projected independently.

---

# 37. Complete Component Flow

The entire system can be understood through this flow:

```text
                    ┌──────────────────────┐
                    │       Sarah          │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │      UI / API        │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │ Application Services │
                    └──────────┬───────────┘
                               │
              ┌────────────────┼────────────────┐
              │                │                │
              ▼                ▼                ▼
          User Domain     Exercise Domain   Template Domain
              │                │                │
              │                │                ▼
              │                │        Template Revision
              │                │                │
              │                └────────────────┤
              │                                 │
              │                                 ▼
              │                          Workout Session
              │                                 │
              │             ┌───────────────────┼────────────────┐
              │             │                   │                │
              │             ▼                   ▼                ▼
              │       Execution Sets       Rest Intervals   Interruptions
              │             │                   │                │
              │             └───────────────────┼────────────────┘
              │                                 │
              │                                 ▼
              │                         Domain Events
              │                                 │
              └─────────────────────────────────┤
                                                ▼
                                    Analytics Projection
                                                │
                    ┌───────────────────────────┼───────────────────────┐
                    │                           │                       │
                    ▼                           ▼                       ▼
             Progression                   PRs / 1RM             Goal Progress
                    │                           │                       │
                    └───────────────────────────┼───────────────────────┘
                                                ▼
                                             UI
```

---

# 38. Repository Layer in the Flow

The application service does not directly manipulate storage.

For example:

```text
StartWorkoutSession
        ↓
WorkoutSessionApplicationService
        ↓
WorkoutSessionRepository
        ↓
Persistence Adapter
        ↓
Document / KV / NoSQL Store
```

Similarly:

```text
GetExercise
        ↓
ExerciseApplicationService
        ↓
ExerciseRepository
        ↓
Exercise Persistence Adapter
```

This separation allows the storage implementation to change without rewriting domain logic.

---

# 39. Analytics Has a Different Read Path

When Sarah opens her progress screen:

```text
Sarah
  ↓
UI
  ↓
GetExerciseProgression
  ↓
Analytics Query Service
  ↓
AnalyticsRepository
  ↓
exercise_progression
```

The application does **not** need to reconstruct the entire history every time.

This is why materialized read models exist.

---

# 40. Analytics Failure Scenario

Suppose the analytics database becomes corrupted.

The authoritative data remains:

```text
Users
Exercises
Templates
Template Revisions
Sessions
Execution Sets
Rest Intervals
Measurements
Goals
```

The application can run:

```text
RebuildAnalytics
```

Conceptually:

```text
Authoritative Domain
        ↓
Completed Sessions
        ↓
Projection Engine
        ↓
Fresh Analytics Database
```

The system can reconstruct:

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

This is one of the strongest architectural properties of the design.

---

# 41. Exporting Sarah's Data

Sarah chooses:

```text
Settings
→ Export My Data
```

The application executes:

```text
ExportData
```

The export package contains:

```text
ExportPackage
├── manifest
│   ├── formatVersion
│   ├── exportedAt
│   ├── appVersion
│   ├── generator
│   ├── checksum
│   └── featureFlags
│
└── payload
    ├── users
    ├── profiles
    ├── preferences
    ├── goals
    ├── equipment
    ├── exercises
    ├── exercisePreferences
    ├── templates
    ├── templateRevisions
    ├── sessions
    └── measurements
```

Analytics normally do not need to be exported because they can be regenerated.

---

# 42. Sarah Imports the Data Into a New Installation

Sarah installs the application on another device.

The application performs:

```text
ValidateImport
        ↓
PreviewImportConflicts
        ↓
ImportData
        ↓
RebuildAnalytics
```

Suppose the imported exercise has:

```text
exerciseId = exercise-squat
```

but the new installation already has a system Back Squat with a different ID.

The conflict resolver can use:

```text
BIND
FORK
PROMPT
```

For example:

```text
Imported:
exercise-abc = "Back Squat"

Existing:
exercise-system-001 = "Back Squat"
```

The user may bind them:

```text
exercise-abc
     ↓
exercise-system-001
```

The import process maintains an explicit mapping:

```text
oldId → newId
```

and rewrites references consistently.

---

# 43. Migration Example

Imagine Sarah has an old export:

```text
formatVersion = 1
```

The current application expects:

```text
formatVersion = 3
```

The migration path is:

```text
V1
 │
 ▼
V1 → V2 Migrator
 │
 ▼
V2
 │
 ▼
V2 → V3 Migrator
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
 │
 ▼
Analytics Rebuild
```

The application does not need dozens of direct migration paths such as:

```text
V1 → V3
V1 → V4
V2 → V4
V2 → V5
...
```

Instead, migrations remain sequential and deterministic.

---

# 44. Sarah's Full Day Through the Architecture

Here is the entire story condensed into one timeline.

```text
07:30
Sarah opens app
    ↓
User/Profile loaded

07:32
Training preferences loaded
    ↓
WorkoutPreferences

07:35
"Lower Strength A" selected
    ↓
WorkoutTemplate
    ↓
WorkoutTemplateRevision 1

07:36
Start workout
    ↓
StartWorkoutSession
    ↓
WorkoutSession STARTING
    ↓
WorkoutSession IN_PROGRESS

07:42
Back Squat Set 1
    ↓
ExecutionSet
    ↓
ExecutionSetCompleted

07:47
Rest
    ↓
RestInterval

07:50
Back Squat Set 2
    ↓
ExecutionSet

07:55
Phone call
    ↓
SessionInterruption
    ↓
Session PAUSED

08:01
Resume
    ↓
Session IN_PROGRESS

08:25
Final set completed
    ↓
ExecutionSetCompleted

08:30
Complete workout
    ↓
WorkoutSession COMPLETED

08:30+
Domain events processed
    ↓
Analytics projection

08:31
PR calculated
    ↓
PersonalRecord

08:31
Progress updated
    ↓
GoalProgress

08:32
Sarah views dashboard
    ↓
Analytics query models
```

---

# 45. Component-to-Real-World Mapping

| Architecture Component | Sarah's Example                  | Purpose                      |
| ---------------------- | -------------------------------- | ---------------------------- |
| UserAccount            | Sarah's account                  | Identity/lifecycle           |
| UserProfile            | Name, timezone, units            | Personal profile             |
| TrainingProfile        | Intermediate, strength           | Training configuration       |
| WorkoutPreferences     | 120-sec default rest             | UI/workout behavior          |
| TrainingGoal           | 90 kg × 5 squat                  | User objective               |
| UserEquipment          | Barbell, rack, dumbbells         | Available equipment          |
| UserExercisePreference | Squat = preferred                | Personal customization       |
| UserMeasurement        | 68.4 kg                          | Historical measurements      |
| Exercise               | Back Squat                       | Exercise definition          |
| ExerciseClassification | Squat, quads, glutes             | Exercise metadata            |
| ExecutionProfile       | Squat instructions               | How exercise is performed    |
| EquipmentProfile       | Barbell + rack                   | Requirements                 |
| MeasurementProfile     | Weight + reps                    | Valid metrics                |
| ExerciseRelationship   | Paused squat → squat             | Exercise relationships       |
| WorkoutTemplate        | Lower Strength A                 | Reusable workout definition  |
| TemplateRevision       | Revision 1                       | Immutable workout definition |
| WorkoutBlock           | Primary Strength                 | Workout grouping             |
| TemplateItem           | Back Squat                       | Exercise in template         |
| TargetSet              | 70 kg × 5                        | Planned execution            |
| RestPolicy             | 120 sec                          | Planned recovery behavior    |
| WorkoutSession         | Today's workout                  | Runtime instance             |
| SessionBlock           | Today's strength block           | Runtime block                |
| SessionItem            | Today's squat                    | Runtime exercise             |
| ExecutionSet           | 67.5 kg × 5                      | Actual performance           |
| RestInterval           | 110 sec rest                     | Actual recovery              |
| SessionInterruption    | Phone call                       | Actual interruption          |
| AuditLog               | 67.5 → 65 kg                     | Change history               |
| Domain Event           | SetCompleted                     | Domain occurrence            |
| Analytics              | Weekly volume                    | Derived information          |
| PersonalRecord         | 72.5 × 5                         | Derived achievement          |
| GoalProgress           | 90 kg target progress            | Derived progress             |
| ExportPackage          | Sarah's backup                   | Portability                  |
| Migration              | V1 → V2 → V3                     | Schema evolution             |
| Conflict Resolution    | Existing squat vs imported squat | Import reconciliation        |

---

# 46. The Most Important Data Boundaries

Sarah's journey makes the four major data categories very clear.

## A. Definitions

```text
Exercise
WorkoutTemplate
WorkoutTemplateRevision
TargetSet
RestPolicy
```

These describe what something **is** or what a workout **is supposed to be**.

---

## B. Configuration

```text
UserProfile
TrainingProfile
WorkoutPreferences
UserEquipment
UserExercisePreference
TrainingGoal
```

These describe Sarah's current configuration and intentions.

---

## C. Runtime / History

```text
WorkoutSession
ExecutionSet
RestInterval
SessionInterruption
AuditLog
```

These describe what actually happened.

---

## D. Derived

```text
PersonalRecord
Estimated 1RM
Exercise progression
Weekly volume
Training frequency
Goal progress
Rest statistics
```

These describe information calculated from authoritative data.

---

# 47. The Critical "Do Not Mix" Rules

Sarah's example demonstrates several rules that should remain invariant.

### Rule 1 — Preferences do not rewrite history

Changing:

```text
defaultRestSeconds
```

must not change:

```text
historical RestInterval
```

---

### Rule 2 — Template edits do not rewrite sessions

Changing:

```text
Template Revision 2
```

must not modify:

```text
Session using Revision 1
```

---

### Rule 3 — Analytics do not become the source of truth

If:

```text
personal_records
```

is lost, it must be possible to recreate it from historical execution data.

---

### Rule 4 — Exercise definitions do not become execution records

The exercise says:

```text
Back Squat supports weight + repetitions.
```

The session says:

```text
Sarah actually performed 72.5 kg × 5.
```

Those are different facts.

---

### Rule 5 — Rest is historical data

The template may say:

```text
planned rest = 120 sec
```

The session may say:

```text
actual rest = 137 sec
```

Both values matter.

---

### Rule 6 — Interruption is historical data

The phone call should not simply disappear into a larger duration number.

The system should know:

```text
Workout:
52 min wall clock

Active:
46.5 min

Phone interruption:
5.5 min
```

---

# 48. Example API/Application Interaction

A simplified application-level interaction could look like:

```text
POST /sessions
        ↓
StartWorkoutSession
        ↓
WorkoutSessionRepository.save()
```

Then:

```text
POST /sessions/session-001/sets
        ↓
LogExecutionSet
        ↓
ExecutionSetCompleted
        ↓
SessionRepository.save()
        ↓
AnalyticsProjection
```

Then:

```text
GET /analytics/exercises/exercise-squat/progression
        ↓
GetExerciseProgression
        ↓
AnalyticsRepository
        ↓
exercise_progression
```

The UI therefore does not directly manipulate:

```text
SQLite
IndexedDB
Document store
Analytics tables
```

It communicates through application contracts.

---

# 49. Recommended Mental Model

The simplest way to understand the entire architecture is:

```text
                  WHAT EXISTS?
                       │
              ┌────────┴────────┐
              │                 │
          Exercises         Templates
              │                 │
              └────────┬────────┘
                       │
                       ▼
                 WHAT SHOULD
                  HAPPEN?
                       │
                       ▼
                Template Revision
                       │
                       ▼
                 WHAT DID SARAH
                    ACTUALLY DO?
                       │
                       ▼
                 Workout Session
                       │
          ┌────────────┼────────────┐
          ▼            ▼            ▼
      Sets          Rest        Interruptions
          │            │            │
          └────────────┼────────────┘
                       ▼
                 WHAT CAN WE
                   DERIVE?
                       │
          ┌────────────┼────────────┐
          ▼            ▼            ▼
      Progress       PRs         Goals
          │            │            │
          └────────────┼────────────┘
                       ▼
                     UI
```

---

# 50. Final End-to-End Architecture

For Sarah, the complete lifecycle is:

```text
┌──────────────────────────────────────────────────────────┐
│                         USER                             │
│                    Sarah Mitchell                        │
└───────────────────────────┬──────────────────────────────┘
                            │
                            ▼
┌──────────────────────────────────────────────────────────┐
│                    USER DOMAIN                            │
│                                                          │
│ Profile | Training | Preferences | Goals | Equipment     │
│ Measurements | Exercise Preferences                     │
└───────────────────────────┬──────────────────────────────┘
                            │
                            ▼
┌──────────────────────────────────────────────────────────┐
│                    EXERCISE DOMAIN                        │
│                                                          │
│ Exercise | Classification | Execution | Equipment       │
│ Measurement | Relationships | Media                      │
└───────────────────────────┬──────────────────────────────┘
                            │
                            ▼
┌──────────────────────────────────────────────────────────┐
│                   TEMPLATE DOMAIN                         │
│                                                          │
│ Template → Immutable Revision → Blocks → Target Sets    │
│                                  ↓                       │
│                             Rest Policy                  │
└───────────────────────────┬──────────────────────────────┘
                            │
                            ▼
┌──────────────────────────────────────────────────────────┐
│                    SESSION DOMAIN                         │
│                                                          │
│ WorkoutSession                                            │
│   ├── SessionBlock                                        │
│   │    └── SessionItem                                    │
│   │         └── ExecutionSet                              │
│   ├── RestInterval                                        │
│   ├── SessionInterruption                                │
│   └── AuditLog                                            │
└───────────────────────────┬──────────────────────────────┘
                            │
                            │ Domain Events
                            ▼
┌──────────────────────────────────────────────────────────┐
│                 ANALYTICS PROJECTION                      │
│                                                          │
│ History | Progression | Volume | PRs | 1RM              │
│ Rest Statistics | Performance | Goal Progress            │
└───────────────────────────┬──────────────────────────────┘
                            │
                            ▼
┌──────────────────────────────────────────────────────────┐
│                         UI                                │
│                                                          │
│ Workout screen | History | Progress | Goals | Dashboard  │
└──────────────────────────────────────────────────────────┘
```

The resulting architectural principle can be summarized as:

> **Sarah's exercises and workout definitions describe what can or should happen. Her workout session records what actually happened. Analytics explains what those historical facts mean.**

That separation is what allows the application to support **accurate history, editable live workouts, immutable program revisions, detailed recovery tracking, crash recovery, reliable analytics, personal goals, and long-term data portability** without different parts of the system corrupting one another.

A useful next step would be to turn this persona into a **fully worked example dataset**—with actual JSON/document records for Sarah's User, Exercises, Template Revision, Session, ExecutionSets, RestIntervals, AuditLogs, Domain Events, and resulting Analytics rows—so the architecture can be used directly as an implementation/test fixture.
