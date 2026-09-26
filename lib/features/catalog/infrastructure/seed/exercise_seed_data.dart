import '../../domain/exercise.dart';
import '../../domain/exercise_classification.dart';
import '../../domain/exercise_enums.dart';
import '../../domain/exercise_equipment.dart';

/// Canonical system exercise seed data.
///
/// These 7 exercises are seeded on first launch if the catalog is empty.
/// IDs match the [Persona_Worked_Example.json] fixture.
class const ExerciseSeedData._() {
  static final _epoch = DateTime.utc(2024);

  static List<Exercise> get all => [
    _squat,
    _deadlift,
    _benchPress,
    _ohp,
    _barbellRow,
    _pullUp,
    _dumbbellRdl,
  ];

  static final _squat = Exercise(
    id: 'exercise-squat-001',
    name: 'Barbell Back Squat',
    aliases: ['back squat', 'squat'],
    description: 'Compound lower-body movement with the barbell loaded on the upper back.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.lowerBody],
      movementPatterns: [MovementPattern.squat],
      primaryMuscles: [MuscleGroup.quads, MuscleGroup.glutes],
      secondaryMuscles: [MuscleGroup.hamstrings, MuscleGroup.lowerBack],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.barbell],
    ),
  );

  static final _deadlift = Exercise(
    id: 'exercise-deadlift-001',
    name: 'Conventional Deadlift',
    aliases: ['deadlift'],
    description: 'Hip-hinge pull from the floor with a barbell.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.fullBody],
      movementPatterns: [MovementPattern.hinge],
      primaryMuscles: [MuscleGroup.hamstrings, MuscleGroup.glutes],
      secondaryMuscles: [MuscleGroup.lowerBack, MuscleGroup.traps],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.barbell],
    ),
  );

  static final _benchPress = Exercise(
    id: 'exercise-bench-001',
    name: 'Barbell Bench Press',
    aliases: ['bench press', 'flat bench'],
    description: 'Horizontal push compound on a flat bench with a barbell.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.horizontalPush],
      primaryMuscles: [MuscleGroup.chest],
      secondaryMuscles: [MuscleGroup.triceps, MuscleGroup.frontDelts],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.barbell, EquipmentType.bench],
    ),
  );

  static final _ohp = Exercise(
    id: 'exercise-ohp-001',
    name: 'Overhead Press',
    aliases: ['OHP', 'military press', 'standing press'],
    description: 'Vertical push with a barbell pressed from shoulder rack.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.verticalPush],
      primaryMuscles: [MuscleGroup.frontDelts, MuscleGroup.sideDelts],
      secondaryMuscles: [MuscleGroup.triceps, MuscleGroup.traps],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.barbell],
    ),
  );

  static final _barbellRow = Exercise(
    id: 'exercise-row-001',
    name: 'Barbell Row',
    aliases: ['bent-over row', 'Pendlay row'],
    description: 'Horizontal pull compound with barbell and hip-hinged torso.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.horizontalPull],
      primaryMuscles: [MuscleGroup.lats, MuscleGroup.traps],
      secondaryMuscles: [MuscleGroup.biceps, MuscleGroup.rearDelts],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.barbell],
    ),
  );

  static final _pullUp = Exercise(
    id: 'exercise-pullup-001',
    name: 'Pull-Up',
    aliases: ['pullup', 'chin-up'],
    description: 'Vertical pull bodyweight compound hanging from a bar.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.verticalPull],
      primaryMuscles: [MuscleGroup.lats],
      secondaryMuscles: [MuscleGroup.biceps, MuscleGroup.rearDelts],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.pullUpBar],
    ),
  );

  static final _dumbbellRdl = Exercise(
    id: 'exercise-rdl-001',
    name: 'Dumbbell RDL',
    aliases: ['Romanian deadlift', 'dumbbell Romanian deadlift'],
    description:
        'Hip-hinge hinge movement with dumbbells emphasising hamstrings.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.lowerBody],
      movementPatterns: [MovementPattern.hinge],
      primaryMuscles: [MuscleGroup.hamstrings, MuscleGroup.glutes],
      secondaryMuscles: [MuscleGroup.lowerBack],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.dumbbell],
    ),
  );
}
