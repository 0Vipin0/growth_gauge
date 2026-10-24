import '../../domain/exercise.dart';
import '../../domain/exercise_classification.dart';
import '../../domain/exercise_enums.dart';
import '../../domain/exercise_equipment.dart';

/// Canonical system exercise seed data.
///
/// These 50 exercises are seeded on first launch if the catalog is empty.
class ExerciseSeedData._() {
  static final _epoch = DateTime.utc(2024);

  static List<Exercise> get all => [
    _squat,
    _deadlift,
    _benchPress,
    _ohp,
    _barbellRow,
    _pullUp,
    _dumbbellRdl,
    _inclineBenchPress,
    _latPulldown,
    _legPress,
    _dumbbellCurl,
    _tricepPushdown,
    _lateralRaise,
    _bulgarianSplitSquat,
    _sumoDeadlift,
    _frontSquat,
    _gobletSquat,
    _barbellRdl,
    _trapBarDeadlift,
    _declineBenchPress,
    _dumbbellBenchPress,
    _inclineDumbbellPress,
    _dumbbellFly,
    _cableCrossover,
    _seatedCableRow,
    _tBarRow,
    _singleArmDbRow,
    _chinUp,
    _pushUp,
    _dips,
    _seatedDbShoulderPress,
    _arnoldPress,
    _facePull,
    _barbellCurl,
    _hammerCurl,
    _preacherCurl,
    _overheadTricepExtension,
    _skullCrusher,
    _legExtension,
    _seatedLegCurl,
    _lyingLegCurl,
    _standingCalfRaise,
    _seatedCalfRaise,
    _barbellHipThrust,
    _cablePullThrough,
    _hangingLegRaise,
    _cableWoodchopper,
    _plank,
    _farmersWalk,
    _chestSupportedRow,
  ];

