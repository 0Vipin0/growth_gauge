import 'package:json_annotation/json_annotation.dart';

/// Body regions targeted by an exercise.
enum BodyRegion {
  @JsonValue('UPPER_BODY')
  upperBody,
  @JsonValue('LOWER_BODY')
  lowerBody,
  @JsonValue('FULL_BODY')
  fullBody,
  @JsonValue('CORE')
  core,
}

/// Primary movement biomechanical patterns.
enum MovementPattern {
  @JsonValue('HORIZONTAL_PUSH')
  horizontalPush,
  @JsonValue('VERTICAL_PUSH')
  verticalPush,
  @JsonValue('HORIZONTAL_PULL')
  horizontalPull,
  @JsonValue('VERTICAL_PULL')
  verticalPull,
  @JsonValue('SQUAT')
  squat,
  @JsonValue('HINGE')
  hinge,
  @JsonValue('LUNGE')
  lunge,
  @JsonValue('CARRY')
  carry,
  @JsonValue('ROTATION')
  rotation,
  @JsonValue('ISOLATION')
  isolation,
}

/// Anatomical muscle groups.
enum MuscleGroup {
  @JsonValue('CHEST')
  chest,
  @JsonValue('LATS')
  lats,
  @JsonValue('TRAPS')
  traps,
  @JsonValue('FRONT_DELTS')
  frontDelts,
  @JsonValue('SIDE_DELTS')
  sideDelts,
  @JsonValue('REAR_DELTS')
  rearDelts,
  @JsonValue('TRICEPS')
  triceps,
  @JsonValue('BICEPS')
  biceps,
  @JsonValue('FOREARMS')
  forearms,
  @JsonValue('QUADS')
  quads,
  @JsonValue('HAMSTRINGS')
  hamstrings,
  @JsonValue('GLUTES')
  glutes,
  @JsonValue('CALVES')
  calves,
  @JsonValue('ABS')
  abs,
  @JsonValue('OBLIQUES')
  obliques,
  @JsonValue('LOWER_BACK')
  lowerBack,
}

/// Equipment required or used for exercise execution.
enum EquipmentType {
  @JsonValue('BARBELL')
  barbell,
  @JsonValue('DUMBBELL')
  dumbbell,
  @JsonValue('KETTLEBELL')
  kettlebell,
  @JsonValue('CABLE')
  cable,
  @JsonValue('MACHINE')
  machine,
  @JsonValue('BODYWEIGHT')
  bodyweight,
  @JsonValue('SMITH_MACHINE')
  smithMachine,
  @JsonValue('RESISTANCE_BAND')
  resistanceBand,
  @JsonValue('PULL_UP_BAR')
  pullUpBar,
  @JsonValue('BENCH')
  bench,
}

/// Exercise lifecycle status.
enum ExerciseStatus {
  @JsonValue('DRAFT')
  draft,
  @JsonValue('ACTIVE')
  active,
  @JsonValue('ARCHIVED')
  archived,
}

/// Source / ownership of an exercise catalog item.
enum ExerciseSourceType {
  @JsonValue('SYSTEM')
  system,
  @JsonValue('USER_CREATED')
  userCreated,
  @JsonValue('USER_FORKED')
  userForked,
}

/// Relational connection between exercises (for substitutions and progressions).
enum RelationshipType {
  @JsonValue('ALTERNATIVE')
  alternative,
  @JsonValue('REGRESSION')
  regression,
  @JsonValue('PROGRESSION')
  progression,
  @JsonValue('VARIATION_OF')
  variationOf,
  @JsonValue('WARMUP_FOR')
  warmupFor,
  @JsonValue('COOLDOWN_FOR')
  cooldownFor,
}

/// Metric tracking style supported by an exercise.
enum MetricType {
  @JsonValue('WEIGHT_AND_REPS')
  weightAndReps,
  @JsonValue('TIME_BASED')
  timeBased,
  @JsonValue('COUNT_BASED')
  countBased,
  @JsonValue('DISTANCE_BASED')
  distanceBased,
  @JsonValue('CALORIES')
  calories,
  @JsonValue('PACE')
  pace,
}
