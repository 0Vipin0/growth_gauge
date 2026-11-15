import 'package:json_annotation/json_annotation.dart';

/// Lifecycle status of a user account.
enum AccountStatus() {
  @JsonValue('ACTIVE')
  active,
  @JsonValue('SUSPENDED')
  suspended,
  @JsonValue('DELETED')
  deleted,
  @JsonValue('PENDING')
  pending,
}

/// Self-reported or assessed training experience level.
enum TrainingExperience() {
  @JsonValue('BEGINNER')
  beginner,
  @JsonValue('INTERMEDIATE')
  intermediate,
  @JsonValue('ADVANCED')
  advanced,
}

/// Category of personal training goal.
enum GoalType() {
  @JsonValue('STRENGTH')
  strength,
  @JsonValue('ENDURANCE')
  endurance,
  @JsonValue('WORKOUT_FREQUENCY')
  workoutFrequency,
  @JsonValue('VOLUME')
  volume,
  @JsonValue('REPETITION')
  repetition,
  @JsonValue('DURATION')
  duration,
  @JsonValue('DISTANCE')
  distance,
  @JsonValue('BODY_WEIGHT')
  bodyWeight,
  @JsonValue('CUSTOM')
  custom,
}

/// Lifecycle status of a training goal.
enum GoalStatus() {
  @JsonValue('ACTIVE')
  active,
  @JsonValue('ACHIEVED')
  achieved,
  @JsonValue('ABANDONED')
  abandoned,
}

/// Anthropometric and body composition measurement types.
enum MeasurementType() {
  @JsonValue('BODY_WEIGHT')
  bodyWeight,
  @JsonValue('BODY_FAT_PERCENT')
  bodyFatPercent,
  @JsonValue('WAIST')
  waist,
  @JsonValue('CHEST')
  chest,
  @JsonValue('ARM')
  arm,
  @JsonValue('THIGH')
  thigh,
  @JsonValue('CUSTOM')
  custom,
}
