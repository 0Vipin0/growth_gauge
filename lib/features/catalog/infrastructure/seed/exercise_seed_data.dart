import '../../domain/exercise.dart';
import '../../domain/exercise_classification.dart';
import '../../domain/exercise_enums.dart';
import '../../domain/exercise_equipment.dart';
import '../../domain/exercise_execution.dart';

/// Canonical system exercise seed data.
///
/// These 89 exercises are seeded on first launch if the catalog is empty.
/// Every exercise ships with a complete execution profile (setup, execution,
/// technique cues and breathing) covering the staples used by beginner,
/// intermediate and advanced lifters.
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
    _walkingLunge,
    _gluteBridge,
    _closeGripBenchPress,
    _pushPress,
    _weightedPullUp,
    _barbellShrug,
    _rearDeltFly,
    _backExtension,
    _machineChestPress,
    _deadBug,
    _armCircles,
    _birdDog,
    _bodyweightSquat,
    _burpee,
    _calfStretch,
    _catCow,
    _childsPose,
    _crossBodyShoulderStretch,
    _dumbbellSwing,
    _dumbbellThruster,
    _diaphragmaticBreathing,
    _doorwayChestStretch,
    _figureFourStretch,
    _hamstringStretch,
    _hipFlexorStretch,
    _inchworm,
    _jumpRope,
    _jumpSquat,
    _jumpingJack,
    _legSwings,
    _lyingSpinalTwist,
    _mountainClimber,
    _overheadTricepStretch,
    _quadStretch,
    _recoveryWalk,
    _rowingMachine,
    _stationaryBike,
    _treadmillRun,
    _worldsGreatestStretch,
  ];

  // 1-7 (Original Reference Exercises)
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Set barbell in rack at mid-chest height.',
        'Step under bar, resting it across upper traps, hands gripping firmly just outside shoulders.',
        'Unrack bar, take 2-3 controlled steps back, setting feet shoulder-width apart with toes flared slightly.',
      ],
      executionInstructions: [
        'Inhale deeply and brace core with intra-abdominal pressure.',
        'Hinge hips back and bend knees, descending until hip crease passes below knee level.',
        'Drive through mid-foot and extend hips and knees forcefully to return to standing.',
      ],
      techniqueCues: [
        'Knees track over toes',
        'Keep chest proud and spine neutral',
        'Drive through mid-foot',
      ],
      breathingInstructions: 'Inhale and brace at the top, hold through descent, exhale as you complete the ascent.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Stand with mid-foot directly beneath barbell, feet hip-width apart.',
        'Hinge at hips and grip barbell just outside shins with double-overhand or mixed grip.',
        'Pull shoulder blades down and back, engage lats, and take the slack out of the bar.',
      ],
      executionInstructions: [
        'Inhale deeply and brace abdominal wall against a neutral spine.',
        'Push the floor away through mid-foot, driving hips and knees forward simultaneously.',
        'Lock out with glutes and tall chest without hyperextending lower back.',
      ],
      techniqueCues: [
        'Keep bar in contact with legs throughout',
        'Pack the lats and pull slack out',
        'Push floor away rather than pulling bar',
      ],
      breathingInstructions: 'Deep diaphragmatic breath at setup; hold breath through pull; exhale upon lockout.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Lie flat on bench with eyes directly under the racked bar.',
        'Retract and depress shoulder blades, driving upper back into bench with firm arch.',
        'Grip bar slightly wider than shoulder-width and plant feet firmly on the ground.',
      ],
      executionInstructions: [
        'Unrack bar and stabilize it directly over sternum with locked elbows.',
        'Lower bar in a controlled diagonal path to touch lower chest / sternum, elbows tucked ~45-75 degrees.',
        'Press bar up and slightly back toward eye line until arms are fully extended.',
      ],
      techniqueCues: [
        'Keep shoulder blades squeezed together',
        'Drive legs into floor for leg drive',
        'Tuck elbows ~45-75 degrees',
      ],
      breathingInstructions: 'Inhale and brace core before lowering; exhale as you push past the sticking point.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Set barbell at collarbone height in rack.',
        'Grip bar just outside shoulders with wrists stacked over forearms.',
        'Unrack, step back, squeeze glutes, brace abs, and pull head slightly back.',
      ],
      executionInstructions: [
        'Press bar vertically in a straight path, clearing chin and nose.',
        'Once bar passes forehead, push head forward into neutral window.',
        'Lock out bar directly over shoulders and mid-foot.',
      ],
      techniqueCues: [
        'Squeeze glutes and quads to create a rigid base',
        'Keep wrists straight and forearms vertical',
        'Push head through at lockout',
      ],
      breathingInstructions:
          'Inhale and brace before each rep; exhale as bar locks out overhead.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Stand over barbell with feet hip-width apart and bar over mid-foot.',
        'Hinge at hips with soft knees until torso is angled between 15-45 degrees above parallel.',
        'Grip bar overhand slightly wider than shoulder-width with arms fully extended.',
      ],
      executionInstructions: [
        'Brace core and pull barbell towards lower ribs / navel, driving elbows back.',
        'Squeeze shoulder blades and lats at the top of the pull.',
        'Lower bar under control until arms are fully extended without losing spinal neutrality.',
      ],
      techniqueCues: [
        'Keep spine neutral without swinging torso',
        'Lead movement with elbows',
        'Squeeze shoulder blades at top',
      ],
      breathingInstructions: 'Inhale before pull; exhale during concentric contraction; inhale on return.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Grip overhead pull-up bar with overhand grip slightly wider than shoulder-width.',
        'Hang with arms fully extended and engage core to prevent swinging.',
      ],
      executionInstructions: [
        'Depress shoulder blades down and back to initiate pull.',
        'Drive elbows down toward floor, pulling chest toward the bar until chin clears bar height.',
        'Lower under control back to full dead hang.',
      ],
      techniqueCues: [
        'Depress scaps before bending elbows',
        'Drive elbows into back pockets',
        'Avoid kicking or swinging legs',
      ],
      breathingInstructions:
          'Exhale on the pull upward; inhale on the controlled descent.',
    ),
  );

  static final _dumbbellRdl = Exercise(
    id: 'exercise-rdl-001',
    name: 'Dumbbell RDL',
    aliases: ['Romanian deadlift', 'dumbbell Romanian deadlift'],
    description: 'Hip-hinge movement with dumbbells emphasising hamstrings.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Stand tall holding a dumbbell in each hand at sides or front of thighs.',
        'Set feet hip-width apart, soften knees slightly, and pull shoulders down and back.',
      ],
      executionInstructions: [
        'Hinge hips backwards, sliding dumbbells down along front of legs.',
        'Maintain neutral spine until feeling a deep stretch in hamstrings (around mid-shin).',
        'Contract glutes and hamstrings to drive hips forward back to starting position.',
      ],
      techniqueCues: [
        'Hinge hips backward as if pushing a door closed',
        'Keep dumbbells close to thighs and shins',
        'Do not round lower back',
      ],
      breathingInstructions:
          'Inhale and brace on descent; exhale forcefully as hips lock out.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Set the bench incline to roughly 30-45 degrees and rack the bar at a height you can unrack with arms nearly straight.',
        'Lie back with eyes under the bar, pinch shoulder blades together and plant feet flat on the floor.',
        'Grip the bar slightly wider than shoulder-width with wrists stacked over forearms.',
      ],
      executionInstructions: [
        'Unrack and stabilize the bar over the upper chest with locked elbows.',
        'Lower under control to touch the upper chest just below the collarbone, elbows tucked ~45-60 degrees.',
        'Press the bar up and slightly back to full lockout over the shoulders.',
      ],
      techniqueCues: [
        'Keep the incline moderate so the chest, not the shoulders, does the work',
        'Keep the upper back pinned into the bench',
        'Keep forearms vertical at the bottom',
      ],
      breathingInstructions: 'Inhale and brace before lowering; exhale as you press past the sticking point.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Adjust the thigh pad so your legs are locked in and you stay seated under heavy loads.',
        'Grip the bar with an overhand grip wider than shoulder-width.',
        'Sit tall with a slight lean back and arms fully extended overhead.',
      ],
      executionInstructions: [
        'Depress the shoulder blades first, then pull the bar down to the upper chest.',
        'Drive elbows down and slightly back, pausing briefly with lats fully contracted.',
        'Return the bar slowly until arms are straight and lats are fully stretched.',
      ],
      techniqueCues: [
        'Think about pulling elbows to hips, not hands to chest',
        'Avoid swinging the torso to move the weight',
        'Do not pull the bar behind the neck',
      ],
      breathingInstructions: 'Exhale as you pull the bar down; inhale as the bar returns overhead.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Adjust the seat so knees reach about 90 degrees at the bottom with hips staying flat on the pad.',
        'Place feet shoulder-width apart in the middle of the platform with toes slightly turned out.',
        'Press the platform up, release the safety handles and keep lower back and hips pressed into the seat.',
      ],
      executionInstructions: [
        'Lower the platform under control until knees reach roughly 90 degrees.',
        'Press through the mid-foot and heels to extend knees and hips.',
        'Stop just short of locking the knees, then repeat.',
      ],
      techniqueCues: [
        'Keep hips and lower back glued to the pad',
        'Track knees over toes without letting them cave in',
        'Do not slam into a hard knee lockout',
      ],
      breathingInstructions:
          'Inhale on the way down; exhale as you press the platform away.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Stand tall holding a dumbbell in each hand with palms facing forward.',
        'Pin elbows to your sides and brace your core with feet hip-width apart.',
      ],
      executionInstructions: [
        'Curl the dumbbells up by bending at the elbows, rotating palms to face the shoulders.',
        'Squeeze the biceps hard at the top without letting elbows drift forward.',
        'Lower slowly over 2-3 seconds to a full elbow extension.',
      ],
      techniqueCues: [
        'Keep elbows pinned at your sides',
        'Do not swing or lean back to cheat the weight up',
        'Use the full range of motion on every rep',
      ],
      breathingInstructions: 'Exhale as you curl up; inhale as you lower.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Attach a straight bar or rope to a high pulley and stand close to the stack.',
        'Grip the attachment with elbows pinned to your sides and forearms at about 90 degrees.',
        'Hinge very slightly forward with a braced core and feet shoulder-width apart.',
      ],
      executionInstructions: [
        'Press the attachment down by extending the elbows until arms are fully straight.',
        'Squeeze the triceps hard for a brief pause at the bottom.',
        'Let the attachment rise under control until forearms are just past 90 degrees.',
      ],
      techniqueCues: [
        'Keep elbows locked at your sides',
        'Do not lean over the bar to push with bodyweight',
        'Keep wrists neutral and straight',
      ],
      breathingInstructions:
          'Exhale as you push down; inhale as the attachment returns up.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Stand tall holding light dumbbells at your sides with a slight bend in the elbows.',
        'Lean very slightly forward from the hips and brace your core.',
      ],
      executionInstructions: [
        'Raise the dumbbells out to the sides, leading with the elbows, until arms reach about shoulder height.',
        'Pause briefly at the top with the shoulders feeling the contraction.',
        'Lower slowly over 2-3 seconds without letting the dumbbells drop.',
      ],
      techniqueCues: [
        'Think of pouring water from a pitcher at the top',
        'Keep shoulders down away from your ears, do not shrug',
        'Use lighter weights and strict form rather than momentum',
      ],
      breathingInstructions:
          'Exhale as you raise the weights; inhale as you lower.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Stand about two feet in front of a bench and rest the laces of your rear foot on it.',
        'Hold a dumbbell in each hand at your sides and set the front foot far enough forward that the shin stays near vertical at the bottom.',
        'Stand tall with ribs down and weight mostly on the front leg.',
      ],
      executionInstructions: [
        'Lower straight down by bending the front knee until the thigh is about parallel to the floor.',
        'Let the rear knee drop toward the floor without slamming it down.',
        'Drive through the front mid-foot to return to standing, then repeat before switching legs.',
      ],
      techniqueCues: [
        'Lean slightly forward to bias glutes, stay upright to bias quads',
        'Keep the front knee tracking over the toes',
        'Let the front leg do the work, the rear leg only balances',
      ],
      breathingInstructions:
          'Inhale on the way down; exhale as you drive back up.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Take a wide stance with toes turned out about 30-45 degrees and the bar over mid-foot, shins close to the bar.',
        'Hinge down and grip the bar with arms hanging straight inside the knees.',
        'Drop hips, lift the chest, pull shoulders down and take the slack out of the bar.',
      ],
      executionInstructions: [
        'Brace hard and push the floor apart through the feet while driving knees out.',
        'Extend hips and knees together, keeping the bar dragging up the legs.',
        'Lock out by squeezing glutes with a tall chest, then lower under control.',
      ],
      techniqueCues: [
        'Keep knees tracking over toes the whole way',
        'Keep chest up and back flat',
        'Spread the floor apart with your feet',
      ],
      breathingInstructions: 'Take a deep breath and brace at setup; hold through the pull; exhale at lockout.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Set the bar at upper-chest height and rest it across the front delts using a clean grip or crossed-arm grip.',
        'Lift the elbows high so the upper arms are roughly parallel to the floor.',
        'Unrack, step back and set feet shoulder-width apart with toes slightly out.',
      ],
      executionInstructions: [
        'Brace the core and descend straight down, sitting between the knees.',
        'Reach at least parallel depth while keeping the elbows high and torso upright.',
        'Drive up through the whole foot, leading with the chest to return to standing.',
      ],
      techniqueCues: [
        'Keep elbows high throughout the lift',
        'Stay as upright as possible',
        'Keep your whole foot planted, with weight at mid-foot',
      ],
      breathingInstructions: 'Inhale and brace at the top; hold through the descent; exhale as you stand.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Hold one dumbbell vertically at chest height, cupping the top end with both hands.',
        'Keep elbows pointing down and stand with feet slightly wider than shoulder-width, toes turned out slightly.',
      ],
      executionInstructions: [
        'Brace your core and sit down between your knees, keeping the chest tall.',
        'Descend until the elbows touch the inside of the knees or thighs are below parallel.',
        'Drive through the whole foot to stand back up.',
      ],
      techniqueCues: [
        'Keep the chest tall and the weight close to the body',
        'Push knees out in line with toes',
        'Use the elbows inside the knees to open up the hips at the bottom',
      ],
      breathingInstructions: 'Inhale on the way down; exhale as you stand up.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Stand holding the barbell at hip height with an overhand grip just outside the thighs.',
        'Set feet hip-width apart with a soft bend in the knees, shoulders pulled down and back.',
      ],
      executionInstructions: [
        'Push the hips straight back, sliding the bar down the thighs and shins.',
        'Lower until you feel a deep hamstring stretch, usually around mid-shin, with a flat back.',
        'Drive the hips forward and squeeze the glutes to stand tall.',
      ],
      techniqueCues: [
        'Keep the bar dragging against your legs',
        'Keep the back flat and the lats tight',
        'Keep shins close to vertical while the hips travel back',
      ],
      breathingInstructions: 'Inhale and brace on the way down; exhale as you drive the hips forward.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Step into the center of the hex bar with feet hip-width apart.',
        'Hinge down and grip the handles with arms straight and hips lower than shoulders.',
        'Pull the chest up and shoulders back to tighten the lats.',
      ],
      executionInstructions: [
        'Brace hard and push the floor away, extending knees and hips together.',
        'Stand tall and squeeze the glutes at lockout without leaning back.',
        'Lower by hinging the hips back first, then bending the knees, and set the bar down under control.',
      ],
      techniqueCues: [
        'Keep chest up and back flat',
        'Keep the bar path straight and close to the body',
        'Think of it as a leg press into the floor',
      ],
      breathingInstructions: 'Inhale and brace before the pull; hold through the rep; exhale at the top.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Set a decline bench at a modest angle and hook your legs securely under the pads.',
        'Lie back with the bar over your lower chest, pinch the shoulder blades together and use a spotter or safety arms if possible.',
        'Grip the bar slightly wider than shoulder-width.',
      ],
      executionInstructions: [
        'Unrack the bar and hold it over your chest with locked elbows.',
        'Lower the bar under control to the lower chest with elbows tucked ~45-60 degrees.',
        'Press the bar back up to full lockout.',
      ],
      techniqueCues: [
        'Keep wrists stacked over elbows',
        'Control the bar down, never bounce it off the chest',
        'Keep the head and upper back pressed into the bench',
      ],
      breathingInstructions:
          'Inhale at the top; hold while lowering; exhale as you press up.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Sit on a flat bench with a dumbbell resting on each thigh.',
        'Lie back, kicking the dumbbells up to chest level, and pinch the shoulder blades together.',
        'Plant feet flat on the floor and press the dumbbells up over the chest.',
      ],
      executionInstructions: [
        'Lower the dumbbells under control, elbows tucked ~45-60 degrees, until you feel a deep chest stretch.',
        'Stop when the elbows are slightly below the bench line.',
        'Press the dumbbells up and slightly inward to full arm extension.',
      ],
      techniqueCues: [
        'Keep wrists stacked over elbows',
        'Keep shoulder blades retracted against the bench',
        'Do not clank the dumbbells together at the top',
      ],
      breathingInstructions: 'Inhale as you lower; exhale as you press up.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Set the bench incline to roughly 30 degrees.',
        'Sit with the dumbbells on your thighs, lie back and kick them up to shoulder level.',
        'Pinch the shoulder blades together and plant your feet firmly on the floor.',
      ],
      executionInstructions: [
        'Press the dumbbells up over the upper chest until arms are fully extended.',
        'Lower under control until elbows are just below the bench line with a deep chest stretch.',
        'Press back up along the same path, squeezing the upper chest at the top.',
      ],
      techniqueCues: [
        'Keep the incline low enough that the chest, not the shoulders, drives the press',
        'Keep forearms vertical throughout',
        'Keep the upper back tight against the pad',
      ],
      breathingInstructions: 'Inhale as you lower; exhale as you press.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Lie on a flat bench holding light dumbbells above your chest with palms facing each other.',
        'Pinch the shoulder blades together and set a slight, fixed bend in the elbows.',
      ],
      executionInstructions: [
        'Open the arms in a wide arc, lowering the dumbbells until you feel a comfortable chest stretch.',
        'Keep the elbow angle fixed as if hugging a large tree.',
        'Squeeze the chest to bring the dumbbells back together over the sternum.',
      ],
      techniqueCues: [
        'Keep the elbow bend constant, do not turn it into a press',
        'Stop lowering when elbows reach about shoulder level',
        'Use lighter weights and control the stretch',
      ],
      breathingInstructions:
          'Inhale as the arms open; exhale as you squeeze them together.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Set both pulleys to a high position and grab a handle in each hand.',
        'Step forward into a split stance with a slight forward hinge and braced core.',
        'Start with arms out wide and a soft, fixed bend in the elbows.',
      ],
      executionInstructions: [
        'Sweep the handles down and together in an arc until hands meet in front of the lower chest.',
        'Squeeze the chest hard for a brief pause.',
        'Return slowly along the same arc until you feel a stretch across the chest.',
      ],
      techniqueCues: [
        'Keep the elbow bend constant throughout',
        'Keep the torso still, do not rock with the weight',
        'Lead with the elbows and squeeze with the chest',
      ],
      breathingInstructions:
          'Exhale as the hands come together; inhale as the arms open.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Sit at the cable station with feet on the platform and knees slightly bent.',
        'Grab the handle with arms extended and sit tall with a neutral spine.',
      ],
      executionInstructions: [
        'Pull the handle toward your lower ribs, driving elbows straight back.',
        'Squeeze the shoulder blades together at the end of the pull.',
        'Extend the arms slowly until the lats stretch, keeping the torso upright.',
      ],
      techniqueCues: [
        'Keep the chest tall without leaning back excessively',
        'Keep shoulders down and away from the ears',
        'Lead the pull with the elbows, not the hands',
      ],
      breathingInstructions:
          'Exhale as you pull; inhale as you extend the arms.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Straddle the loaded bar and hinge forward at the hips to about a 45-degree torso angle.',
        'Grip the handle attachment or bar end with arms hanging straight and a soft knee bend.',
        'Set a flat back and brace the core before the first rep.',
      ],
      executionInstructions: [
        'Row the weight toward your lower chest and upper abdomen, driving elbows back.',
        'Squeeze the shoulder blades together at the top.',
        'Lower the weight slowly until arms are fully extended without rounding the back.',
      ],
      techniqueCues: [
        'Keep the chest up and spine neutral',
        'Do not jerk or use momentum from the hips',
        'Keep the torso angle fixed through the set',
      ],
      breathingInstructions:
          'Inhale before the pull; exhale as you row; inhale as you lower.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Place one hand and the same-side knee on a flat bench with the back flat and parallel to the floor.',
        'Hold a dumbbell in the free hand with the arm hanging straight down under the shoulder.',
        'Keep the other foot planted on the floor for stability.',
      ],
      executionInstructions: [
        'Row the dumbbell toward your hip, keeping the elbow close to the body.',
        'Squeeze the lat at the top without rotating the torso.',
        'Lower under control to a full stretch at the bottom.',
      ],
      techniqueCues: [
        'Think about driving the elbow to the hip',
        'Keep the hips and shoulders square to the floor',
        'Do not twist or yank the weight up',
      ],
      breathingInstructions: 'Exhale as you row; inhale as you lower.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Grip the bar with an underhand grip at about shoulder-width.',
        'Hang with arms fully extended, core braced and legs straight or slightly bent behind you.',
      ],
      executionInstructions: [
        'Depress the shoulder blades, then pull your chest toward the bar.',
        'Continue until your chin clears the bar, keeping elbows driving down and forward.',
        'Lower slowly to a full dead hang.',
      ],
      techniqueCues: [
        'Lead with the chest toward the bar',
        'Avoid kipping or swinging',
        'Fully extend the arms at the bottom of every rep',
      ],
      breathingInstructions: 'Exhale as you pull up; inhale as you lower.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Place hands on floor slightly wider than shoulder-width apart.',
        'Extend legs straight behind you, supporting weight on balls of feet.',
        'Engage glutes and core to form a rigid, straight line from head to heels.',
      ],
      executionInstructions: [
        'Lower chest toward floor by bending elbows back at ~45-degree angle.',
        'Descend until chest is about an inch above the floor.',
        'Press floor away through palms to return to full arm extension.',
      ],
      techniqueCues: [
        'Do not let hips sag or hike up',
        'Keep elbows tucked ~45 degrees, not flared out 90 degrees',
        'Maintain a packed, neutral neck',
      ],
      breathingInstructions:
          'Inhale on the way down; exhale as you press back up.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Grip parallel bars firmly and press yourself up until arms are fully locked.',
        'Cross ankles and bend knees slightly if needed for ground clearance.',
        'Lean torso slightly forward (~15 degrees) for chest emphasis.',
      ],
      executionInstructions: [
        'Lower body smoothly by bending elbows until shoulders are below elbows (90 degrees).',
        'Pause momentarily in the deep stretched position.',
        'Press back up through palms until arms are locked out.',
      ],
      techniqueCues: [
        'Keep shoulders depressed away from ears',
        'Avoid excessive forward shoulder rolling at bottom',
        'Control descent to protect shoulder joints',
      ],
      breathingInstructions:
          'Inhale on the descent; exhale forcefully as you drive back up.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Set a bench to a near-upright back angle and sit with your back fully supported.',
        'Bring the dumbbells to shoulder height with palms facing forward and elbows slightly in front of the body.',
        'Plant feet flat and brace the core.',
      ],
      executionInstructions: [
        'Press the dumbbells up and slightly inward until arms are fully extended overhead.',
        'Pause briefly at lockout with the weights directly above the shoulders.',
        'Lower under control until the dumbbells return to about ear level.',
      ],
      techniqueCues: [
        'Keep forearms vertical throughout the press',
        'Keep ribs down and avoid arching the lower back',
        'Do not shrug the shoulders toward the ears',
      ],
      breathingInstructions: 'Inhale and brace before pressing; exhale as the dumbbells go overhead.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Sit on an upright bench holding the dumbbells in front of your chest with palms facing you.',
        'Keep elbows tucked in front of the body and brace the core.',
      ],
      executionInstructions: [
        'Press the dumbbells up while rotating the palms outward so they face forward at lockout.',
        'Extend the arms fully overhead without shrugging.',
        'Lower while rotating the palms back toward you until the dumbbells return to chest level.',
      ],
      techniqueCues: [
        'Rotate smoothly and continuously through the press',
        'Use lighter weights than a standard press',
        'Avoid leaning back or arching the lower back',
      ],
      breathingInstructions:
          'Exhale as you press overhead; inhale as you lower.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Attach a rope to a cable set at about upper-chest to face height.',
        'Grab the rope with an overhand grip, step back until the cable is taut and stand with feet hip-width apart.',
      ],
      executionInstructions: [
        'Pull the rope toward your face, splitting the ends apart as they reach either side of your head.',
        'Keep elbows high and externally rotate so your knuckles point toward the ceiling.',
        'Squeeze the rear delts and upper back, then return slowly with control.',
      ],
      techniqueCues: [
        'Keep elbows high, roughly level with the shoulders',
        'Pull the rope apart rather than just back',
        'Do not lean back or use momentum',
      ],
      breathingInstructions: 'Exhale as you pull; inhale as you return.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Stand tall holding a straight or EZ-bar with an underhand, shoulder-width grip.',
        'Pin the elbows to your sides and set the feet hip-width apart with a braced core.',
      ],
      executionInstructions: [
        'Curl the bar up by flexing the elbows until the biceps are fully contracted.',
        'Pause briefly at the top without letting the elbows travel forward.',
        'Lower the bar slowly to full elbow extension.',
      ],
      techniqueCues: [
        'Keep elbows fixed at your sides',
        'Do not swing the hips or lean back to cheat the weight',
        'Control the lowering phase',
      ],
      breathingInstructions: 'Exhale as you curl up; inhale as you lower.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Stand tall holding a dumbbell in each hand with palms facing your thighs.',
        'Pin the elbows to your sides and brace the core.',
      ],
      executionInstructions: [
        'Curl the dumbbells up keeping the palms facing each other the entire time.',
        'Squeeze at the top without moving the elbows forward.',
        'Lower slowly to full arm extension.',
      ],
      techniqueCues: [
        'Keep the wrists neutral and locked',
        'Keep the upper arms still',
        'Avoid swinging with the torso',
      ],
      breathingInstructions: 'Exhale as you curl; inhale as you lower.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Adjust the seat so your armpits rest at the top of the pad and the upper arms lie flat along it.',
        'Grip an EZ-bar or straight bar with an underhand, shoulder-width grip.',
      ],
      executionInstructions: [
        'Curl the bar up until the biceps are fully contracted.',
        'Hold briefly at the top without lifting the elbows off the pad.',
        'Lower slowly to near full extension, keeping tension on the biceps.',
      ],
      techniqueCues: [
        'Keep the upper arms and chest glued to the pad',
        'Do not drop the weight in the bottom position',
        'Do not lift the hips off the seat to help the curl',
      ],
      breathingInstructions: 'Exhale as you curl up; inhale as you lower.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Attach a rope to a low or mid pulley and face away from the stack.',
        'Hold the rope overhead with both hands, elbows pointed forward and close to the head.',
        'Stand in a split stance with the core braced.',
      ],
      executionInstructions: [
        'Extend the elbows to press the rope forward and up until arms are fully straight.',
        'Squeeze the triceps at lockout.',
        'Return slowly behind the head to a deep tricep stretch.',
      ],
      techniqueCues: [
        'Keep elbows pointed forward and narrow, not flared',
        'Keep ribs down and avoid arching the lower back',
        'Keep the upper arms still, only the forearms move',
      ],
      breathingInstructions: 'Exhale as you extend; inhale as you return.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Lie on a flat bench holding an EZ-bar with a narrow overhand grip.',
        'Press the bar up over your chest with arms straight and elbows pointing toward the ceiling.',
      ],
      executionInstructions: [
        'Bend only at the elbows to lower the bar toward your forehead or just behind your head.',
        'Pause when you feel a deep tricep stretch.',
        'Extend the elbows to press the bar back to the start.',
      ],
      techniqueCues: [
        'Keep upper arms stationary and perpendicular to the floor',
        'Keep elbows narrow, do not let them flare',
        'Control the descent and use a spotter on heavy sets',
      ],
      breathingInstructions: 'Inhale as you lower; exhale as you extend.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Adjust the back pad so your knees line up with the machine pivot point.',
        'Set the ankle pad just above your feet and grip the handles for stability.',
      ],
      executionInstructions: [
        'Extend the knees until the legs are straight, squeezing the quads hard at the top.',
        'Hold for a brief pause at full extension.',
        'Lower slowly over 2-3 seconds without letting the weight stack touch down.',
      ],
      techniqueCues: [
        'Keep hips seated and do not lift them off the pad',
        'Avoid swinging or kicking the weight up',
        'Control the lowering phase',
      ],
      breathingInstructions:
          'Exhale as you extend the legs; inhale as you lower.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Adjust the seat and back pad so your knees line up with the machine pivot.',
        'Position the ankle pad just above the heels and lower the thigh pad snugly over your legs.',
      ],
      executionInstructions: [
        'Curl the heels down and back toward the glutes, squeezing the hamstrings.',
        'Hold briefly at the bottom of the movement.',
        'Return slowly until the legs are nearly straight, keeping tension on the hamstrings.',
      ],
      techniqueCues: [
        'Keep the hips pressed back into the seat',
        'Do not use momentum or jerk the weight',
        'Control the return for a full stretch',
      ],
      breathingInstructions: 'Exhale as you curl down; inhale as you return.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Lie face down on the machine with your knees just off the edge of the bench and in line with the pivot.',
        'Set the roller pad on the lower calves just above the heels and grip the handles.',
      ],
      executionInstructions: [
        'Curl the heels toward the glutes, squeezing the hamstrings at the top.',
        'Pause briefly at peak contraction.',
        'Lower slowly under control until the legs are almost fully extended.',
      ],
      techniqueCues: [
        'Keep the hips pressed into the bench',
        'Do not arch the lower back to help the curl',
        'Use a controlled tempo, especially on the way down',
      ],
      breathingInstructions: 'Exhale as you curl up; inhale as you lower.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Position your shoulders under the pads of the machine and place the balls of your feet on the platform.',
        'Stand tall with knees nearly straight and the core braced.',
      ],
      executionInstructions: [
        'Lower the heels as far as comfortable to get a deep calf stretch.',
        'Press up through the balls of the feet as high as possible.',
        'Pause for a second at the top, then lower slowly.',
      ],
      techniqueCues: [
        'Use the full range of motion on every rep',
        'Keep knees nearly straight but not locked',
        'Avoid bouncing at the bottom of the rep',
      ],
      breathingInstructions:
          'Exhale as you rise onto your toes; inhale as you lower.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Sit at the machine and place the balls of your feet on the platform.',
        'Set the knee pad firmly across the lower thighs with knees bent to about 90 degrees.',
      ],
      executionInstructions: [
        'Release the safety and lower the heels for a deep stretch in the calves.',
        'Press up through the balls of the feet as high as possible.',
        'Hold the top briefly, then lower slowly.',
      ],
      techniqueCues: [
        'Use a full stretch at the bottom and full contraction at the top',
        'Keep the movement slow and controlled',
        'Do not bounce the weight off the stretch',
      ],
      breathingInstructions:
          'Exhale as you raise the heels; inhale as you lower.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Sit on floor with upper back against a sturdy bench (around shoulder blade level).',
        'Roll a loaded, padded barbell over legs until it rests in the hip crease.',
        'Plant feet firmly flat on floor, shoulder-width apart, knees bent at ~90 degrees when raised.',
      ],
      executionInstructions: [
        'Drive through heels and extend hips upward until thighs and torso form a straight line.',
        'Squeeze glutes intensely at top lockout while maintaining a chin-tucked position.',
        'Lower hips under control until nearly touching the floor before repeating.',
      ],
      techniqueCues: [
        'Keep ribs down and chin tucked (eyes looking forward, not at ceiling)',
        'Drive primarily through heels',
        'Full hip extension at top with glute squeeze',
      ],
      breathingInstructions:
          'Inhale at bottom; exhale forcefully as hips thrust upward.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Attach a rope to a low pulley and face away from the stack, holding the rope between your legs.',
        'Walk forward until the cable is taut and set feet shoulder-width apart with a soft knee bend.',
      ],
      executionInstructions: [
        'Hinge at the hips, pushing them back so the rope travels between your legs.',
        'Lower until you feel a deep hamstring stretch while keeping the back flat.',
        'Drive the hips forward and squeeze the glutes to stand tall.',
      ],
      techniqueCues: [
        'Keep the arms long and let the hips do the work',
        'This is a hinge, not a squat',
        'Finish tall with glutes squeezed, without leaning back',
      ],
      breathingInstructions:
          'Inhale as you hinge back; exhale as you drive the hips forward.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Hang from a pull-up bar with an overhand grip and arms fully extended.',
        'Pull your shoulders down slightly and keep the legs together and straight or slightly bent.',
      ],
      executionInstructions: [
        'Tilt the pelvis back and raise the legs until they reach at least hip height, higher if you can control it.',
        'Curl the pelvis up at the top to fully engage the abs.',
        'Lower the legs slowly without swinging.',
      ],
      techniqueCues: [
        'Curl the pelvis rather than just lifting the legs',
        'Avoid swinging or using momentum',
        'Control the descent for full tension',
      ],
      breathingInstructions: 'Exhale as the legs rise; inhale as they lower.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Set the cable high and stand sideways to the stack with feet slightly wider than shoulder-width.',
        'Grip the handle with both hands, arms extended toward the pulley, and brace the core.',
      ],
      executionInstructions: [
        'Rotate the torso and pull the handle diagonally down and across the body toward the opposite hip.',
        'Pivot the back foot and keep the arms mostly straight so the core drives the motion.',
        'Return slowly to the start under control, then repeat before switching sides.',
      ],
      techniqueCues: [
        'Rotate through the torso, not just the arms',
        'Keep hips stable and let the back foot pivot naturally',
        'Control the return to avoid being pulled back by the weight',
      ],
      breathingInstructions:
          'Exhale as you chop down and across; inhale as you return.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Place forearms on floor with elbows directly beneath shoulders.',
        'Extend legs straight behind you, feet together or hip-width apart on toes.',
      ],
      executionInstructions: [
        'Brace abdominal muscles as if anticipating a punch.',
        'Squeeze glutes and quads to keep hips from dropping or sagging.',
        'Hold rigid body line for prescribed duration.',
      ],
      techniqueCues: [
        'Do not let hips sag or hike into the air',
        'Keep neck neutral by looking at floor between thumbs',
        'Actively push forearms into the floor',
      ],
      breathingInstructions: 'Take steady, continuous diaphragmatic breaths while maintaining abdominal brace.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Stand between two heavy dumbbells with feet hip-width apart.',
        'Hinge down, grip each handle firmly and stand up tall with shoulders pulled down and back.',
      ],
      executionInstructions: [
        'Walk forward with quick, controlled steps while keeping the torso upright.',
        'Squeeze the handles hard and keep the core braced throughout.',
        'Carry for the prescribed distance or time, then set the weights down by hinging at the hips.',
      ],
      techniqueCues: [
        'Stand tall and do not lean to either side',
        'Keep shoulders packed and not shrugged to the ears',
        'Take short, steady steps rather than long strides',
      ],
      breathingInstructions:
          'Breathe steadily and continuously while keeping the core braced.',
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
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Set a bench to a 30-45 degree incline and lie face down with the chest supported on the pad.',
        'Let the dumbbells hang straight down with arms fully extended and feet planted on the floor.',
      ],
      executionInstructions: [
        'Row the dumbbells up toward your hips, driving the elbows back and up.',
        'Squeeze the shoulder blades together at the top.',
        'Lower slowly to a full stretch without losing contact with the pad.',
      ],
      techniqueCues: [
        'Keep the chest glued to the pad throughout',
        'Lead the pull with the elbows',
        'Avoid shrugging the shoulders toward the ears',
      ],
      breathingInstructions: 'Exhale as you row; inhale as you lower.',
    ),
  );

  // 51-60 (Additional Staples: beginner, intermediate and advanced)
  static final _walkingLunge = Exercise(
    id: 'exercise-walking-lunge-001',
    name: 'Dumbbell Walking Lunge',
    aliases: ['walking lunge', 'db lunge'],
    description: 'Unilateral lower-body exercise stepping forward into alternating lunges while holding dumbbells.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.lowerBody],
      movementPatterns: [MovementPattern.squat],
      primaryMuscles: [MuscleGroup.quads, MuscleGroup.glutes],
      secondaryMuscles: [MuscleGroup.hamstrings, MuscleGroup.core],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.dumbbell],
    ),
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Hold a dumbbell in each hand at your sides and stand tall with feet hip-width apart.',
        'Clear a straight walking path of 10-20 meters.',
      ],
      executionInstructions: [
        'Take a long step forward and lower the back knee toward the floor until both knees are at about 90 degrees.',
        'Drive through the front heel and mid-foot to rise and bring the back leg through into the next step.',
        'Continue alternating legs for the prescribed reps or distance.',
      ],
      techniqueCues: [
        'Take a long enough step that the front shin stays near vertical',
        'Keep the torso tall and core braced',
        'Keep the front knee tracking over the toes',
      ],
      breathingInstructions: 'Inhale as you lower into the lunge; exhale as you drive up and step through.',
    ),
  );

  static final _gluteBridge = Exercise(
    id: 'exercise-glute-bridge-001',
    name: 'Glute Bridge',
    aliases: ['bodyweight glute bridge', 'hip bridge'],
    description: 'Beginner-friendly floor hip extension that builds glute strength and hip control.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.lowerBody],
      movementPatterns: [MovementPattern.hinge],
      primaryMuscles: [MuscleGroup.glutes],
      secondaryMuscles: [MuscleGroup.hamstrings, MuscleGroup.core],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.bodyweight],
    ),
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Lie on your back with knees bent and feet flat on the floor, hip-width apart.',
        'Rest arms at your sides with palms down and tuck the chin slightly.',
      ],
      executionInstructions: [
        'Brace the core and drive through the heels to lift the hips toward the ceiling.',
        'Squeeze the glutes at the top until shoulders, hips and knees form a straight line.',
        'Lower the hips slowly back to just above the floor and repeat.',
      ],
      techniqueCues: [
        'Keep ribs down and avoid arching the lower back at the top',
        'Push through the heels, not the toes',
        'Pause and squeeze at the top of every rep',
      ],
      breathingInstructions:
          'Exhale as you lift the hips; inhale as you lower.',
    ),
  );

  static final _closeGripBenchPress = Exercise(
    id: 'exercise-close-grip-bench-001',
    name: 'Close-Grip Bench Press',
    aliases: ['CGBP', 'close grip bench'],
    description: 'Barbell bench press variation with a narrower grip to emphasize the triceps.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.horizontalPush],
      primaryMuscles: [MuscleGroup.triceps, MuscleGroup.chest],
      secondaryMuscles: [MuscleGroup.frontDelts],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.barbell, EquipmentType.bench],
    ),
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Lie flat on the bench with eyes under the bar and shoulder blades pinched together.',
        'Grip the bar at about shoulder-width, slightly narrower than a standard bench grip.',
        'Plant feet firmly on the floor and create a stable arch in the upper back.',
      ],
      executionInstructions: [
        'Unrack the bar and hold it over the lower chest with locked elbows.',
        'Lower the bar to the lower chest with the elbows tucked close to the body.',
        'Press the bar up to full lockout, focusing on triceps extension.',
      ],
      techniqueCues: [
        'Keep elbows tucked, do not flare them out',
        'Do not use an extremely narrow grip as it stresses the wrists',
        'Keep wrists stacked over elbows',
      ],
      breathingInstructions:
          'Inhale and brace before lowering; exhale as you press.',
    ),
  );

  static final _pushPress = Exercise(
    id: 'exercise-push-press-001',
    name: 'Barbell Push Press',
    aliases: ['push press'],
    description: 'Explosive overhead press that uses a leg drive to move heavier loads overhead.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.fullBody],
      movementPatterns: [MovementPattern.verticalPush],
      primaryMuscles: [MuscleGroup.frontDelts, MuscleGroup.sideDelts],
      secondaryMuscles: [
        MuscleGroup.triceps,
        MuscleGroup.quads,
        MuscleGroup.traps,
      ],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.barbell],
    ),
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Unrack the bar in the front rack position resting on the front delts with elbows slightly in front of the bar.',
        'Stand with feet hip-width apart, glutes squeezed and core braced.',
      ],
      executionInstructions: [
        'Dip a few inches by bending the knees, keeping the torso upright.',
        'Explosively extend the legs and hips to drive the bar off the shoulders, pressing the arms overhead as the bar rises.',
        'Lock out over the shoulders and mid-foot, then lower the bar back to the front rack with control.',
      ],
      techniqueCues: [
        'Keep the dip vertical, do not lean back',
        'Let the legs launch the bar and the arms finish the press',
        'Push the head through the window at lockout',
      ],
      breathingInstructions: 'Inhale and brace at the top; hold through the dip and drive; exhale at lockout.',
    ),
  );

  static final _weightedPullUp = Exercise(
    id: 'exercise-weighted-pullup-001',
    name: 'Weighted Pull-Up',
    aliases: ['loaded pull-up', 'weighted chin-up'],
    description: 'Advanced vertical pull performed with added load from a dip belt or a dumbbell held between the feet.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.verticalPull],
      primaryMuscles: [MuscleGroup.lats],
      secondaryMuscles: [
        MuscleGroup.biceps,
        MuscleGroup.rearDelts,
        MuscleGroup.forearms,
      ],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.pullUpBar],
    ),
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Secure the added weight with a dip belt, or hold a dumbbell between the feet.',
        'Grip the bar with an overhand grip slightly wider than shoulder-width and hang with arms fully extended.',
        'Brace the core and keep the legs still.',
      ],
      executionInstructions: [
        'Depress the shoulder blades and drive the elbows down to pull the chest toward the bar.',
        'Pull until the chin clears the bar without craning the neck.',
        'Lower slowly to a full dead hang before the next rep.',
      ],
      techniqueCues: [
        'Start every rep from a controlled dead hang',
        'Avoid kipping or swinging under load',
        'Master bodyweight pull-ups for multiple clean reps before adding load',
      ],
      breathingInstructions: 'Exhale as you pull up; inhale as you lower.',
    ),
  );

  static final _barbellShrug = Exercise(
    id: 'exercise-barbell-shrug-001',
    name: 'Barbell Shrug',
    aliases: ['shrug', 'trap shrug'],
    description: 'Isolation exercise elevating the shoulders against a heavy barbell to build the upper traps.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.isolation],
      primaryMuscles: [MuscleGroup.traps],
      secondaryMuscles: [MuscleGroup.forearms],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.barbell],
    ),
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Stand with feet hip-width apart holding a barbell at the thighs with an overhand grip just outside the hips.',
        'Stand tall with arms straight, shoulders relaxed and core braced.',
      ],
      executionInstructions: [
        'Shrug the shoulders straight up toward the ears as high as possible.',
        'Pause for a second at the top with the traps fully contracted.',
        'Lower slowly to a full stretch at the bottom.',
      ],
      techniqueCues: [
        'Lift straight up and down, do not roll the shoulders',
        'Keep arms straight and do not bend the elbows to lift the bar',
        'Keep the head neutral and do not jut the chin forward',
      ],
      breathingInstructions: 'Exhale as you shrug up; inhale as you lower.',
    ),
  );

  static final _rearDeltFly = Exercise(
    id: 'exercise-rear-delt-fly-001',
    name: 'Dumbbell Rear Delt Fly',
    aliases: ['bent-over lateral raise', 'reverse fly'],
    description: 'Isolation exercise for the rear deltoids performed bent over with light dumbbells.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.isolation],
      primaryMuscles: [MuscleGroup.rearDelts],
      secondaryMuscles: [MuscleGroup.traps],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.dumbbell],
    ),
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Hold light dumbbells and hinge forward at the hips until the torso is near parallel to the floor.',
        'Let the arms hang straight down with a soft bend in the elbows and a flat back.',
      ],
      executionInstructions: [
        'Raise the dumbbells out to the sides in a wide arc until the arms are in line with the torso.',
        'Squeeze the rear delts and upper back at the top.',
        'Lower slowly to the start without swinging.',
      ],
      techniqueCues: [
        'Lead with the elbows and keep the elbow angle fixed',
        'Keep the torso still and the neck neutral',
        'Use light weights and avoid shrugging',
      ],
      breathingInstructions:
          'Exhale as you raise the weights; inhale as you lower.',
    ),
  );

  static final _backExtension = Exercise(
    id: 'exercise-back-extension-001',
    name: '45-Degree Back Extension',
    aliases: ['hyperextension', 'back extension'],
    description: 'Hip-hinge exercise on a hyperextension bench that strengthens the lower back, glutes and hamstrings.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.lowerBody],
      movementPatterns: [MovementPattern.hinge],
      primaryMuscles: [MuscleGroup.lowerBack, MuscleGroup.glutes],
      secondaryMuscles: [MuscleGroup.hamstrings],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.machine],
    ),
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Adjust the pad so it sits just below the hips, letting you hinge freely at the waist.',
        'Lock your heels under the foot pads and cross the arms over the chest, or hold a plate against the chest for extra load.',
      ],
      executionInstructions: [
        'Lower the torso under control by hinging at the hips until you feel a stretch in the hamstrings.',
        'Squeeze the glutes and lower back to raise the torso until the body forms a straight line.',
        'Pause briefly at the top without leaning back past neutral.',
      ],
      techniqueCues: [
        'Hinge from the hips, not by rounding the spine',
        'Stop at a straight body line and do not hyperextend',
        'Move with control instead of swinging up',
      ],
      breathingInstructions: 'Inhale as you lower; exhale as you rise.',
    ),
  );

  static final _machineChestPress = Exercise(
    id: 'exercise-machine-chest-press-001',
    name: 'Machine Chest Press',
    aliases: ['seated chest press'],
    description: 'Beginner-friendly guided horizontal press on a machine that targets the chest.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.upperBody],
      movementPatterns: [MovementPattern.horizontalPush],
      primaryMuscles: [MuscleGroup.chest],
      secondaryMuscles: [MuscleGroup.triceps, MuscleGroup.frontDelts],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.machine],
    ),
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Adjust the seat so the handles line up with the middle of your chest.',
        'Sit with your back flat against the pad, feet planted and shoulder blades pinched together.',
      ],
      executionInstructions: [
        'Press the handles forward until the arms are fully extended without locking the elbows hard.',
        'Squeeze the chest at full extension.',
        'Return slowly until you feel a stretch across the chest.',
      ],
      techniqueCues: [
        'Keep shoulders down and back against the pad',
        'Keep wrists straight and stacked over the elbows',
        'Control the return and do not let the stack slam',
      ],
      breathingInstructions:
          'Exhale as you press forward; inhale as you return.',
    ),
  );

  static final _deadBug = Exercise(
    id: 'exercise-dead-bug-001',
    name: 'Dead Bug',
    aliases: ['dead bugs'],
    description: 'Beginner-friendly anti-extension core exercise lowering opposite arm and leg while keeping the back flat.',
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: const ExerciseClassification(
      bodyRegions: [BodyRegion.fullBody],
      movementPatterns: [MovementPattern.isolation],
      primaryMuscles: [MuscleGroup.core],
    ),
    equipment: const ExerciseEquipmentProfile(
      requiredEquipment: [EquipmentType.bodyweight],
    ),
    execution: const ExerciseExecutionProfile(
      setupInstructions: [
        'Lie on your back with arms extended straight up over the shoulders.',
        'Lift the legs so hips and knees are bent at about 90 degrees and press the lower back into the floor.',
      ],
      executionInstructions: [
        'Slowly lower one arm overhead and extend the opposite leg until just above the floor.',
        'Keep the lower back pressed flat throughout.',
        'Return to the start and repeat on the opposite side, alternating.',
      ],
      techniqueCues: [
        'Keep the lower back in contact with the floor at all times',
        'Move slowly and stop before the back starts to arch',
        'Keep the ribs down and the neck relaxed',
      ],
      breathingInstructions:
          'Exhale as you extend the arm and leg; inhale as you return.',
    ),
  );

  // 61-89 (Template support: warm-ups, conditioning, mobility and recovery)
  static final _armCircles = _movement(
    id: 'exercise-arm-circles-001',
    name: 'Arm Circles',
    aliases: const ['shoulder circles'],
    description: 'Dynamic shoulder mobility drill using controlled arm circles to prepare the shoulder girdle.',
    regions: const [BodyRegion.upperBody],
    patterns: const [MovementPattern.isolation],
    primary: const [MuscleGroup.shoulders, MuscleGroup.frontDelts],
    setup: const [
      'Stand tall with feet shoulder-width apart, knees soft and ribs stacked over the pelvis.',
      'Extend both arms out to the sides at shoulder height with elbows relaxed.',
    ],
    execution: const [
      'Make small forward circles from the shoulders, gradually increasing the circle size while keeping the torso still.',
      'Continue for the prescribed time, then reverse direction for an equal duration.',
      'Lower the arms slowly and relax the shoulders before moving on.',
    ],
    cues: const [
      'Keep the neck relaxed and shoulders away from the ears',
      'Use smooth, pain-free circles rather than forcing range',
      'Keep the trunk still and avoid arching the lower back',
    ],
    breathing: 'Breathe steadily throughout; avoid holding your breath as the circles become larger.',
  );

  static final _birdDog = _movement(
    id: 'exercise-bird-dog-001',
    name: 'Bird Dog',
    aliases: const ['quadruped opposite arm leg raise'],
    description: 'Quadruped core-stability drill extending opposite arm and leg while resisting trunk rotation.',
    regions: const [BodyRegion.fullBody],
    patterns: const [MovementPattern.isolation],
    primary: const [MuscleGroup.core],
    secondary: const [
      MuscleGroup.glutes,
      MuscleGroup.shoulders,
      MuscleGroup.lowerBack,
    ],
    setup: const [
      'Start on hands and knees with hands under shoulders and knees under hips.',
      'Brace the abdomen gently and keep the spine in a neutral position with eyes on the floor.',
    ],
    execution: const [
      'Reach one arm forward while extending the opposite leg straight behind you.',
      'Pause when the arm, torso and leg form one long line without allowing the hips to rotate.',
      'Return under control and repeat on the opposite side, alternating for the prescribed reps.',
    ],
    cues: const [
      'Keep the pelvis square to the floor',
      'Reach long rather than lifting the leg excessively high',
      'Move slowly and keep the trunk steady',
    ],
    breathing: 'Exhale as you extend the arm and leg; inhale as you return to the starting position.',
  );

  static final _bodyweightSquat = _movement(
    id: 'exercise-bodyweight-squat-001',
    name: 'Bodyweight Squat',
    aliases: const ['air squat'],
    description: 'Foundational squat pattern performed without external load to build lower-body control and prepare for loaded squats.',
    regions: const [BodyRegion.lowerBody],
    patterns: const [MovementPattern.squat],
    primary: const [MuscleGroup.quads, MuscleGroup.glutes],
    secondary: const [MuscleGroup.hamstrings, MuscleGroup.core],
    setup: const [
      'Stand with feet around shoulder-width apart and toes turned out slightly.',
      'Brace the abdomen, keep the chest comfortably lifted and distribute weight across the whole foot.',
    ],
    execution: const [
      'Bend the hips and knees together, sitting down between the feet while keeping heels grounded.',
      'Descend to a comfortable depth while the knees track in line with the toes.',
      'Press through the whole foot to stand tall and fully reset before the next repetition.',
    ],
    cues: const [
      'Keep the heels planted and knees tracking over the toes',
      'Maintain a neutral spine and controlled torso position',
      'Use a smooth tempo without bouncing at the bottom',
    ],
    breathing: 'Inhale as you lower; exhale as you stand, keeping the trunk braced throughout.',
  );

  static final _burpee = _movement(
    id: 'exercise-burpee-001',
    name: 'Burpee',
    aliases: const ['bodyweight burpee'],
    description: 'Full-body conditioning movement combining a squat, plank transition and controlled return to standing.',
    regions: const [BodyRegion.fullBody],
    patterns: const [MovementPattern.squat, MovementPattern.horizontalPush],
    primary: const [MuscleGroup.quads, MuscleGroup.glutes, MuscleGroup.core],
    secondary: const [
      MuscleGroup.chest,
      MuscleGroup.triceps,
      MuscleGroup.shoulders,
    ],
    setup: const [
      'Stand with feet about hip-width apart, arms relaxed and core lightly braced.',
      'Choose a step-back version or a jump-back version that you can perform with stable form.',
    ],
    execution: const [
      'Squat down and place both hands on the floor just in front of the feet.',
      'Step or jump both feet back to a strong high-plank position with shoulders over wrists.',
      'Step or jump the feet back toward the hands, stand tall and add a small vertical jump only if appropriate.',
    ],
    cues: const [
      'Keep the abdomen braced as the feet travel back',
      'Land softly and keep knees tracking in line with the feet',
      'Use the step-back variation to maintain control or reduce impact',
    ],
    breathing: 'Breathe out as you return to standing; take a controlled breath during the plank transition.',
  );

  static final _calfStretch = _movement(
    id: 'exercise-calf-stretch-001',
    name: 'Standing Calf Stretch',
    aliases: const ['wall calf stretch'],
    description: 'Static calf stretch with the rear heel grounded and the ankle gently moved into dorsiflexion.',
    regions: const [BodyRegion.lowerBody],
    patterns: const [MovementPattern.isolation],
    primary: const [MuscleGroup.calves],
    setup: const [
      'Stand facing a wall and place both hands on it for balance.',
      'Step one foot back, keep both toes pointing forward and bend the front knee slightly.',
    ],
    execution: const [
      'Keep the rear heel on the floor and the rear knee straight as you shift the hips gently forward.',
      'Stop at a mild stretch through the rear calf and hold for the prescribed time.',
      'Ease out slowly and repeat on the other side.',
    ],
    cues: const [
      'Keep the rear heel grounded',
      'Point the rear toes straight ahead rather than turning the foot out',
      'Use gentle tension; do not bounce or force the ankle',
    ],
    breathing: 'Breathe slowly and evenly throughout the hold, relaxing into the stretch on each exhale.',
  );

  static final _catCow = _movement(
    id: 'exercise-cat-cow-001',
    name: 'Cat-Cow',
    aliases: const ['cat cow stretch', 'cat camel'],
    description: 'Controlled spinal mobility drill alternating gentle spinal flexion and extension from quadruped.',
    regions: const [BodyRegion.fullBody],
    patterns: const [MovementPattern.isolation],
    primary: const [MuscleGroup.core, MuscleGroup.lowerBack],
    secondary: const [MuscleGroup.shoulders],
    setup: const [
      'Start on hands and knees with wrists below shoulders and knees below hips.',
      'Keep the head in line with the spine and distribute pressure evenly through the hands.',
    ],
    execution: const [
      'Exhale and gently round the spine toward the ceiling, drawing the abdomen inward.',
      'Inhale and reverse the movement, allowing the chest to open and the tailbone to tilt up without forcing the lower back.',
      'Continue alternating smoothly for the prescribed repetitions.',
    ],
    cues: const [
      'Move one segment of the spine at a time',
      'Keep the movement gentle and within a comfortable range',
      'Avoid pushing into end-range neck extension',
    ],
    breathing: 'Exhale during the rounded cat position and inhale as you move into cow; let breathing set the pace.',
  );

  static final _childsPose = _movement(
    id: 'exercise-childs-pose-001',
    name: "Child's Pose",
    aliases: const ['balasana'],
    description: 'Gentle kneeling recovery posture that relaxes the back, hips and shoulders.',
    regions: const [BodyRegion.fullBody],
    patterns: const [MovementPattern.isolation],
    primary: const [MuscleGroup.lowerBack, MuscleGroup.shoulders],
    secondary: const [MuscleGroup.glutes],
    setup: const [
      'Kneel on a mat with knees comfortably apart and big toes close together.',
      'Sit the hips toward the heels and place the hands on the floor in front of you.',
    ],
    execution: const [
      'Walk the hands forward and lower the torso toward the thighs, resting the forehead on the mat or a support.',
      'Allow the shoulders and back to relax while keeping the hips as close to the heels as comfortable.',
      'Hold for the prescribed time, then walk the hands back and rise slowly.',
    ],
    cues: const [
      'Keep the position comfortable for the knees and hips',
      'Relax the shoulders away from the ears',
      'Use a cushion under the hips or forehead when needed',
    ],
    breathing: 'Breathe slowly into the back and sides of the rib cage; lengthen each exhale without straining.',
  );

  static final _crossBodyShoulderStretch = _movement(
    id: 'exercise-cross-body-shoulder-stretch-001',
    name: 'Cross-Body Shoulder Stretch',
    aliases: const ['posterior shoulder stretch'],
    description: 'Static stretch for the rear shoulder performed by drawing one arm gently across the chest.',
    regions: const [BodyRegion.upperBody],
    patterns: const [MovementPattern.isolation],
    primary: const [MuscleGroup.rearDelts, MuscleGroup.shoulders],
    setup: const [
      'Stand or sit tall with shoulders relaxed and the chest facing forward.',
      'Bring one arm across the chest at approximately shoulder height.',
    ],
    execution: const [
      'Use the opposite hand to draw the upper arm gently closer to the chest.',
      'Keep the stretching shoulder down and hold the mild stretch for the prescribed time.',
      'Release slowly and repeat on the opposite side.',
    ],
    cues: const [
      'Keep the torso facing forward without twisting',
      'Apply pressure to the upper arm rather than the elbow joint',
      'Do not shrug the stretching shoulder',
    ],
    breathing: 'Maintain relaxed, even breathing and soften the stretch slightly as you exhale.',
  );

  static final _dumbbellSwing = _movement(
    id: 'exercise-db-swing-001',
    name: 'Dumbbell Swing',
    aliases: const ['single dumbbell swing'],
    description: 'Hip-driven ballistic hinge using one dumbbell, performed with a controlled swing arc.',
    regions: const [BodyRegion.fullBody],
    patterns: const [MovementPattern.hinge],
    primary: const [MuscleGroup.glutes, MuscleGroup.hamstrings],
    secondary: const [
      MuscleGroup.core,
      MuscleGroup.lowerBack,
      MuscleGroup.shoulders,
    ],
    equipment: const [EquipmentType.dumbbell],
    setup: const [
      'Stand with feet slightly wider than hip-width and hold one dumbbell securely with both hands.',
      'Brace the abdomen, soften the knees and hinge at the hips with the dumbbell hanging in front of the thighs.',
    ],
    execution: const [
      'Hike the dumbbell back between the thighs by hinging at the hips, keeping the spine neutral.',
      'Drive the hips forward forcefully to swing the dumbbell to around chest height; let the arms guide rather than lift it.',
      'Allow the dumbbell to fall, hinge again and immediately flow into the next repetition.',
    ],
    cues: const [
      'Generate power from the hips, not the shoulders',
      'Keep the dumbbell close to the body on the backswing',
      'Finish tall with glutes contracted, not with the lower back arched',
    ],
    breathing: 'Exhale sharply as the hips drive forward; inhale during the backswing while maintaining the brace.',
  );

  static final _dumbbellThruster = _movement(
    id: 'exercise-db-thruster-001',
    name: 'Dumbbell Thruster',
    aliases: const ['dumbbell squat to press'],
    description: 'Full-body compound combining a front-loaded squat with a continuous overhead dumbbell press.',
    regions: const [BodyRegion.fullBody],
    patterns: const [MovementPattern.squat, MovementPattern.verticalPush],
    primary: const [
      MuscleGroup.quads,
      MuscleGroup.glutes,
      MuscleGroup.frontDelts,
    ],
    secondary: const [MuscleGroup.triceps, MuscleGroup.core],
    equipment: const [EquipmentType.dumbbell],
    setup: const [
      'Hold a dumbbell in each hand at shoulder height with palms facing inward or slightly forward.',
      'Stand with feet around shoulder-width apart, elbows slightly forward and core braced.',
    ],
    execution: const [
      'Squat under control until the thighs are at least near parallel while keeping the dumbbells at the shoulders.',
      'Drive through the whole foot and use the upward momentum of the squat to press both dumbbells overhead.',
      'Lower the dumbbells back to the shoulders with control and flow into the next squat.',
    ],
    cues: const [
      'Keep the chest lifted and knees tracking over the toes',
      'Finish with the weights stacked over the shoulders and mid-foot',
      'Use a load that allows a stable overhead lockout',
    ],
    breathing: 'Inhale and brace on the descent; exhale through the drive and press; inhale as the weights return to the shoulders.',
  );

  static final _diaphragmaticBreathing = _movement(
    id: 'exercise-diaphragmatic-breathing-001',
    name: 'Supine Diaphragmatic Breathing',
    aliases: const ['belly breathing', 'diaphragmatic breathing'],
    description: 'Supine breathing drill encouraging relaxed diaphragmatic expansion and a calm recovery response.',
    regions: const [BodyRegion.fullBody],
    patterns: const [MovementPattern.isolation],
    primary: const [MuscleGroup.core],
    setup: const [
      'Lie on your back with knees bent, feet flat and head supported comfortably.',
      'Rest one hand on the abdomen and one on the upper chest to notice the breathing pattern.',
    ],
    execution: const [
      'Inhale slowly through the nose, allowing the abdomen and lower ribs to expand while the upper chest stays relatively quiet.',
      'Exhale gently through pursed lips, letting the abdomen fall without forcefully tightening it.',
      'Continue for the prescribed duration with an unhurried, comfortable rhythm.',
    ],
    cues: const [
      'Keep the jaw, neck and shoulders relaxed',
      'Breathe comfortably without forcing a very deep breath',
      'Allow the exhale to be slightly longer than the inhale if comfortable',
    ],
    breathing: 'Use a slow nasal inhale and soft, prolonged exhale; stop or return to normal breathing if light-headed.',
  );

  static final _doorwayChestStretch = _movement(
    id: 'exercise-doorway-chest-stretch-001',
    name: 'Doorway Chest Stretch',
    aliases: const ['door frame pectoral stretch'],
    description: 'Static chest and anterior shoulder stretch using a doorway to support the arms.',
    regions: const [BodyRegion.upperBody],
    patterns: const [MovementPattern.isolation],
    primary: const [MuscleGroup.chest],
    secondary: const [MuscleGroup.frontDelts],
    setup: const [
      'Stand in a doorway and place one forearm against the frame with the elbow around shoulder height.',
      'Step the same-side foot slightly forward and keep the ribs stacked over the pelvis.',
    ],
    execution: const [
      'Rotate the torso gently away from the supported arm until a mild stretch is felt across the chest.',
      'Hold without bouncing for the prescribed duration.',
      'Step back to release and repeat with the other arm.',
    ],
    cues: const [
      'Keep the shoulder down and avoid excessive arching',
      'Use a comfortable elbow and shoulder angle',
      'Do not push into sharp or pinching sensations',
    ],
    breathing:
        'Breathe slowly and evenly; allow the chest to relax on each exhale.',
  );

  static final _figureFourStretch = _movement(
    id: 'exercise-figure-four-stretch-001',
    name: 'Figure-Four Glute Stretch',
    aliases: const ['supine figure four stretch', 'piriformis stretch'],
    description:
        'Supine hip external-rotation stretch targeting the gluteal region.',
    regions: const [BodyRegion.lowerBody],
    patterns: const [MovementPattern.isolation],
    primary: const [MuscleGroup.glutes],
    secondary: const [MuscleGroup.hamstrings],
    setup: const [
      'Lie on your back with both knees bent and feet flat on the floor.',
      'Cross one ankle over the opposite thigh just above the knee, creating a figure-four shape.',
    ],
    execution: const [
      'Thread both hands behind the uncrossed thigh and draw it gently toward the chest.',
      'Keep the head and shoulders relaxed while holding the stretch for the prescribed time.',
      'Release slowly and change sides.',
    ],
    cues: const [
      'Keep the crossed foot gently flexed',
      'Do not pull directly on the knee joint',
      'Keep the pelvis level and the lower back comfortable',
    ],
    breathing: 'Breathe slowly into the hips and glutes, relaxing slightly deeper only as comfort allows.',
  );

  static final _hamstringStretch = _movement(
    id: 'exercise-hamstring-stretch-001',
    name: 'Standing Hamstring Stretch',
    aliases: const ['standing hamstring hinge stretch'],
    description: 'Standing hamstring stretch using a shallow hip hinge with one leg positioned forward.',
    regions: const [BodyRegion.lowerBody],
    patterns: const [MovementPattern.hinge],
    primary: const [MuscleGroup.hamstrings],
    secondary: const [MuscleGroup.glutes],
    setup: const [
      'Stand tall and place one heel a short step in front with the toes lifted.',
      'Keep a soft bend in the supporting knee and place hands on the hips or a stable support.',
    ],
    execution: const [
      'Hinge forward from the hips with a long spine until a gentle stretch is felt along the back of the front thigh.',
      'Hold for the prescribed duration without rounding the back.',
      'Rise slowly and switch legs.',
    ],
    cues: const [
      'Move from the hips rather than rounding the spine',
      'Keep the front knee softly unlocked',
      'Maintain a mild, comfortable stretch rather than pulling hard',
    ],
    breathing: 'Maintain slow, relaxed breathing throughout the hold.',
  );

  static final _hipFlexorStretch = _movement(
    id: 'exercise-hip-flexor-stretch-001',
    name: 'Half-Kneeling Hip Flexor Stretch',
    aliases: const ['half kneeling lunge stretch'],
    description: 'Half-kneeling hip extension stretch targeting the front of the rear hip.',
    regions: const [BodyRegion.lowerBody],
    patterns: const [MovementPattern.isolation],
    primary: const [MuscleGroup.quads],
    secondary: const [MuscleGroup.glutes],
    setup: const [
      'Kneel on one knee with the opposite foot planted in front and both knees around 90 degrees.',
      'Tuck the pelvis slightly and brace the abdomen while keeping the torso tall.',
    ],
    execution: const [
      'Squeeze the glute on the kneeling side and shift the pelvis forward a few centimetres.',
      'Stop when a mild stretch is felt across the front of the rear hip and hold for the prescribed time.',
      'Return to neutral and switch sides.',
    ],
    cues: const [
      'Keep the ribs down and avoid arching the lower back',
      'Use the rear-side glute to create the stretch',
      'Keep the front foot planted and knee stable',
    ],
    breathing:
        'Breathe slowly and evenly, maintaining a gentle abdominal brace.',
  );

  static final _inchworm = _movement(
    id: 'exercise-inchworm-001',
    name: 'Inchworm',
    aliases: const ['walkout'],
    description: 'Dynamic full-body mobility drill walking the hands from a standing fold into a high plank and back.',
    regions: const [BodyRegion.fullBody],
    patterns: const [MovementPattern.hinge, MovementPattern.horizontalPush],
    primary: const [MuscleGroup.core, MuscleGroup.shoulders],
    secondary: const [MuscleGroup.hamstrings, MuscleGroup.chest],
    setup: const [
      'Stand with feet hip-width apart, knees soft and arms relaxed.',
      'Brace the abdomen lightly and hinge forward to place the hands on the floor in front of the feet.',
    ],
    execution: const [
      'Walk the hands forward in small steps until the body reaches a stable high plank.',
      'Pause briefly with shoulders over wrists and hips level.',
      'Walk the hands back toward the feet and return to standing with control.',
    ],
    cues: const [
      'Keep the abdomen braced and avoid letting the lower back sag',
      'Use small hand steps and keep the knees softly bent as needed',
      'Keep the hips level in the plank position',
    ],
    breathing: 'Exhale as you walk the hands out; inhale as you walk them back and stand.',
  );

  static final _jumpRope = _movement(
    id: 'exercise-jump-rope-001',
    name: 'Jump Rope',
    aliases: const ['skipping'],
    description: 'Rhythmic low-amplitude skipping drill using a rope to develop aerobic capacity, timing and lower-leg spring.',
    regions: const [BodyRegion.fullBody],
    patterns: const [MovementPattern.isolation],
    primary: const [MuscleGroup.calves],
    secondary: const [
      MuscleGroup.quads,
      MuscleGroup.shoulders,
      MuscleGroup.core,
    ],
    setup: const [
      'Hold one handle in each hand with the rope behind the heels and elbows close to the sides.',
      'Stand tall with feet together or hip-width apart and look forward.',
    ],
    execution: const [
      'Turn the rope using small wrist circles and hop just high enough for it to pass beneath the feet.',
      'Land softly on the balls of the feet with knees relaxed and repeat at a steady rhythm.',
      'Stop safely by allowing the rope to pass to the side or stepping out of the rhythm.',
    ],
    cues: const [
      'Keep jumps low and quiet',
      'Use the wrists rather than large shoulder circles to turn the rope',
      'Stay tall and avoid stiff-legged landings',
    ],
    breathing: 'Maintain a steady breathing rhythm; exhale naturally across several jumps rather than holding your breath.',
  );

  static final _jumpSquat = _movement(
    id: 'exercise-jump-squat-001',
    name: 'Jump Squat',
    aliases: const ['bodyweight squat jump'],
    description: 'Plyometric squat variation that uses a controlled countermovement and soft landing to develop lower-body power.',
    regions: const [BodyRegion.lowerBody],
    patterns: const [MovementPattern.squat],
    primary: const [MuscleGroup.quads, MuscleGroup.glutes],
    secondary: const [MuscleGroup.calves, MuscleGroup.core],
    setup: const [
      'Stand with feet around shoulder-width apart and arms relaxed or slightly behind the body.',
      'Brace the abdomen and establish a balanced stance with weight across the whole foot.',
    ],
    execution: const [
      'Bend the hips and knees into a shallow-to-moderate squat while swinging the arms back.',
      'Drive through the feet and jump vertically, extending the hips, knees and ankles.',
      'Land softly on both feet with knees tracking over toes, absorb the landing and reset before the next rep.',
    ],
    cues: const [
      'Prioritise a quiet, controlled landing',
      'Keep knees aligned with the toes',
      'Use a lower-impact squat without a jump when landing control fades',
    ],
    breathing: 'Inhale during the countermovement; exhale as you jump and land with a braced trunk.',
  );

  static final _jumpingJack = _movement(
    id: 'exercise-jumping-jack-001',
    name: 'Jumping Jack',
    aliases: const ['star jump'],
    description: 'Bodyweight cardiovascular warm-up moving the feet apart as the arms sweep overhead, then returning to the start.',
    regions: const [BodyRegion.fullBody],
    patterns: const [MovementPattern.isolation],
    primary: const [MuscleGroup.shoulders, MuscleGroup.quads],
    secondary: const [MuscleGroup.calves, MuscleGroup.core],
    setup: const [
      'Stand tall with feet together, arms by the sides and knees relaxed.',
      'Brace lightly and look forward with enough space around you to move.',
    ],
    execution: const [
      'Jump or step both feet out wider than shoulder-width while sweeping the arms out and overhead.',
      'Jump or step the feet back together as the arms return to the sides.',
      'Continue at a controlled, repeatable rhythm for the prescribed duration.',
    ],
    cues: const [
      'Land softly with knees tracking over the toes',
      'Keep the shoulders relaxed as the arms travel overhead',
      'Use the step-out variation to reduce impact',
    ],
    breathing: 'Breathe rhythmically and continuously; exhale naturally as the feet move out.',
  );

  static final _legSwings = _movement(
    id: 'exercise-leg-swings-001',
    name: 'Leg Swings',
    aliases: const ['dynamic leg swings'],
    description: 'Dynamic hip mobility drill swinging one leg forward and backward while supported by a stable surface.',
    regions: const [BodyRegion.lowerBody],
    patterns: const [MovementPattern.isolation],
    primary: const [MuscleGroup.glutes, MuscleGroup.hamstrings],
    secondary: const [MuscleGroup.quads, MuscleGroup.core],
    setup: const [
      'Stand beside a wall or rack and hold it lightly for balance.',
      'Stand tall on the supporting leg with the swinging leg relaxed and pelvis facing forward.',
    ],
    execution: const [
      'Swing the free leg forward and backward through a comfortable range without twisting the torso.',
      'Gradually increase the range as the hip becomes warm while keeping the movement smooth.',
      'Complete the prescribed repetitions and repeat on the other side.',
    ],
    cues: const [
      'Keep the trunk upright and pelvis square',
      'Let the hip create the movement rather than kicking from the knee',
      'Start with a small range and build gradually',
    ],
    breathing:
        'Breathe naturally and steadily while keeping the swing relaxed.',
  );

  static final _lyingSpinalTwist = _movement(
    id: 'exercise-lying-spinal-twist-001',
    name: 'Lying Spinal Twist',
    aliases: const ['supine spinal twist'],
    description: 'Supine rotational mobility stretch allowing bent knees to lower gently to one side.',
    regions: const [BodyRegion.fullBody],
    patterns: const [MovementPattern.isolation],
    primary: const [MuscleGroup.core, MuscleGroup.lowerBack],
    secondary: const [MuscleGroup.glutes],
    setup: const [
      'Lie on your back with arms extended out to the sides in a T shape.',
      'Bend both knees and place the feet flat, keeping shoulders relaxed against the floor.',
    ],
    execution: const [
      'Allow both knees to lower together toward one side while keeping the opposite shoulder comfortably grounded.',
      'Pause in a gentle stretch for the prescribed duration without forcing the knees to the floor.',
      'Bring the knees back to centre and repeat on the other side.',
    ],
    cues: const [
      'Move slowly and keep the shoulders relaxed',
      'Use a smaller range if the lower back feels strained',
      'Keep both knees moving together',
    ],
    breathing:
        'Exhale gently as the knees lower; inhale as they return to centre.',
  );

  static final _mountainClimber = _movement(
    id: 'exercise-mountain-climber-001',
    name: 'Mountain Climber',
    aliases: const ['alternating mountain climber'],
    description: 'Dynamic plank-based conditioning drill alternating knee drives toward the chest.',
    regions: const [BodyRegion.fullBody],
    patterns: const [MovementPattern.horizontalPush],
    primary: const [MuscleGroup.core],
    secondary: const [MuscleGroup.quads, MuscleGroup.shoulders],
    setup: const [
      'Start in a high plank with hands under shoulders, feet hip-width apart and body in a straight line.',
      'Brace the abdomen and press the floor away to keep the upper back stable.',
    ],
    execution: const [
      'Drive one knee toward the chest while keeping the hips as level as possible.',
      'Return that foot to the plank and immediately drive the opposite knee forward.',
      'Alternate smoothly for the prescribed time or repetitions, adjusting speed to maintain control.',
    ],
    cues: const [
      'Keep shoulders stacked over wrists',
      'Avoid bouncing the hips high or allowing the lower back to sag',
      'Use a slower step-in variation when needed',
    ],
    breathing: 'Breathe continuously and rhythmically; avoid holding the breath as the pace increases.',
  );

  static final _overheadTricepStretch = _movement(
    id: 'exercise-overhead-tricep-stretch-001',
    name: 'Overhead Triceps Stretch',
    aliases: const ['overhead triceps stretch'],
    description: 'Static triceps stretch with one elbow bent overhead and the hand moving gently down the upper back.',
    regions: const [BodyRegion.upperBody],
    patterns: const [MovementPattern.isolation],
    primary: const [MuscleGroup.triceps],
    secondary: const [MuscleGroup.shoulders],
    setup: const [
      'Stand or sit tall and raise one arm overhead.',
      'Bend the elbow so the hand moves toward the upper back between the shoulder blades.',
    ],
    execution: const [
      'Use the opposite hand to guide the raised elbow gently backward, without pulling on the wrist.',
      'Hold the mild stretch for the prescribed duration while keeping the ribs down.',
      'Release slowly and repeat on the other side.',
    ],
    cues: const [
      'Keep the lower ribs from flaring upward',
      'Avoid pressing the elbow into pain',
      'Keep the neck relaxed',
    ],
    breathing:
        'Breathe slowly and evenly, softening the shoulders as you exhale.',
  );

  static final _quadStretch = _movement(
    id: 'exercise-quad-stretch-001',
    name: 'Standing Quad Stretch',
    aliases: const ['standing quadriceps stretch'],
    description: 'Standing static quadriceps stretch drawing one heel toward the glutes while balancing with support as needed.',
    regions: const [BodyRegion.lowerBody],
    patterns: const [MovementPattern.isolation],
    primary: const [MuscleGroup.quads],
    secondary: const [MuscleGroup.glutes],
    setup: const [
      'Stand tall beside a wall or stable support and hold it lightly for balance.',
      'Bend one knee and bring the heel toward the glutes, holding the ankle or foot.',
    ],
    execution: const [
      'Bring the knees close together and gently draw the heel toward the glutes until the front thigh stretches.',
      'Keep the pelvis neutral and hold for the prescribed duration.',
      'Release slowly and repeat with the other leg.',
    ],
    cues: const [
      'Keep the knees pointing toward the floor',
      'Avoid arching the lower back or pushing the hip forward aggressively',
      'Use a hand support to maintain balance',
    ],
    breathing: 'Maintain calm, steady breathing throughout the hold.',
  );

  static final _recoveryWalk = _movement(
    id: 'exercise-recovery-walk-001',
    name: 'Easy Recovery Walk',
    aliases: const ['easy walk', 'cool-down walk'],
    description: 'Low-intensity walking interval used to raise body temperature gradually or bring heart rate down after training.',
    regions: const [BodyRegion.lowerBody],
    patterns: const [MovementPattern.isolation],
    primary: const [MuscleGroup.quads, MuscleGroup.glutes, MuscleGroup.calves],
    secondary: const [MuscleGroup.hamstrings, MuscleGroup.core],
    setup: const [
      'Choose a flat, unobstructed walking route or treadmill and stand tall with a relaxed arm swing.',
      'Begin at a comfortable pace that allows full-sentence conversation.',
    ],
    execution: const [
      'Walk continuously for the prescribed time using short, natural strides.',
      'Keep the shoulders relaxed, eyes forward and steps quiet.',
      'Gradually reduce the pace when using the walk as a cool-down.',
    ],
    cues: const [
      'Keep effort easy and conversational',
      'Avoid suddenly stopping after hard intervals',
      'Use a flat route and comfortable stride length',
    ],
    breathing: 'Breathe naturally; the pace should allow controlled conversation without gasping.',
  );

  static final _rowingMachine = _movement(
    id: 'exercise-rowing-machine-001',
    name: 'Rowing Machine',
    aliases: const ['indoor rower', 'erg rowing'],
    description: 'Full-body aerobic exercise on an indoor rowing ergometer using a coordinated leg drive, body swing and arm pull.',
    regions: const [BodyRegion.fullBody],
    patterns: const [MovementPattern.horizontalPull, MovementPattern.hinge],
    primary: const [MuscleGroup.quads, MuscleGroup.lats],
    secondary: const [
      MuscleGroup.glutes,
      MuscleGroup.hamstrings,
      MuscleGroup.core,
      MuscleGroup.biceps,
    ],
    equipment: const [EquipmentType.machine],
    setup: const [
      'Set the foot straps across the widest part of the feet and adjust the damper to a manageable setting.',
      'Sit tall with shins near vertical, knees bent, arms straight and hands holding the handle.',
    ],
    execution: const [
      'Drive through the legs first, then swing the torso slightly back and draw the handle toward the lower ribs.',
      'Reverse the sequence by extending the arms, hinging the torso forward and bending the knees to slide toward the flywheel.',
      'Repeat in a smooth rhythm, keeping the handle path level.',
    ],
    cues: const [
      'Use the sequence legs, body, arms on the drive and arms, body, legs on recovery',
      'Keep the shoulders relaxed and wrists flat',
      'Avoid rounding the lower back at the catch',
    ],
    breathing: 'Exhale through the leg drive and pull; inhale during the controlled recovery.',
  );

  static final _stationaryBike = _movement(
    id: 'exercise-stationary-bike-001',
    name: 'Stationary Bike',
    aliases: const ['indoor cycling', 'exercise bike'],
    description: 'Low-impact aerobic cycling interval performed on a stationary exercise bike.',
    regions: const [BodyRegion.lowerBody],
    patterns: const [MovementPattern.isolation],
    primary: const [MuscleGroup.quads],
    secondary: const [
      MuscleGroup.glutes,
      MuscleGroup.hamstrings,
      MuscleGroup.calves,
    ],
    equipment: const [EquipmentType.machine],
    setup: const [
      'Adjust the saddle so the knee remains slightly bent when the pedal is at its lowest point.',
      'Set the handlebars and resistance to a comfortable starting level, then place feet securely on the pedals.',
    ],
    execution: const [
      'Pedal smoothly with an even circular motion, keeping the hips stable on the saddle.',
      'Maintain the prescribed cadence or effort and adjust resistance without rocking the torso.',
      'Reduce resistance gradually at the end of the interval.',
    ],
    cues: const [
      'Keep knees tracking in line with the feet',
      'Relax the shoulders and grip lightly',
      'Avoid bouncing in the saddle at higher cadence',
    ],
    breathing: 'Breathe rhythmically and steadily; increase effort only while breathing remains controlled.',
  );

  static final _treadmillRun = _movement(
    id: 'exercise-treadmill-run-001',
    name: 'Treadmill Run',
    aliases: const ['treadmill jogging', 'indoor run'],
    description: 'Running interval on a treadmill with speed and incline set to match the prescribed effort.',
    regions: const [BodyRegion.lowerBody],
    patterns: const [MovementPattern.squat],
    primary: const [MuscleGroup.quads, MuscleGroup.glutes, MuscleGroup.calves],
    secondary: const [MuscleGroup.hamstrings, MuscleGroup.core],
    equipment: const [EquipmentType.machine],
    setup: const [
      'Stand on the side rails, attach the safety clip and select a flat or modest incline.',
      'Start the belt at a walking speed and step onto it only once it is moving slowly and steadily.',
    ],
    execution: const [
      'Gradually increase the belt speed to the prescribed running pace.',
      'Run with a relaxed upright posture, short natural strides and feet landing beneath the body.',
      'Reduce speed gradually before stepping onto the side rails to stop.',
    ],
    cues: const [
      'Keep eyes forward and shoulders relaxed',
      'Avoid reaching far ahead with the lead foot',
      'Use the safety clip and do not jump onto or off a moving belt',
    ],
    breathing: 'Use controlled rhythmic breathing appropriate to the interval intensity; ease the pace if breathing becomes uncontrolled.',
  );

  static final _worldsGreatestStretch = _movement(
    id: 'exercise-worlds-greatest-stretch-001',
    name: "World's Greatest Stretch",
    aliases: const ['worlds greatest stretch', 'lunge with thoracic rotation'],
    description: 'Dynamic multi-joint mobility sequence combining a lunge, hip flexor stretch and thoracic rotation.',
    regions: const [BodyRegion.fullBody],
    patterns: const [MovementPattern.squat, MovementPattern.isolation],
    primary: const [MuscleGroup.glutes, MuscleGroup.quads, MuscleGroup.core],
    secondary: const [
      MuscleGroup.hamstrings,
      MuscleGroup.shoulders,
      MuscleGroup.lowerBack,
    ],
    setup: const [
      'Begin in a high plank with hands under shoulders and feet hip-width apart.',
      'Step one foot forward outside the same-side hand, keeping the rear leg long and the front foot flat.',
    ],
    execution: const [
      'Lower the rear hip gently toward the floor while keeping the front knee aligned over the foot.',
      'Place the same-side hand inside the front foot, then rotate that arm toward the ceiling while following the hand with the eyes.',
      'Return the hand to the floor, shift the hips back briefly to stretch the front leg, then step back and repeat on the other side.',
    ],
    cues: const [
      'Keep the front foot flat and knee tracking over the toes',
      'Rotate through the upper back rather than forcing the lower back',
      'Move smoothly and use a shorter lunge if hip mobility is limited',
    ],
    breathing: 'Exhale as you rotate and inhale as you return to the lunge; keep breathing smoothly through the sequence.',
  );

  /// Shared constructor keeps the catalog entries consistent while each movement
  /// still carries its own complete, exercise-specific execution profile.
  static Exercise _movement({
    required String id,
    required String name,
    List<String> aliases = const [],
    required String description,
    required List<BodyRegion> regions,
    required List<MovementPattern> patterns,
    required List<MuscleGroup> primary,
    List<MuscleGroup> secondary = const [],
    List<EquipmentType> equipment = const [EquipmentType.bodyweight],
    required List<String> setup,
    required List<String> execution,
    required List<String> cues,
    required String breathing,
  }) => Exercise(
    id: id,
    name: name,
    aliases: aliases,
    description: description,
    createdAt: _epoch,
    updatedAt: _epoch,
    classification: ExerciseClassification(
      bodyRegions: regions,
      movementPatterns: patterns,
      primaryMuscles: primary,
      secondaryMuscles: secondary,
    ),
    equipment: ExerciseEquipmentProfile(requiredEquipment: equipment),
    execution: ExerciseExecutionProfile(
      setupInstructions: setup,
      executionInstructions: execution,
      techniqueCues: cues,
      breathingInstructions: breathing,
    ),
  );
}
