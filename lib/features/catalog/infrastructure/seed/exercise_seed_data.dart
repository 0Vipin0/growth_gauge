import '../../domain/exercise.dart';
import '../../domain/exercise_classification.dart';
import '../../domain/exercise_enums.dart';
import '../../domain/exercise_equipment.dart';
import '../../domain/exercise_execution.dart';

/// Canonical system exercise seed data.
///
/// These 60 exercises are seeded on first launch if the catalog is empty.
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
}
