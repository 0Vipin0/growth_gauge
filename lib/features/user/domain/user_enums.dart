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

/// Self-reported biological sex, optional because it is sensitive data.
enum BiologicalSex() {
  @JsonValue('FEMALE')
  female,
  @JsonValue('MALE')
  male,
  @JsonValue('INTERSEX')
  intersex,
  @JsonValue('PREFER_NOT_TO_SAY')
  preferNotToSay,
}

/// Self-reported habitual activity level used for fitness estimates.
enum ActivityLevel() {
  @JsonValue('SEDENTARY')
  sedentary,
  @JsonValue('LIGHTLY_ACTIVE')
  lightlyActive,
  @JsonValue('MODERATELY_ACTIVE')
  moderatelyActive,
  @JsonValue('VERY_ACTIVE')
  veryActive,
  @JsonValue('EXTRA_ACTIVE')
  extraActive,
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
  @JsonValue('NECK')
  neck,
  @JsonValue('CHEST')
  chest,
  @JsonValue('HIP')
  hip,
  @JsonValue('ARM')
  arm,
  @JsonValue('THIGH')
  thigh,
  @JsonValue('CUSTOM')
  custom,
}