  // 1-7 (Original Reference Exercises)
  static final _squat = Exercise(
    id: 'exercise-squat-001',
    name: 'Barbell Back Squat',
    aliases: ['back squat', 'squat'],
    description: 'Compound lower-body movement with the barbell loaded on the upper back[cite: 23].',
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
    description: 'Hip-hinge pull from the floor with a barbell[cite: 23].',
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
    description:
        'Horizontal push compound on a flat bench with a barbell[cite: 23].',
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
    description:
        'Vertical push with a barbell pressed from shoulder rack[cite: 23].',
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
    description:
        'Horizontal pull compound with barbell and hip-hinged torso[cite: 23].',
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
    description:
        'Vertical pull bodyweight compound hanging from a bar[cite: 23].',
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
        'Hip-hinge movement with dumbbells emphasising hamstrings[cite: 23].',
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

  // 8-50 (Expanded Unique Exercises)
  static final _inclineBenchPress = Exercise(
    id: 'exercise-incline-bench-001',
    name: 'Incline Barbell Bench Press',
    aliases: ['incline bench'],
    description:
        'Compound press on an inclined bench targeting upper pectoral fibers.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.horizontalPush],
      primaryMuscles: [MuscleGroup.chest],
      secondaryMuscles: [MuscleGroup.frontDelts, MuscleGroup.triceps],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.barbell, EquipmentType.bench],
    ),
  );

  static final _latPulldown = Exercise(
    id: 'exercise-lat-pulldown-001',
    name: 'Lat Pulldown',
    aliases: ['cable pulldown'],
    description: 'Vertical pulling cable exercise focusing on latissimus dorsi development.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.verticalPull],
      primaryMuscles: [MuscleGroup.lats],
      secondaryMuscles: [MuscleGroup.biceps],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.cable],
    ),
  );

  static final _legPress = Exercise(
    id: 'exercise-leg-press-001',
    name: 'Leg Press',
    aliases: ['machine leg press'],
    description: 'Heavy machine-based compound push targeting quads and glutes with back support.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.lowerBody],
      movementPatterns: [MovementPattern.squat],
      primaryMuscles: [MuscleGroup.quads, MuscleGroup.glutes],
      secondaryMuscles: [MuscleGroup.hamstrings],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.machine],
    ),
  );

  static final _dumbbellCurl = Exercise(
    id: 'exercise-db-curl-001',
    name: 'Dumbbell Bicep Curl',
    aliases: ['bicep curl'],
    description:
        'Isolation elbow flexion movement using dumbbells to target biceps.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.isolation],
      primaryMuscles: [MuscleGroup.biceps],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.dumbbell],
    ),
  );

  static final _tricepPushdown = Exercise(
    id: 'exercise-tricep-pushdown-001',
    name: 'Cable Tricep Pushdown',
    aliases: ['tricep pushdown'],
    description: 'Isolation elbow extension exercise using a cable machine.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.isolation],
      primaryMuscles: [MuscleGroup.triceps],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.cable],
    ),
  );

  static final _lateralRaise = Exercise(
    id: 'exercise-lateral-raise-001',
    name: 'Dumbbell Lateral Raise',
    aliases: ['side lateral raise'],
    description:
        'Isolation shoulder movement raising dumbbells out to the sides.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.isolation],
      primaryMuscles: [MuscleGroup.sideDelts],
      secondaryMuscles: [MuscleGroup.traps],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.dumbbell],
    ),
  );

  static final _bulgarianSplitSquat = Exercise(
    id: 'exercise-bulgarian-squat-001',
    name: 'Bulgarian Split Squat',
    aliases: ['rear foot elevated split squat'],
    description: 'Unilateral lower-body squat variation emphasizing single-leg strength.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.lowerBody],
      movementPatterns: [MovementPattern.squat],
      primaryMuscles: [MuscleGroup.quads, MuscleGroup.glutes],
      secondaryMuscles: [MuscleGroup.hamstrings],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.dumbbell, EquipmentType.bench],
    ),
  );

  static final _sumoDeadlift = Exercise(
    id: 'exercise-sumo-deadlift-001',
    name: 'Sumo Deadlift',
    aliases: ['sumo dl'],
    description: 'Wide-stance deadlift variation placing greater emphasis on quads and inner thighs.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.fullBody],
      movementPatterns: [MovementPattern.hinge],
      primaryMuscles: [MuscleGroup.glutes, MuscleGroup.quads],
      secondaryMuscles: [MuscleGroup.hamstrings, MuscleGroup.lowerBack],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.barbell],
    ),
  );

  static final _frontSquat = Exercise(
    id: 'exercise-front-squat-001',
    name: 'Barbell Front Squat',
    aliases: ['front squat'],
    description: 'Squat variation with the barbell resting on the front deltoids for enhanced upright posture.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.lowerBody],
      movementPatterns: [MovementPattern.squat],
      primaryMuscles: [MuscleGroup.quads],
      secondaryMuscles: [MuscleGroup.glutes, MuscleGroup.core],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.barbell],
    ),
  );

  static final _gobletSquat = Exercise(
    id: 'exercise-goblet-squat-001',
    name: 'Goblet Squat',
    aliases: ['db squat'],
    description:
        'Squat holding a dumbbell or kettlebell vertically against the chest.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.lowerBody],
      movementPatterns: [MovementPattern.squat],
      primaryMuscles: [MuscleGroup.quads, MuscleGroup.glutes],
      secondaryMuscles: [MuscleGroup.core],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.dumbbell],
    ),
  );

  static final _barbellRdl = Exercise(
    id: 'exercise-barbell-rdl-001',
    name: 'Barbell Romanian Deadlift',
    aliases: ['barbell rdl'],
    description: 'Hip-hinge movement with a barbell keeping minimal knee bend to target hamstrings.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.lowerBody],
      movementPatterns: [MovementPattern.hinge],
      primaryMuscles: [MuscleGroup.hamstrings, MuscleGroup.glutes],
      secondaryMuscles: [MuscleGroup.lowerBack],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.barbell],
    ),
  );

  static final _trapBarDeadlift = Exercise(
    id: 'exercise-trap-bar-deadlift-001',
    name: 'Trap Bar Deadlift',
    aliases: ['hex bar deadlift'],
    description: 'Deadlift performed inside a hex bar, allowing a more upright torso position.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.fullBody],
      movementPatterns: [MovementPattern.hinge],
      primaryMuscles: [MuscleGroup.quads, MuscleGroup.glutes],
      secondaryMuscles: [MuscleGroup.hamstrings, MuscleGroup.traps],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.barbell],
    ),
  );

  static final _declineBenchPress = Exercise(
    id: 'exercise-decline-bench-001',
    name: 'Decline Barbell Bench Press',
    aliases: ['decline bench'],
    description:
        'Press performed on a decline bench targeting lower pectoral fibers.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.horizontalPush],
      primaryMuscles: [MuscleGroup.chest],
      secondaryMuscles: [MuscleGroup.triceps],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.barbell, EquipmentType.bench],
    ),
  );

  static final _dumbbellBenchPress = Exercise(
    id: 'exercise-db-bench-001',
    name: 'Dumbbell Bench Press',
    aliases: ['db bench press'],
    description: 'Flat bench press using dumbbells for increased range of motion and independent arm stabilization.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.horizontalPush],
      primaryMuscles: [MuscleGroup.chest],
      secondaryMuscles: [MuscleGroup.triceps, MuscleGroup.frontDelts],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.dumbbell, EquipmentType.bench],
    ),
  );

  static final _inclineDumbbellPress = Exercise(
    id: 'exercise-incline-db-press-001',
    name: 'Incline Dumbbell Press',
    aliases: ['incline db press'],
    description: 'Upper chest pressing movement utilizing dumbbells on an inclined bench.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.horizontalPush],
      primaryMuscles: [MuscleGroup.chest],
      secondaryMuscles: [MuscleGroup.frontDelts, MuscleGroup.triceps],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.dumbbell, EquipmentType.bench],
    ),
  );

  static final _dumbbellFly = Exercise(
    id: 'exercise-db-fly-001',
    name: 'Dumbbell Chest Fly',
    aliases: ['chest fly'],
    description:
        'Isolation chest movement involving an arc motion with dumbbells.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.isolation],
      primaryMuscles: [MuscleGroup.chest],
      secondaryMuscles: [MuscleGroup.frontDelts],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.dumbbell, EquipmentType.bench],
    ),
  );

  static final _cableCrossover = Exercise(
    id: 'exercise-cable-crossover-001',
    name: 'Cable Crossover',
    aliases: ['cable fly'],
    description:
        'Constant-tension chest fly performed using dual cable pulleys.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.isolation],
      primaryMuscles: [MuscleGroup.chest],
      secondaryMuscles: [MuscleGroup.frontDelts],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.cable],
    ),
  );

  static final _seatedCableRow = Exercise(
    id: 'exercise-seated-cable-row-001',
    name: 'Seated Cable Row',
    aliases: ['cable row'],
    description: 'Horizontal pulling exercise using a cable machine and handle attachment.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.horizontalPull],
      primaryMuscles: [MuscleGroup.lats, MuscleGroup.traps],
      secondaryMuscles: [MuscleGroup.biceps, MuscleGroup.rearDelts],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.cable],
    ),
  );

  static final _tBarRow = Exercise(
    id: 'exercise-t-bar-row-001',
    name: 'T-Bar Row',
    aliases: ['landmine row'],
    description: 'Heavy horizontal pulling movement using a landmine attachment or T-bar apparatus.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.horizontalPull],
      primaryMuscles: [MuscleGroup.lats, MuscleGroup.traps],
      secondaryMuscles: [MuscleGroup.biceps],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.barbell],
    ),
  );

  static final _singleArmDbRow = Exercise(
    id: 'exercise-single-arm-db-row-001',
    name: 'Single-Arm Dumbbell Row',
    aliases: ['db row'],
    description: 'Unilateral horizontal pull supported by a bench.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.horizontalPull],
      primaryMuscles: [MuscleGroup.lats],
      secondaryMuscles: [MuscleGroup.biceps, MuscleGroup.rearDelts],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.dumbbell, EquipmentType.bench],
    ),
  );

  static final _chinUp = Exercise(
    id: 'exercise-chinup-001',
    name: 'Chin-Up',
    aliases: ['supinated pullup'],
    description: 'Bodyweight vertical pull using a supinated (underhand) grip.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.verticalPull],
      primaryMuscles: [MuscleGroup.lats, MuscleGroup.biceps],
      secondaryMuscles: [MuscleGroup.rearDelts],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.pullUpBar],
    ),
  );

  static final _pushUp = Exercise(
    id: 'exercise-pushup-001',
    name: 'Push-Up',
    aliases: ['floor pushup'],
    description:
        'Classic bodyweight horizontal push movement performed on the floor.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.horizontalPush],
      primaryMuscles: [MuscleGroup.chest],
      secondaryMuscles: [
        MuscleGroup.triceps,
        MuscleGroup.frontDelts,
        MuscleGroup.core,
      ],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.bodyweight],
    ),
  );

  static final _dips = Exercise(
    id: 'exercise-dips-001',
    name: 'Parallel Bar Dips',
    aliases: ['chest dips'],
    description:
        'Compound bodyweight push exercise performed on parallel bars.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.verticalPush],
      primaryMuscles: [MuscleGroup.triceps, MuscleGroup.chest],
      secondaryMuscles: [MuscleGroup.frontDelts],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.bodyweight],
    ),
  );

  static final _seatedDbShoulderPress = Exercise(
    id: 'exercise-seated-db-press-001',
    name: 'Seated Dumbbell Shoulder Press',
    aliases: ['db overhead press'],
    description: 'Overhead vertical press using dumbbells while seated with back support.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.verticalPush],
      primaryMuscles: [MuscleGroup.frontDelts, MuscleGroup.sideDelts],
      secondaryMuscles: [MuscleGroup.triceps],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.dumbbell, EquipmentType.bench],
    ),
  );

  static final _arnoldPress = Exercise(
    id: 'exercise-arnold-press-001',
    name: 'Arnold Press',
    aliases: ['rotating shoulder press'],
    description:
        'Dumbbell shoulder press featuring a rotational wrist movement.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.verticalPush],
      primaryMuscles: [MuscleGroup.frontDelts, MuscleGroup.sideDelts],
      secondaryMuscles: [MuscleGroup.triceps],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.dumbbell, EquipmentType.bench],
    ),
  );

  static final _facePull = Exercise(
    id: 'exercise-face-pull-001',
    name: 'Cable Face Pull',
    aliases: ['face pull'],
    description:
        'Rear delt and upper back cable exercise pulling towards the face.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.isolation],
      primaryMuscles: [MuscleGroup.rearDelts, MuscleGroup.traps],
      secondaryMuscles: [MuscleGroup.biceps],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.cable],
    ),
  );

  static final _barbellCurl = Exercise(
    id: 'exercise-barbell-curl-001',
    name: 'Barbell Bicep Curl',
    aliases: ['bb curl'],
    description:
        'Bicep isolation exercise performed with a straight or EZ-bar.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.isolation],
      primaryMuscles: [MuscleGroup.biceps],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.barbell],
    ),
  );

  static final _hammerCurl = Exercise(
    id: 'exercise-hammer-curl-001',
    name: 'Dumbbell Hammer Curl',
    aliases: ['neutral curl'],
    description:
        'Bicep and brachialis curl with a neutral (palms facing inward) grip.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.isolation],
      primaryMuscles: [MuscleGroup.biceps],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.dumbbell],
    ),
  );

  static final _preacherCurl = Exercise(
    id: 'exercise-preacher-curl-001',
    name: 'Preacher Curl',
    aliases: ['bench curl'],
    description: 'Bicep isolation curl performed with upper arms resting on a preacher bench.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.isolation],
      primaryMuscles: [MuscleGroup.biceps],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.barbell, EquipmentType.bench],
    ),
  );

  static final _overheadTricepExtension = Exercise(
    id: 'exercise-overhead-tricep-001',
    name: 'Overhead Cable Tricep Extension',
    aliases: ['overhead extension'],
    description: 'Tricep isolation exercise stretching the long head overhead.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.isolation],
      primaryMuscles: [MuscleGroup.triceps],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.cable],
    ),
  );

  static final _skullCrusher = Exercise(
    id: 'exercise-skull-crusher-001',
    name: 'Lying Tricep Extension',
    aliases: ['skull crusher'],
    description:
        'Tricep extension performed lying on a bench with a barbell or EZ-bar.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.isolation],
      primaryMuscles: [MuscleGroup.triceps],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.barbell, EquipmentType.bench],
    ),
  );

  static final _legExtension = Exercise(
    id: 'exercise-leg-extension-001',
    name: 'Leg Extension Machine',
    aliases: ['leg extension'],
    description: 'Machine-based isolation movement targeting the quadriceps.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.lowerBody],
      movementPatterns: [MovementPattern.isolation],
      primaryMuscles: [MuscleGroup.quads],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.machine],
    ),
  );

  static final _seatedLegCurl = Exercise(
    id: 'exercise-seated-leg-curl-001',
    name: 'Seated Leg Curl Machine',
    aliases: ['seated leg curl'],
    description: 'Machine-based hamstring isolation exercise performed in a seated position.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.lowerBody],
      movementPatterns: [MovementPattern.isolation],
      primaryMuscles: [MuscleGroup.hamstrings],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.machine],
    ),
  );

  static final _lyingLegCurl = Exercise(
    id: 'exercise-lying-leg-curl-001',
    name: 'Lying Leg Curl Machine',
    aliases: ['lying leg curl'],
    description:
        'Hamstring isolation curl performed face down on a padded machine.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.lowerBody],
      movementPatterns: [MovementPattern.isolation],
      primaryMuscles: [MuscleGroup.hamstrings],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.machine],
    ),
  );

  static final _standingCalfRaise = Exercise(
    id: 'exercise-standing-calf-raise-001',
    name: 'Standing Calf Raise',
    aliases: ['calf raise'],
    description: 'Calf isolation exercise lifting heels against resistance.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.lowerBody],
      movementPatterns: [MovementPattern.isolation],
      primaryMuscles: [MuscleGroup.calves],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.machine],
    ),
  );

  static final _seatedCalfRaise = Exercise(
    id: 'exercise-seated-calf-raise-001',
    name: 'Seated Calf Raise',
    aliases: ['seated calf'],
    description: 'Calf raise emphasizing the soleus muscle with knees bent.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.lowerBody],
      movementPatterns: [MovementPattern.isolation],
      primaryMuscles: [MuscleGroup.calves],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.machine],
    ),
  );

  static final _barbellHipThrust = Exercise(
    id: 'exercise-hip-thrust-001',
    name: 'Barbell Hip Thrust',
    aliases: ['hip thrust'],
    description: 'Glute-focused hip extension movement with upper back resting on a bench.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.lowerBody],
      movementPatterns: [MovementPattern.hinge],
      primaryMuscles: [MuscleGroup.glutes],
      secondaryMuscles: [MuscleGroup.hamstrings],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.barbell, EquipmentType.bench],
    ),
  );

  static final _cablePullThrough = Exercise(
    id: 'exercise-cable-pull-through-001',
    name: 'Cable Pull-Through',
    aliases: ['pull through'],
    description:
        'Hip hinge movement using a low cable pulley between the legs.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.lowerBody],
      movementPatterns: [MovementPattern.hinge],
      primaryMuscles: [MuscleGroup.glutes, MuscleGroup.hamstrings],
      secondaryMuscles: [MuscleGroup.lowerBack],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.cable],
    ),
  );

  static final _hangingLegRaise = Exercise(
    id: 'exercise-hanging-leg-raise-001',
    name: 'Hanging Leg Raise',
    aliases: ['leg raise'],
    description:
        'Core strength exercise raising legs while hanging from a pull-up bar.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.fullBody],
      movementPatterns: [MovementPattern.isolation],
      primaryMuscles: [MuscleGroup.core],
      secondaryMuscles: [MuscleGroup.forearms],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.pullUpBar],
    ),
  );

  static final _cableWoodchopper = Exercise(
    id: 'exercise-cable-woodchopper-001',
    name: 'Cable Woodchopper',
    aliases: ['woodchopper'],
    description: 'Rotational core strengthening exercise using a cable pulley.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.fullBody],
      movementPatterns: [MovementPattern.isolation],
      primaryMuscles: [MuscleGroup.core],
      secondaryMuscles: [MuscleGroup.frontDelts],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.cable],
    ),
  );

  static final _plank = Exercise(
    id: 'exercise-plank-001',
    name: 'Forearm Plank',
    aliases: ['plank'],
    description: 'Isometric core stabilization exercise holding a straight body position.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.fullBody],
      movementPatterns: [MovementPattern.isolation],
      primaryMuscles: [MuscleGroup.core],
      secondaryMuscles: [MuscleGroup.shoulders],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.bodyweight],
    ),
  );

  static final _farmersWalk = Exercise(
    id: 'exercise-farmers-walk-001',
    name: "Farmer's Walk",
    aliases: ['farmers carry'],
    description: 'Carrying heavy dumbbells or kettlebells over a distance for grip and total body conditioning.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.fullBody],
      movementPatterns: [MovementPattern.isolation],
      primaryMuscles: [MuscleGroup.forearms, MuscleGroup.traps],
      secondaryMuscles: [MuscleGroup.core, MuscleGroup.quads],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.dumbbell],
    ),
  );

  static final _chestSupportedRow = Exercise(
    id: 'exercise-chest-supported-row-001',
    name: 'Chest-Supported Dumbbell Row',
    aliases: ['incline bench row'],
    description: 'Horizontal row performed face down on an inclined bench to eliminate lower back strain.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.horizontalPull],
      primaryMuscles: [MuscleGroup.lats, MuscleGroup.traps],
      secondaryMuscles: [MuscleGroup.biceps, MuscleGroup.rearDelts],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.dumbbell, EquipmentType.bench],
    ),
  );
}
