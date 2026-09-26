import 'package:json_annotation/json_annotation.dart';

/// Supported workout block formats.
enum WorkoutBlockType() {
  @JsonValue('STANDARD')
  standard,
  @JsonValue('SUPERSET')
  superset,
  @JsonValue('TRISET')
  triset,
  @JsonValue('CIRCUIT')
  circuit,
  @JsonValue('AMRAP')
  amrap,
  @JsonValue('EMOM')
  emom,
  @JsonValue('FOR_TIME')
  forTime,
  @JsonValue('TABATA')
  tabata,
  @JsonValue('WARMUP')
  warmup,
  @JsonValue('COOLDOWN')
  cooldown,
  @JsonValue('REST')
  rest,
}

/// Classification of a set within an exercise prescription.
enum SetType() {
  @JsonValue('WARMUP')
  warmup,
  @JsonValue('WORKING')
  working,
  @JsonValue('BACKOFF')
  backoff,
  @JsonValue('DROP_SET')
  dropSet,
  @JsonValue('AMRAP')
  amrap,
  @JsonValue('FAILURE')
  failure,
  @JsonValue('COOLDOWN')
  cooldown,
  @JsonValue('OTHER')
  other,
}

/// Lifecycle status of a workout template revision.
enum TemplateRevisionStatus() {
  @JsonValue('DRAFT')
  draft,
  @JsonValue('PUBLISHED')
  published,
  @JsonValue('ARCHIVED')
  archived,
}
