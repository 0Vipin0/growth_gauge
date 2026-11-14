import '../../domain/target_set.dart';
import '../../domain/template_enums.dart';
import '../../domain/template_item.dart';
import '../../domain/workout_block.dart';
import '../../domain/workout_template.dart';
import '../../domain/workout_template_revision.dart';

/// A system template paired with its initial published revision.
class const TemplateSeedBundle({
  required final WorkoutTemplate template,
  required final WorkoutTemplateRevision initialRevision,
});

/// Canonical system workout template seed data containing 83 complete programs.
/// Every program has an explicitly timed warm-up and a stretch / relaxed cool-down.
///
/// Every session follows a full structure: warm-up, main work, then a
/// cool-down stretch and a relaxed finish (breathing / spinal release).
/// Programs cover strength, HIIT, strength-conditioning, endurance and
/// mobility / recovery for beginner, intermediate and expert athletes.
///
/// Conventions:
///  - Weights are in kg and are conservative starting points to be adjusted
///    per athlete; RPE targets express intended effort.
///  - Superset and circuit blocks use one target set per item and repeat for
///    [WorkoutBlock.rounds]. Work / rest protocols are noted in block names.
///  - Unilateral stretches and drills use one set per side.
class WorkoutTemplateSeedData._() {
  static final _epoch = DateTime.utc(2024);
  static const String _systemUser = 'system-admin';

  static List<TemplateSeedBundle> get all => [
    _fullBodyStrengthA,
    _fullBodyStrengthB,
    _upperBodyPushA,
    _upperBodyPushB,
    _upperBodyPullA,
    _upperBodyPullB,
    _lowerBodyQuadFocus,
    _lowerBodyHingeFocus,
    _pushHypertrophy,
    _pullHypertrophy,
    _legDayBalanced,
    _upperPowerPump,
    _lowerHypertrophyBlock,
    _armsAndShouldersBlaster,
    _coreAndConditioningCircuit,
    _upperChestSpecialization,
    _unilateralLegBuilder,
    _trapBarPowerSession,
    _expressFullBody,
    _posteriorChainDominator,
    _hiitStarter,
    _hiitTabata,
    _hiitExpertPower,
    _hiitTreadmill,
    _scStarter,
    _scIntermediate,
    _scExpert,
    _runWalkStarter,
    _steadyZone2Run,
    _thresholdRunIntervals,
    _crossTrainingAerobic,
    _rowingIntervals,
    _muscularEnduranceCircuit,
    _aerobicBaseBuilder,
    _mobilityFlow,
    _lowerStretchRelease,
    _upperStretchRelease,
    _activeRecovery,
    _upperBodyA,
    _lowerBodyA,
    _upperBodyB,
    _upperBodyC,
    _lowerBodyB,
    _routine1Shoulders,
    _routine1Back,
    _routine1Chest,
    _routine1Biceps,
    _routineShoulders,
    _routineTriceps,
    _routineChest,
    _routineBiceps,
    _routineBack,
    _routineThighs,
    _routineMondayBack,
    _routineTuesdayBiceps,
    _routineWednesdayChest,
    _routineThursdayTriceps,
    _routineFridayShoulders,
    _routineSaturdayLegs,
    _routine4MondayBackCore,
    _routine4TuesdayBicepsCore,
    _routineWednesdayShoulders,
    _routine4ThursdayTricepsCore,
    _routineFridayLower,
    _routineSaturdayChest,
    _routine5MondayBack,
    _routine5TuesdayBiceps,
    _routineWednesdayShoulder,
    _routineThursdayTricep,
    _routine5FridayLowerBody,
    _routine5SaturdayChest,
    _routine6MondayBack,
    _routine6TuesdayBiceps,
    _routine6WednesdayShoulders,
    _routine6ThursdayTriceps,
    _routineFridayChest,
    _routineSaturdayLower,
    _routineMondayChest,
    _routineTuesdayTriceps,
    _routineWednesdayBack,
    _routineThursdayBiceps,
    _routine7FridayLowerBody,
    _routineSaturdayRecovery,
  ];

  // ===================== STRENGTH (1-20) =====================

  // 1. Full Body Strength A
  static final _fullBodyStrengthA = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-full-body-strength-a',
      name: 'Full Body Strength A',
      description: 'Beginner | ~50 min. Foundational full-body session built on squat, bench press and barbell row with ramped warm-up sets, a short core finisher, then a stretch and relaxed ending. Weights are starting points in kg.',
      currentRevisionId: 'rev-full-body-strength-a-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['strength', 'full-body', 'beginner', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-full-body-strength-a-001',
      templateId: 'template-full-body-strength-a',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-fba-1',
          name: 'Dynamic Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-fba-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-fba-1',
                  setNumber: 1,
                  targetDurationSeconds: 225,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-fba-1',
              exerciseId: 'exercise-jumping-jack-001', // Jumping Jack
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-fba-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fba-2',
              exerciseId: 'exercise-arm-circles-001', // Arm Circles
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-fba-2-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fba-3',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-fba-3-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-fba-4',
              exerciseId: 'exercise-inchworm-001', // Inchworm
              order: 5,
              targetSets: [
                TargetSet(id: 'ts-fba-4-1', setNumber: 1, targetReps: 5),
              ],
            ),
            TemplateItem(
              id: 'item-fba-5',
              exerciseId: 'exercise-worlds-greatest-stretch-001', // World's Greatest Stretch
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-fba-5-1', setNumber: 1, targetReps: 3),
                TargetSet(id: 'ts-fba-5-2', setNumber: 2, targetReps: 3),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-fba-2',
          name: 'Main Lifts',
          items: [
            TemplateItem(
              id: 'item-fba-6',
              exerciseId: 'exercise-squat-001', // Barbell Back Squat
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-fba-6-1',
                  setNumber: 1,
                  setType: SetType.warmup,
                  targetWeight: 30.0,
                  targetReps: 10,
                ),
                TargetSet(
                  id: 'ts-fba-6-2',
                  setNumber: 2,
                  setType: SetType.warmup,
                  targetWeight: 45.0,
                  targetReps: 5,
                ),
                TargetSet(
                  id: 'ts-fba-6-3',
                  setNumber: 3,
                  targetWeight: 60.0,
                  targetReps: 5,
                  targetRpe: 7.0,
                ),
                TargetSet(
                  id: 'ts-fba-6-4',
                  setNumber: 4,
                  targetWeight: 60.0,
                  targetReps: 5,
                  targetRpe: 7.5,
                ),
                TargetSet(
                  id: 'ts-fba-6-5',
                  setNumber: 5,
                  targetWeight: 60.0,
                  targetReps: 5,
                  targetRpe: 8.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fba-7',
              exerciseId: 'exercise-bench-001', // Barbell Bench Press
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-fba-7-1',
                  setNumber: 1,
                  setType: SetType.warmup,
                  targetWeight: 20.0,
                  targetReps: 10,
                ),
                TargetSet(
                  id: 'ts-fba-7-2',
                  setNumber: 2,
                  targetWeight: 40.0,
                  targetReps: 8,
                  targetRpe: 7.0,
                ),
                TargetSet(
                  id: 'ts-fba-7-3',
                  setNumber: 3,
                  targetWeight: 40.0,
                  targetReps: 8,
                  targetRpe: 7.5,
                ),
                TargetSet(
                  id: 'ts-fba-7-4',
                  setNumber: 4,
                  targetWeight: 40.0,
                  targetReps: 8,
                  targetRpe: 8.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fba-8',
              exerciseId: 'exercise-row-001', // Barbell Row
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-fba-8-1',
                  setNumber: 1,
                  targetWeight: 40.0,
                  targetReps: 8,
                  targetRpe: 7.0,
                ),
                TargetSet(
                  id: 'ts-fba-8-2',
                  setNumber: 2,
                  targetWeight: 40.0,
                  targetReps: 8,
                  targetRpe: 7.5,
                ),
                TargetSet(
                  id: 'ts-fba-8-3',
                  setNumber: 3,
                  targetWeight: 40.0,
                  targetReps: 8,
                  targetRpe: 8.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-fba-3',
          name: 'Core Finisher',
          items: [
            TemplateItem(
              id: 'item-fba-9',
              exerciseId: 'exercise-plank-001', // Forearm Plank
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-fba-9-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-fba-9-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-fba-9-3',
                  setNumber: 3,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fba-10',
              exerciseId: 'exercise-bird-dog-001', // Bird Dog
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-fba-10-1', setNumber: 1, targetReps: 8),
                TargetSet(id: 'ts-fba-10-2', setNumber: 2, targetReps: 8),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-fba-4',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-fba-11',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-fba-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-fba-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fba-12',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-fba-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-fba-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fba-13',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-fba-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-fba-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fba-14',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-fba-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-fba-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fba-15',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001', // Cross-Body Shoulder Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-fba-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-fba-15-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-fba-5',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-fba-16',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-fba-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fba-17',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-fba-17-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-fba-17-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fba-18',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-fba-18-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 2. Full Body Strength B
  static final _fullBodyStrengthB = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-full-body-strength-b',
      name: 'Full Body Strength B',
      description: 'Beginner | ~50 min. Complementary full-body session featuring deadlifts, overhead press and lat pulldowns, finished with glute and core stability work, stretching and a relaxed ending.',
      currentRevisionId: 'rev-full-body-strength-b-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: [
        'strength',
        'full-body',
        'posterior-chain',
        'beginner',
        'stretching',
      ],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-full-body-strength-b-001',
      templateId: 'template-full-body-strength-b',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-fbb-1',
          name: 'Dynamic Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-fbb-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-fbb-1',
                  setNumber: 1,
                  targetDurationSeconds: 225,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-fbb-1',
              exerciseId: 'exercise-jumping-jack-001', // Jumping Jack
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-fbb-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fbb-2',
              exerciseId: 'exercise-arm-circles-001', // Arm Circles
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-fbb-2-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fbb-3',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-fbb-3-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-fbb-4',
              exerciseId: 'exercise-inchworm-001', // Inchworm
              order: 5,
              targetSets: [
                TargetSet(id: 'ts-fbb-4-1', setNumber: 1, targetReps: 5),
              ],
            ),
            TemplateItem(
              id: 'item-fbb-5',
              exerciseId: 'exercise-worlds-greatest-stretch-001', // World's Greatest Stretch
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-fbb-5-1', setNumber: 1, targetReps: 3),
                TargetSet(id: 'ts-fbb-5-2', setNumber: 2, targetReps: 3),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-fbb-2',
          name: 'Compound Sequence',
          items: [
            TemplateItem(
              id: 'item-fbb-6',
              exerciseId: 'exercise-deadlift-001', // Conventional Deadlift
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-fbb-6-1',
                  setNumber: 1,
                  setType: SetType.warmup,
                  targetWeight: 40.0,
                  targetReps: 5,
                ),
                TargetSet(
                  id: 'ts-fbb-6-2',
                  setNumber: 2,
                  setType: SetType.warmup,
                  targetWeight: 60.0,
                  targetReps: 3,
                ),
                TargetSet(
                  id: 'ts-fbb-6-3',
                  setNumber: 3,
                  targetWeight: 70.0,
                  targetReps: 5,
                  targetRpe: 7.0,
                ),
                TargetSet(
                  id: 'ts-fbb-6-4',
                  setNumber: 4,
                  targetWeight: 70.0,
                  targetReps: 5,
                  targetRpe: 7.5,
                ),
                TargetSet(
                  id: 'ts-fbb-6-5',
                  setNumber: 5,
                  targetWeight: 70.0,
                  targetReps: 5,
                  targetRpe: 8.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fbb-7',
              exerciseId: 'exercise-ohp-001', // Overhead Press
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-fbb-7-1',
                  setNumber: 1,
                  setType: SetType.warmup,
                  targetWeight: 20.0,
                  targetReps: 8,
                ),
                TargetSet(
                  id: 'ts-fbb-7-2',
                  setNumber: 2,
                  targetWeight: 30.0,
                  targetReps: 6,
                  targetRpe: 7.0,
                ),
                TargetSet(
                  id: 'ts-fbb-7-3',
                  setNumber: 3,
                  targetWeight: 30.0,
                  targetReps: 6,
                  targetRpe: 7.5,
                ),
                TargetSet(
                  id: 'ts-fbb-7-4',
                  setNumber: 4,
                  targetWeight: 30.0,
                  targetReps: 6,
                  targetRpe: 8.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fbb-8',
              exerciseId: 'exercise-lat-pulldown-001', // Lat Pulldown
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-fbb-8-1',
                  setNumber: 1,
                  targetWeight: 40.0,
                  targetReps: 10,
                  targetRpe: 7.0,
                ),
                TargetSet(
                  id: 'ts-fbb-8-2',
                  setNumber: 2,
                  targetWeight: 40.0,
                  targetReps: 10,
                  targetRpe: 7.5,
                ),
                TargetSet(
                  id: 'ts-fbb-8-3',
                  setNumber: 3,
                  targetWeight: 40.0,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-fbb-3',
          name: 'Glute & Core Finisher',
          items: [
            TemplateItem(
              id: 'item-fbb-9',
              exerciseId: 'exercise-glute-bridge-001', // Glute Bridge
              order: 1,
              targetSets: [
                TargetSet(id: 'ts-fbb-9-1', setNumber: 1, targetReps: 12),
                TargetSet(id: 'ts-fbb-9-2', setNumber: 2, targetReps: 12),
                TargetSet(id: 'ts-fbb-9-3', setNumber: 3, targetReps: 12),
              ],
            ),
            TemplateItem(
              id: 'item-fbb-10',
              exerciseId: 'exercise-dead-bug-001', // Dead Bug
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-fbb-10-1', setNumber: 1, targetReps: 8),
                TargetSet(id: 'ts-fbb-10-2', setNumber: 2, targetReps: 8),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-fbb-4',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-fbb-11',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-fbb-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-fbb-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fbb-12',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-fbb-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-fbb-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fbb-13',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-fbb-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-fbb-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fbb-14',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-fbb-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-fbb-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fbb-15',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001', // Cross-Body Shoulder Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-fbb-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-fbb-15-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-fbb-5',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-fbb-16',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-fbb-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fbb-17',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-fbb-17-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-fbb-17-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fbb-18',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-fbb-18-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 3. Upper Body Push A
  static final _upperBodyPushA = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-upper-push-a',
      name: 'Upper Body Push A',
      description: 'Intermediate | ~60 min. Horizontal and vertical pressing power with bench, incline and dips, then triceps work, upper-body stretching and a relaxed ending.',
      currentRevisionId: 'rev-upper-push-a-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['push', 'upper-body', 'chest', 'intermediate', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-upper-push-a-001',
      templateId: 'template-upper-push-a',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-upa-1',
          name: 'Upper Body Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-upa-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-upa-1',
                  setNumber: 1,
                  targetDurationSeconds: 270,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-upa-1',
              exerciseId: 'exercise-arm-circles-001', // Arm Circles
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upa-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upa-2',
              exerciseId: 'exercise-cat-cow-001', // Cat-Cow
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-upa-2-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-upa-3',
              exerciseId: 'exercise-inchworm-001', // Inchworm
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-upa-3-1', setNumber: 1, targetReps: 6),
              ],
            ),
            TemplateItem(
              id: 'item-upa-4',
              exerciseId: 'exercise-face-pull-001', // Cable Face Pull
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-upa-4-1',
                  setNumber: 1,
                  targetWeight: 10.0,
                  targetReps: 15,
                ),
                TargetSet(
                  id: 'ts-upa-4-2',
                  setNumber: 2,
                  targetWeight: 10.0,
                  targetReps: 15,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upa-5',
              exerciseId: 'exercise-pushup-001', // Push-Up
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-upa-5-1', setNumber: 1, targetReps: 8),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-upa-2',
          name: 'Pressing Block',
          items: [
            TemplateItem(
              id: 'item-upa-6',
              exerciseId: 'exercise-bench-001', // Barbell Bench Press
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-upa-6-1',
                  setNumber: 1,
                  setType: SetType.warmup,
                  targetWeight: 40.0,
                  targetReps: 10,
                ),
                TargetSet(
                  id: 'ts-upa-6-2',
                  setNumber: 2,
                  setType: SetType.warmup,
                  targetWeight: 60.0,
                  targetReps: 5,
                ),
                TargetSet(
                  id: 'ts-upa-6-3',
                  setNumber: 3,
                  targetWeight: 82.5,
                  targetReps: 8,
                  targetRpe: 7.5,
                ),
                TargetSet(
                  id: 'ts-upa-6-4',
                  setNumber: 4,
                  targetWeight: 82.5,
                  targetReps: 8,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-upa-6-5',
                  setNumber: 5,
                  targetWeight: 82.5,
                  targetReps: 8,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-upa-6-6',
                  setNumber: 6,
                  targetWeight: 82.5,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upa-7',
              exerciseId:
                  'exercise-incline-bench-001', // Incline Barbell Bench Press
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upa-7-1',
                  setNumber: 1,
                  targetWeight: 70.0,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-upa-7-2',
                  setNumber: 2,
                  targetWeight: 70.0,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-upa-7-3',
                  setNumber: 3,
                  targetWeight: 70.0,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-upa-3',
          name: 'Triceps Block',
          items: [
            TemplateItem(
              id: 'item-upa-8',
              exerciseId: 'exercise-dips-001', // Parallel Bar Dips
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-upa-8-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-upa-8-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-upa-8-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upa-9',
              exerciseId:
                  'exercise-tricep-pushdown-001', // Cable Tricep Pushdown
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upa-9-1',
                  setNumber: 1,
                  targetWeight: 25.0,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-upa-9-2',
                  setNumber: 2,
                  targetWeight: 25.0,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-upa-9-3',
                  setNumber: 3,
                  targetWeight: 25.0,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-upa-4',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-upa-10',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-upa-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-upa-10-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upa-11',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001', // Cross-Body Shoulder Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upa-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-upa-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upa-12',
              exerciseId: 'exercise-overhead-tricep-stretch-001', // Overhead Triceps Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-upa-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-upa-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-upa-5',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-upa-13',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-upa-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upa-14',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upa-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-upa-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upa-15',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-upa-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 4. Upper Body Push B
  static final _upperBodyPushB = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-upper-push-b',
      name: 'Upper Body Push B',
      description: 'Intermediate | ~55 min. Shoulder-focused push session with heavy overhead press, dumbbell pressing and a delt and triceps superset, plus stretching and a relaxed ending.',
      currentRevisionId: 'rev-upper-push-b-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['push', 'shoulders', 'triceps', 'intermediate', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-upper-push-b-001',
      templateId: 'template-upper-push-b',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-upb-1',
          name: 'Upper Body Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-upb-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-upb-1',
                  setNumber: 1,
                  targetDurationSeconds: 270,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-upb-1',
              exerciseId: 'exercise-arm-circles-001', // Arm Circles
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upb-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upb-2',
              exerciseId: 'exercise-cat-cow-001', // Cat-Cow
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-upb-2-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-upb-3',
              exerciseId: 'exercise-inchworm-001', // Inchworm
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-upb-3-1', setNumber: 1, targetReps: 6),
              ],
            ),
            TemplateItem(
              id: 'item-upb-4',
              exerciseId: 'exercise-face-pull-001', // Cable Face Pull
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-upb-4-1',
                  setNumber: 1,
                  targetWeight: 10.0,
                  targetReps: 15,
                ),
                TargetSet(
                  id: 'ts-upb-4-2',
                  setNumber: 2,
                  targetWeight: 10.0,
                  targetReps: 15,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upb-5',
              exerciseId: 'exercise-pushup-001', // Push-Up
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-upb-5-1', setNumber: 1, targetReps: 8),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-upb-2',
          name: 'Shoulder Power',
          items: [
            TemplateItem(
              id: 'item-upb-6',
              exerciseId: 'exercise-ohp-001', // Overhead Press
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-upb-6-1',
                  setNumber: 1,
                  setType: SetType.warmup,
                  targetWeight: 30.0,
                  targetReps: 8,
                ),
                TargetSet(
                  id: 'ts-upb-6-2',
                  setNumber: 2,
                  setType: SetType.warmup,
                  targetWeight: 40.0,
                  targetReps: 5,
                ),
                TargetSet(
                  id: 'ts-upb-6-3',
                  setNumber: 3,
                  targetWeight: 52.5,
                  targetReps: 6,
                  targetRpe: 7.5,
                ),
                TargetSet(
                  id: 'ts-upb-6-4',
                  setNumber: 4,
                  targetWeight: 52.5,
                  targetReps: 6,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-upb-6-5',
                  setNumber: 5,
                  targetWeight: 52.5,
                  targetReps: 6,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-upb-6-6',
                  setNumber: 6,
                  targetWeight: 52.5,
                  targetReps: 6,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upb-7',
              exerciseId: 'exercise-seated-db-press-001', // Seated Dumbbell Shoulder Press
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upb-7-1',
                  setNumber: 1,
                  targetWeight: 22.0,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-upb-7-2',
                  setNumber: 2,
                  targetWeight: 22.0,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-upb-7-3',
                  setNumber: 3,
                  targetWeight: 22.0,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-upb-3',
          name: 'Delt & Triceps Superset',
          type: WorkoutBlockType.superset,
          rounds: 3,
          items: [
            TemplateItem(
              id: 'item-upb-8',
              exerciseId:
                  'exercise-lateral-raise-001', // Dumbbell Lateral Raise
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-upb-8-1',
                  setNumber: 1,
                  targetWeight: 12.5,
                  targetReps: 15,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upb-9',
              exerciseId: 'exercise-overhead-tricep-001', // Overhead Cable Tricep Extension
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upb-9-1',
                  setNumber: 1,
                  targetWeight: 20.0,
                  targetReps: 12,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-upb-4',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-upb-10',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-upb-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-upb-10-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upb-11',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001', // Cross-Body Shoulder Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upb-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-upb-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upb-12',
              exerciseId: 'exercise-overhead-tricep-stretch-001', // Overhead Triceps Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-upb-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-upb-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-upb-5',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-upb-13',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-upb-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upb-14',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upb-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-upb-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upb-15',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-upb-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 5. Upper Body Pull A
  static final _upperBodyPullA = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-upper-pull-a',
      name: 'Upper Body Pull A',
      description: 'Intermediate | ~60 min. Back thickness and biceps volume built on barbell rows, pulldowns and cable rows, followed by stretching and a relaxed ending.',
      currentRevisionId: 'rev-upper-pull-a-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['pull', 'back', 'biceps', 'intermediate', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-upper-pull-a-001',
      templateId: 'template-upper-pull-a',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-upla-1',
          name: 'Upper Body Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-upla-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-upla-1',
                  setNumber: 1,
                  targetDurationSeconds: 270,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-upla-1',
              exerciseId: 'exercise-arm-circles-001', // Arm Circles
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upla-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upla-2',
              exerciseId: 'exercise-cat-cow-001', // Cat-Cow
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-upla-2-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-upla-3',
              exerciseId: 'exercise-inchworm-001', // Inchworm
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-upla-3-1', setNumber: 1, targetReps: 6),
              ],
            ),
            TemplateItem(
              id: 'item-upla-4',
              exerciseId: 'exercise-face-pull-001', // Cable Face Pull
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-upla-4-1',
                  setNumber: 1,
                  targetWeight: 10.0,
                  targetReps: 15,
                ),
                TargetSet(
                  id: 'ts-upla-4-2',
                  setNumber: 2,
                  targetWeight: 10.0,
                  targetReps: 15,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upla-5',
              exerciseId: 'exercise-pushup-001', // Push-Up
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-upla-5-1', setNumber: 1, targetReps: 8),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-upla-2',
          name: 'Back Thickness',
          items: [
            TemplateItem(
              id: 'item-upla-6',
              exerciseId: 'exercise-row-001', // Barbell Row
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-upla-6-1',
                  setNumber: 1,
                  setType: SetType.warmup,
                  targetWeight: 40.0,
                  targetReps: 10,
                ),
                TargetSet(
                  id: 'ts-upla-6-2',
                  setNumber: 2,
                  setType: SetType.warmup,
                  targetWeight: 60.0,
                  targetReps: 5,
                ),
                TargetSet(
                  id: 'ts-upla-6-3',
                  setNumber: 3,
                  targetWeight: 75.0,
                  targetReps: 8,
                  targetRpe: 7.5,
                ),
                TargetSet(
                  id: 'ts-upla-6-4',
                  setNumber: 4,
                  targetWeight: 75.0,
                  targetReps: 8,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-upla-6-5',
                  setNumber: 5,
                  targetWeight: 75.0,
                  targetReps: 8,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-upla-6-6',
                  setNumber: 6,
                  targetWeight: 75.0,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upla-7',
              exerciseId: 'exercise-lat-pulldown-001', // Lat Pulldown
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upla-7-1',
                  setNumber: 1,
                  targetWeight: 60.0,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-upla-7-2',
                  setNumber: 2,
                  targetWeight: 60.0,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-upla-7-3',
                  setNumber: 3,
                  targetWeight: 60.0,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upla-8',
              exerciseId: 'exercise-seated-cable-row-001', // Seated Cable Row
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-upla-8-1',
                  setNumber: 1,
                  targetWeight: 50.0,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-upla-8-2',
                  setNumber: 2,
                  targetWeight: 50.0,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-upla-8-3',
                  setNumber: 3,
                  targetWeight: 50.0,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-upla-3',
          name: 'Biceps Superset',
          type: WorkoutBlockType.superset,
          rounds: 3,
          items: [
            TemplateItem(
              id: 'item-upla-9',
              exerciseId: 'exercise-db-curl-001', // Dumbbell Bicep Curl
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-upla-9-1',
                  setNumber: 1,
                  targetWeight: 15.0,
                  targetReps: 10,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upla-10',
              exerciseId: 'exercise-hammer-curl-001', // Dumbbell Hammer Curl
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upla-10-1',
                  setNumber: 1,
                  targetWeight: 14.0,
                  targetReps: 10,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-upla-4',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-upla-11',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-upla-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-upla-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upla-12',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001', // Cross-Body Shoulder Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upla-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-upla-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upla-13',
              exerciseId: 'exercise-overhead-tricep-stretch-001', // Overhead Triceps Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-upla-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-upla-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-upla-5',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-upla-14',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-upla-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upla-15',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upla-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-upla-15-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upla-16',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-upla-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 6. Upper Body Pull B
  static final _upperBodyPullB = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-upper-pull-b',
      name: 'Upper Body Pull B',
      description: 'Intermediate | ~55 min. Vertical pulling and rear-delt specialization with pull-ups, chin-ups, face pulls and shrugs, then stretching and a relaxed ending.',
      currentRevisionId: 'rev-upper-pull-b-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['pull', 'lats', 'rear-delts', 'intermediate', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-upper-pull-b-001',
      templateId: 'template-upper-pull-b',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-uplb-1',
          name: 'Upper Body Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-uplb-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-uplb-1',
                  setNumber: 1,
                  targetDurationSeconds: 270,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-uplb-1',
              exerciseId: 'exercise-arm-circles-001', // Arm Circles
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-uplb-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uplb-2',
              exerciseId: 'exercise-cat-cow-001', // Cat-Cow
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-uplb-2-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-uplb-3',
              exerciseId: 'exercise-inchworm-001', // Inchworm
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-uplb-3-1', setNumber: 1, targetReps: 6),
              ],
            ),
            TemplateItem(
              id: 'item-uplb-4',
              exerciseId: 'exercise-face-pull-001', // Cable Face Pull
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-uplb-4-1',
                  setNumber: 1,
                  targetWeight: 10.0,
                  targetReps: 15,
                ),
                TargetSet(
                  id: 'ts-uplb-4-2',
                  setNumber: 2,
                  targetWeight: 10.0,
                  targetReps: 15,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uplb-5',
              exerciseId: 'exercise-pushup-001', // Push-Up
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-uplb-5-1', setNumber: 1, targetReps: 8),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-uplb-2',
          name: 'Vertical Pull',
          items: [
            TemplateItem(
              id: 'item-uplb-6',
              exerciseId: 'exercise-pullup-001', // Pull-Up
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-uplb-6-1',
                  setNumber: 1,
                  targetReps: 8,
                  targetRpe: 7.5,
                ),
                TargetSet(
                  id: 'ts-uplb-6-2',
                  setNumber: 2,
                  targetReps: 8,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-uplb-6-3',
                  setNumber: 3,
                  targetReps: 8,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-uplb-6-4',
                  setNumber: 4,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uplb-7',
              exerciseId: 'exercise-chinup-001', // Chin-Up
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-uplb-7-1',
                  setNumber: 1,
                  targetReps: 8,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-uplb-7-2',
                  setNumber: 2,
                  targetReps: 8,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-uplb-7-3',
                  setNumber: 3,
                  targetReps: 8,
                  targetRpe: 8.5,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-uplb-3',
          name: 'Rear Delts & Upper Back',
          items: [
            TemplateItem(
              id: 'item-uplb-8',
              exerciseId: 'exercise-face-pull-001', // Cable Face Pull
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-uplb-8-1',
                  setNumber: 1,
                  targetWeight: 20.0,
                  targetReps: 15,
                  targetRpe: 7.5,
                ),
                TargetSet(
                  id: 'ts-uplb-8-2',
                  setNumber: 2,
                  targetWeight: 20.0,
                  targetReps: 15,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-uplb-8-3',
                  setNumber: 3,
                  targetWeight: 20.0,
                  targetReps: 15,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-uplb-8-4',
                  setNumber: 4,
                  targetWeight: 20.0,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uplb-9',
              exerciseId:
                  'exercise-rear-delt-fly-001', // Dumbbell Rear Delt Fly
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-uplb-9-1',
                  setNumber: 1,
                  targetWeight: 8.0,
                  targetReps: 15,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-uplb-9-2',
                  setNumber: 2,
                  targetWeight: 8.0,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-uplb-9-3',
                  setNumber: 3,
                  targetWeight: 8.0,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uplb-10',
              exerciseId: 'exercise-barbell-shrug-001', // Barbell Shrug
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-uplb-10-1',
                  setNumber: 1,
                  targetWeight: 60.0,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-uplb-10-2',
                  setNumber: 2,
                  targetWeight: 60.0,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-uplb-10-3',
                  setNumber: 3,
                  targetWeight: 60.0,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-uplb-4',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-uplb-11',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-uplb-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-uplb-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uplb-12',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001', // Cross-Body Shoulder Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-uplb-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-uplb-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uplb-13',
              exerciseId: 'exercise-overhead-tricep-stretch-001', // Overhead Triceps Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-uplb-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-uplb-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-uplb-5',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-uplb-14',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-uplb-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uplb-15',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-uplb-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-uplb-15-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uplb-16',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-uplb-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 7. Lower Body Quad Focus
  static final _lowerBodyQuadFocus = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-lower-quad',
      name: 'Lower Body Quad Focus',
      description: 'Intermediate | ~60 min. Squat and leg press heavy session with quad isolation and calves, finished with lower-body stretching and a relaxed ending.',
      currentRevisionId: 'rev-lower-quad-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['legs', 'quads', 'strength', 'intermediate', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-lower-quad-001',
      templateId: 'template-lower-quad',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-lq-1',
          name: 'Lower Body Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-lq-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-lq-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-lq-1',
              exerciseId: 'exercise-glute-bridge-001', // Glute Bridge
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-lq-1-1', setNumber: 1, targetReps: 12),
              ],
            ),
            TemplateItem(
              id: 'item-lq-2',
              exerciseId: 'exercise-leg-swings-001', // Leg Swings
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-lq-2-1', setNumber: 1, targetReps: 10),
                TargetSet(id: 'ts-lq-2-2', setNumber: 2, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-lq-3',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-lq-3-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-lq-4',
              exerciseId: 'exercise-worlds-greatest-stretch-001', // World's Greatest Stretch
              order: 5,
              targetSets: [
                TargetSet(id: 'ts-lq-4-1', setNumber: 1, targetReps: 3),
                TargetSet(id: 'ts-lq-4-2', setNumber: 2, targetReps: 3),
              ],
            ),
            TemplateItem(
              id: 'item-lq-5',
              exerciseId: 'exercise-cat-cow-001', // Cat-Cow
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-lq-5-1', setNumber: 1, targetReps: 8),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-lq-2',
          name: 'Quad Block',
          items: [
            TemplateItem(
              id: 'item-lq-6',
              exerciseId: 'exercise-squat-001', // Barbell Back Squat
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lq-6-1',
                  setNumber: 1,
                  setType: SetType.warmup,
                  targetWeight: 40.0,
                  targetReps: 8,
                ),
                TargetSet(
                  id: 'ts-lq-6-2',
                  setNumber: 2,
                  setType: SetType.warmup,
                  targetWeight: 70.0,
                  targetReps: 5,
                ),
                TargetSet(
                  id: 'ts-lq-6-3',
                  setNumber: 3,
                  setType: SetType.warmup,
                  targetWeight: 90.0,
                  targetReps: 3,
                ),
                TargetSet(
                  id: 'ts-lq-6-4',
                  setNumber: 4,
                  targetWeight: 100.0,
                  targetReps: 6,
                  targetRpe: 7.5,
                ),
                TargetSet(
                  id: 'ts-lq-6-5',
                  setNumber: 5,
                  targetWeight: 100.0,
                  targetReps: 6,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-lq-6-6',
                  setNumber: 6,
                  targetWeight: 100.0,
                  targetReps: 6,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lq-6-7',
                  setNumber: 7,
                  targetWeight: 100.0,
                  targetReps: 6,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lq-7',
              exerciseId: 'exercise-leg-press-001', // Leg Press
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lq-7-1',
                  setNumber: 1,
                  targetWeight: 180.0,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-lq-7-2',
                  setNumber: 2,
                  targetWeight: 200.0,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lq-7-3',
                  setNumber: 3,
                  targetWeight: 200.0,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-lq-3',
          name: 'Isolation & Calves',
          items: [
            TemplateItem(
              id: 'item-lq-8',
              exerciseId: 'exercise-leg-extension-001', // Leg Extension Machine
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lq-8-1',
                  setNumber: 1,
                  targetWeight: 50.0,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-lq-8-2',
                  setNumber: 2,
                  targetWeight: 50.0,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lq-8-3',
                  setNumber: 3,
                  targetWeight: 50.0,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lq-9',
              exerciseId:
                  'exercise-standing-calf-raise-001', // Standing Calf Raise
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lq-9-1',
                  setNumber: 1,
                  targetWeight: 60.0,
                  targetReps: 15,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-lq-9-2',
                  setNumber: 2,
                  targetWeight: 60.0,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lq-9-3',
                  setNumber: 3,
                  targetWeight: 60.0,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-lq-4',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-lq-10',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lq-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-lq-10-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lq-11',
              exerciseId: 'exercise-quad-stretch-001', // Standing Quad Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lq-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-lq-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lq-12',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-lq-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-lq-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lq-13',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-lq-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-lq-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lq-14',
              exerciseId: 'exercise-calf-stretch-001', // Standing Calf Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-lq-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-lq-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-lq-5',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-lq-15',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lq-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lq-16',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lq-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-lq-16-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lq-17',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-lq-17-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 8. Lower Body Hinge Focus
  static final _lowerBodyHingeFocus = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-lower-hinge',
      name: 'Lower Body Hinge Focus',
      description: 'Intermediate | ~60 min. Hamstring and posterior-chain builder with deadlifts, Romanian deadlifts, curls and back extensions, then stretching and a relaxed ending.',
      currentRevisionId: 'rev-lower-hinge-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['legs', 'hamstrings', 'deadlift', 'intermediate', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-lower-hinge-001',
      templateId: 'template-lower-hinge',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-lh-1',
          name: 'Lower Body Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-lh-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-lh-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-lh-1',
              exerciseId: 'exercise-glute-bridge-001', // Glute Bridge
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-lh-1-1', setNumber: 1, targetReps: 12),
              ],
            ),
            TemplateItem(
              id: 'item-lh-2',
              exerciseId: 'exercise-leg-swings-001', // Leg Swings
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-lh-2-1', setNumber: 1, targetReps: 10),
                TargetSet(id: 'ts-lh-2-2', setNumber: 2, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-lh-3',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-lh-3-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-lh-4',
              exerciseId: 'exercise-worlds-greatest-stretch-001', // World's Greatest Stretch
              order: 5,
              targetSets: [
                TargetSet(id: 'ts-lh-4-1', setNumber: 1, targetReps: 3),
                TargetSet(id: 'ts-lh-4-2', setNumber: 2, targetReps: 3),
              ],
            ),
            TemplateItem(
              id: 'item-lh-5',
              exerciseId: 'exercise-cat-cow-001', // Cat-Cow
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-lh-5-1', setNumber: 1, targetReps: 8),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-lh-2',
          name: 'Hinge Block',
          items: [
            TemplateItem(
              id: 'item-lh-6',
              exerciseId: 'exercise-deadlift-001', // Conventional Deadlift
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lh-6-1',
                  setNumber: 1,
                  setType: SetType.warmup,
                  targetWeight: 60.0,
                  targetReps: 5,
                ),
                TargetSet(
                  id: 'ts-lh-6-2',
                  setNumber: 2,
                  setType: SetType.warmup,
                  targetWeight: 100.0,
                  targetReps: 3,
                ),
                TargetSet(
                  id: 'ts-lh-6-3',
                  setNumber: 3,
                  targetWeight: 120.0,
                  targetReps: 5,
                  targetRpe: 7.5,
                ),
                TargetSet(
                  id: 'ts-lh-6-4',
                  setNumber: 4,
                  targetWeight: 120.0,
                  targetReps: 5,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-lh-6-5',
                  setNumber: 5,
                  targetWeight: 120.0,
                  targetReps: 5,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lh-6-6',
                  setNumber: 6,
                  targetWeight: 120.0,
                  targetReps: 5,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lh-7',
              exerciseId:
                  'exercise-barbell-rdl-001', // Barbell Romanian Deadlift
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lh-7-1',
                  setNumber: 1,
                  targetWeight: 80.0,
                  targetReps: 8,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-lh-7-2',
                  setNumber: 2,
                  targetWeight: 80.0,
                  targetReps: 8,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lh-7-3',
                  setNumber: 3,
                  targetWeight: 80.0,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-lh-3',
          name: 'Hamstrings & Lower Back',
          items: [
            TemplateItem(
              id: 'item-lh-8',
              exerciseId:
                  'exercise-seated-leg-curl-001', // Seated Leg Curl Machine
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lh-8-1',
                  setNumber: 1,
                  targetWeight: 40.0,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-lh-8-2',
                  setNumber: 2,
                  targetWeight: 40.0,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lh-8-3',
                  setNumber: 3,
                  targetWeight: 40.0,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lh-9',
              exerciseId:
                  'exercise-back-extension-001', // 45-Degree Back Extension
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lh-9-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-lh-9-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lh-9-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-lh-4',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-lh-10',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lh-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-lh-10-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lh-11',
              exerciseId: 'exercise-quad-stretch-001', // Standing Quad Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lh-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-lh-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lh-12',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-lh-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-lh-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lh-13',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-lh-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-lh-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lh-14',
              exerciseId: 'exercise-calf-stretch-001', // Standing Calf Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-lh-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-lh-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-lh-5',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-lh-15',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lh-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lh-16',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lh-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-lh-16-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lh-17',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-lh-17-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 9. Push Hypertrophy
  static final _pushHypertrophy = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-push-hypertrophy',
      name: 'Push Hypertrophy',
      description: 'Intermediate | ~65 min. Volume-driven chest, shoulder and triceps session using dumbbells and cables, plus stretching and a relaxed ending.',
      currentRevisionId: 'rev-push-hyp-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['hypertrophy', 'push', 'chest', 'intermediate', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-push-hyp-001',
      templateId: 'template-push-hypertrophy',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-ph-1',
          name: 'Upper Body Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-ph-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-ph-1',
                  setNumber: 1,
                  targetDurationSeconds: 270,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-ph-1',
              exerciseId: 'exercise-arm-circles-001', // Arm Circles
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ph-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ph-2',
              exerciseId: 'exercise-cat-cow-001', // Cat-Cow
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-ph-2-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-ph-3',
              exerciseId: 'exercise-inchworm-001', // Inchworm
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-ph-3-1', setNumber: 1, targetReps: 6),
              ],
            ),
            TemplateItem(
              id: 'item-ph-4',
              exerciseId: 'exercise-face-pull-001', // Cable Face Pull
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-ph-4-1',
                  setNumber: 1,
                  targetWeight: 10.0,
                  targetReps: 15,
                ),
                TargetSet(
                  id: 'ts-ph-4-2',
                  setNumber: 2,
                  targetWeight: 10.0,
                  targetReps: 15,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ph-5',
              exerciseId: 'exercise-pushup-001', // Push-Up
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-ph-5-1', setNumber: 1, targetReps: 8),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ph-2',
          name: 'Pressing Volume',
          items: [
            TemplateItem(
              id: 'item-ph-6',
              exerciseId: 'exercise-db-bench-001', // Dumbbell Bench Press
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ph-6-1',
                  setNumber: 1,
                  setType: SetType.warmup,
                  targetWeight: 14.0,
                  targetReps: 12,
                ),
                TargetSet(
                  id: 'ts-ph-6-2',
                  setNumber: 2,
                  targetWeight: 30.0,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-ph-6-3',
                  setNumber: 3,
                  targetWeight: 30.0,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-ph-6-4',
                  setNumber: 4,
                  targetWeight: 30.0,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ph-6-5',
                  setNumber: 5,
                  targetWeight: 30.0,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ph-7',
              exerciseId:
                  'exercise-incline-db-press-001', // Incline Dumbbell Press
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ph-7-1',
                  setNumber: 1,
                  targetWeight: 24.0,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-ph-7-2',
                  setNumber: 2,
                  targetWeight: 24.0,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-ph-7-3',
                  setNumber: 3,
                  targetWeight: 24.0,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ph-3',
          name: 'Chest & Shoulder Isolation',
          items: [
            TemplateItem(
              id: 'item-ph-8',
              exerciseId: 'exercise-cable-crossover-001', // Cable Crossover
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ph-8-1',
                  setNumber: 1,
                  targetWeight: 15.0,
                  targetReps: 15,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-ph-8-2',
                  setNumber: 2,
                  targetWeight: 15.0,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-ph-8-3',
                  setNumber: 3,
                  targetWeight: 15.0,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ph-9',
              exerciseId:
                  'exercise-lateral-raise-001', // Dumbbell Lateral Raise
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ph-9-1',
                  setNumber: 1,
                  targetWeight: 10.0,
                  targetReps: 15,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-ph-9-2',
                  setNumber: 2,
                  targetWeight: 10.0,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-ph-9-3',
                  setNumber: 3,
                  targetWeight: 10.0,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ph-4',
          name: 'Triceps',
          items: [
            TemplateItem(
              id: 'item-ph-10',
              exerciseId:
                  'exercise-tricep-pushdown-001', // Cable Tricep Pushdown
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ph-10-1',
                  setNumber: 1,
                  targetWeight: 25.0,
                  targetReps: 15,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-ph-10-2',
                  setNumber: 2,
                  targetWeight: 25.0,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-ph-10-3',
                  setNumber: 3,
                  targetWeight: 25.0,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ph-5',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-ph-11',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ph-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ph-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ph-12',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001', // Cross-Body Shoulder Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ph-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ph-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ph-13',
              exerciseId: 'exercise-overhead-tricep-stretch-001', // Overhead Triceps Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-ph-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ph-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ph-6',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-ph-14',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ph-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ph-15',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ph-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-ph-15-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ph-16',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-ph-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 10. Pull Hypertrophy
  static final _pullHypertrophy = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-pull-hypertrophy',
      name: 'Pull Hypertrophy',
      description: 'Intermediate | ~65 min. High-volume back, rear-delt and biceps session built on cable and dumbbell rowing, then stretching and a relaxed ending.',
      currentRevisionId: 'rev-pull-hyp-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['hypertrophy', 'pull', 'back', 'intermediate', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-pull-hyp-001',
      templateId: 'template-pull-hypertrophy',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-pullh-1',
          name: 'Upper Body Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-pullh-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-pullh-1',
                  setNumber: 1,
                  targetDurationSeconds: 270,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-pullh-1',
              exerciseId: 'exercise-arm-circles-001', // Arm Circles
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-pullh-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-pullh-2',
              exerciseId: 'exercise-cat-cow-001', // Cat-Cow
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-pullh-2-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-pullh-3',
              exerciseId: 'exercise-inchworm-001', // Inchworm
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-pullh-3-1', setNumber: 1, targetReps: 6),
              ],
            ),
            TemplateItem(
              id: 'item-pullh-4',
              exerciseId: 'exercise-face-pull-001', // Cable Face Pull
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-pullh-4-1',
                  setNumber: 1,
                  targetWeight: 10.0,
                  targetReps: 15,
                ),
                TargetSet(
                  id: 'ts-pullh-4-2',
                  setNumber: 2,
                  targetWeight: 10.0,
                  targetReps: 15,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-pullh-5',
              exerciseId: 'exercise-pushup-001', // Push-Up
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-pullh-5-1', setNumber: 1, targetReps: 8),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-pullh-2',
          name: 'Rowing Volume',
          items: [
            TemplateItem(
              id: 'item-pullh-6',
              exerciseId: 'exercise-seated-cable-row-001', // Seated Cable Row
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-pullh-6-1',
                  setNumber: 1,
                  targetWeight: 55.0,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-pullh-6-2',
                  setNumber: 2,
                  targetWeight: 55.0,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-pullh-6-3',
                  setNumber: 3,
                  targetWeight: 55.0,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-pullh-6-4',
                  setNumber: 4,
                  targetWeight: 55.0,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-pullh-7',
              exerciseId:
                  'exercise-single-arm-db-row-001', // Single-Arm Dumbbell Row
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-pullh-7-1',
                  setNumber: 1,
                  targetWeight: 28.0,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-pullh-7-2',
                  setNumber: 2,
                  targetWeight: 28.0,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-pullh-7-3',
                  setNumber: 3,
                  targetWeight: 28.0,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-pullh-3',
          name: 'Lats & Rear Delts',
          items: [
            TemplateItem(
              id: 'item-pullh-8',
              exerciseId: 'exercise-lat-pulldown-001', // Lat Pulldown
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-pullh-8-1',
                  setNumber: 1,
                  targetWeight: 55.0,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-pullh-8-2',
                  setNumber: 2,
                  targetWeight: 55.0,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-pullh-8-3',
                  setNumber: 3,
                  targetWeight: 55.0,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-pullh-9',
              exerciseId: 'exercise-face-pull-001', // Cable Face Pull
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-pullh-9-1',
                  setNumber: 1,
                  targetWeight: 20.0,
                  targetReps: 15,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-pullh-9-2',
                  setNumber: 2,
                  targetWeight: 20.0,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-pullh-9-3',
                  setNumber: 3,
                  targetWeight: 20.0,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-pullh-4',
          name: 'Biceps',
          items: [
            TemplateItem(
              id: 'item-pullh-10',
              exerciseId: 'exercise-barbell-curl-001', // Barbell Bicep Curl
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-pullh-10-1',
                  setNumber: 1,
                  targetWeight: 30.0,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-pullh-10-2',
                  setNumber: 2,
                  targetWeight: 30.0,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-pullh-10-3',
                  setNumber: 3,
                  targetWeight: 30.0,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-pullh-5',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-pullh-11',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-pullh-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-pullh-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-pullh-12',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001', // Cross-Body Shoulder Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-pullh-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-pullh-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-pullh-13',
              exerciseId: 'exercise-overhead-tricep-stretch-001', // Overhead Triceps Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-pullh-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-pullh-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-pullh-6',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-pullh-14',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-pullh-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-pullh-15',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-pullh-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-pullh-15-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-pullh-16',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-pullh-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 11. Balanced Leg Session
  static final _legDayBalanced = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-leg-balanced',
      name: 'Balanced Leg Session',
      description: 'Intermediate | ~65 min. Complete leg workout addressing quads, glutes, hamstrings and calves with front squats and hip thrusts, then stretching and a relaxed ending.',
      currentRevisionId: 'rev-leg-bal-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['legs', 'balanced', 'glutes', 'intermediate', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-leg-bal-001',
      templateId: 'template-leg-balanced',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-legbal-1',
          name: 'Lower Body Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-legbal-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-legbal-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-legbal-1',
              exerciseId: 'exercise-glute-bridge-001', // Glute Bridge
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-legbal-1-1', setNumber: 1, targetReps: 12),
              ],
            ),
            TemplateItem(
              id: 'item-legbal-2',
              exerciseId: 'exercise-leg-swings-001', // Leg Swings
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-legbal-2-1', setNumber: 1, targetReps: 10),
                TargetSet(id: 'ts-legbal-2-2', setNumber: 2, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-legbal-3',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-legbal-3-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-legbal-4',
              exerciseId: 'exercise-worlds-greatest-stretch-001', // World's Greatest Stretch
              order: 5,
              targetSets: [
                TargetSet(id: 'ts-legbal-4-1', setNumber: 1, targetReps: 3),
                TargetSet(id: 'ts-legbal-4-2', setNumber: 2, targetReps: 3),
              ],
            ),
            TemplateItem(
              id: 'item-legbal-5',
              exerciseId: 'exercise-cat-cow-001', // Cat-Cow
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-legbal-5-1', setNumber: 1, targetReps: 8),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-legbal-2',
          name: 'Quad Focus',
          items: [
            TemplateItem(
              id: 'item-legbal-6',
              exerciseId: 'exercise-front-squat-001', // Barbell Front Squat
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-legbal-6-1',
                  setNumber: 1,
                  setType: SetType.warmup,
                  targetWeight: 30.0,
                  targetReps: 8,
                ),
                TargetSet(
                  id: 'ts-legbal-6-2',
                  setNumber: 2,
                  targetWeight: 70.0,
                  targetReps: 6,
                  targetRpe: 7.5,
                ),
                TargetSet(
                  id: 'ts-legbal-6-3',
                  setNumber: 3,
                  targetWeight: 70.0,
                  targetReps: 6,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-legbal-6-4',
                  setNumber: 4,
                  targetWeight: 70.0,
                  targetReps: 6,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-legbal-6-5',
                  setNumber: 5,
                  targetWeight: 70.0,
                  targetReps: 6,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-legbal-3',
          name: 'Glutes & Hamstrings',
          items: [
            TemplateItem(
              id: 'item-legbal-7',
              exerciseId: 'exercise-hip-thrust-001', // Barbell Hip Thrust
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-legbal-7-1',
                  setNumber: 1,
                  setType: SetType.warmup,
                  targetWeight: 40.0,
                  targetReps: 10,
                ),
                TargetSet(
                  id: 'ts-legbal-7-2',
                  setNumber: 2,
                  targetWeight: 100.0,
                  targetReps: 8,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-legbal-7-3',
                  setNumber: 3,
                  targetWeight: 100.0,
                  targetReps: 8,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-legbal-7-4',
                  setNumber: 4,
                  targetWeight: 100.0,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-legbal-7-5',
                  setNumber: 5,
                  targetWeight: 100.0,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-legbal-8',
              exerciseId:
                  'exercise-lying-leg-curl-001', // Lying Leg Curl Machine
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-legbal-8-1',
                  setNumber: 1,
                  targetWeight: 35.0,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-legbal-8-2',
                  setNumber: 2,
                  targetWeight: 35.0,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-legbal-8-3',
                  setNumber: 3,
                  targetWeight: 35.0,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-legbal-4',
          name: 'Calves',
          items: [
            TemplateItem(
              id: 'item-legbal-9',
              exerciseId:
                  'exercise-standing-calf-raise-001', // Standing Calf Raise
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-legbal-9-1',
                  setNumber: 1,
                  targetWeight: 70.0,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-legbal-9-2',
                  setNumber: 2,
                  targetWeight: 70.0,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-legbal-9-3',
                  setNumber: 3,
                  targetWeight: 70.0,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-legbal-9-4',
                  setNumber: 4,
                  targetWeight: 70.0,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-legbal-10',
              exerciseId: 'exercise-seated-calf-raise-001', // Seated Calf Raise
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-legbal-10-1',
                  setNumber: 1,
                  targetWeight: 40.0,
                  targetReps: 15,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-legbal-10-2',
                  setNumber: 2,
                  targetWeight: 40.0,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-legbal-10-3',
                  setNumber: 3,
                  targetWeight: 40.0,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-legbal-5',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-legbal-11',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-legbal-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-legbal-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-legbal-12',
              exerciseId: 'exercise-quad-stretch-001', // Standing Quad Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-legbal-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-legbal-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-legbal-13',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-legbal-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-legbal-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-legbal-14',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-legbal-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-legbal-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-legbal-15',
              exerciseId: 'exercise-calf-stretch-001', // Standing Calf Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-legbal-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-legbal-15-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-legbal-6',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-legbal-16',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-legbal-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-legbal-17',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-legbal-17-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-legbal-17-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-legbal-18',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-legbal-18-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 12. Upper Power & Pump
  static final _upperPowerPump = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-upper-power-pump',
      name: 'Upper Power & Pump',
      description: 'Expert | ~70 min. Heavy low-rep bench and row power work followed by two high-rep pump supersets, then stretching and a relaxed ending.',
      currentRevisionId: 'rev-upp-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['upper-body', 'power', 'pump', 'expert', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-upp-001',
      templateId: 'template-upper-power-pump',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-upp-1',
          name: 'Upper Body Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-upp-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-upp-1',
                  setNumber: 1,
                  targetDurationSeconds: 270,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-upp-1',
              exerciseId: 'exercise-arm-circles-001', // Arm Circles
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upp-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upp-2',
              exerciseId: 'exercise-cat-cow-001', // Cat-Cow
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-upp-2-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-upp-3',
              exerciseId: 'exercise-inchworm-001', // Inchworm
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-upp-3-1', setNumber: 1, targetReps: 6),
              ],
            ),
            TemplateItem(
              id: 'item-upp-4',
              exerciseId: 'exercise-face-pull-001', // Cable Face Pull
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-upp-4-1',
                  setNumber: 1,
                  targetWeight: 10.0,
                  targetReps: 15,
                ),
                TargetSet(
                  id: 'ts-upp-4-2',
                  setNumber: 2,
                  targetWeight: 10.0,
                  targetReps: 15,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upp-5',
              exerciseId: 'exercise-pushup-001', // Push-Up
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-upp-5-1', setNumber: 1, targetReps: 8),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-upp-2',
          name: 'Power Block',
          items: [
            TemplateItem(
              id: 'item-upp-6',
              exerciseId: 'exercise-bench-001', // Barbell Bench Press
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-upp-6-1',
                  setNumber: 1,
                  setType: SetType.warmup,
                  targetWeight: 60.0,
                  targetReps: 5,
                ),
                TargetSet(
                  id: 'ts-upp-6-2',
                  setNumber: 2,
                  setType: SetType.warmup,
                  targetWeight: 80.0,
                  targetReps: 3,
                ),
                TargetSet(
                  id: 'ts-upp-6-3',
                  setNumber: 3,
                  targetWeight: 90.0,
                  targetReps: 3,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-upp-6-4',
                  setNumber: 4,
                  targetWeight: 90.0,
                  targetReps: 3,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-upp-6-5',
                  setNumber: 5,
                  targetWeight: 90.0,
                  targetReps: 3,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-upp-6-6',
                  setNumber: 6,
                  targetWeight: 90.0,
                  targetReps: 3,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-upp-6-7',
                  setNumber: 7,
                  targetWeight: 90.0,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upp-7',
              exerciseId: 'exercise-row-001', // Barbell Row
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upp-7-1',
                  setNumber: 1,
                  targetWeight: 80.0,
                  targetReps: 6,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-upp-7-2',
                  setNumber: 2,
                  targetWeight: 80.0,
                  targetReps: 6,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-upp-7-3',
                  setNumber: 3,
                  targetWeight: 80.0,
                  targetReps: 6,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-upp-7-4',
                  setNumber: 4,
                  targetWeight: 80.0,
                  targetReps: 6,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-upp-3',
          name: 'Shoulder Pump Superset',
          type: WorkoutBlockType.superset,
          rounds: 3,
          items: [
            TemplateItem(
              id: 'item-upp-8',
              exerciseId:
                  'exercise-lateral-raise-001', // Dumbbell Lateral Raise
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-upp-8-1',
                  setNumber: 1,
                  targetWeight: 10.0,
                  targetReps: 15,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upp-9',
              exerciseId: 'exercise-face-pull-001', // Cable Face Pull
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upp-9-1',
                  setNumber: 1,
                  targetWeight: 20.0,
                  targetReps: 15,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-upp-4',
          name: 'Arm Pump Superset',
          type: WorkoutBlockType.superset,
          rounds: 3,
          items: [
            TemplateItem(
              id: 'item-upp-10',
              exerciseId:
                  'exercise-tricep-pushdown-001', // Cable Tricep Pushdown
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-upp-10-1',
                  setNumber: 1,
                  targetWeight: 30.0,
                  targetReps: 15,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upp-11',
              exerciseId: 'exercise-db-curl-001', // Dumbbell Bicep Curl
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upp-11-1',
                  setNumber: 1,
                  targetWeight: 14.0,
                  targetReps: 15,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-upp-5',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-upp-12',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-upp-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-upp-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upp-13',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001', // Cross-Body Shoulder Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upp-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-upp-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upp-14',
              exerciseId: 'exercise-overhead-tricep-stretch-001', // Overhead Triceps Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-upp-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-upp-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-upp-6',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-upp-15',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-upp-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upp-16',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upp-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-upp-16-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upp-17',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-upp-17-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 13. Lower Hypertrophy Block
  static final _lowerHypertrophyBlock = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-lower-hypertrophy',
      name: 'Lower Hypertrophy Block',
      description: 'Intermediate | ~60 min. Isolation and machine-focused lower-body builder for quads, hamstrings and calves, then stretching and a relaxed ending.',
      currentRevisionId: 'rev-low-hyp-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['legs', 'hypertrophy', 'isolation', 'intermediate', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-low-hyp-001',
      templateId: 'template-lower-hypertrophy',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-lhy-1',
          name: 'Lower Body Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-lhy-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-lhy-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-lhy-1',
              exerciseId: 'exercise-glute-bridge-001', // Glute Bridge
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-lhy-1-1', setNumber: 1, targetReps: 12),
              ],
            ),
            TemplateItem(
              id: 'item-lhy-2',
              exerciseId: 'exercise-leg-swings-001', // Leg Swings
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-lhy-2-1', setNumber: 1, targetReps: 10),
                TargetSet(id: 'ts-lhy-2-2', setNumber: 2, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-lhy-3',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-lhy-3-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-lhy-4',
              exerciseId: 'exercise-worlds-greatest-stretch-001', // World's Greatest Stretch
              order: 5,
              targetSets: [
                TargetSet(id: 'ts-lhy-4-1', setNumber: 1, targetReps: 3),
                TargetSet(id: 'ts-lhy-4-2', setNumber: 2, targetReps: 3),
              ],
            ),
            TemplateItem(
              id: 'item-lhy-5',
              exerciseId: 'exercise-cat-cow-001', // Cat-Cow
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-lhy-5-1', setNumber: 1, targetReps: 8),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-lhy-2',
          name: 'Machine Block',
          items: [
            TemplateItem(
              id: 'item-lhy-6',
              exerciseId: 'exercise-leg-extension-001', // Leg Extension Machine
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lhy-6-1',
                  setNumber: 1,
                  targetWeight: 50.0,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-lhy-6-2',
                  setNumber: 2,
                  targetWeight: 50.0,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lhy-6-3',
                  setNumber: 3,
                  targetWeight: 50.0,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-lhy-6-4',
                  setNumber: 4,
                  targetWeight: 50.0,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lhy-7',
              exerciseId: 'exercise-leg-press-001', // Leg Press
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lhy-7-1',
                  setNumber: 1,
                  targetWeight: 160.0,
                  targetReps: 15,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-lhy-7-2',
                  setNumber: 2,
                  targetWeight: 160.0,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lhy-7-3',
                  setNumber: 3,
                  targetWeight: 160.0,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lhy-8',
              exerciseId:
                  'exercise-seated-leg-curl-001', // Seated Leg Curl Machine
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-lhy-8-1',
                  setNumber: 1,
                  targetWeight: 40.0,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-lhy-8-2',
                  setNumber: 2,
                  targetWeight: 40.0,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lhy-8-3',
                  setNumber: 3,
                  targetWeight: 40.0,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lhy-9',
              exerciseId:
                  'exercise-lying-leg-curl-001', // Lying Leg Curl Machine
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-lhy-9-1',
                  setNumber: 1,
                  targetWeight: 35.0,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-lhy-9-2',
                  setNumber: 2,
                  targetWeight: 35.0,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lhy-9-3',
                  setNumber: 3,
                  targetWeight: 35.0,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-lhy-3',
          name: 'Calves',
          items: [
            TemplateItem(
              id: 'item-lhy-10',
              exerciseId:
                  'exercise-standing-calf-raise-001', // Standing Calf Raise
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lhy-10-1',
                  setNumber: 1,
                  targetWeight: 70.0,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-lhy-10-2',
                  setNumber: 2,
                  targetWeight: 70.0,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lhy-10-3',
                  setNumber: 3,
                  targetWeight: 70.0,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-lhy-10-4',
                  setNumber: 4,
                  targetWeight: 70.0,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lhy-11',
              exerciseId: 'exercise-seated-calf-raise-001', // Seated Calf Raise
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lhy-11-1',
                  setNumber: 1,
                  targetWeight: 40.0,
                  targetReps: 15,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-lhy-11-2',
                  setNumber: 2,
                  targetWeight: 40.0,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lhy-11-3',
                  setNumber: 3,
                  targetWeight: 40.0,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-lhy-11-4',
                  setNumber: 4,
                  targetWeight: 40.0,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-lhy-4',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-lhy-12',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lhy-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-lhy-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lhy-13',
              exerciseId: 'exercise-quad-stretch-001', // Standing Quad Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lhy-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-lhy-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lhy-14',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-lhy-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-lhy-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lhy-15',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-lhy-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-lhy-15-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lhy-16',
              exerciseId: 'exercise-calf-stretch-001', // Standing Calf Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-lhy-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-lhy-16-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-lhy-5',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-lhy-17',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lhy-17-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lhy-18',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lhy-18-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-lhy-18-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lhy-19',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-lhy-19-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 14. Arms & Shoulders Blaster
  static final _armsAndShouldersBlaster = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-arms-shoulders',
      name: 'Arms & Shoulders Blaster',
      description: 'Intermediate | ~55 min. Dedicated arm and delt session with two arm supersets and a shoulder isolation block, then stretching and a relaxed ending.',
      currentRevisionId: 'rev-arm-shd-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['arms', 'shoulders', 'accessories', 'intermediate', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-arm-shd-001',
      templateId: 'template-arms-shoulders',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-as-1',
          name: 'Upper Body Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-as-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-as-1',
                  setNumber: 1,
                  targetDurationSeconds: 270,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-as-1',
              exerciseId: 'exercise-arm-circles-001', // Arm Circles
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-as-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-as-2',
              exerciseId: 'exercise-cat-cow-001', // Cat-Cow
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-as-2-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-as-3',
              exerciseId: 'exercise-inchworm-001', // Inchworm
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-as-3-1', setNumber: 1, targetReps: 6),
              ],
            ),
            TemplateItem(
              id: 'item-as-4',
              exerciseId: 'exercise-face-pull-001', // Cable Face Pull
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-as-4-1',
                  setNumber: 1,
                  targetWeight: 10.0,
                  targetReps: 15,
                ),
                TargetSet(
                  id: 'ts-as-4-2',
                  setNumber: 2,
                  targetWeight: 10.0,
                  targetReps: 15,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-as-5',
              exerciseId: 'exercise-pushup-001', // Push-Up
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-as-5-1', setNumber: 1, targetReps: 8),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-as-2',
          name: 'Arm Blaster',
          type: WorkoutBlockType.superset,
          rounds: 4,
          items: [
            TemplateItem(
              id: 'item-as-6',
              exerciseId: 'exercise-barbell-curl-001', // Barbell Bicep Curl
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-as-6-1',
                  setNumber: 1,
                  targetWeight: 30.0,
                  targetReps: 10,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-as-7',
              exerciseId:
                  'exercise-skull-crusher-001', // Lying Tricep Extension
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-as-7-1',
                  setNumber: 1,
                  targetWeight: 35.0,
                  targetReps: 10,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-as-3',
          name: 'Arm Blaster 2',
          type: WorkoutBlockType.superset,
          rounds: 3,
          items: [
            TemplateItem(
              id: 'item-as-8',
              exerciseId: 'exercise-hammer-curl-001', // Dumbbell Hammer Curl
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-as-8-1',
                  setNumber: 1,
                  targetWeight: 14.0,
                  targetReps: 12,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-as-9',
              exerciseId: 'exercise-overhead-tricep-001', // Overhead Cable Tricep Extension
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-as-9-1',
                  setNumber: 1,
                  targetWeight: 20.0,
                  targetReps: 12,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-as-4',
          name: 'Shoulder Block',
          items: [
            TemplateItem(
              id: 'item-as-10',
              exerciseId:
                  'exercise-lateral-raise-001', // Dumbbell Lateral Raise
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-as-10-1',
                  setNumber: 1,
                  targetWeight: 10.0,
                  targetReps: 15,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-as-10-2',
                  setNumber: 2,
                  targetWeight: 10.0,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-as-10-3',
                  setNumber: 3,
                  targetWeight: 10.0,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-as-10-4',
                  setNumber: 4,
                  targetWeight: 10.0,
                  targetReps: 15,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-as-11',
              exerciseId:
                  'exercise-rear-delt-fly-001', // Dumbbell Rear Delt Fly
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-as-11-1',
                  setNumber: 1,
                  targetWeight: 8.0,
                  targetReps: 15,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-as-11-2',
                  setNumber: 2,
                  targetWeight: 8.0,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-as-11-3',
                  setNumber: 3,
                  targetWeight: 8.0,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-as-5',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-as-12',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-as-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-as-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-as-13',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001', // Cross-Body Shoulder Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-as-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-as-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-as-14',
              exerciseId: 'exercise-overhead-tricep-stretch-001', // Overhead Triceps Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-as-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-as-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-as-6',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-as-15',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-as-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-as-16',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-as-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-as-16-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-as-17',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-as-17-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 15. Core & Conditioning Circuit
  static final _coreAndConditioningCircuit = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-core-conditioning',
      name: 'Core & Conditioning Circuit',
      description: 'Intermediate | ~40 min. Core and loaded-carry conditioning circuit with planks, farmer walks, rotational work and mountain climbers, then stretching and a relaxed ending.',
      currentRevisionId: 'rev-core-cond-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['core', 'conditioning', 'abs', 'intermediate', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-core-cond-001',
      templateId: 'template-core-conditioning',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-cc-1',
          name: 'Dynamic Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-cc-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-cc-1',
                  setNumber: 1,
                  targetDurationSeconds: 225,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-cc-1',
              exerciseId: 'exercise-jumping-jack-001', // Jumping Jack
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-cc-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-cc-2',
              exerciseId: 'exercise-arm-circles-001', // Arm Circles
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-cc-2-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-cc-3',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-cc-3-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-cc-4',
              exerciseId: 'exercise-inchworm-001', // Inchworm
              order: 5,
              targetSets: [
                TargetSet(id: 'ts-cc-4-1', setNumber: 1, targetReps: 5),
              ],
            ),
            TemplateItem(
              id: 'item-cc-5',
              exerciseId: 'exercise-worlds-greatest-stretch-001', // World's Greatest Stretch
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-cc-5-1', setNumber: 1, targetReps: 3),
                TargetSet(id: 'ts-cc-5-2', setNumber: 2, targetReps: 3),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-cc-2',
          name: 'Circuit Block',
          type: WorkoutBlockType.circuit,
          rounds: 4,
          items: [
            TemplateItem(
              id: 'item-cc-6',
              exerciseId: 'exercise-plank-001', // Forearm Plank
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-cc-6-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-cc-7',
              exerciseId: 'exercise-farmers-walk-001', // Farmer's Walk
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-cc-7-1',
                  setNumber: 1,
                  targetWeight: 24.0,
                  targetDistanceMeters: 40.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-cc-8',
              exerciseId: 'exercise-dead-bug-001', // Dead Bug
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-cc-8-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-cc-9',
              exerciseId: 'exercise-cable-woodchopper-001', // Cable Woodchopper
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-cc-9-1',
                  setNumber: 1,
                  targetWeight: 15.0,
                  targetReps: 12,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-cc-10',
              exerciseId: 'exercise-mountain-climber-001', // Mountain Climber
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-cc-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-cc-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-cc-11',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-cc-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-cc-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-cc-12',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-cc-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-cc-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-cc-13',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-cc-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-cc-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-cc-14',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-cc-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-cc-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-cc-15',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001', // Cross-Body Shoulder Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-cc-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-cc-15-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-cc-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-cc-16',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-cc-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-cc-17',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-cc-17-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-cc-17-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-cc-18',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-cc-18-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 16. Upper Chest Specialization
  static final _upperChestSpecialization = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-upper-chest',
      name: 'Upper Chest Specialization',
      description: 'Intermediate | ~60 min. Incline press heavy session emphasizing the upper pectorals with dumbbell and cable follow-ups, then stretching and a relaxed ending.',
      currentRevisionId: 'rev-up-chest-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['chest', 'hypertrophy', 'incline', 'intermediate', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-up-chest-001',
      templateId: 'template-upper-chest',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-uc-1',
          name: 'Upper Body Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-uc-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-uc-1',
                  setNumber: 1,
                  targetDurationSeconds: 270,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-uc-1',
              exerciseId: 'exercise-arm-circles-001', // Arm Circles
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-uc-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uc-2',
              exerciseId: 'exercise-cat-cow-001', // Cat-Cow
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-uc-2-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-uc-3',
              exerciseId: 'exercise-inchworm-001', // Inchworm
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-uc-3-1', setNumber: 1, targetReps: 6),
              ],
            ),
            TemplateItem(
              id: 'item-uc-4',
              exerciseId: 'exercise-face-pull-001', // Cable Face Pull
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-uc-4-1',
                  setNumber: 1,
                  targetWeight: 10.0,
                  targetReps: 15,
                ),
                TargetSet(
                  id: 'ts-uc-4-2',
                  setNumber: 2,
                  targetWeight: 10.0,
                  targetReps: 15,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uc-5',
              exerciseId: 'exercise-pushup-001', // Push-Up
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-uc-5-1', setNumber: 1, targetReps: 8),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-uc-2',
          name: 'Chest Focus',
          items: [
            TemplateItem(
              id: 'item-uc-6',
              exerciseId:
                  'exercise-incline-bench-001', // Incline Barbell Bench Press
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-uc-6-1',
                  setNumber: 1,
                  setType: SetType.warmup,
                  targetWeight: 40.0,
                  targetReps: 8,
                ),
                TargetSet(
                  id: 'ts-uc-6-2',
                  setNumber: 2,
                  setType: SetType.warmup,
                  targetWeight: 60.0,
                  targetReps: 5,
                ),
                TargetSet(
                  id: 'ts-uc-6-3',
                  setNumber: 3,
                  targetWeight: 75.0,
                  targetReps: 8,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-uc-6-4',
                  setNumber: 4,
                  targetWeight: 75.0,
                  targetReps: 8,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-uc-6-5',
                  setNumber: 5,
                  targetWeight: 75.0,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-uc-6-6',
                  setNumber: 6,
                  targetWeight: 75.0,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uc-7',
              exerciseId:
                  'exercise-incline-db-press-001', // Incline Dumbbell Press
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-uc-7-1',
                  setNumber: 1,
                  targetWeight: 26.0,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-uc-7-2',
                  setNumber: 2,
                  targetWeight: 26.0,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-uc-7-3',
                  setNumber: 3,
                  targetWeight: 26.0,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uc-8',
              exerciseId: 'exercise-cable-crossover-001', // Cable Crossover
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-uc-8-1',
                  setNumber: 1,
                  targetWeight: 15.0,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-uc-8-2',
                  setNumber: 2,
                  targetWeight: 15.0,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-uc-8-3',
                  setNumber: 3,
                  targetWeight: 15.0,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uc-9',
              exerciseId: 'exercise-pushup-001', // Push-Up
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-uc-9-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-uc-9-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-uc-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-uc-10',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-uc-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-uc-10-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uc-11',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001', // Cross-Body Shoulder Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-uc-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-uc-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uc-12',
              exerciseId: 'exercise-overhead-tricep-stretch-001', // Overhead Triceps Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-uc-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-uc-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-uc-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-uc-13',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-uc-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uc-14',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-uc-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-uc-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uc-15',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-uc-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 17. Unilateral Leg Builder
  static final _unilateralLegBuilder = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-unilateral-legs',
      name: 'Unilateral Leg Builder',
      description: 'Intermediate | ~55 min. Single-leg strength with split squats, lunges and single-weight hinges (reps are per leg), plus core stability, stretching and a relaxed ending.',
      currentRevisionId: 'rev-uni-legs-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['legs', 'unilateral', 'balance', 'intermediate', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-uni-legs-001',
      templateId: 'template-unilateral-legs',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-ul-1',
          name: 'Lower Body Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-ul-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-ul-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-ul-1',
              exerciseId: 'exercise-glute-bridge-001', // Glute Bridge
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-ul-1-1', setNumber: 1, targetReps: 12),
              ],
            ),
            TemplateItem(
              id: 'item-ul-2',
              exerciseId: 'exercise-leg-swings-001', // Leg Swings
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-ul-2-1', setNumber: 1, targetReps: 10),
                TargetSet(id: 'ts-ul-2-2', setNumber: 2, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-ul-3',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-ul-3-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-ul-4',
              exerciseId: 'exercise-worlds-greatest-stretch-001', // World's Greatest Stretch
              order: 5,
              targetSets: [
                TargetSet(id: 'ts-ul-4-1', setNumber: 1, targetReps: 3),
                TargetSet(id: 'ts-ul-4-2', setNumber: 2, targetReps: 3),
              ],
            ),
            TemplateItem(
              id: 'item-ul-5',
              exerciseId: 'exercise-cat-cow-001', // Cat-Cow
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-ul-5-1', setNumber: 1, targetReps: 8),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ul-2',
          name: 'Unilateral Block',
          items: [
            TemplateItem(
              id: 'item-ul-6',
              exerciseId:
                  'exercise-bulgarian-squat-001', // Bulgarian Split Squat
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ul-6-1',
                  setNumber: 1,
                  targetWeight: 20.0,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-ul-6-2',
                  setNumber: 2,
                  targetWeight: 20.0,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-ul-6-3',
                  setNumber: 3,
                  targetWeight: 20.0,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ul-6-4',
                  setNumber: 4,
                  targetWeight: 20.0,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ul-7',
              exerciseId:
                  'exercise-walking-lunge-001', // Dumbbell Walking Lunge
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ul-7-1',
                  setNumber: 1,
                  targetWeight: 14.0,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-ul-7-2',
                  setNumber: 2,
                  targetWeight: 14.0,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-ul-7-3',
                  setNumber: 3,
                  targetWeight: 14.0,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ul-8',
              exerciseId: 'exercise-rdl-001', // Dumbbell RDL
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-ul-8-1',
                  setNumber: 1,
                  targetWeight: 20.0,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-ul-8-2',
                  setNumber: 2,
                  targetWeight: 20.0,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-ul-8-3',
                  setNumber: 3,
                  targetWeight: 20.0,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ul-3',
          name: 'Stability Finisher',
          items: [
            TemplateItem(
              id: 'item-ul-9',
              exerciseId: 'exercise-bird-dog-001', // Bird Dog
              order: 1,
              targetSets: [
                TargetSet(id: 'ts-ul-9-1', setNumber: 1, targetReps: 8),
                TargetSet(id: 'ts-ul-9-2', setNumber: 2, targetReps: 8),
              ],
            ),
            TemplateItem(
              id: 'item-ul-10',
              exerciseId: 'exercise-plank-001', // Forearm Plank
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ul-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
                TargetSet(
                  id: 'ts-ul-10-2',
                  setNumber: 2,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ul-4',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-ul-11',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ul-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ul-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ul-12',
              exerciseId: 'exercise-quad-stretch-001', // Standing Quad Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ul-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ul-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ul-13',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-ul-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ul-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ul-14',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-ul-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ul-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ul-15',
              exerciseId: 'exercise-calf-stretch-001', // Standing Calf Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-ul-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ul-15-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ul-5',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-ul-16',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ul-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ul-17',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ul-17-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-ul-17-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ul-18',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-ul-18-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 18. Trap Bar Power Session
  static final _trapBarPowerSession = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-trap-bar-power',
      name: 'Trap Bar Power Session',
      description: 'Expert | ~65 min. Explosive pulling, pressing and carrying with trap bar deadlifts, push press and heavy carries, then stretching and a relaxed ending.',
      currentRevisionId: 'rev-tb-power-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['power', 'functional', 'deadlift', 'expert', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-tb-power-001',
      templateId: 'template-trap-bar-power',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-tbp-1',
          name: 'Lower Body Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-tbp-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-tbp-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-tbp-1',
              exerciseId: 'exercise-glute-bridge-001', // Glute Bridge
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-tbp-1-1', setNumber: 1, targetReps: 12),
              ],
            ),
            TemplateItem(
              id: 'item-tbp-2',
              exerciseId: 'exercise-leg-swings-001', // Leg Swings
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-tbp-2-1', setNumber: 1, targetReps: 10),
                TargetSet(id: 'ts-tbp-2-2', setNumber: 2, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-tbp-3',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-tbp-3-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-tbp-4',
              exerciseId: 'exercise-worlds-greatest-stretch-001', // World's Greatest Stretch
              order: 5,
              targetSets: [
                TargetSet(id: 'ts-tbp-4-1', setNumber: 1, targetReps: 3),
                TargetSet(id: 'ts-tbp-4-2', setNumber: 2, targetReps: 3),
              ],
            ),
            TemplateItem(
              id: 'item-tbp-5',
              exerciseId: 'exercise-cat-cow-001', // Cat-Cow
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-tbp-5-1', setNumber: 1, targetReps: 8),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-tbp-2',
          name: 'Trap Bar Block',
          items: [
            TemplateItem(
              id: 'item-tbp-6',
              exerciseId: 'exercise-trap-bar-deadlift-001', // Trap Bar Deadlift
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-tbp-6-1',
                  setNumber: 1,
                  setType: SetType.warmup,
                  targetWeight: 60.0,
                  targetReps: 5,
                ),
                TargetSet(
                  id: 'ts-tbp-6-2',
                  setNumber: 2,
                  setType: SetType.warmup,
                  targetWeight: 100.0,
                  targetReps: 3,
                ),
                TargetSet(
                  id: 'ts-tbp-6-3',
                  setNumber: 3,
                  targetWeight: 140.0,
                  targetReps: 5,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-tbp-6-4',
                  setNumber: 4,
                  targetWeight: 140.0,
                  targetReps: 5,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-tbp-6-5',
                  setNumber: 5,
                  targetWeight: 140.0,
                  targetReps: 5,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-tbp-6-6',
                  setNumber: 6,
                  targetWeight: 140.0,
                  targetReps: 5,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tbp-7',
              exerciseId: 'exercise-push-press-001', // Barbell Push Press
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-tbp-7-1',
                  setNumber: 1,
                  targetWeight: 60.0,
                  targetReps: 4,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-tbp-7-2',
                  setNumber: 2,
                  targetWeight: 60.0,
                  targetReps: 4,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-tbp-7-3',
                  setNumber: 3,
                  targetWeight: 60.0,
                  targetReps: 4,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-tbp-7-4',
                  setNumber: 4,
                  targetWeight: 60.0,
                  targetReps: 4,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tbp-8',
              exerciseId: 'exercise-barbell-shrug-001', // Barbell Shrug
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-tbp-8-1',
                  setNumber: 1,
                  targetWeight: 100.0,
                  targetReps: 8,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-tbp-8-2',
                  setNumber: 2,
                  targetWeight: 100.0,
                  targetReps: 8,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-tbp-8-3',
                  setNumber: 3,
                  targetWeight: 100.0,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-tbp-3',
          name: 'Carry Finisher',
          items: [
            TemplateItem(
              id: 'item-tbp-9',
              exerciseId: 'exercise-farmers-walk-001', // Farmer's Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-tbp-9-1',
                  setNumber: 1,
                  targetWeight: 32.0,
                  targetDistanceMeters: 40.0,
                ),
                TargetSet(
                  id: 'ts-tbp-9-2',
                  setNumber: 2,
                  targetWeight: 32.0,
                  targetDistanceMeters: 40.0,
                ),
                TargetSet(
                  id: 'ts-tbp-9-3',
                  setNumber: 3,
                  targetWeight: 32.0,
                  targetDistanceMeters: 40.0,
                ),
                TargetSet(
                  id: 'ts-tbp-9-4',
                  setNumber: 4,
                  targetWeight: 32.0,
                  targetDistanceMeters: 40.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-tbp-4',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-tbp-10',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-tbp-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-tbp-10-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tbp-11',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-tbp-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-tbp-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tbp-12',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-tbp-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-tbp-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tbp-13',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-tbp-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-tbp-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tbp-14',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001', // Cross-Body Shoulder Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-tbp-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-tbp-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-tbp-5',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-tbp-15',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-tbp-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tbp-16',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-tbp-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-tbp-16-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tbp-17',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-tbp-17-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 19. Express Full Body
  static final _expressFullBody = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-express-full',
      name: 'Express Full Body',
      description: 'Beginner | ~30 min. Time-efficient circuit hitting squat, push, pull and core patterns, with a quick stretch and short relaxed ending.',
      currentRevisionId: 'rev-exp-full-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['express', 'full-body', 'quick', 'beginner', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-exp-full-001',
      templateId: 'template-express-full',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-ef-1',
          name: 'Quick Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-ef-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-ef-1',
                  setNumber: 1,
                  targetDurationSeconds: 150,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-ef-1',
              exerciseId: 'exercise-jumping-jack-001', // Jumping Jack
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ef-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ef-2',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-ef-2-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-ef-3',
              exerciseId: 'exercise-inchworm-001', // Inchworm
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-ef-3-1', setNumber: 1, targetReps: 5),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ef-2',
          name: 'Express Circuit',
          type: WorkoutBlockType.circuit,
          rounds: 3,
          items: [
            TemplateItem(
              id: 'item-ef-4',
              exerciseId: 'exercise-goblet-squat-001', // Goblet Squat
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ef-4-1',
                  setNumber: 1,
                  targetWeight: 20.0,
                  targetReps: 12,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ef-5',
              exerciseId: 'exercise-pushup-001', // Push-Up
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-ef-5-1', setNumber: 1, targetReps: 15),
              ],
            ),
            TemplateItem(
              id: 'item-ef-6',
              exerciseId:
                  'exercise-single-arm-db-row-001', // Single-Arm Dumbbell Row
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-ef-6-1',
                  setNumber: 1,
                  targetWeight: 14.0,
                  targetReps: 10,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ef-7',
              exerciseId: 'exercise-plank-001', // Forearm Plank
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-ef-7-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ef-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-ef-8',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ef-8-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ef-8-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ef-9',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ef-9-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ef-9-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ef-10',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-ef-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ef-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-ef-11',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ef-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ef-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ef-12',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ef-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 120,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 20. Posterior Chain Dominator
  static final _posteriorChainDominator = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-posterior-chain',
      name: 'Posterior Chain Dominator',
      description: 'Expert | ~70 min. Intense hip-hinge and glute specialization with heavy hip thrusts, Romanian deadlifts and swings, then stretching and a relaxed ending.',
      currentRevisionId: 'rev-post-chain-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['posterior-chain', 'glutes', 'hamstrings', 'expert', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-post-chain-001',
      templateId: 'template-posterior-chain',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-pc-1',
          name: 'Lower Body Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-pc-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-pc-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-pc-1',
              exerciseId: 'exercise-glute-bridge-001', // Glute Bridge
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-pc-1-1', setNumber: 1, targetReps: 12),
              ],
            ),
            TemplateItem(
              id: 'item-pc-2',
              exerciseId: 'exercise-leg-swings-001', // Leg Swings
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-pc-2-1', setNumber: 1, targetReps: 10),
                TargetSet(id: 'ts-pc-2-2', setNumber: 2, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-pc-3',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-pc-3-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-pc-4',
              exerciseId: 'exercise-worlds-greatest-stretch-001', // World's Greatest Stretch
              order: 5,
              targetSets: [
                TargetSet(id: 'ts-pc-4-1', setNumber: 1, targetReps: 3),
                TargetSet(id: 'ts-pc-4-2', setNumber: 2, targetReps: 3),
              ],
            ),
            TemplateItem(
              id: 'item-pc-5',
              exerciseId: 'exercise-cat-cow-001', // Cat-Cow
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-pc-5-1', setNumber: 1, targetReps: 8),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-pc-2',
          name: 'Posterior Block',
          items: [
            TemplateItem(
              id: 'item-pc-6',
              exerciseId: 'exercise-hip-thrust-001', // Barbell Hip Thrust
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-pc-6-1',
                  setNumber: 1,
                  setType: SetType.warmup,
                  targetWeight: 60.0,
                  targetReps: 8,
                ),
                TargetSet(
                  id: 'ts-pc-6-2',
                  setNumber: 2,
                  setType: SetType.warmup,
                  targetWeight: 100.0,
                  targetReps: 5,
                ),
                TargetSet(
                  id: 'ts-pc-6-3',
                  setNumber: 3,
                  targetWeight: 140.0,
                  targetReps: 6,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-pc-6-4',
                  setNumber: 4,
                  targetWeight: 140.0,
                  targetReps: 6,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-pc-6-5',
                  setNumber: 5,
                  targetWeight: 140.0,
                  targetReps: 6,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-pc-6-6',
                  setNumber: 6,
                  targetWeight: 140.0,
                  targetReps: 6,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-pc-7',
              exerciseId:
                  'exercise-barbell-rdl-001', // Barbell Romanian Deadlift
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-pc-7-1',
                  setNumber: 1,
                  targetWeight: 100.0,
                  targetReps: 6,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-pc-7-2',
                  setNumber: 2,
                  targetWeight: 100.0,
                  targetReps: 6,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-pc-7-3',
                  setNumber: 3,
                  targetWeight: 100.0,
                  targetReps: 6,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-pc-7-4',
                  setNumber: 4,
                  targetWeight: 100.0,
                  targetReps: 6,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-pc-8',
              exerciseId:
                  'exercise-cable-pull-through-001', // Cable Pull-Through
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-pc-8-1',
                  setNumber: 1,
                  targetWeight: 35.0,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-pc-8-2',
                  setNumber: 2,
                  targetWeight: 35.0,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-pc-8-3',
                  setNumber: 3,
                  targetWeight: 35.0,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-pc-3',
          name: 'Hamstrings & Power',
          items: [
            TemplateItem(
              id: 'item-pc-9',
              exerciseId:
                  'exercise-lying-leg-curl-001', // Lying Leg Curl Machine
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-pc-9-1',
                  setNumber: 1,
                  targetWeight: 40.0,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-pc-9-2',
                  setNumber: 2,
                  targetWeight: 40.0,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-pc-9-3',
                  setNumber: 3,
                  targetWeight: 40.0,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-pc-10',
              exerciseId: 'exercise-db-swing-001', // Dumbbell Swing
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-pc-10-1',
                  setNumber: 1,
                  targetWeight: 24.0,
                  targetReps: 15,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-pc-10-2',
                  setNumber: 2,
                  targetWeight: 24.0,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-pc-10-3',
                  setNumber: 3,
                  targetWeight: 24.0,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-pc-11',
              exerciseId:
                  'exercise-back-extension-001', // 45-Degree Back Extension
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-pc-11-1',
                  setNumber: 1,
                  targetWeight: 10.0,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-pc-11-2',
                  setNumber: 2,
                  targetWeight: 10.0,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-pc-11-3',
                  setNumber: 3,
                  targetWeight: 10.0,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-pc-4',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-pc-12',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-pc-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-pc-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-pc-13',
              exerciseId: 'exercise-quad-stretch-001', // Standing Quad Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-pc-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-pc-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-pc-14',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-pc-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-pc-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-pc-15',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-pc-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-pc-15-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-pc-16',
              exerciseId: 'exercise-calf-stretch-001', // Standing Calf Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-pc-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-pc-16-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-pc-5',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-pc-17',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-pc-17-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-pc-18',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-pc-18-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-pc-18-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-pc-19',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-pc-19-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // ===================== HIIT (21-24) =====================

  // 21. HIIT Starter (Bodyweight)
  static final _hiitStarter = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-hiit-starter',
      name: 'HIIT Starter (Bodyweight)',
      description: 'Beginner | ~25 min. Low-equipment interval circuit: 4 rounds of 30 s work with 30 s rest between exercises, followed by a walk, stretching and a relaxed ending.',
      currentRevisionId: 'rev-hiit-starter-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['hiit', 'cardio', 'bodyweight', 'beginner', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-hiit-starter-001',
      templateId: 'template-hiit-starter',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-hs-1',
          name: 'HIIT Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-hs-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-hs-1',
                  setNumber: 1,
                  targetDurationSeconds: 235,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-hs-1',
              exerciseId: 'exercise-jumping-jack-001', // Jumping Jack
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-hs-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-hs-2',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-hs-2-1', setNumber: 1, targetReps: 12),
              ],
            ),
            TemplateItem(
              id: 'item-hs-3',
              exerciseId: 'exercise-inchworm-001', // Inchworm
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-hs-3-1', setNumber: 1, targetReps: 5),
              ],
            ),
            TemplateItem(
              id: 'item-hs-4',
              exerciseId: 'exercise-mountain-climber-001', // Mountain Climber
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-hs-4-1',
                  setNumber: 1,
                  targetDurationSeconds: 20,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-hs-2',
          name: 'HIIT Circuit - 30s On / 30s Off',
          type: WorkoutBlockType.circuit,
          rounds: 4,
          items: [
            TemplateItem(
              id: 'item-hs-5',
              exerciseId: 'exercise-jumping-jack-001', // Jumping Jack
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-hs-5-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-hs-6',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-hs-6-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-hs-7',
              exerciseId: 'exercise-mountain-climber-001', // Mountain Climber
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-hs-7-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-hs-8',
              exerciseId: 'exercise-glute-bridge-001', // Glute Bridge
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-hs-8-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-hs-3',
          name: 'Cool-Down Walk',
          items: [
            TemplateItem(
              id: 'item-hs-9',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-hs-9-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-hs-4',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-hs-10',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-hs-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-hs-10-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-hs-11',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-hs-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-hs-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-hs-12',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-hs-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-hs-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-hs-13',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-hs-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-hs-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-hs-14',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001', // Cross-Body Shoulder Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-hs-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-hs-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-hs-5',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-hs-15',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-hs-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-hs-16',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-hs-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-hs-16-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-hs-17',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-hs-17-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 22. Tabata Burners
  static final _hiitTabata = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-hiit-tabata',
      name: 'Tabata Burners',
      description: 'Intermediate | ~30 min. Four classic Tabata blocks of 8 rounds at 20 s work / 10 s rest (burpees, jump squats, mountain climbers, jump rope) with about a minute between blocks, then a walk, stretching and a relaxed ending.',
      currentRevisionId: 'rev-hiit-tabata-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['hiit', 'tabata', 'cardio', 'intermediate', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-hiit-tabata-001',
      templateId: 'template-hiit-tabata',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-ht-1',
          name: 'HIIT Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-ht-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-ht-1',
                  setNumber: 1,
                  targetDurationSeconds: 235,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-ht-1',
              exerciseId: 'exercise-jumping-jack-001', // Jumping Jack
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ht-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ht-2',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-ht-2-1', setNumber: 1, targetReps: 12),
              ],
            ),
            TemplateItem(
              id: 'item-ht-3',
              exerciseId: 'exercise-inchworm-001', // Inchworm
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-ht-3-1', setNumber: 1, targetReps: 5),
              ],
            ),
            TemplateItem(
              id: 'item-ht-4',
              exerciseId: 'exercise-mountain-climber-001', // Mountain Climber
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-ht-4-1',
                  setNumber: 1,
                  targetDurationSeconds: 20,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ht-2',
          name: 'Tabata 1 - Burpees',
          type: WorkoutBlockType.circuit,
          rounds: 8,
          items: [
            TemplateItem(
              id: 'item-ht-5',
              exerciseId: 'exercise-burpee-001', // Burpee
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ht-5-1',
                  setNumber: 1,
                  targetDurationSeconds: 20,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ht-3',
          name: 'Tabata 2 - Jump Squats',
          type: WorkoutBlockType.circuit,
          rounds: 8,
          items: [
            TemplateItem(
              id: 'item-ht-6',
              exerciseId: 'exercise-jump-squat-001', // Jump Squat
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ht-6-1',
                  setNumber: 1,
                  targetDurationSeconds: 20,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ht-4',
          name: 'Tabata 3 - Mountain Climbers',
          type: WorkoutBlockType.circuit,
          rounds: 8,
          items: [
            TemplateItem(
              id: 'item-ht-7',
              exerciseId: 'exercise-mountain-climber-001', // Mountain Climber
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ht-7-1',
                  setNumber: 1,
                  targetDurationSeconds: 20,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ht-5',
          name: 'Tabata 4 - Jump Rope',
          type: WorkoutBlockType.circuit,
          rounds: 8,
          items: [
            TemplateItem(
              id: 'item-ht-8',
              exerciseId: 'exercise-jump-rope-001', // Jump Rope
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ht-8-1',
                  setNumber: 1,
                  targetDurationSeconds: 20,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ht-6',
          name: 'Cool-Down Walk',
          items: [
            TemplateItem(
              id: 'item-ht-9',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ht-9-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ht-7',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-ht-10',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ht-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ht-10-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ht-11',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ht-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ht-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ht-12',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-ht-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ht-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ht-13',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-ht-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ht-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ht-14',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001', // Cross-Body Shoulder Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-ht-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ht-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ht-8',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-ht-15',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ht-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ht-16',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ht-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-ht-16-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ht-17',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-ht-17-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 23. Expert Power Intervals
  static final _hiitExpertPower = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-hiit-expert-power',
      name: 'Expert Power Intervals',
      description: 'Expert | ~40 min. Loaded interval circuit of thrusters, swings, burpees and rowing sprints at 40 s work / 20 s rest, plus a bodyweight finisher, a walk, stretching and a relaxed ending.',
      currentRevisionId: 'rev-hiit-expert-power-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['hiit', 'power', 'conditioning', 'expert', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-hiit-expert-power-001',
      templateId: 'template-hiit-expert-power',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-he-1',
          name: 'HIIT Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-he-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-he-1',
                  setNumber: 1,
                  targetDurationSeconds: 235,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-he-1',
              exerciseId: 'exercise-jumping-jack-001', // Jumping Jack
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-he-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-he-2',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-he-2-1', setNumber: 1, targetReps: 12),
              ],
            ),
            TemplateItem(
              id: 'item-he-3',
              exerciseId: 'exercise-inchworm-001', // Inchworm
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-he-3-1', setNumber: 1, targetReps: 5),
              ],
            ),
            TemplateItem(
              id: 'item-he-4',
              exerciseId: 'exercise-mountain-climber-001', // Mountain Climber
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-he-4-1',
                  setNumber: 1,
                  targetDurationSeconds: 20,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-he-2',
          name: 'Power Intervals - 40s On / 20s Off',
          type: WorkoutBlockType.circuit,
          rounds: 5,
          items: [
            TemplateItem(
              id: 'item-he-5',
              exerciseId: 'exercise-db-thruster-001', // Dumbbell Thruster
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-he-5-1',
                  setNumber: 1,
                  targetWeight: 20.0,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-he-6',
              exerciseId: 'exercise-db-swing-001', // Dumbbell Swing
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-he-6-1',
                  setNumber: 1,
                  targetWeight: 24.0,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-he-7',
              exerciseId: 'exercise-burpee-001', // Burpee
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-he-7-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-he-8',
              exerciseId: 'exercise-rowing-machine-001', // Rowing Machine
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-he-8-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-he-3',
          name: 'Bodyweight Finisher',
          type: WorkoutBlockType.circuit,
          rounds: 4,
          items: [
            TemplateItem(
              id: 'item-he-9',
              exerciseId: 'exercise-mountain-climber-001', // Mountain Climber
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-he-9-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-he-10',
              exerciseId: 'exercise-jump-squat-001', // Jump Squat
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-he-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-he-4',
          name: 'Cool-Down Walk',
          items: [
            TemplateItem(
              id: 'item-he-11',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-he-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-he-5',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-he-12',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-he-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-he-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-he-13',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-he-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-he-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-he-14',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-he-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-he-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-he-15',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-he-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-he-15-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-he-16',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001', // Cross-Body Shoulder Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-he-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-he-16-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-he-6',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-he-17',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-he-17-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-he-18',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-he-18-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-he-18-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-he-19',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-he-19-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 24. Treadmill Sprint Intervals
  static final _hiitTreadmill = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-hiit-treadmill',
      name: 'Treadmill Sprint Intervals',
      description: 'Intermediate | ~35 min. Eight 30 s all-out treadmill sprints, each followed by 90 s of easy recovery walking, then a cool-down walk, stretching and a relaxed ending.',
      currentRevisionId: 'rev-hiit-treadmill-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['hiit', 'running', 'cardio', 'intermediate', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-hiit-treadmill-001',
      templateId: 'template-hiit-treadmill',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-hr-1',
          name: 'Easy Warm-Up',
          items: [
            TemplateItem(
              id: 'item-hr-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-hr-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-hr-2',
              exerciseId: 'exercise-leg-swings-001', // Leg Swings
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-hr-2-1', setNumber: 1, targetReps: 10),
                TargetSet(id: 'ts-hr-2-2', setNumber: 2, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-hr-3',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-hr-3-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-hr-4',
              exerciseId: 'exercise-jumping-jack-001', // Jumping Jack
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-hr-4-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-hr-2',
          name: 'Sprint Intervals - 30s Sprint / 90s Walk',
          type: WorkoutBlockType.circuit,
          rounds: 8,
          items: [
            TemplateItem(
              id: 'item-hr-5',
              exerciseId: 'exercise-treadmill-run-001', // Treadmill Run
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-hr-5-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-hr-6',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-hr-6-1',
                  setNumber: 1,
                  targetDurationSeconds: 90,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-hr-3',
          name: 'Cool-Down Walk',
          items: [
            TemplateItem(
              id: 'item-hr-7',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-hr-7-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-hr-4',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-hr-8',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-hr-8-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-hr-8-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-hr-9',
              exerciseId: 'exercise-quad-stretch-001', // Standing Quad Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-hr-9-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-hr-9-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-hr-10',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-hr-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-hr-10-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-hr-11',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-hr-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-hr-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-hr-12',
              exerciseId: 'exercise-calf-stretch-001', // Standing Calf Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-hr-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-hr-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-hr-5',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-hr-13',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-hr-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-hr-14',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-hr-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-hr-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-hr-15',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-hr-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // ===================== STRENGTH CONDITIONING (25-27) =====================

  // 25. Strength & Conditioning Starter
  static final _scStarter = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-sc-starter',
      name: 'Strength & Conditioning Starter',
      description: 'Beginner | ~40 min. Light machine and dumbbell strength circuit followed by a short bodyweight conditioning finisher, then stretching and a relaxed ending.',
      currentRevisionId: 'rev-sc-starter-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: [
        'strength-conditioning',
        'circuit',
        'full-body',
        'beginner',
        'stretching',
      ],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-sc-starter-001',
      templateId: 'template-sc-starter',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-scb-1',
          name: 'Dynamic Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-scb-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-scb-1',
                  setNumber: 1,
                  targetDurationSeconds: 225,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-scb-1',
              exerciseId: 'exercise-jumping-jack-001', // Jumping Jack
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-scb-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-scb-2',
              exerciseId: 'exercise-arm-circles-001', // Arm Circles
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-scb-2-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-scb-3',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-scb-3-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-scb-4',
              exerciseId: 'exercise-inchworm-001', // Inchworm
              order: 5,
              targetSets: [
                TargetSet(id: 'ts-scb-4-1', setNumber: 1, targetReps: 5),
              ],
            ),
            TemplateItem(
              id: 'item-scb-5',
              exerciseId: 'exercise-worlds-greatest-stretch-001', // World's Greatest Stretch
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-scb-5-1', setNumber: 1, targetReps: 3),
                TargetSet(id: 'ts-scb-5-2', setNumber: 2, targetReps: 3),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-scb-2',
          name: 'Strength Circuit',
          type: WorkoutBlockType.circuit,
          rounds: 3,
          items: [
            TemplateItem(
              id: 'item-scb-6',
              exerciseId: 'exercise-goblet-squat-001', // Goblet Squat
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-scb-6-1',
                  setNumber: 1,
                  targetWeight: 12.0,
                  targetReps: 12,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-scb-7',
              exerciseId:
                  'exercise-machine-chest-press-001', // Machine Chest Press
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-scb-7-1',
                  setNumber: 1,
                  targetWeight: 30.0,
                  targetReps: 12,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-scb-8',
              exerciseId: 'exercise-seated-cable-row-001', // Seated Cable Row
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-scb-8-1',
                  setNumber: 1,
                  targetWeight: 30.0,
                  targetReps: 12,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-scb-9',
              exerciseId: 'exercise-rdl-001', // Dumbbell RDL
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-scb-9-1',
                  setNumber: 1,
                  targetWeight: 10.0,
                  targetReps: 12,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-scb-10',
              exerciseId: 'exercise-plank-001', // Forearm Plank
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-scb-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-scb-3',
          name: 'Conditioning Finisher',
          type: WorkoutBlockType.circuit,
          rounds: 3,
          items: [
            TemplateItem(
              id: 'item-scb-11',
              exerciseId: 'exercise-jumping-jack-001', // Jumping Jack
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-scb-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-scb-12',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-scb-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-scb-4',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-scb-13',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-scb-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-scb-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-scb-14',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-scb-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-scb-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-scb-15',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-scb-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-scb-15-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-scb-16',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-scb-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-scb-16-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-scb-17',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001', // Cross-Body Shoulder Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-scb-17-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-scb-17-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-scb-5',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-scb-18',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-scb-18-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-scb-19',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-scb-19-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-scb-19-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-scb-20',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-scb-20-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 26. Strength & Conditioning Complex
  static final _scIntermediate = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-sc-intermediate',
      name: 'Strength & Conditioning Complex',
      description: 'Intermediate | ~55 min. Front squat and dumbbell bench strength block, a push-pull superset and a swing, thruster and rowing conditioning circuit, then a walk, stretching and a relaxed ending.',
      currentRevisionId: 'rev-sc-intermediate-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: [
        'strength-conditioning',
        'metcon',
        'full-body',
        'intermediate',
        'stretching',
      ],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-sc-intermediate-001',
      templateId: 'template-sc-intermediate',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-sci-1',
          name: 'Dynamic Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-sci-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-sci-1',
                  setNumber: 1,
                  targetDurationSeconds: 225,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-sci-1',
              exerciseId: 'exercise-jumping-jack-001', // Jumping Jack
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-sci-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sci-2',
              exerciseId: 'exercise-arm-circles-001', // Arm Circles
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-sci-2-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sci-3',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-sci-3-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-sci-4',
              exerciseId: 'exercise-inchworm-001', // Inchworm
              order: 5,
              targetSets: [
                TargetSet(id: 'ts-sci-4-1', setNumber: 1, targetReps: 5),
              ],
            ),
            TemplateItem(
              id: 'item-sci-5',
              exerciseId: 'exercise-worlds-greatest-stretch-001', // World's Greatest Stretch
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-sci-5-1', setNumber: 1, targetReps: 3),
                TargetSet(id: 'ts-sci-5-2', setNumber: 2, targetReps: 3),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sci-2',
          name: 'Strength Block',
          items: [
            TemplateItem(
              id: 'item-sci-6',
              exerciseId: 'exercise-front-squat-001', // Barbell Front Squat
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sci-6-1',
                  setNumber: 1,
                  setType: SetType.warmup,
                  targetWeight: 30.0,
                  targetReps: 8,
                ),
                TargetSet(
                  id: 'ts-sci-6-2',
                  setNumber: 2,
                  targetWeight: 70.0,
                  targetReps: 6,
                  targetRpe: 7.5,
                ),
                TargetSet(
                  id: 'ts-sci-6-3',
                  setNumber: 3,
                  targetWeight: 70.0,
                  targetReps: 6,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-sci-6-4',
                  setNumber: 4,
                  targetWeight: 70.0,
                  targetReps: 6,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sci-6-5',
                  setNumber: 5,
                  targetWeight: 70.0,
                  targetReps: 6,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sci-7',
              exerciseId: 'exercise-db-bench-001', // Dumbbell Bench Press
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-sci-7-1',
                  setNumber: 1,
                  targetWeight: 26.0,
                  targetReps: 8,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-sci-7-2',
                  setNumber: 2,
                  targetWeight: 26.0,
                  targetReps: 8,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sci-7-3',
                  setNumber: 3,
                  targetWeight: 26.0,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sci-7-4',
                  setNumber: 4,
                  targetWeight: 26.0,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sci-3',
          name: 'Push-Pull Superset',
          type: WorkoutBlockType.superset,
          rounds: 3,
          items: [
            TemplateItem(
              id: 'item-sci-8',
              exerciseId: 'exercise-pullup-001', // Pull-Up
              order: 1,
              targetSets: [
                TargetSet(id: 'ts-sci-8-1', setNumber: 1, targetReps: 8),
              ],
            ),
            TemplateItem(
              id: 'item-sci-9',
              exerciseId: 'exercise-pushup-001', // Push-Up
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-sci-9-1', setNumber: 1, targetReps: 12),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sci-4',
          name: 'Conditioning Circuit',
          type: WorkoutBlockType.circuit,
          rounds: 4,
          items: [
            TemplateItem(
              id: 'item-sci-10',
              exerciseId: 'exercise-db-swing-001', // Dumbbell Swing
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sci-10-1',
                  setNumber: 1,
                  targetWeight: 24.0,
                  targetReps: 15,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sci-11',
              exerciseId: 'exercise-db-thruster-001', // Dumbbell Thruster
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-sci-11-1',
                  setNumber: 1,
                  targetWeight: 16.0,
                  targetReps: 10,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sci-12',
              exerciseId: 'exercise-rowing-machine-001', // Rowing Machine
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-sci-12-1',
                  setNumber: 1,
                  targetDistanceMeters: 250.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sci-13',
              exerciseId: 'exercise-mountain-climber-001', // Mountain Climber
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-sci-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sci-5',
          name: 'Cool-Down Walk',
          items: [
            TemplateItem(
              id: 'item-sci-14',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sci-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sci-6',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-sci-15',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sci-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-sci-15-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sci-16',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-sci-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-sci-16-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sci-17',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-sci-17-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-sci-17-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sci-18',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-sci-18-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-sci-18-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sci-19',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001', // Cross-Body Shoulder Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-sci-19-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-sci-19-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sci-7',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-sci-20',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sci-20-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sci-21',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-sci-21-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-sci-21-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sci-22',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-sci-22-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 27. Heavy Lift + Metcon
  static final _scExpert = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-sc-expert',
      name: 'Heavy Lift + Metcon',
      description: 'Expert | ~65 min. Heavy deadlift and push press followed by a pull-up, thruster, burpee and rowing metcon and a heavy carry finisher, then a walk, stretching and a relaxed ending.',
      currentRevisionId: 'rev-sc-expert-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: [
        'strength-conditioning',
        'metcon',
        'power',
        'expert',
        'stretching',
      ],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-sc-expert-001',
      templateId: 'template-sc-expert',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-sce-1',
          name: 'Lower Body Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-sce-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-sce-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-sce-1',
              exerciseId: 'exercise-glute-bridge-001', // Glute Bridge
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-sce-1-1', setNumber: 1, targetReps: 12),
              ],
            ),
            TemplateItem(
              id: 'item-sce-2',
              exerciseId: 'exercise-leg-swings-001', // Leg Swings
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-sce-2-1', setNumber: 1, targetReps: 10),
                TargetSet(id: 'ts-sce-2-2', setNumber: 2, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-sce-3',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-sce-3-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-sce-4',
              exerciseId: 'exercise-worlds-greatest-stretch-001', // World's Greatest Stretch
              order: 5,
              targetSets: [
                TargetSet(id: 'ts-sce-4-1', setNumber: 1, targetReps: 3),
                TargetSet(id: 'ts-sce-4-2', setNumber: 2, targetReps: 3),
              ],
            ),
            TemplateItem(
              id: 'item-sce-5',
              exerciseId: 'exercise-cat-cow-001', // Cat-Cow
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-sce-5-1', setNumber: 1, targetReps: 8),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sce-2',
          name: 'Heavy Pull',
          items: [
            TemplateItem(
              id: 'item-sce-6',
              exerciseId: 'exercise-deadlift-001', // Conventional Deadlift
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sce-6-1',
                  setNumber: 1,
                  setType: SetType.warmup,
                  targetWeight: 60.0,
                  targetReps: 5,
                ),
                TargetSet(
                  id: 'ts-sce-6-2',
                  setNumber: 2,
                  setType: SetType.warmup,
                  targetWeight: 100.0,
                  targetReps: 3,
                ),
                TargetSet(
                  id: 'ts-sce-6-3',
                  setNumber: 3,
                  setType: SetType.warmup,
                  targetWeight: 140.0,
                  targetReps: 1,
                ),
                TargetSet(
                  id: 'ts-sce-6-4',
                  setNumber: 4,
                  targetWeight: 160.0,
                  targetReps: 3,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-sce-6-5',
                  setNumber: 5,
                  targetWeight: 160.0,
                  targetReps: 3,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sce-6-6',
                  setNumber: 6,
                  targetWeight: 160.0,
                  targetReps: 3,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sce-6-7',
                  setNumber: 7,
                  targetWeight: 160.0,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sce-3',
          name: 'Power Press',
          items: [
            TemplateItem(
              id: 'item-sce-7',
              exerciseId: 'exercise-push-press-001', // Barbell Push Press
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sce-7-1',
                  setNumber: 1,
                  targetWeight: 65.0,
                  targetReps: 5,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-sce-7-2',
                  setNumber: 2,
                  targetWeight: 65.0,
                  targetReps: 5,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sce-7-3',
                  setNumber: 3,
                  targetWeight: 65.0,
                  targetReps: 5,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sce-7-4',
                  setNumber: 4,
                  targetWeight: 65.0,
                  targetReps: 5,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sce-4',
          name: 'Metcon',
          type: WorkoutBlockType.circuit,
          rounds: 5,
          items: [
            TemplateItem(
              id: 'item-sce-8',
              exerciseId: 'exercise-pullup-001', // Pull-Up
              order: 1,
              targetSets: [
                TargetSet(id: 'ts-sce-8-1', setNumber: 1, targetReps: 8),
              ],
            ),
            TemplateItem(
              id: 'item-sce-9',
              exerciseId: 'exercise-db-thruster-001', // Dumbbell Thruster
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-sce-9-1',
                  setNumber: 1,
                  targetWeight: 20.0,
                  targetReps: 10,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sce-10',
              exerciseId: 'exercise-burpee-001', // Burpee
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-sce-10-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-sce-11',
              exerciseId: 'exercise-rowing-machine-001', // Rowing Machine
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-sce-11-1',
                  setNumber: 1,
                  targetDistanceMeters: 250.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sce-5',
          name: 'Carry Finisher',
          items: [
            TemplateItem(
              id: 'item-sce-12',
              exerciseId: 'exercise-farmers-walk-001', // Farmer's Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sce-12-1',
                  setNumber: 1,
                  targetWeight: 36.0,
                  targetDistanceMeters: 50.0,
                ),
                TargetSet(
                  id: 'ts-sce-12-2',
                  setNumber: 2,
                  targetWeight: 36.0,
                  targetDistanceMeters: 50.0,
                ),
                TargetSet(
                  id: 'ts-sce-12-3',
                  setNumber: 3,
                  targetWeight: 36.0,
                  targetDistanceMeters: 50.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sce-6',
          name: 'Cool-Down Walk',
          items: [
            TemplateItem(
              id: 'item-sce-13',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sce-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sce-7',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-sce-14',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sce-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-sce-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sce-15',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-sce-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-sce-15-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sce-16',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-sce-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-sce-16-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sce-17',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-sce-17-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-sce-17-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sce-18',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001', // Cross-Body Shoulder Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-sce-18-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-sce-18-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sce-8',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-sce-19',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sce-19-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sce-20',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-sce-20-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-sce-20-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sce-21',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-sce-21-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // ===================== ENDURANCE (28-34) =====================

  // 28. Run/Walk Starter
  static final _runWalkStarter = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-run-walk-starter',
      name: 'Run/Walk Starter',
      description: 'Beginner | ~40 min. Six rounds of 2 minutes easy jogging and 1 minute walking to build an aerobic base safely, then a cool-down walk, stretching and a relaxed ending.',
      currentRevisionId: 'rev-run-walk-starter-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['endurance', 'running', 'cardio', 'beginner', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-run-walk-starter-001',
      templateId: 'template-run-walk-starter',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-rw-1',
          name: 'Easy Warm-Up',
          items: [
            TemplateItem(
              id: 'item-rw-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-rw-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-rw-2',
              exerciseId: 'exercise-leg-swings-001', // Leg Swings
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-rw-2-1', setNumber: 1, targetReps: 10),
                TargetSet(id: 'ts-rw-2-2', setNumber: 2, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-rw-3',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-rw-3-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-rw-4',
              exerciseId: 'exercise-jumping-jack-001', // Jumping Jack
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-rw-4-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-rw-2',
          name: 'Run/Walk Intervals',
          type: WorkoutBlockType.circuit,
          rounds: 6,
          items: [
            TemplateItem(
              id: 'item-rw-5',
              exerciseId: 'exercise-treadmill-run-001', // Treadmill Run
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-rw-5-1',
                  setNumber: 1,
                  targetDurationSeconds: 120,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-rw-6',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-rw-6-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-rw-3',
          name: 'Cool-Down Walk',
          items: [
            TemplateItem(
              id: 'item-rw-7',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-rw-7-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-rw-4',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-rw-8',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-rw-8-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-rw-8-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-rw-9',
              exerciseId: 'exercise-quad-stretch-001', // Standing Quad Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-rw-9-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-rw-9-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-rw-10',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-rw-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-rw-10-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-rw-11',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-rw-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-rw-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-rw-12',
              exerciseId: 'exercise-calf-stretch-001', // Standing Calf Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-rw-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-rw-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-rw-5',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-rw-13',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-rw-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-rw-14',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-rw-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-rw-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-rw-15',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-rw-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 29. Steady-State Zone 2 Run
  static final _steadyZone2Run = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-zone2-run',
      name: 'Steady-State Zone 2 Run',
      description: 'Intermediate | ~60 min. 40 minutes of conversational-pace running plus short finishing strides, then a cool-down walk, stretching and a relaxed ending.',
      currentRevisionId: 'rev-zone2-run-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['endurance', 'running', 'zone-2', 'intermediate', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-zone2-run-001',
      templateId: 'template-zone2-run',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-z2-1',
          name: 'Easy Warm-Up',
          items: [
            TemplateItem(
              id: 'item-z2-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-z2-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-z2-2',
              exerciseId: 'exercise-leg-swings-001', // Leg Swings
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-z2-2-1', setNumber: 1, targetReps: 10),
                TargetSet(id: 'ts-z2-2-2', setNumber: 2, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-z2-3',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-z2-3-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-z2-4',
              exerciseId: 'exercise-jumping-jack-001', // Jumping Jack
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-z2-4-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-z2-2',
          name: 'Steady Run',
          items: [
            TemplateItem(
              id: 'item-z2-5',
              exerciseId: 'exercise-treadmill-run-001', // Treadmill Run
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-z2-5-1',
                  setNumber: 1,
                  targetDurationSeconds: 2400,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-z2-3',
          name: 'Finishing Strides',
          type: WorkoutBlockType.circuit,
          rounds: 4,
          items: [
            TemplateItem(
              id: 'item-z2-6',
              exerciseId: 'exercise-treadmill-run-001', // Treadmill Run
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-z2-6-1',
                  setNumber: 1,
                  targetDurationSeconds: 20,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-z2-7',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-z2-7-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-z2-4',
          name: 'Cool-Down Walk',
          items: [
            TemplateItem(
              id: 'item-z2-8',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-z2-8-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-z2-5',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-z2-9',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-z2-9-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-z2-9-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-z2-10',
              exerciseId: 'exercise-quad-stretch-001', // Standing Quad Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-z2-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-z2-10-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-z2-11',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-z2-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-z2-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-z2-12',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-z2-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-z2-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-z2-13',
              exerciseId: 'exercise-calf-stretch-001', // Standing Calf Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-z2-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-z2-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-z2-6',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-z2-14',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-z2-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-z2-15',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-z2-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-z2-15-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-z2-16',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-z2-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 30. Threshold Run Intervals
  static final _thresholdRunIntervals = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-threshold-run',
      name: 'Threshold Run Intervals',
      description: 'Expert | ~70 min. Five 5-minute threshold-pace runs with 2 minutes easy recovery and a 10-minute steady finish, then a cool-down walk, stretching and a relaxed ending.',
      currentRevisionId: 'rev-threshold-run-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['endurance', 'running', 'threshold', 'expert', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-threshold-run-001',
      templateId: 'template-threshold-run',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-tr-1',
          name: 'Easy Warm-Up',
          items: [
            TemplateItem(
              id: 'item-tr-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-tr-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tr-2',
              exerciseId: 'exercise-leg-swings-001', // Leg Swings
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-tr-2-1', setNumber: 1, targetReps: 10),
                TargetSet(id: 'ts-tr-2-2', setNumber: 2, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-tr-3',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-tr-3-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-tr-4',
              exerciseId: 'exercise-jumping-jack-001', // Jumping Jack
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-tr-4-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-tr-2',
          name: 'Threshold Intervals',
          type: WorkoutBlockType.circuit,
          rounds: 5,
          items: [
            TemplateItem(
              id: 'item-tr-5',
              exerciseId: 'exercise-treadmill-run-001', // Treadmill Run
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-tr-5-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tr-6',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-tr-6-1',
                  setNumber: 1,
                  targetDurationSeconds: 120,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-tr-3',
          name: 'Steady Finish',
          items: [
            TemplateItem(
              id: 'item-tr-7',
              exerciseId: 'exercise-treadmill-run-001', // Treadmill Run
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-tr-7-1',
                  setNumber: 1,
                  targetDurationSeconds: 600,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-tr-4',
          name: 'Cool-Down Walk',
          items: [
            TemplateItem(
              id: 'item-tr-8',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-tr-8-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-tr-5',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-tr-9',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-tr-9-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-tr-9-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tr-10',
              exerciseId: 'exercise-quad-stretch-001', // Standing Quad Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-tr-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-tr-10-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tr-11',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-tr-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-tr-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tr-12',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-tr-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-tr-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tr-13',
              exerciseId: 'exercise-calf-stretch-001', // Standing Calf Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-tr-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-tr-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-tr-6',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-tr-14',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-tr-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tr-15',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-tr-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-tr-15-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tr-16',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-tr-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 31. Cross-Training Aerobic Base
  static final _crossTrainingAerobic = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-cross-training-aerobic',
      name: 'Cross-Training Aerobic Base',
      description: 'Beginner to Intermediate | ~50 min. Low-impact aerobic session moving through bike, rower and treadmill at an easy to moderate effort, then a cool-down walk, stretching and a relaxed ending.',
      currentRevisionId: 'rev-cross-training-aerobic-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: [
        'endurance',
        'cross-training',
        'low-impact',
        'beginner',
        'intermediate',
        'stretching',
      ],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-cross-training-aerobic-001',
      templateId: 'template-cross-training-aerobic',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-ct-1',
          name: 'Easy Warm-Up',
          items: [
            TemplateItem(
              id: 'item-ct-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ct-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ct-2',
              exerciseId: 'exercise-leg-swings-001', // Leg Swings
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-ct-2-1', setNumber: 1, targetReps: 10),
                TargetSet(id: 'ts-ct-2-2', setNumber: 2, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-ct-3',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-ct-3-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-ct-4',
              exerciseId: 'exercise-jumping-jack-001', // Jumping Jack
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-ct-4-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ct-2',
          name: 'Aerobic Machines',
          items: [
            TemplateItem(
              id: 'item-ct-5',
              exerciseId: 'exercise-stationary-bike-001', // Stationary Bike
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ct-5-1',
                  setNumber: 1,
                  targetDurationSeconds: 900,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ct-6',
              exerciseId: 'exercise-rowing-machine-001', // Rowing Machine
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ct-6-1',
                  setNumber: 1,
                  targetDurationSeconds: 600,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ct-7',
              exerciseId: 'exercise-treadmill-run-001', // Treadmill Run
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-ct-7-1',
                  setNumber: 1,
                  targetDurationSeconds: 600,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ct-3',
          name: 'Cool-Down Walk',
          items: [
            TemplateItem(
              id: 'item-ct-8',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ct-8-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ct-4',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-ct-9',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ct-9-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ct-9-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ct-10',
              exerciseId: 'exercise-quad-stretch-001', // Standing Quad Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ct-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ct-10-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ct-11',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-ct-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ct-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ct-12',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-ct-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ct-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ct-13',
              exerciseId: 'exercise-calf-stretch-001', // Standing Calf Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-ct-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ct-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ct-5',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-ct-14',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ct-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ct-15',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ct-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-ct-15-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ct-16',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-ct-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 32. Rowing Interval Endurance
  static final _rowingIntervals = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-rowing-intervals',
      name: 'Rowing Interval Endurance',
      description: 'Intermediate | ~45 min. Five 500 m rowing efforts, each followed by 90 seconds of easy cycling for active recovery, then a cool-down walk, stretching and a relaxed ending.',
      currentRevisionId: 'rev-rowing-intervals-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['endurance', 'rowing', 'intervals', 'intermediate', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-rowing-intervals-001',
      templateId: 'template-rowing-intervals',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-ri-1',
          name: 'Dynamic Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-ri-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-ri-1',
                  setNumber: 1,
                  targetDurationSeconds: 225,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-ri-1',
              exerciseId: 'exercise-jumping-jack-001', // Jumping Jack
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ri-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ri-2',
              exerciseId: 'exercise-arm-circles-001', // Arm Circles
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-ri-2-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ri-3',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-ri-3-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-ri-4',
              exerciseId: 'exercise-inchworm-001', // Inchworm
              order: 5,
              targetSets: [
                TargetSet(id: 'ts-ri-4-1', setNumber: 1, targetReps: 5),
              ],
            ),
            TemplateItem(
              id: 'item-ri-5',
              exerciseId: 'exercise-worlds-greatest-stretch-001', // World's Greatest Stretch
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-ri-5-1', setNumber: 1, targetReps: 3),
                TargetSet(id: 'ts-ri-5-2', setNumber: 2, targetReps: 3),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ri-2',
          name: 'Rowing Intervals',
          type: WorkoutBlockType.circuit,
          rounds: 5,
          items: [
            TemplateItem(
              id: 'item-ri-6',
              exerciseId: 'exercise-rowing-machine-001', // Rowing Machine
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ri-6-1',
                  setNumber: 1,
                  targetDistanceMeters: 500.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ri-7',
              exerciseId: 'exercise-stationary-bike-001', // Stationary Bike
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ri-7-1',
                  setNumber: 1,
                  targetDurationSeconds: 90,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ri-3',
          name: 'Cool-Down Walk',
          items: [
            TemplateItem(
              id: 'item-ri-8',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ri-8-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ri-4',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-ri-9',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ri-9-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ri-9-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ri-10',
              exerciseId: 'exercise-quad-stretch-001', // Standing Quad Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ri-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ri-10-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ri-11',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-ri-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ri-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ri-12',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-ri-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ri-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ri-13',
              exerciseId: 'exercise-calf-stretch-001', // Standing Calf Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-ri-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ri-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ri-5',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-ri-14',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ri-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ri-15',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ri-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-ri-15-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ri-16',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-ri-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 33. Muscular Endurance Circuit
  static final _muscularEnduranceCircuit = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-muscular-endurance',
      name: 'Muscular Endurance Circuit',
      description: 'Intermediate | ~45 min. High-rep full-body circuit of squats, push-ups, rows, lunges, planks and jacks to build local muscular endurance, then stretching and a relaxed ending.',
      currentRevisionId: 'rev-muscular-endurance-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: [
        'endurance',
        'muscular-endurance',
        'circuit',
        'intermediate',
        'stretching',
      ],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-muscular-endurance-001',
      templateId: 'template-muscular-endurance',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-me-1',
          name: 'Dynamic Warm-Up',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-me-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-me-1',
                  setNumber: 1,
                  targetDurationSeconds: 225,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-me-1',
              exerciseId: 'exercise-jumping-jack-001', // Jumping Jack
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-me-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-me-2',
              exerciseId: 'exercise-arm-circles-001', // Arm Circles
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-me-2-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-me-3',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-me-3-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-me-4',
              exerciseId: 'exercise-inchworm-001', // Inchworm
              order: 5,
              targetSets: [
                TargetSet(id: 'ts-me-4-1', setNumber: 1, targetReps: 5),
              ],
            ),
            TemplateItem(
              id: 'item-me-5',
              exerciseId: 'exercise-worlds-greatest-stretch-001', // World's Greatest Stretch
              order: 6,
              targetSets: [
                TargetSet(id: 'ts-me-5-1', setNumber: 1, targetReps: 3),
                TargetSet(id: 'ts-me-5-2', setNumber: 2, targetReps: 3),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-me-2',
          name: 'Endurance Circuit',
          type: WorkoutBlockType.circuit,
          rounds: 4,
          items: [
            TemplateItem(
              id: 'item-me-6',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 1,
              targetSets: [
                TargetSet(id: 'ts-me-6-1', setNumber: 1, targetReps: 20),
              ],
            ),
            TemplateItem(
              id: 'item-me-7',
              exerciseId: 'exercise-pushup-001', // Push-Up
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-me-7-1', setNumber: 1, targetReps: 15),
              ],
            ),
            TemplateItem(
              id: 'item-me-8',
              exerciseId:
                  'exercise-single-arm-db-row-001', // Single-Arm Dumbbell Row
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-me-8-1',
                  setNumber: 1,
                  targetWeight: 14.0,
                  targetReps: 15,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-me-9',
              exerciseId:
                  'exercise-walking-lunge-001', // Dumbbell Walking Lunge
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-me-9-1',
                  setNumber: 1,
                  targetWeight: 10.0,
                  targetReps: 20,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-me-10',
              exerciseId: 'exercise-plank-001', // Forearm Plank
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-me-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-me-11',
              exerciseId: 'exercise-jumping-jack-001', // Jumping Jack
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-me-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-me-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-me-12',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-me-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-me-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-me-13',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-me-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-me-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-me-14',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-me-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-me-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-me-15',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-me-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-me-15-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-me-16',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001', // Cross-Body Shoulder Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-me-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-me-16-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-me-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-me-17',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-me-17-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-me-18',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-me-18-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-me-18-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-me-19',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-me-19-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 34. Expert Aerobic Base Builder
  static final _aerobicBaseBuilder = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-aerobic-base-builder',
      name: 'Expert Aerobic Base Builder',
      description: 'Expert | ~90 min. Long steady-state session across rower, bike and treadmill followed by core work, a cool-down walk, stretching and a relaxed ending.',
      currentRevisionId: 'rev-aerobic-base-builder-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: [
        'endurance',
        'aerobic-base',
        'long-session',
        'expert',
        'stretching',
      ],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-aerobic-base-builder-001',
      templateId: 'template-aerobic-base-builder',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-ab-1',
          name: 'Easy Warm-Up',
          items: [
            TemplateItem(
              id: 'item-ab-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ab-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ab-2',
              exerciseId: 'exercise-leg-swings-001', // Leg Swings
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-ab-2-1', setNumber: 1, targetReps: 10),
                TargetSet(id: 'ts-ab-2-2', setNumber: 2, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-ab-3',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-ab-3-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-ab-4',
              exerciseId: 'exercise-jumping-jack-001', // Jumping Jack
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-ab-4-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ab-2',
          name: 'Long Aerobic Blocks',
          items: [
            TemplateItem(
              id: 'item-ab-5',
              exerciseId: 'exercise-rowing-machine-001', // Rowing Machine
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ab-5-1',
                  setNumber: 1,
                  targetDurationSeconds: 1200,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ab-6',
              exerciseId: 'exercise-stationary-bike-001', // Stationary Bike
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ab-6-1',
                  setNumber: 1,
                  targetDurationSeconds: 1200,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ab-7',
              exerciseId: 'exercise-treadmill-run-001', // Treadmill Run
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-ab-7-1',
                  setNumber: 1,
                  targetDurationSeconds: 900,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ab-3',
          name: 'Core Finish',
          items: [
            TemplateItem(
              id: 'item-ab-8',
              exerciseId: 'exercise-plank-001', // Forearm Plank
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ab-8-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
                TargetSet(
                  id: 'ts-ab-8-2',
                  setNumber: 2,
                  targetDurationSeconds: 60,
                ),
                TargetSet(
                  id: 'ts-ab-8-3',
                  setNumber: 3,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ab-9',
              exerciseId: 'exercise-hanging-leg-raise-001', // Hanging Leg Raise
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-ab-9-1', setNumber: 1, targetReps: 10),
                TargetSet(id: 'ts-ab-9-2', setNumber: 2, targetReps: 10),
                TargetSet(id: 'ts-ab-9-3', setNumber: 3, targetReps: 10),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ab-4',
          name: 'Cool-Down Walk',
          items: [
            TemplateItem(
              id: 'item-ab-10',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ab-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ab-5',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-ab-11',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ab-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ab-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ab-12',
              exerciseId: 'exercise-quad-stretch-001', // Standing Quad Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ab-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ab-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ab-13',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-ab-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ab-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ab-14',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-ab-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ab-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ab-15',
              exerciseId: 'exercise-calf-stretch-001', // Standing Calf Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-ab-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ab-15-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ab-6',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-ab-16',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ab-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ab-17',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ab-17-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-ab-17-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ab-18',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-ab-18-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // ===================== MOBILITY, STRETCHING & RECOVERY (35-38) =====================

  // 35. Full Body Mobility & Stretch Flow
  static final _mobilityFlow = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-mobility-flow',
      name: 'Full Body Mobility & Stretch Flow',
      description: 'Beginner | ~30 min. Gentle mobility flow followed by a full-body deep stretch sequence and a relaxed ending. Suitable as a standalone session or rest-day routine.',
      currentRevisionId: 'rev-mobility-flow-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['mobility', 'stretching', 'recovery', 'beginner'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-mobility-flow-001',
      templateId: 'template-mobility-flow',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-mf-1',
          name: 'Warm-Up Mobility Flow',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-mf-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-mf-1',
                  setNumber: 1,
                  targetDurationSeconds: 255,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-mf-1',
              exerciseId: 'exercise-cat-cow-001', // Cat-Cow
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-mf-1-1', setNumber: 1, targetReps: 10),
                TargetSet(id: 'ts-mf-1-2', setNumber: 2, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-mf-2',
              exerciseId: 'exercise-worlds-greatest-stretch-001', // World's Greatest Stretch
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-mf-2-1', setNumber: 1, targetReps: 5),
                TargetSet(id: 'ts-mf-2-2', setNumber: 2, targetReps: 5),
              ],
            ),
            TemplateItem(
              id: 'item-mf-3',
              exerciseId: 'exercise-inchworm-001', // Inchworm
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-mf-3-1', setNumber: 1, targetReps: 6),
              ],
            ),
            TemplateItem(
              id: 'item-mf-4',
              exerciseId: 'exercise-leg-swings-001', // Leg Swings
              order: 5,
              targetSets: [
                TargetSet(id: 'ts-mf-4-1', setNumber: 1, targetReps: 12),
                TargetSet(id: 'ts-mf-4-2', setNumber: 2, targetReps: 12),
              ],
            ),
            TemplateItem(
              id: 'item-mf-5',
              exerciseId: 'exercise-arm-circles-001', // Arm Circles
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-mf-5-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-mf-6',
              exerciseId: 'exercise-bodyweight-squat-001', // Bodyweight Squat
              order: 7,
              targetSets: [
                TargetSet(id: 'ts-mf-6-1', setNumber: 1, targetReps: 10),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-mf-2',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-mf-7',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-mf-7-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
                TargetSet(
                  id: 'ts-mf-7-2',
                  setNumber: 2,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-mf-8',
              exerciseId: 'exercise-quad-stretch-001', // Standing Quad Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-mf-8-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-mf-8-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-mf-9',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-mf-9-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
                TargetSet(
                  id: 'ts-mf-9-2',
                  setNumber: 2,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-mf-10',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-mf-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
                TargetSet(
                  id: 'ts-mf-10-2',
                  setNumber: 2,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-mf-11',
              exerciseId: 'exercise-calf-stretch-001', // Standing Calf Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-mf-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-mf-11-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-mf-12',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-mf-12-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-mf-12-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-mf-13',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001', // Cross-Body Shoulder Stretch
              order: 7,
              targetSets: [
                TargetSet(
                  id: 'ts-mf-13-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-mf-13-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-mf-14',
              exerciseId: 'exercise-overhead-tricep-stretch-001', // Overhead Triceps Stretch
              order: 8,
              targetSets: [
                TargetSet(
                  id: 'ts-mf-14-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-mf-14-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-mf-3',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-mf-15',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-mf-15-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-mf-16',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-mf-16-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-mf-16-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-mf-17',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-mf-17-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 36. Lower Body Stretch & Release
  static final _lowerStretchRelease = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-lower-stretch-release',
      name: 'Lower Body Stretch & Release',
      description: 'Beginner | ~25 min. Easy walk and activation followed by long-hold stretches for hips, quads, hamstrings, glutes and calves, finishing with a relaxed ending. Ideal after leg day.',
      currentRevisionId: 'rev-lower-stretch-release-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['mobility', 'stretching', 'recovery', 'legs', 'beginner'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-lower-stretch-release-001',
      templateId: 'template-lower-stretch-release',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-lsr-1',
          name: 'Lower Body Warm-Up & Prep',
          items: [
            TemplateItem(
              id: 'item-lsr-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lsr-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lsr-2',
              exerciseId: 'exercise-leg-swings-001', // Leg Swings
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-lsr-2-1', setNumber: 1, targetReps: 12),
                TargetSet(id: 'ts-lsr-2-2', setNumber: 2, targetReps: 12),
              ],
            ),
            TemplateItem(
              id: 'item-lsr-3',
              exerciseId: 'exercise-glute-bridge-001', // Glute Bridge
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-lsr-3-1', setNumber: 1, targetReps: 12),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-lsr-2',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-lsr-4',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lsr-4-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
                TargetSet(
                  id: 'ts-lsr-4-2',
                  setNumber: 2,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lsr-5',
              exerciseId: 'exercise-quad-stretch-001', // Standing Quad Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lsr-5-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
                TargetSet(
                  id: 'ts-lsr-5-2',
                  setNumber: 2,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lsr-6',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-lsr-6-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
                TargetSet(
                  id: 'ts-lsr-6-2',
                  setNumber: 2,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lsr-7',
              exerciseId: 'exercise-figure-four-stretch-001', // Figure-Four Glute Stretch
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-lsr-7-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
                TargetSet(
                  id: 'ts-lsr-7-2',
                  setNumber: 2,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lsr-8',
              exerciseId: 'exercise-calf-stretch-001', // Standing Calf Stretch
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-lsr-8-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
                TargetSet(
                  id: 'ts-lsr-8-2',
                  setNumber: 2,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-lsr-3',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-lsr-9',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lsr-9-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lsr-10',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lsr-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-lsr-10-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lsr-11',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-lsr-11-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 37. Upper Body Stretch & Release
  static final _upperStretchRelease = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-upper-stretch-release',
      name: 'Upper Body Stretch & Release',
      description: 'Beginner | ~20 min. Shoulder and spine mobility followed by long-hold stretches for chest, shoulders and triceps, finishing with a relaxed ending. Ideal after push or pull days.',
      currentRevisionId: 'rev-upper-stretch-release-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['mobility', 'stretching', 'recovery', 'upper-body', 'beginner'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-upper-stretch-release-001',
      templateId: 'template-upper-stretch-release',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-usr-1',
          name: 'Upper Body Warm-Up & Prep',
          items: [
            TemplateItem(
              id: 'item-warmup-walk-usr-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-warmup-walk-usr-1',
                  setNumber: 1,
                  targetDurationSeconds: 240,
                ),
              ],
            ),

            TemplateItem(
              id: 'item-usr-1',
              exerciseId: 'exercise-arm-circles-001', // Arm Circles
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-usr-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-usr-2',
              exerciseId: 'exercise-cat-cow-001', // Cat-Cow
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-usr-2-1', setNumber: 1, targetReps: 10),
                TargetSet(id: 'ts-usr-2-2', setNumber: 2, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-usr-3',
              exerciseId: 'exercise-inchworm-001', // Inchworm
              order: 4,
              targetSets: [
                TargetSet(id: 'ts-usr-3-1', setNumber: 1, targetReps: 6),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-usr-2',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-usr-4',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-usr-4-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
                TargetSet(
                  id: 'ts-usr-4-2',
                  setNumber: 2,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-usr-5',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001', // Cross-Body Shoulder Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-usr-5-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
                TargetSet(
                  id: 'ts-usr-5-2',
                  setNumber: 2,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-usr-6',
              exerciseId: 'exercise-overhead-tricep-stretch-001', // Overhead Triceps Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-usr-6-1',
                  setNumber: 1,
                  targetDurationSeconds: 45,
                ),
                TargetSet(
                  id: 'ts-usr-6-2',
                  setNumber: 2,
                  targetDurationSeconds: 45,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-usr-3',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-usr-7',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-usr-7-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-usr-8',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-usr-8-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-usr-8-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-usr-9',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-usr-9-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 38. Active Recovery & Relaxation
  static final _activeRecovery = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-active-recovery',
      name: 'Active Recovery & Relaxation',
      description: 'All levels | ~30 min. Easy walk, gentle core stability and light stretching for rest days, ending with a long relaxed breathing finish.',
      currentRevisionId: 'rev-active-recovery-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: [
        'recovery',
        'relaxation',
        'stretching',
        'beginner',
        'intermediate',
        'expert',
      ],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-active-recovery-001',
      templateId: 'template-active-recovery',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-ar-1',
          name: 'Easy Movement Warm-Up',
          items: [
            TemplateItem(
              id: 'item-ar-1',
              exerciseId: 'exercise-recovery-walk-001', // Easy Recovery Walk
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ar-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 600,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ar-2',
              exerciseId: 'exercise-cat-cow-001', // Cat-Cow
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-ar-2-1', setNumber: 1, targetReps: 10),
              ],
            ),
            TemplateItem(
              id: 'item-ar-3',
              exerciseId: 'exercise-bird-dog-001', // Bird Dog
              order: 3,
              targetSets: [
                TargetSet(id: 'ts-ar-3-1', setNumber: 1, targetReps: 8),
                TargetSet(id: 'ts-ar-3-2', setNumber: 2, targetReps: 8),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ar-2',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-ar-4',
              exerciseId: 'exercise-hip-flexor-stretch-001', // Half-Kneeling Hip Flexor Stretch
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ar-4-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ar-4-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ar-5',
              exerciseId: 'exercise-hamstring-stretch-001', // Standing Hamstring Stretch
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ar-5-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ar-5-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ar-6',
              exerciseId:
                  'exercise-doorway-chest-stretch-001', // Doorway Chest Stretch
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-ar-6-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ar-3',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-ar-7',
              exerciseId: 'exercise-childs-pose-001', // Child's Pose
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ar-7-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ar-8',
              exerciseId:
                  'exercise-lying-spinal-twist-001', // Lying Spinal Twist
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ar-8-1',
                  setNumber: 1,
                  targetDurationSeconds: 40,
                ),
                TargetSet(
                  id: 'ts-ar-8-2',
                  setNumber: 2,
                  targetDurationSeconds: 40,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ar-9',
              exerciseId: 'exercise-diaphragmatic-breathing-001', // Supine Diaphragmatic Breathing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-ar-9-1',
                  setNumber: 1,
                  targetDurationSeconds: 300,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // ===================== CUSTOM USER TEMPLATES (1-5) =====================

  // 1. Upper Body A
  static final _upperBodyA = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-upper-body-a-001',
      name: 'Upper Body A',
      description: 'Intermediate | ~65 min. Focuses on horizontal pushing, vertical pulling, and shoulder/arm accessories with warm-up, stretching and relaxed ending.',
      currentRevisionId: 'rev-upper-body-a-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['upper-body', 'push', 'pull', 'intermediate', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-upper-body-a-001',
      templateId: 'template-upper-body-a-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-uba-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-uba-w1',
              exerciseId: 'exercise-band-pull-aparts-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-uba-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 6.0,
                ),
                TargetSet(
                  id: 'ts-uba-w1-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 6.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uba-w2',
              exerciseId: 'exercise-arm-circles-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-uba-w2-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 5.0,
                ),
                TargetSet(
                  id: 'ts-uba-w2-2',
                  setNumber: 2,
                  targetReps: 20,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-uba-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-uba-1',
              exerciseId: 'exercise-seated-machine-chest-press-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-uba-1-1',
                  setNumber: 1,
                  targetReps: 8,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-uba-1-2',
                  setNumber: 2,
                  targetReps: 8,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-uba-1-3',
                  setNumber: 3,
                  targetReps: 8,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uba-2',
              exerciseId: 'exercise-chest-supported-t-bar-row-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-uba-2-1',
                  setNumber: 1,
                  targetReps: 8,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-uba-2-2',
                  setNumber: 2,
                  targetReps: 8,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-uba-2-3',
                  setNumber: 3,
                  targetReps: 8,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uba-3',
              exerciseId: 'exercise-seated-machine-ohp-001',
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-uba-3-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-uba-3-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-uba-3-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uba-4',
              exerciseId: 'exercise-single-arm-lat-pulldown-001',
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-uba-4-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-uba-4-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-uba-4-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uba-5',
              exerciseId: 'exercise-single-arm-cable-tricep-extension-001',
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-uba-5-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-uba-5-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-uba-5-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uba-6',
              exerciseId: 'exercise-incline-db-bicep-curl-001',
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-uba-6-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-uba-6-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-uba-6-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-uba-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-uba-7',
              exerciseId: 'exercise-chest-doorway-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-uba-7-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-uba-7-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uba-8',
              exerciseId: 'exercise-lat-overhead-stretch-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-uba-8-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-uba-8-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-uba-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-uba-9',
              exerciseId: 'exercise-childs-pose-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-uba-9-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-uba-10',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-uba-10-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 2. Lower Body A
  static final _lowerBodyA = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-lower-body-a-001',
      name: 'Lower Body A',
      description: 'Heavy quad focus featuring leg press, lunges, and calf/core finishers with warm-up and stretching.',
      currentRevisionId: 'rev-lower-body-a-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['lower-body', 'quads', 'core', 'intermediate', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-lower-body-a-001',
      templateId: 'template-lower-body-a-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-lba-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-lba-w1',
              exerciseId: 'exercise-bodyweight-squat-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lba-w1-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 6.0,
                ),
                TargetSet(
                  id: 'ts-lba-w1-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 6.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lba-w2',
              exerciseId: 'exercise-leg-swings-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lba-w2-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
                TargetSet(
                  id: 'ts-lba-w2-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-lba-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-lba-1',
              exerciseId: 'exercise-leg-press-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lba-1-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lba-1-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lba-1-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lba-2',
              exerciseId: 'exercise-leg-extension-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lba-2-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-lba-2-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-lba-2-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lba-3',
              exerciseId: 'exercise-walking-lunge-001',
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-lba-3-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lba-3-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lba-3-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lba-4',
              exerciseId: 'exercise-seated-calf-raise-001',
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-lba-4-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-lba-4-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-lba-4-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-lba-4-4',
                  setNumber: 4,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lba-5',
              exerciseId: 'exercise-hanging-leg-raise-001',
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-lba-5-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lba-5-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lba-5-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-lba-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-lba-6',
              exerciseId: 'exercise-quad-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lba-6-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-lba-6-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lba-7',
              exerciseId: 'exercise-hamstring-stretch-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lba-7-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-lba-7-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-lba-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-lba-8',
              exerciseId: 'exercise-childs-pose-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lba-8-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lba-9',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lba-9-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 3. Upper Body B
  static final _upperBodyB = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-upper-body-b-001',
      name: 'Upper Body B',
      description: 'Emphasizes upper chest, fly variations, lateral delts, and tricep long-head work with warm-up and stretching.',
      currentRevisionId: 'rev-upper-body-b-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: [
        'upper-body',
        'chest',
        'triceps',
        'shoulders',
        'intermediate',
        'stretching',
      ],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-upper-body-b-001',
      templateId: 'template-upper-body-b-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-ubb-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-ubb-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ubb-w1-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 5.0,
                ),
                TargetSet(
                  id: 'ts-ubb-w1-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 5.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ubb-w2',
              exerciseId: 'exercise-cat-cow-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ubb-w2-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 6.0,
                ),
                TargetSet(
                  id: 'ts-ubb-w2-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 6.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ubb-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-ubb-1',
              exerciseId: 'exercise-incline-db-press-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ubb-1-1',
                  setNumber: 1,
                  targetReps: 8,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-ubb-1-2',
                  setNumber: 2,
                  targetReps: 8,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-ubb-1-3',
                  setNumber: 3,
                  targetReps: 8,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ubb-2',
              exerciseId: 'exercise-pec-deck-fly-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ubb-2-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ubb-2-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ubb-2-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ubb-3',
              exerciseId: 'exercise-cable-lateral-raise-001',
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-ubb-3-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ubb-3-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ubb-3-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ubb-3-4',
                  setNumber: 4,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ubb-4',
              exerciseId: 'exercise-tricep-pushdown-001',
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-ubb-4-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ubb-4-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ubb-4-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ubb-5',
              exerciseId: 'exercise-overhead-tricep-001',
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-ubb-5-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ubb-5-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ubb-5-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ubb-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-ubb-6',
              exerciseId: 'exercise-chest-doorway-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ubb-6-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ubb-6-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ubb-7',
              exerciseId: 'exercise-overhead-tricep-stretch-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ubb-7-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ubb-7-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ubb-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-ubb-8',
              exerciseId: 'exercise-childs-pose-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ubb-8-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ubb-9',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ubb-9-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 4. Upper Body C
  static final _upperBodyC = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-upper-body-c-001',
      name: 'Upper Body C',
      description: 'Back-dominant pulling routine with rear delt focus and preacher bicep isolation with warm-up and stretching.',
      currentRevisionId: 'rev-upper-body-c-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['upper-body', 'back', 'biceps', 'intermediate', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-upper-body-c-001',
      templateId: 'template-upper-body-c-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-ubc-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-ubc-w1',
              exerciseId: 'exercise-band-pull-aparts-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ubc-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 6.0,
                ),
                TargetSet(
                  id: 'ts-ubc-w1-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 6.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ubc-w2',
              exerciseId: 'exercise-cat-cow-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ubc-w2-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 5.0,
                ),
                TargetSet(
                  id: 'ts-ubc-w2-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ubc-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-ubc-1',
              exerciseId: 'exercise-lat-pulldown-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ubc-1-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-ubc-1-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-ubc-1-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ubc-2',
              exerciseId: 'exercise-single-arm-db-row-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ubc-2-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-ubc-2-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-ubc-2-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ubc-3',
              exerciseId: 'exercise-rear-delt-fly-001',
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-ubc-3-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ubc-3-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ubc-3-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ubc-4',
              exerciseId: 'exercise-face-pull-001',
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-ubc-4-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ubc-4-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ubc-4-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ubc-5',
              exerciseId: 'exercise-barbell-curl-001',
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-ubc-5-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ubc-5-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ubc-5-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ubc-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-ubc-6',
              exerciseId: 'exercise-lat-overhead-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ubc-6-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ubc-6-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ubc-7',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ubc-7-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-ubc-7-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ubc-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-ubc-8',
              exerciseId: 'exercise-childs-pose-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ubc-8-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ubc-9',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ubc-9-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 5. Lower Body B
  static final _lowerBodyB = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-lower-body-b-001',
      name: 'Lower Body B',
      description: 'Posterior chain focused leg day with hamstring isolation, high/wide leg press, and core work with warm-up and stretching.',
      currentRevisionId: 'rev-lower-body-b-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: [
        'lower-body',
        'hamstrings',
        'glutes',
        'abs',
        'intermediate',
        'stretching',
      ],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-lower-body-b-001',
      templateId: 'template-lower-body-b-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release: timed warm-up, structured work blocks and complete cool-down',
      blocks: [
        const WorkoutBlock(
          id: 'block-lbb-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-lbb-w1',
              exerciseId: 'exercise-bodyweight-squat-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lbb-w1-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 6.0,
                ),
                TargetSet(
                  id: 'ts-lbb-w1-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 6.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lbb-w2',
              exerciseId: 'exercise-leg-swings-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lbb-w2-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
                TargetSet(
                  id: 'ts-lbb-w2-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-lbb-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-lbb-1',
              exerciseId: 'exercise-seated-leg-curl-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lbb-1-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-lbb-1-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-lbb-1-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lbb-2',
              exerciseId: 'exercise-leg-press-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lbb-2-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lbb-2-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lbb-2-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lbb-3',
              exerciseId: 'exercise-standing-calf-raise-001',
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-lbb-3-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-lbb-3-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-lbb-3-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-lbb-3-4',
                  setNumber: 4,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lbb-4',
              exerciseId: 'exercise-cable-ab-crunch-001',
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-lbb-4-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lbb-4-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-lbb-4-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lbb-5',
              exerciseId: 'exercise-plank-001',
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-lbb-5-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-lbb-5-2',
                  setNumber: 2,
                  targetDurationSeconds: 60,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-lbb-5-3',
                  setNumber: 3,
                  targetDurationSeconds: 60,
                  targetRpe: 8.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-lbb-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-lbb-6',
              exerciseId: 'exercise-hamstring-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lbb-6-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-lbb-6-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lbb-7',
              exerciseId: 'exercise-hip-flexor-stretch-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lbb-7-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-lbb-7-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-lbb-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-lbb-8',
              exerciseId: 'exercise-childs-pose-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lbb-8-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lbb-9',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lbb-9-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // ===================== CUSTOM ROUTINE 1 TEMPLATES (Mon-Thu) =====================

  // 1. Monday: Shoulders
  static final _routine1Shoulders = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine1-shoulders-001',
      name: 'Routine 1: Monday Shoulders',
      description: 'Monday Routine | Focuses on heavy shoulder pressing, isolation raises, and trap development with a complete warm-up and cool-down.',
      currentRevisionId: 'rev-routine1-shoulders-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['shoulders', 'routine-1', 'hypertrophy', 'stretching'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine1-shoulders-001',
      templateId: 'template-routine1-shoulders-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release for Routine 1 Shoulders workout',
      blocks: [
        const WorkoutBlock(
          id: 'block-r1s-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-r1s-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r1s-w1-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 5.0,
                ),
                TargetSet(
                  id: 'ts-r1s-w1-2',
                  setNumber: 2,
                  targetReps: 20,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r1s-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-r1s-1',
              exerciseId: 'exercise-seated-db-press-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r1s-1-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1s-1-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1s-1-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1s-1-4',
                  setNumber: 4,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r1s-2',
              exerciseId: 'exercise-ohp-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-r1s-2-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1s-2-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1s-2-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1s-2-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1s-2-5',
                  setNumber: 5,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r1s-3',
              exerciseId: 'exercise-front-raise-001', // Front raise mapping
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-r1s-3-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-r1s-3-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-r1s-3-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-r1s-3-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r1s-4',
              exerciseId: 'exercise-lateral-raise-001',
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-r1s-4-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r1s-4-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r1s-4-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r1s-4-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r1s-5',
              exerciseId: 'exercise-barbell-shrug-001',
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-r1s-5-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1s-5-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1s-5-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1s-5-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1s-5-5',
                  setNumber: 5,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r1s-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-r1s-6',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r1s-6-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-r1s-6-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r1s-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-r1s-7',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r1s-7-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 2. Tuesday: Back
  static final _routine1Back = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine1-back-001',
      name: 'Routine 1: Tuesday Back',
      description: 'Tuesday Routine | Complete back session featuring pull-ups to max, lat pulldowns, heavy one-arm rows, sitting cable rows, and hyper extensions.',
      currentRevisionId: 'rev-routine1-back-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['back', 'routine-1', 'pull', 'hypertrophy'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine1-back-001',
      templateId: 'template-routine1-back-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release for Routine 1 Back workout',
      blocks: [
        const WorkoutBlock(
          id: 'block-r1b-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-r1b-w1',
              exerciseId: 'exercise-cat-cow-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r1b-w1-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r1b-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-r1b-1',
              exerciseId: 'exercise-pullup-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r1b-1-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.5,
                ), // 0 reps can indicate max effort tracking in app logic
                TargetSet(
                  id: 'ts-r1b-1-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r1b-1-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r1b-1-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r1b-1-5',
                  setNumber: 5,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r1b-1-6',
                  setNumber: 6,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r1b-2',
              exerciseId: 'exercise-lat-pulldown-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-r1b-2-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1b-2-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1b-2-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1b-2-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r1b-3',
              exerciseId: 'exercise-single-arm-db-row-001',
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-r1b-3-1',
                  setNumber: 1,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r1b-3-2',
                  setNumber: 2,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r1b-3-3',
                  setNumber: 3,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r1b-4',
              exerciseId:
                  'exercise-seated-cable-row-001', // Sitting draw / cable row
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-r1b-4-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1b-4-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1b-4-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r1b-5',
              exerciseId: 'exercise-back-extension-001', // Hyper Extension
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-r1b-5-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-r1b-5-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-r1b-5-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r1b-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-r1b-6',
              exerciseId: 'exercise-lat-overhead-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r1b-6-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-r1b-6-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r1b-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-r1b-7',
              exerciseId: 'exercise-childs-pose-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r1b-7-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 3. Wednesday: Chest
  static final _routine1Chest = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine1-chest-001',
      name: 'Routine 1: Wednesday Chest',
      description: 'Wednesday Routine | Comprehensive chest workout featuring push-ups, flat bench, flat DB press, incline DB press, and pec deck/flys.',
      currentRevisionId: 'rev-routine1-chest-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['chest', 'routine-1', 'push', 'hypertrophy'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine1-chest-001',
      templateId: 'template-routine1-chest-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release for Routine 1 Chest workout',
      blocks: [
        const WorkoutBlock(
          id: 'block-r1c-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-r1c-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r1c-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r1c-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-r1c-1',
              exerciseId: 'exercise-pushup-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r1c-1-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 7.5,
                ),
                TargetSet(
                  id: 'ts-r1c-1-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 7.5,
                ),
                TargetSet(
                  id: 'ts-r1c-1-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 7.5,
                ),
                TargetSet(
                  id: 'ts-r1c-1-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-r1c-1-5',
                  setNumber: 5,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-r1c-1-6',
                  setNumber: 6,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r1c-2',
              exerciseId: 'exercise-bench-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-r1c-2-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1c-2-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1c-2-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1c-2-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1c-2-5',
                  setNumber: 5,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r1c-3',
              exerciseId: 'exercise-db-bench-001',
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-r1c-3-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1c-3-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1c-3-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1c-3-4',
                  setNumber: 4,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r1c-4',
              exerciseId: 'exercise-incline-db-press-001',
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-r1c-4-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1c-4-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1c-4-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1c-4-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r1c-5',
              exerciseId: 'exercise-pec-deck-fly-001',
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-r1c-5-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r1c-5-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r1c-5-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r1c-5-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r1c-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-r1c-6',
              exerciseId: 'exercise-chest-doorway-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r1c-6-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
                TargetSet(
                  id: 'ts-r1c-6-2',
                  setNumber: 2,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r1c-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-r1c-7',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r1c-7-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 4. Thursday: Biceps
  static final _routine1Biceps = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine1-biceps-001',
      name: 'Routine 1: Thursday Biceps',
      description: 'Thursday Routine | High-volume bicep isolation routine featuring barbell curls, preacher curls, and dumbbell curls.',
      currentRevisionId: 'rev-routine1-biceps-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['biceps', 'routine-1', 'arms', 'hypertrophy'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine1-biceps-001',
      templateId: 'template-routine1-biceps-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release for Routine 1 Biceps workout',
      blocks: [
        const WorkoutBlock(
          id: 'block-r1bi-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-r1bi-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r1bi-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r1bi-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-r1bi-1',
              exerciseId: 'exercise-barbell-curl-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r1bi-1-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1bi-1-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1bi-1-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r1bi-1-4',
                  setNumber: 4,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r1bi-1-5',
                  setNumber: 5,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r1bi-2',
              exerciseId: 'exercise-preacher-curl-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-r1bi-2-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r1bi-2-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r1bi-2-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r1bi-2-4',
                  setNumber: 4,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r1bi-2-5',
                  setNumber: 5,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r1bi-3',
              exerciseId: 'exercise-db-curl-001',
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-r1bi-3-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r1bi-3-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r1bi-3-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r1bi-3-4',
                  setNumber: 4,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r1bi-3-5',
                  setNumber: 5,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r1bi-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-r1bi-4',
              exerciseId: 'exercise-lat-overhead-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r1bi-4-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r1bi-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-r1bi-5',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r1bi-5-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // ===================== 6-DAY ROUTINE TEMPLATES (Mon-Sat with Warm-ups & Cool-downs) =====================

  // 1. Monday: Shoulders
  static final _routineShoulders = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-shoulders-001',
      name: 'Routine 2: Monday Shoulders',
      description: 'Monday Routine | High-volume shoulder session covering front raises, lateral raises, upright rows, rear delts, military/behind-the-neck presses, and heavy shrugs, complete with warm-ups and cool-downs.',
      currentRevisionId: 'rev-routine-shoulders-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['shoulders', 'routine', 'hypertrophy'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-shoulders-001',
      templateId: 'template-routine-shoulders-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Monday Shoulders routine with warm-ups and cool-downs',
      blocks: [
        const WorkoutBlock(
          id: 'block-sh-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-sh-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sh-w1-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sh-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-sh-1',
              exerciseId: 'exercise-front-raise-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sh-1-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-sh-1-2',
                  setNumber: 2,
                  targetReps: 20,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-sh-1-3',
                  setNumber: 3,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sh-1-4',
                  setNumber: 4,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sh-2',
              exerciseId: 'exercise-lateral-raise-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-sh-2-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sh-2-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sh-2-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sh-2-4',
                  setNumber: 4,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sh-3',
              exerciseId: 'exercise-upright-row-001',
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-sh-3-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sh-3-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sh-3-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sh-4',
              exerciseId: 'exercise-rear-delt-fly-001',
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-sh-4-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sh-4-2',
                  setNumber: 2,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sh-4-3',
                  setNumber: 3,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sh-4-4',
                  setNumber: 4,
                  targetReps: 20,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sh-5',
              exerciseId: 'exercise-ohp-001',
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-sh-5-1',
                  setNumber: 1,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sh-5-2',
                  setNumber: 2,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sh-5-3',
                  setNumber: 3,
                  targetReps: 8,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-sh-5-4',
                  setNumber: 4,
                  targetReps: 8,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sh-6',
              exerciseId: 'exercise-behind-neck-press-001',
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-sh-6-1',
                  setNumber: 1,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sh-6-2',
                  setNumber: 2,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sh-6-3',
                  setNumber: 3,
                  targetReps: 8,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-sh-6-4',
                  setNumber: 4,
                  targetReps: 8,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sh-7',
              exerciseId: 'exercise-barbell-shrug-001',
              order: 7,
              targetSets: [
                TargetSet(
                  id: 'ts-sh-7-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sh-7-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sh-7-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-sh-7-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-sh-7-5',
                  setNumber: 5,
                  targetReps: 10,
                  targetRpe: 10.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sh-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-sh-c1',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sh-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sh-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-sh-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sh-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 2. Tuesday: Triceps
  static final _routineTriceps = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-triceps-001',
      name: 'Routine 2: Tuesday Triceps',
      description: 'Tuesday Routine | Dedicated arm session featuring rope pushdowns, skull crushers, bench dips, reverse pushdowns, pulley pushdowns, and kickbacks with warm-up and cool-down.',
      currentRevisionId: 'rev-routine-triceps-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['triceps', 'routine', 'arms'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-triceps-001',
      templateId: 'template-routine-triceps-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Tuesday Triceps routine with warm-ups and cool-downs',
      blocks: [
        const WorkoutBlock(
          id: 'block-r2-tr-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-r2-tr-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r2-tr-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r2-tr-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-r2-tr-1',
              exerciseId: 'exercise-rope-pushdown-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r2-tr-1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r2-tr-1-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r2-tr-1-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r2-tr-1-4',
                  setNumber: 4,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r2-tr-2',
              exerciseId: 'exercise-skull-crusher-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-r2-tr-2-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r2-tr-2-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r2-tr-2-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r2-tr-2-4',
                  setNumber: 4,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r2-tr-3',
              exerciseId: 'exercise-bench-dips-001',
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-r2-tr-3-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r2-tr-3-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r2-tr-3-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r2-tr-3-4',
                  setNumber: 4,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r2-tr-4',
              exerciseId: 'exercise-reverse-pushdown-001',
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-r2-tr-4-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r2-tr-4-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r2-tr-4-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r2-tr-4-4',
                  setNumber: 4,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r2-tr-5',
              exerciseId: 'exercise-tricep-pushdown-001',
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-r2-tr-5-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r2-tr-5-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r2-tr-5-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r2-tr-5-4',
                  setNumber: 4,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r2-tr-6',
              exerciseId: 'exercise-dumbbell-kickback-001',
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-r2-tr-6-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r2-tr-6-2',
                  setNumber: 2,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r2-tr-6-3',
                  setNumber: 3,
                  targetReps: 20,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r2-tr-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-r2-tr-c1',
              exerciseId: 'exercise-overhead-tricep-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r2-tr-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r2-tr-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-r2-tr-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r2-tr-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 3. Wednesday: Chest
  static final _routineChest = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-chest-001',
      name: 'Routine 2: Wednesday Chest',
      description: 'Wednesday Routine | Comprehensive chest volume including push-ups, incline/flat bench presses, dumbbell flys, decline presses, rising cable presses, and pullovers with warm-up and cool-down.',
      currentRevisionId: 'rev-routine-chest-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['chest', 'routine', 'push'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-chest-001',
      templateId: 'template-routine-chest-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Wednesday Chest routine with warm-ups and cool-downs',
      blocks: [
        const WorkoutBlock(
          id: 'block-ch-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-ch-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ch-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ch-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-ch-1',
              exerciseId: 'exercise-pushup-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ch-1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-ch-1-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-ch-1-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-ch-1-4',
                  setNumber: 4,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ch-2',
              exerciseId: 'exercise-incline-bench-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ch-2-1',
                  setNumber: 1,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ch-2-2',
                  setNumber: 2,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ch-2-3',
                  setNumber: 3,
                  targetReps: 8,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-ch-2-4',
                  setNumber: 4,
                  targetReps: 8,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ch-3',
              exerciseId: 'exercise-bench-001',
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-ch-3-1',
                  setNumber: 1,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ch-3-2',
                  setNumber: 2,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ch-3-3',
                  setNumber: 3,
                  targetReps: 8,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-ch-3-4',
                  setNumber: 4,
                  targetReps: 8,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ch-4',
              exerciseId: 'exercise-db-fly-001',
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-ch-4-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-ch-4-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-ch-4-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ch-5',
              exerciseId: 'exercise-incline-db-fly-001',
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-ch-5-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ch-5-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ch-5-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-ch-5-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ch-6',
              exerciseId: 'exercise-decline-bench-001',
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-ch-6-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-ch-6-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-ch-6-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ch-7',
              exerciseId: 'exercise-rising-cable-press-001',
              order: 7,
              targetSets: [
                TargetSet(
                  id: 'ts-ch-7-1',
                  setNumber: 1,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ch-7-2',
                  setNumber: 2,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ch-7-3',
                  setNumber: 3,
                  targetReps: 8,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-ch-7-4',
                  setNumber: 4,
                  targetReps: 8,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ch-8',
              exerciseId: 'exercise-dumbbell-pullover-001',
              order: 8,
              targetSets: [
                TargetSet(
                  id: 'ts-ch-8-1',
                  setNumber: 1,
                  targetReps: 4,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ch-8-2',
                  setNumber: 2,
                  targetReps: 4,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-ch-8-3',
                  setNumber: 3,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-ch-8-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ch-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-ch-c1',
              exerciseId: 'exercise-chest-doorway-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ch-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-ch-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-ch-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ch-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 4. Thursday: Biceps
  static final _routineBiceps = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-biceps-001',
      name: 'Routine 2: Thursday Biceps',
      description: 'Thursday Routine | High-intensity bicep builder incorporating dumbbell curls, barbell curls, close-grip EZ curls, wide-grip preacher curls, concentration curls, and hammer curls with warm-up and cool-down.',
      currentRevisionId: 'rev-routine-biceps-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['biceps', 'routine', 'arms'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-biceps-001',
      templateId: 'template-routine-biceps-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Thursday Biceps routine with warm-ups and cool-downs',
      blocks: [
        const WorkoutBlock(
          id: 'block-bi-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-bi-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-bi-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-bi-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-bi-1',
              exerciseId: 'exercise-db-curl-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-bi-1-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-bi-1-2',
                  setNumber: 2,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-bi-1-3',
                  setNumber: 3,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-bi-1-4',
                  setNumber: 4,
                  targetReps: 20,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-bi-1-5',
                  setNumber: 5,
                  targetReps: 20,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-bi-1-6',
                  setNumber: 6,
                  targetReps: 20,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-bi-1-7',
                  setNumber: 7,
                  targetReps: 20,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-bi-1-8',
                  setNumber: 8,
                  targetReps: 20,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-bi-1-9',
                  setNumber: 9,
                  targetReps: 20,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-bi-2',
              exerciseId: 'exercise-barbell-curl-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-bi-2-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-bi-2-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-bi-2-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-bi-2-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-bi-2-5',
                  setNumber: 5,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-bi-2-6',
                  setNumber: 6,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-bi-2-7',
                  setNumber: 7,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-bi-2-8',
                  setNumber: 8,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-bi-2-9',
                  setNumber: 9,
                  targetReps: 10,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-bi-3',
              exerciseId: 'exercise-ez-close-grip-curl-001',
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-bi-3-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-bi-3-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-bi-3-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-bi-3-4',
                  setNumber: 4,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-bi-4',
              exerciseId: 'exercise-preacher-curl-001',
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-bi-4-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-bi-4-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-bi-4-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-bi-4-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-bi-5',
              exerciseId: 'exercise-concentration-curl-001',
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-bi-5-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-bi-5-2',
                  setNumber: 2,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-bi-5-3',
                  setNumber: 3,
                  targetReps: 20,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-bi-5-4',
                  setNumber: 4,
                  targetReps: 20,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-bi-6',
              exerciseId: 'exercise-hammer-curl-001',
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-bi-6-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-bi-6-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-bi-6-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-bi-6-4',
                  setNumber: 4,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-bi-6-5',
                  setNumber: 5,
                  targetReps: 15,
                  targetRpe: 9.5,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-bi-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-bi-c1',
              exerciseId: 'exercise-lat-overhead-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-bi-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-bi-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-bi-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-bi-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 5. Friday: Back
  static final _routineBack = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-back-001',
      name: 'Routine 2: Friday Back',
      description: 'Friday Routine | Comprehensive back workout featuring pull-ups, front pulleys, behind-neck presses/rows, seated/single-arm/bent-over rows, heavy deadlifts, and hyperextensions with warm-up and cool-down.',
      currentRevisionId: 'rev-routine-back-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['back', 'routine', 'pull'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-back-001',
      templateId: 'template-routine-back-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Friday Back routine with warm-ups and cool-downs',
      blocks: [
        const WorkoutBlock(
          id: 'block-bk-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-bk-w1',
              exerciseId: 'exercise-cat-cow-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-bk-w1-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-bk-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-bk-1',
              exerciseId: 'exercise-pullup-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-bk-1-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-bk-1-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-bk-1-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-bk-1-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-bk-2',
              exerciseId: 'exercise-lat-pulldown-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-bk-2-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-bk-2-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-bk-2-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-bk-2-4',
                  setNumber: 4,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-bk-3',
              exerciseId: 'exercise-behind-neck-row-001',
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-bk-3-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-bk-3-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-bk-3-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-bk-4',
              exerciseId: 'exercise-seated-cable-row-001',
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-bk-4-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-bk-4-2',
                  setNumber: 2,
                  targetReps: 20,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-bk-4-3',
                  setNumber: 3,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-bk-4-4',
                  setNumber: 4,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-bk-5',
              exerciseId: 'exercise-single-arm-db-row-001',
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-bk-5-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-bk-5-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-bk-5-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-bk-6',
              exerciseId: 'exercise-row-001',
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-bk-6-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-bk-6-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-bk-6-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-bk-6-4',
                  setNumber: 4,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-bk-7',
              exerciseId: 'exercise-deadlift-001',
              order: 7,
              targetSets: [
                TargetSet(
                  id: 'ts-bk-7-1',
                  setNumber: 1,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-bk-7-2',
                  setNumber: 2,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-bk-7-3',
                  setNumber: 3,
                  targetReps: 8,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-bk-7-4',
                  setNumber: 4,
                  targetReps: 8,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-bk-8',
              exerciseId: 'exercise-back-extension-001',
              order: 8,
              targetSets: [
                TargetSet(
                  id: 'ts-bk-8-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-bk-8-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-bk-8-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-bk-8-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-bk-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-bk-c1',
              exerciseId: 'exercise-lat-overhead-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-bk-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-bk-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-bk-f1',
              exerciseId: 'exercise-childs-pose-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-bk-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 6. Saturday: Thighs / Lower
  static final _routineThighs = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-thighs-001',
      name: 'Routine 2: Saturday Thighs & Lower Body',
      description: 'Saturday Routine | Lower body session covering free bodyweight squats, weighted barbell squats, leg extensions, leg curls, heavy leg press, lunges, and high-rep calves with warm-up and cool-down.',
      currentRevisionId: 'rev-routine-thighs-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['legs', 'routine', 'lower-body'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-thighs-001',
      templateId: 'template-routine-thighs-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Saturday Thighs & Lower routine with warm-ups and cool-downs',
      blocks: [
        const WorkoutBlock(
          id: 'block-th-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-th-w1',
              exerciseId: 'exercise-bodyweight-squat-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-th-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-th-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-th-1',
              exerciseId: 'exercise-bodyweight-squat-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-th-1-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 7.5,
                ),
                TargetSet(
                  id: 'ts-th-1-2',
                  setNumber: 2,
                  targetReps: 20,
                  targetRpe: 7.5,
                ),
                TargetSet(
                  id: 'ts-th-1-3',
                  setNumber: 3,
                  targetReps: 20,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-th-1-4',
                  setNumber: 4,
                  targetReps: 20,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-th-1-5',
                  setNumber: 5,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-th-2',
              exerciseId: 'exercise-squat-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-th-2-1',
                  setNumber: 1,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-th-2-2',
                  setNumber: 2,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-th-2-3',
                  setNumber: 3,
                  targetReps: 8,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-th-2-4',
                  setNumber: 4,
                  targetReps: 8,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-th-3',
              exerciseId: 'exercise-leg-extension-001',
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-th-3-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-th-3-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-th-3-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-th-3-4',
                  setNumber: 4,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-th-4',
              exerciseId: 'exercise-lying-leg-curl-001',
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-th-4-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-th-4-2',
                  setNumber: 2,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-th-4-3',
                  setNumber: 3,
                  targetReps: 20,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-th-4-4',
                  setNumber: 4,
                  targetReps: 20,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-th-5',
              exerciseId: 'exercise-leg-press-001',
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-th-5-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-th-5-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-th-5-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-th-5-4',
                  setNumber: 4,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-th-6',
              exerciseId: 'exercise-walking-lunge-001',
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-th-6-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-th-6-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-th-6-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-th-6-4',
                  setNumber: 4,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-th-7',
              exerciseId: 'exercise-standing-calf-raise-001',
              order: 7,
              targetSets: [
                TargetSet(
                  id: 'ts-th-7-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-th-7-2',
                  setNumber: 2,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-th-7-3',
                  setNumber: 3,
                  targetReps: 20,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-th-7-4',
                  setNumber: 4,
                  targetReps: 20,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-th-7-5',
                  setNumber: 5,
                  targetReps: 20,
                  targetRpe: 9.5,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-th-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-th-c1',
              exerciseId: 'exercise-hamstring-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-th-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-th-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-th-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-th-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // ===================== 6-DAY ROUTINE TEMPLATES (Mon-Sat with Warm-ups & Cool-downs) =====================

  // 1. Monday: Back
  static final _routineMondayBack = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-monday-back-001',
      name: 'Routine 3: Monday Back',
      description: 'Monday Routine | Back and posterior chain session featuring pull-ups, hyper extensions, pulley draws, one-arm rows, and bent rows.',
      currentRevisionId: 'rev-routine-monday-back-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['back', 'routine', 'pull'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-monday-back-001',
      templateId: 'template-routine-monday-back-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Monday Back routine with integrated warm-ups and cool-downs',
      blocks: [
        const WorkoutBlock(
          id: 'block-mon-bk-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-mon-bk-w1',
              exerciseId: 'exercise-cat-cow-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-mon-bk-w1-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-mon-bk-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-mon-bk-1',
              exerciseId: 'exercise-pullup-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-mon-bk-1-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-bk-1-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-bk-1-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-bk-1-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-bk-1-5',
                  setNumber: 5,
                  targetReps: 5,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-mon-bk-2',
              exerciseId: 'exercise-back-extension-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-mon-bk-2-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-mon-bk-3',
              exerciseId: 'exercise-seated-cable-row-001', // Pulley Draw
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-mon-bk-3-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-mon-bk-3-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-mon-bk-3-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-bk-3-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-bk-3-5',
                  setNumber: 5,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-mon-bk-4',
              exerciseId: 'exercise-single-arm-db-row-001',
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-mon-bk-4-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-mon-bk-4-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-bk-4-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-bk-4-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-mon-bk-5',
              exerciseId: 'exercise-row-001',
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-mon-bk-5-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-mon-bk-5-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-bk-5-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-mon-bk-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-mon-bk-c1',
              exerciseId: 'exercise-lat-overhead-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-mon-bk-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-mon-bk-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-mon-bk-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-mon-bk-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 2. Tuesday: Biceps & Abdomen
  static final _routineTuesdayBiceps = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-tuesday-biceps-001',
      name: 'Routine 3: Tuesday Biceps & Abdomen',
      description: 'Tuesday Routine | Arm and abdomen session featuring dumbbell curls, 21s abdomen/bicep work, barbell curls, and hammer curls.',
      currentRevisionId: 'rev-routine-tuesday-biceps-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['biceps', 'abdomen', 'routine', 'arms'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-tuesday-biceps-001',
      templateId: 'template-routine-tuesday-biceps-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Tuesday Biceps & Abdomen routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-tue-bi-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-tue-bi-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-tue-bi-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-tue-bi-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-tue-bi-1',
              exerciseId: 'exercise-db-curl-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-tue-bi-1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-tue-bi-1-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-tue-bi-1-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-tue-bi-1-4',
                  setNumber: 4,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tue-bi-2',
              exerciseId: 'exercise-hanging-leg-raise-001', // Abdomen (21s / core focus)
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-tue-bi-2-1',
                  setNumber: 1,
                  targetReps: 21,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tue-bi-3',
              exerciseId: 'exercise-barbell-curl-001',
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-tue-bi-3-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-tue-bi-3-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-tue-bi-3-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-tue-bi-3-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tue-bi-4',
              exerciseId: 'exercise-hammer-curl-001',
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-tue-bi-4-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-tue-bi-4-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-tue-bi-4-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-tue-bi-4-4',
                  setNumber: 4,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-tue-bi-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-tue-bi-c1',
              exerciseId: 'exercise-lat-overhead-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-tue-bi-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-tue-bi-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-tue-bi-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-tue-bi-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 3. Wednesday: Chest
  static final _routineWednesdayChest = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-wednesday-chest-001',
      name: 'Routine 3: Wednesday Chest',
      description: 'Wednesday Routine | Pectoral session featuring weighted push-ups, height push-ups, and butterfly flys.',
      currentRevisionId: 'rev-routine-wednesday-chest-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['chest', 'routine', 'push'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-wednesday-chest-001',
      templateId: 'template-routine-wednesday-chest-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Wednesday Chest routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-wed-ch-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-wed-ch-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-ch-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-wed-ch-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-wed-ch-1',
              exerciseId: 'exercise-pushup-001', // Weighted pushup variant
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-ch-1-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-ch-1-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-ch-1-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-wed-ch-1-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-wed-ch-2',
              exerciseId: 'exercise-pushup-001', // Height pushup
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-ch-2-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-ch-2-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-ch-2-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-wed-ch-2-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-wed-ch-3',
              exerciseId: 'exercise-pec-deck-fly-001', // Butterfly
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-ch-3-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-wed-ch-3-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-wed-ch-3-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-ch-3-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-wed-ch-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-wed-ch-c1',
              exerciseId: 'exercise-chest-doorway-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-ch-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-wed-ch-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-wed-ch-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-ch-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 4. Thursday: Triceps & Core
  static final _routineThursdayTriceps = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-thursday-triceps-001',
      name: 'Routine 3: Thursday Triceps & Core',
      description: 'Thursday Routine | Tricep isolation and integrated core/hyper-extension work featuring rope pushdowns, reverse pushdowns, hyper extensions, and kickbacks.',
      currentRevisionId: 'rev-routine-thursday-triceps-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['triceps', 'routine', 'arms'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-thursday-triceps-001',
      templateId: 'template-routine-thursday-triceps-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Thursday Triceps routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-thu-tr-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-thu-tr-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-thu-tr-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-thu-tr-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-thu-tr-1',
              exerciseId: 'exercise-rope-pushdown-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-thu-tr-1-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-thu-tr-1-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-thu-tr-1-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-thu-tr-1-4',
                  setNumber: 4,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-thu-tr-2',
              exerciseId: 'exercise-hanging-leg-raise-001', // Abdomen inclusion
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-thu-tr-2-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-thu-tr-3',
              exerciseId: 'exercise-reverse-pushdown-001',
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-thu-tr-3-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-thu-tr-3-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-thu-tr-3-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-thu-tr-3-4',
                  setNumber: 4,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-thu-tr-4',
              exerciseId:
                  'exercise-back-extension-001', // Hyper Extension inclusion
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-thu-tr-4-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-thu-tr-5',
              exerciseId: 'exercise-dumbbell-kickback-001',
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-thu-tr-5-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-thu-tr-5-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-thu-tr-5-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-thu-tr-5-4',
                  setNumber: 4,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-thu-tr-5-5',
                  setNumber: 5,
                  targetReps: 15,
                  targetRpe: 9.5,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-thu-tr-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-thu-tr-c1',
              exerciseId: 'exercise-overhead-tricep-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-thu-tr-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-thu-tr-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-thu-tr-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-thu-tr-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 5. Friday: Shoulders & Core
  static final _routineFridayShoulders = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-friday-shoulders-001',
      name: 'Routine 3: Friday Shoulders & Core',
      description: 'Friday Routine | Shoulder isolation and pressing session featuring behind-the-neck presses, abdomen work, side lateral raises, and upright rows.',
      currentRevisionId: 'rev-routine-friday-shoulders-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['shoulders', 'routine', 'hypertrophy'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-friday-shoulders-001',
      templateId: 'template-routine-friday-shoulders-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Friday Shoulders routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-fri-sh-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-fri-sh-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-sh-w1-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-fri-sh-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-fri-sh-1',
              exerciseId: 'exercise-behind-neck-press-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-sh-1-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-fri-sh-1-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-fri-sh-1-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fri-sh-2',
              exerciseId: 'exercise-hanging-leg-raise-001', // Abdomen inclusion
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-sh-2-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fri-sh-3',
              exerciseId: 'exercise-lateral-raise-001',
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-sh-3-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-fri-sh-3-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-fri-sh-3-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fri-sh-4',
              exerciseId: 'exercise-upright-row-001',
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-sh-4-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-fri-sh-4-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-fri-sh-4-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-fri-sh-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-fri-sh-c1',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-sh-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-fri-sh-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-fri-sh-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-sh-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 6. Saturday: Legs & Lower Body
  static final _routineSaturdayLegs = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-saturday-legs-001',
      name: 'Routine 3: Saturday Legs & Lower Body',
      description: 'Saturday Routine | Lower body workout including thigh press, hyper extensions, leg extensions, lunges, and calf raises.',
      currentRevisionId: 'rev-routine-saturday-legs-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['legs', 'routine', 'lower-body'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-saturday-legs-001',
      templateId: 'template-routine-saturday-legs-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Saturday Legs routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-sat-lg-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-sat-lg-w1',
              exerciseId: 'exercise-bodyweight-squat-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-lg-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sat-lg-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-sat-lg-1',
              exerciseId: 'exercise-leg-press-001', // Thigh Press
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-lg-1-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sat-lg-1-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sat-lg-1-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-lg-1-4',
                  setNumber: 4,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sat-lg-2',
              exerciseId:
                  'exercise-back-extension-001', // Hyper Extension inclusion
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-lg-2-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sat-lg-3',
              exerciseId: 'exercise-leg-extension-001',
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-lg-3-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sat-lg-3-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sat-lg-3-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-lg-3-4',
                  setNumber: 4,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sat-lg-4',
              exerciseId: 'exercise-walking-lunge-001',
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-lg-4-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sat-lg-4-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sat-lg-4-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sat-lg-5',
              exerciseId: 'exercise-standing-calf-raise-001',
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-lg-5-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sat-lg-5-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sat-lg-5-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sat-lg-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-sat-lg-c1',
              exerciseId: 'exercise-hamstring-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-lg-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sat-lg-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-sat-lg-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-lg-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // ===================== 6-DAY ROUTINE TEMPLATES (Mon-Sat with Warm-ups, Core, & Cool-downs) =====================

  // 1. Monday: Back & Core
  static final _routine4MondayBackCore = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine4-monday-back-core-001',
      name: 'Routine 4: Monday Back & Core',
      description: 'Monday Routine | Pull session featuring pull-ups, abdomen work (skipping + side bends), seated rowing, reverse close grip, one-arm rowing, behind neck rows, and hyper extensions.',
      currentRevisionId: 'rev-routine4-monday-back-core-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['back', 'core', 'routine', 'pull'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine4-monday-back-core-001',
      templateId: 'template-routine4-monday-back-core-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Monday Back & Core routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-r4-mon-bk-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-r4-mon-bk-w1',
              exerciseId: 'exercise-cat-cow-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-mon-bk-w1-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r4-mon-bk-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-r4-mon-bk-1',
              exerciseId: 'exercise-pullup-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-mon-bk-1-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-1-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-1-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-1-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-1-5',
                  setNumber: 5,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r4-mon-bk-2',
              exerciseId: 'exercise-hanging-leg-raise-001', // Abdomen (Skipping + Sidebend)
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-mon-bk-2-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-2-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-2-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-2-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-2-5',
                  setNumber: 5,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r4-mon-bk-3',
              exerciseId: 'exercise-seated-cable-row-001',
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-mon-bk-3-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-3-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-3-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-3-4',
                  setNumber: 4,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r4-mon-bk-4',
              exerciseId: 'exercise-neutral-grip-lat-pulldown-001', // Reverse Close Grip
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-mon-bk-4-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-4-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-4-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-4-4',
                  setNumber: 4,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r4-mon-bk-5',
              exerciseId: 'exercise-single-arm-db-row-001',
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-mon-bk-5-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-5-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-5-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-5-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-5-5',
                  setNumber: 5,
                  targetReps: 10,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r4-mon-bk-6',
              exerciseId: 'exercise-behind-neck-row-001',
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-mon-bk-6-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-6-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-6-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-6-4',
                  setNumber: 4,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-6-5',
                  setNumber: 5,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r4-mon-bk-7',
              exerciseId: 'exercise-back-extension-001',
              order: 7,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-mon-bk-7-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-7-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-7-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-7-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r4-mon-bk-7-5',
                  setNumber: 5,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r4-mon-bk-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-r4-mon-bk-c1',
              exerciseId: 'exercise-lat-overhead-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-mon-bk-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r4-mon-bk-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-r4-mon-bk-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-mon-bk-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 2. Tuesday: Biceps & Core
  static final _routine4TuesdayBicepsCore = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine4-tuesday-biceps-core-001',
      name: 'Routine 4: Tuesday Biceps & Core',
      description: 'Tuesday Routine | Arm and core session featuring inclined sitting dumbbell curls, abdominal crunches, hammer curls, low pulley barbell curls, wide-grip preacher curls, concentration curls, and heavy dumbbell curls.',
      currentRevisionId: 'rev-routine4-tuesday-biceps-core-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['biceps', 'core', 'routine', 'arms'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine4-tuesday-biceps-core-001',
      templateId: 'template-routine4-tuesday-biceps-core-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Tuesday Biceps & Core routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-r4-tue-bi-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-r4-tue-bi-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-tue-bi-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r4-tue-bi-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-r4-tue-bi-1',
              exerciseId: 'exercise-incline-db-bicep-curl-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-tue-bi-1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r4-tue-bi-1-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r4-tue-bi-1-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-tue-bi-1-4',
                  setNumber: 4,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r4-tue-bi-2',
              exerciseId: 'exercise-cable-ab-crunch-001', // Abdomen Crunches
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-tue-bi-2-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r4-tue-bi-3',
              exerciseId: 'exercise-hammer-curl-001',
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-tue-bi-3-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r4-tue-bi-3-2',
                  setNumber: 2,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r4-tue-bi-3-3',
                  setNumber: 3,
                  targetReps: 20,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-tue-bi-3-4',
                  setNumber: 4,
                  targetReps: 20,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-tue-bi-3-5',
                  setNumber: 5,
                  targetReps: 20,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r4-tue-bi-4',
              exerciseId: 'exercise-barbell-curl-001', // Low Pulley Barbell
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-tue-bi-4-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-tue-bi-4-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-tue-bi-4-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r4-tue-bi-4-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r4-tue-bi-5',
              exerciseId: 'exercise-preacher-curl-001', // Wide Grip Preacher
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-tue-bi-5-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-tue-bi-5-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-tue-bi-5-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r4-tue-bi-5-4',
                  setNumber: 4,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r4-tue-bi-5-5',
                  setNumber: 5,
                  targetReps: 12,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r4-tue-bi-6',
              exerciseId:
                  'exercise-db-preacher-curl-single-001', // Concentration Curl
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-tue-bi-6-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r4-tue-bi-6-2',
                  setNumber: 2,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r4-tue-bi-6-3',
                  setNumber: 3,
                  targetReps: 20,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-tue-bi-6-4',
                  setNumber: 4,
                  targetReps: 20,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-tue-bi-6-5',
                  setNumber: 5,
                  targetReps: 20,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r4-tue-bi-7',
              exerciseId: 'exercise-db-curl-001', // Heavy Dumbbell Curl
              order: 7,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-tue-bi-7-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-tue-bi-7-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-tue-bi-7-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r4-tue-bi-7-4',
                  setNumber: 4,
                  targetReps: 15,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r4-tue-bi-7-5',
                  setNumber: 5,
                  targetReps: 15,
                  targetRpe: 10.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r4-tue-bi-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-r4-tue-bi-c1',
              exerciseId: 'exercise-lat-overhead-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-tue-bi-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r4-tue-bi-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-r4-tue-bi-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-tue-bi-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 3. Wednesday: Shoulders & Core
  static final _routineWednesdayShoulders = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-wednesday-shoulders-001',
      name: 'Routine 4: Wednesday Shoulders & Core',
      description: 'Wednesday Routine | Shoulder volume featuring heavy front raises, abdominal crunches, upright rows, side lateral raises, heavy military barbell press, dumbbell shoulder presses, and bent-over rear delt work.',
      currentRevisionId: 'rev-routine-wednesday-shoulders-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['shoulders', 'core', 'routine', 'hypertrophy'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-wednesday-shoulders-001',
      templateId: 'template-routine-wednesday-shoulders-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Wednesday Shoulders & Core routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-wed-sh-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-wed-sh-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-sh-w1-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-wed-sh-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-wed-sh-1',
              exerciseId: 'exercise-front-raise-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-sh-1-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-wed-sh-1-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-wed-sh-1-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-sh-1-4',
                  setNumber: 4,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-wed-sh-2',
              exerciseId: 'exercise-cable-ab-crunch-001', // Abdomen Crunches
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-sh-2-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-wed-sh-3',
              exerciseId: 'exercise-upright-row-001',
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-sh-3-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-wed-sh-3-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-wed-sh-3-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-sh-3-4',
                  setNumber: 4,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-sh-3-5',
                  setNumber: 5,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-wed-sh-4',
              exerciseId: 'exercise-lateral-raise-001',
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-sh-4-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-wed-sh-4-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-wed-sh-4-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-sh-4-4',
                  setNumber: 4,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-sh-4-5',
                  setNumber: 5,
                  targetReps: 15,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-wed-sh-5',
              exerciseId: 'exercise-ohp-001', // Military Press Barbell
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-sh-5-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-sh-5-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-sh-5-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-wed-sh-5-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-wed-sh-6',
              exerciseId:
                  'exercise-seated-db-press-001', // Dumbbell Shoulder Press
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-sh-6-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-sh-6-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-sh-6-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-wed-sh-6-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-wed-sh-6-5',
                  setNumber: 5,
                  targetReps: 10,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-wed-sh-7',
              exerciseId: 'exercise-rear-delt-fly-001', // Bent Over Rear Delt
              order: 7,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-sh-7-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-wed-sh-7-2',
                  setNumber: 2,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-wed-sh-7-3',
                  setNumber: 3,
                  targetReps: 20,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-sh-7-4',
                  setNumber: 4,
                  targetReps: 20,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-wed-sh-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-wed-sh-c1',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-sh-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-wed-sh-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-wed-sh-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-sh-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 4. Thursday: Triceps & Core
  static final _routine4ThursdayTricepsCore = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine4-thursday-triceps-core-001',
      name: 'Routine 4: Thursday Triceps & Core',
      description: 'Thursday Routine | Tricep isolation and integrated core/hyper-extension work featuring close grip pushups, leg raises/twisters, skull crushers, hyper extensions, overhead extensions, close grip bench, pulley pushdowns, and bench triceps.',
      currentRevisionId: 'rev-routine4-thursday-triceps-core-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['triceps', 'core', 'routine', 'arms'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine4-thursday-triceps-core-001',
      templateId: 'template-routine4-thursday-triceps-core-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Thursday Triceps & Core routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-r4-thu-tr-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-r4-thu-tr-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-thu-tr-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r4-thu-tr-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-r4-thu-tr-1',
              exerciseId:
                  'exercise-pushup-001', // Close Grip Push (Diamond Push)
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-thu-tr-1-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-r4-thu-tr-1-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-r4-thu-tr-1-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r4-thu-tr-2',
              exerciseId: 'exercise-hanging-leg-raise-001', // Abdomen (Leg Raise + Twister)
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-thu-tr-2-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r4-thu-tr-3',
              exerciseId: 'exercise-skull-crusher-001',
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-thu-tr-3-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-thu-tr-3-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-thu-tr-3-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r4-thu-tr-3-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r4-thu-tr-4',
              exerciseId:
                  'exercise-back-extension-001', // Hyper Extension (3xMax)
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-thu-tr-4-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-thu-tr-4-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r4-thu-tr-4-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r4-thu-tr-5',
              exerciseId: 'exercise-overhead-tricep-extension-001', // Overhead Extension (Both Hand)
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-thu-tr-5-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-thu-tr-5-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-thu-tr-5-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r4-thu-tr-5-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r4-thu-tr-6',
              exerciseId: 'exercise-close-grip-bench-001', // Close Grip Bench
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-thu-tr-6-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r4-thu-tr-6-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r4-thu-tr-6-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-thu-tr-6-4',
                  setNumber: 4,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r4-thu-tr-7',
              exerciseId: 'exercise-tricep-pushdown-001', // Pulley Pushdown
              order: 7,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-thu-tr-7-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-thu-tr-7-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-thu-tr-7-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r4-thu-tr-7-4',
                  setNumber: 4,
                  targetReps: 15,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r4-thu-tr-7-5',
                  setNumber: 5,
                  targetReps: 15,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r4-thu-tr-8',
              exerciseId: 'exercise-dips-001', // Bench Triceps
              order: 8,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-thu-tr-8-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-thu-tr-8-2',
                  setNumber: 2,
                  targetReps: 20,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r4-thu-tr-8-3',
                  setNumber: 3,
                  targetReps: 20,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r4-thu-tr-8-4',
                  setNumber: 4,
                  targetReps: 20,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r4-thu-tr-8-5',
                  setNumber: 5,
                  targetReps: 20,
                  targetRpe: 10.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r4-thu-tr-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-r4-thu-tr-c1',
              exerciseId: 'exercise-overhead-tricep-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-thu-tr-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r4-thu-tr-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-r4-thu-tr-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r4-thu-tr-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 5. Friday: Lower Body (Interchangeable with Saturday)
  static final _routineFridayLower = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-friday-lower-001',
      name: 'Routine 4: Friday Lower Body',
      description: 'Friday Routine | Lower body session featuring free squats, leg extensions, weighted squats, thigh presses, walking lunges, and calf raises.',
      currentRevisionId: 'rev-routine-friday-lower-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['legs', 'routine', 'lower-body'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-friday-lower-001',
      templateId: 'template-routine-friday-lower-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Friday Lower Body routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-fri-lw-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-fri-lw-w1',
              exerciseId: 'exercise-bodyweight-squat-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-lw-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-fri-lw-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-fri-lw-1',
              exerciseId: 'exercise-bodyweight-squat-001', // Free Squat
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-lw-1-1',
                  setNumber: 1,
                  targetReps: 50,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-fri-lw-1-2',
                  setNumber: 2,
                  targetReps: 50,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-fri-lw-1-3',
                  setNumber: 3,
                  targetReps: 50,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fri-lw-2',
              exerciseId: 'exercise-leg-extension-001',
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-lw-2-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-fri-lw-2-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-fri-lw-2-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-fri-lw-2-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fri-lw-3',
              exerciseId: 'exercise-squat-001', // Weight Squat
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-lw-3-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-fri-lw-3-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-fri-lw-3-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-fri-lw-3-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fri-lw-4',
              exerciseId: 'exercise-leg-press-001', // Thigh Press
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-lw-4-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-fri-lw-4-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-fri-lw-4-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-fri-lw-4-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fri-lw-5',
              exerciseId: 'exercise-walking-lunge-001',
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-lw-5-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-fri-lw-5-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-fri-lw-5-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-fri-lw-5-4',
                  setNumber: 4,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-fri-lw-5-5',
                  setNumber: 5,
                  targetReps: 15,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fri-lw-6',
              exerciseId: 'exercise-standing-calf-raise-001', // Calf Raise + Dumbbell Calf Raise
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-lw-6-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-fri-lw-6-2',
                  setNumber: 2,
                  targetReps: 20,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-fri-lw-6-3',
                  setNumber: 3,
                  targetReps: 20,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-fri-lw-6-4',
                  setNumber: 4,
                  targetReps: 20,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-fri-lw-6-5',
                  setNumber: 5,
                  targetReps: 20,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-fri-lw-6-6',
                  setNumber: 6,
                  targetReps: 20,
                  targetRpe: 9.5,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-fri-lw-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-fri-lw-c1',
              exerciseId: 'exercise-hamstring-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-lw-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-fri-lw-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-fri-lw-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-lw-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 6. Saturday: Chest (Interchangeable with Friday)
  static final _routineSaturdayChest = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-saturday-chest-001',
      name: 'Routine 4: Saturday Chest',
      description: 'Saturday Routine | Massive chest volume featuring flat bench, flat DB press, incline barbell, incline flys, decline barbell/flys, pushups, butterfly/bench flys, rising cable presses, and pullovers.',
      currentRevisionId: 'rev-routine-saturday-chest-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['chest', 'routine', 'push'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-saturday-chest-001',
      templateId: 'template-routine-saturday-chest-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Saturday Chest routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-sat-ch-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-sat-ch-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-ch-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sat-ch-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-sat-ch-1',
              exerciseId: 'exercise-bench-001', // Flat Bench
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-ch-1-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-ch-1-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-ch-1-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-sat-ch-1-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-sat-ch-1-5',
                  setNumber: 5,
                  targetReps: 10,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sat-ch-2',
              exerciseId: 'exercise-db-bench-001', // Flat Bench Dumbbell Press
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-ch-2-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-ch-2-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-ch-2-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sat-ch-3',
              exerciseId: 'exercise-incline-bench-001', // Incline Barbell Press
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-ch-3-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-ch-3-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-ch-3-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-sat-ch-3-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-sat-ch-3-5',
                  setNumber: 5,
                  targetReps: 10,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sat-ch-4',
              exerciseId: 'exercise-incline-db-fly-001', // Incline Fly
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-ch-4-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sat-ch-4-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sat-ch-4-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-ch-4-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sat-ch-5',
              exerciseId: 'exercise-decline-bench-001', // Decline Barbell
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-ch-5-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-ch-5-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-ch-5-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sat-ch-6',
              exerciseId: 'exercise-db-fly-001', // Decline Fly
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-ch-6-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sat-ch-6-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sat-ch-6-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sat-ch-7',
              exerciseId: 'exercise-pushup-001', // Pushup
              order: 7,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-ch-7-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-sat-ch-7-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-sat-ch-7-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sat-ch-7-4',
                  setNumber: 4,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sat-ch-7-5',
                  setNumber: 5,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sat-ch-8',
              exerciseId: 'exercise-pec-deck-fly-001', // Butterfly / Bench Fly
              order: 8,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-ch-8-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sat-ch-8-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sat-ch-8-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-ch-8-4',
                  setNumber: 4,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-ch-8-5',
                  setNumber: 5,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sat-ch-9',
              exerciseId: 'exercise-rising-cable-press-001', // Rising
              order: 9,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-ch-9-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-ch-9-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-ch-9-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sat-ch-10',
              exerciseId: 'exercise-dumbbell-pullover-001', // Pullover
              order: 10,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-ch-10-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-ch-10-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-ch-10-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sat-ch-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-sat-ch-c1',
              exerciseId: 'exercise-chest-doorway-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-ch-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sat-ch-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-sat-ch-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-ch-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // ===================== 6-DAY ROUTINE TEMPLATES (Mon-Sat with Warm-ups & Cool-downs) =====================

  // 1. Monday: Back
  static final _routine5MondayBack = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine5-monday-back-001',
      name: 'Routine 5: Monday Back',
      description: 'Monday Routine | Pull session featuring pull-ups, behind neck rows, front pulleys, one-arm rowing, seated rowing, bent rowing, and hyper extensions.',
      currentRevisionId: 'rev-routine5-monday-back-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['back', 'routine', 'pull'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine5-monday-back-001',
      templateId: 'template-routine5-monday-back-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Monday Back routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-r5-mon-bk-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-r5-mon-bk-w1',
              exerciseId: 'exercise-cat-cow-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-mon-bk-w1-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r5-mon-bk-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-r5-mon-bk-1',
              exerciseId: 'exercise-pullup-001', // Pullups
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-mon-bk-1-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-mon-bk-1-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-mon-bk-1-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-mon-bk-1-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
                TargetSet(
                  id: 'ts-r5-mon-bk-1-5',
                  setNumber: 5,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-mon-bk-2',
              exerciseId: 'exercise-behind-neck-row-001', // Behind Neck
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-mon-bk-2-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r5-mon-bk-2-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r5-mon-bk-2-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-mon-bk-2-4',
                  setNumber: 4,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-mon-bk-2-5',
                  setNumber: 5,
                  targetReps: 15,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-mon-bk-3',
              exerciseId: 'exercise-lat-pulldown-001', // Front Pulley
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-mon-bk-3-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r5-mon-bk-3-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r5-mon-bk-3-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-mon-bk-3-4',
                  setNumber: 4,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-mon-bk-3-5',
                  setNumber: 5,
                  targetReps: 15,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-mon-bk-4',
              exerciseId: 'exercise-single-arm-db-row-001', // One Arm Rowing
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-mon-bk-4-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-mon-bk-4-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-mon-bk-4-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-mon-bk-4-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-mon-bk-5',
              exerciseId: 'exercise-seated-cable-row-001', // Sitted Rowing
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-mon-bk-5-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-mon-bk-5-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-mon-bk-5-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-mon-bk-5-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-mon-bk-6',
              exerciseId: 'exercise-row-001', // Bent Rowing
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-mon-bk-6-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-mon-bk-6-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-mon-bk-6-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-mon-bk-6-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-mon-bk-7',
              exerciseId: 'exercise-back-extension-001', // Hyper Extension
              order: 7,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-mon-bk-7-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-mon-bk-7-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-mon-bk-7-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r5-mon-bk-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-r5-mon-bk-c1',
              exerciseId: 'exercise-lat-overhead-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-mon-bk-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r5-mon-bk-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-r5-mon-bk-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-mon-bk-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 2. Tuesday: Biceps
  static final _routine5TuesdayBiceps = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine5-tuesday-biceps-001',
      name: 'Routine 5: Tuesday Biceps',
      description: 'Tuesday Routine | Arm session featuring dumbbell warm-ups, EZ close-grip curls, wide-grip barbell curls, one-arm preacher curls, low pulley curls, concentration curls, and reverse barbell curls.',
      currentRevisionId: 'rev-routine5-tuesday-biceps-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['biceps', 'routine', 'arms'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine5-tuesday-biceps-001',
      templateId: 'template-routine5-tuesday-biceps-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Tuesday Biceps routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-r5-tue-bi-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-r5-tue-bi-w1',
              exerciseId: 'exercise-db-curl-001', // Warmup - Dumbbell
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-tue-bi-w1-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r5-tue-bi-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-r5-tue-bi-1',
              exerciseId: 'exercise-ez-close-grip-curl-001', // EZ Close Grip
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-tue-bi-1-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-tue-bi-1-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-tue-bi-1-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-tue-bi-1-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-tue-bi-1-5',
                  setNumber: 5,
                  targetReps: 5,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-tue-bi-2',
              exerciseId: 'exercise-barbell-curl-001', // Wide Grip Barbell
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-tue-bi-2-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-tue-bi-2-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-tue-bi-2-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-tue-bi-2-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-tue-bi-2-5',
                  setNumber: 5,
                  targetReps: 5,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-tue-bi-3',
              exerciseId: 'exercise-db-preacher-curl-single-001', // One Arm Preacher Dumbbell
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-tue-bi-3-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-tue-bi-3-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-tue-bi-3-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-tue-bi-3-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-tue-bi-3-5',
                  setNumber: 5,
                  targetReps: 5,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-tue-bi-4',
              exerciseId: 'exercise-barbell-curl-001', // Low Pulley
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-tue-bi-4-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-tue-bi-4-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-tue-bi-4-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-tue-bi-4-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-tue-bi-4-5',
                  setNumber: 5,
                  targetReps: 5,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-tue-bi-5',
              exerciseId: 'exercise-db-preacher-curl-single-001', // Concenteration Dumbbell
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-tue-bi-5-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-tue-bi-5-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-tue-bi-5-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-tue-bi-5-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-tue-bi-5-5',
                  setNumber: 5,
                  targetReps: 5,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-tue-bi-6',
              exerciseId: 'exercise-barbell-curl-001', // Reverse Barbell
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-tue-bi-6-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-tue-bi-6-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-tue-bi-6-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r5-tue-bi-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-r5-tue-bi-c1',
              exerciseId: 'exercise-lat-overhead-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-tue-bi-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r5-tue-bi-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-r5-tue-bi-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-tue-bi-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 3. Wednesday: Shoulder
  static final _routineWednesdayShoulder = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-wednesday-shoulder-001',
      name: 'Routine 5: Wednesday Shoulders',
      description: 'Wednesday Routine | Shoulder session featuring dumbbell presses, behind-the-neck barbell presses, side reverse flies, upright rows, and shrugs.',
      currentRevisionId: 'rev-routine-wednesday-shoulder-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['shoulders', 'routine', 'hypertrophy'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-wednesday-shoulder-001',
      templateId: 'template-routine-wednesday-shoulder-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Wednesday Shoulder routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-r5-wed-sh-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-r5-wed-sh-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-wed-sh-w1-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r5-wed-sh-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-r5-wed-sh-1',
              exerciseId: 'exercise-seated-db-press-001', // Shoulder Dumb Press
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-wed-sh-1-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-wed-sh-1-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-wed-sh-1-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-wed-sh-2',
              exerciseId:
                  'exercise-behind-neck-press-001', // Behind Neck Barbell
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-wed-sh-2-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-wed-sh-2-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-wed-sh-2-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-wed-sh-2-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-wed-sh-2-5',
                  setNumber: 5,
                  targetReps: 5,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-wed-sh-3',
              exerciseId: 'exercise-rear-delt-fly-001', // Side Reverse
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-wed-sh-3-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-wed-sh-3-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-wed-sh-3-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-wed-sh-3-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-wed-sh-3-5',
                  setNumber: 5,
                  targetReps: 5,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-wed-sh-4',
              exerciseId: 'exercise-upright-row-001', // Upright
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-wed-sh-4-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-wed-sh-4-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-wed-sh-4-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-wed-sh-4-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-wed-sh-5',
              exerciseId: 'exercise-barbell-shrug-001', // Shrugs
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-wed-sh-5-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-wed-sh-5-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-wed-sh-5-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-wed-sh-5-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 10.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r5-wed-sh-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-r5-wed-sh-c1',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-wed-sh-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r5-wed-sh-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-r5-wed-sh-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-wed-sh-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 4. Thursday: Tricep
  static final _routineThursdayTricep = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-thursday-tricep-001',
      name: 'Routine 5: Thursday Triceps',
      description: 'Thursday Routine | Tricep isolation session featuring bent over head extensions, single-arm overhead extensions, pushdown rods, reverse pushdowns, bench dips, and diamond pushups.',
      currentRevisionId: 'rev-routine-thursday-tricep-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['triceps', 'routine', 'arms'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-thursday-tricep-001',
      templateId: 'template-routine-thursday-tricep-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Thursday Tricep routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-r5-thu-tr-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-r5-thu-tr-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-thu-tr-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r5-thu-tr-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-r5-thu-tr-1',
              exerciseId: 'exercise-overhead-tricep-extension-001', // Bent Over Head Extension
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-thu-tr-1-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-thu-tr-1-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-thu-tr-1-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-thu-tr-1-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-thu-tr-1-5',
                  setNumber: 5,
                  targetReps: 5,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-thu-tr-2',
              exerciseId: 'exercise-overhead-tricep-extension-001', // Single Arm Over Head
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-thu-tr-2-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-thu-tr-2-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-thu-tr-2-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-thu-tr-2-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-thu-tr-2-5',
                  setNumber: 5,
                  targetReps: 5,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-thu-tr-3',
              exerciseId: 'exercise-tricep-pushdown-001', // Pushdown Rod
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-thu-tr-3-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-thu-tr-3-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-thu-tr-3-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-thu-tr-3-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-thu-tr-3-5',
                  setNumber: 5,
                  targetReps: 5,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-thu-tr-4',
              exerciseId: 'exercise-reverse-pushdown-001', // Reverse Psuhdown
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-thu-tr-4-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-thu-tr-4-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-thu-tr-4-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-thu-tr-4-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-thu-tr-4-5',
                  setNumber: 5,
                  targetReps: 5,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-thu-tr-5',
              exerciseId: 'exercise-dips-001', // Bench Dips
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-thu-tr-5-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-thu-tr-5-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-thu-tr-5-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-thu-tr-5-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-thu-tr-5-5',
                  setNumber: 5,
                  targetReps: 5,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-thu-tr-6',
              exerciseId: 'exercise-pushup-001', // Diamond Pushups
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-thu-tr-6-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-thu-tr-6-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-thu-tr-6-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-thu-tr-6-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 10.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r5-thu-tr-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-r5-thu-tr-c1',
              exerciseId: 'exercise-overhead-tricep-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-thu-tr-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r5-thu-tr-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-r5-thu-tr-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-thu-tr-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 5. Friday: Lower (Interchangeable with Saturday)
  static final _routine5FridayLowerBody = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine5-friday-lower-body-001',
      name: 'Routine 5: Friday Lower Body',
      description: 'Friday Routine | Lower body session featuring free squats, leg extensions, weighted squats, leg curls, thigh presses, and calf raises.',
      currentRevisionId: 'rev-routine5-friday-lower-body-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['legs', 'routine', 'lower-body'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine5-friday-lower-body-001',
      templateId: 'template-routine5-friday-lower-body-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Friday Lower Body routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-r5-fri-lw-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-r5-fri-lw-w1',
              exerciseId: 'exercise-bodyweight-squat-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-fri-lw-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r5-fri-lw-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-r5-fri-lw-1',
              exerciseId: 'exercise-bodyweight-squat-001', // Free Squat
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-fri-lw-1-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-fri-lw-1-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-fri-lw-1-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-fri-lw-1-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-fri-lw-1-5',
                  setNumber: 5,
                  targetReps: 5,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-fri-lw-2',
              exerciseId: 'exercise-leg-extension-001', // Leg Extension
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-fri-lw-2-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-fri-lw-2-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-fri-lw-2-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-fri-lw-2-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-fri-lw-3',
              exerciseId: 'exercise-squat-001', // Weighted Squat
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-fri-lw-3-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-fri-lw-3-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-fri-lw-3-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-fri-lw-3-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-fri-lw-4',
              exerciseId: 'exercise-lying-leg-curl-001', // Leg Curl
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-fri-lw-4-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-fri-lw-4-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-fri-lw-4-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-fri-lw-4-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-fri-lw-5',
              exerciseId: 'exercise-leg-press-001', // Thigh Press
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-fri-lw-5-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-fri-lw-5-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-fri-lw-5-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-fri-lw-5-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-fri-lw-5-5',
                  setNumber: 5,
                  targetReps: 5,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-fri-lw-6',
              exerciseId: 'exercise-standing-calf-raise-001', // Calf Raise
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-fri-lw-6-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-fri-lw-6-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-fri-lw-6-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-fri-lw-6-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r5-fri-lw-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-r5-fri-lw-c1',
              exerciseId: 'exercise-hamstring-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-fri-lw-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r5-fri-lw-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-r5-fri-lw-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-fri-lw-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 6. Saturday: Chest (Interchangeable with Friday)
  static final _routine5SaturdayChest = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine5-saturday-chest-001',
      name: 'Routine 5: Saturday Chest',
      description: 'Saturday Routine | Chest session featuring flat dumbbell presses + pushups, incline dumbbell presses + height pushups, dumbbell flies, decline bench, and pullovers.',
      currentRevisionId: 'rev-routine5-saturday-chest-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['chest', 'routine', 'push'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine5-saturday-chest-001',
      templateId: 'template-routine5-saturday-chest-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Saturday Chest routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-r5-sat-ch-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-r5-sat-ch-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-sat-ch-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r5-sat-ch-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-r5-sat-ch-1',
              exerciseId:
                  'exercise-db-bench-001', // Flat Dumbbell Press + Pushup
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-sat-ch-1-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-sat-ch-1-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-sat-ch-1-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-sat-ch-1-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-sat-ch-2',
              exerciseId: 'exercise-incline-db-press-001', // Incline Dumbbell Press + Height Pushup
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-sat-ch-2-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-sat-ch-2-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-sat-ch-2-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-sat-ch-2-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-sat-ch-3',
              exerciseId: 'exercise-db-fly-001', // Dumbbell Flies
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-sat-ch-3-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-sat-ch-3-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-sat-ch-3-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-sat-ch-3-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-sat-ch-3-5',
                  setNumber: 5,
                  targetReps: 5,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-sat-ch-4',
              exerciseId: 'exercise-decline-bench-001', // Decline Bench
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-sat-ch-4-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-sat-ch-4-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-sat-ch-4-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-sat-ch-4-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r5-sat-ch-5',
              exerciseId: 'exercise-dumbbell-pullover-001', // Pull Over
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-sat-ch-5-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-sat-ch-5-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r5-sat-ch-5-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r5-sat-ch-5-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r5-sat-ch-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-r5-sat-ch-c1',
              exerciseId: 'exercise-chest-doorway-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-sat-ch-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r5-sat-ch-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-r5-sat-ch-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r5-sat-ch-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // ===================== 6-DAY ROUTINE TEMPLATES (Mon-Sat with Warm-ups & Cool-downs) =====================

  // 1. Monday: Back
  static final _routine6MondayBack = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine6-monday-back-001',
      name: 'Routine 6: Monday Back',
      description: 'Monday Routine | Comprehensive back session featuring pull-ups, one-arm rowing, seated rowing, T-bar rows, front lat pulldowns, heavy deadlifts, and hyper extensions.',
      currentRevisionId: 'rev-routine6-monday-back-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['back', 'routine', 'pull'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine6-monday-back-001',
      templateId: 'template-routine6-monday-back-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Monday Back routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-r6-mon-bk-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-r6-mon-bk-w1',
              exerciseId: 'exercise-cat-cow-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-mon-bk-w1-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r6-mon-bk-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-r6-mon-bk-1',
              exerciseId: 'exercise-pullup-001', // Pullups
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-mon-bk-1-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r6-mon-bk-1-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-mon-bk-1-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r6-mon-bk-2',
              exerciseId: 'exercise-single-arm-db-row-001', // One Arm Rowing
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-mon-bk-2-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r6-mon-bk-2-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-mon-bk-2-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r6-mon-bk-3',
              exerciseId: 'exercise-seated-cable-row-001', // Seated Rowing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-mon-bk-3-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r6-mon-bk-3-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-mon-bk-3-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r6-mon-bk-4',
              exerciseId: 'exercise-t-bar-row-001', // T-Bar
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-mon-bk-4-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-mon-bk-4-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-mon-bk-4-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r6-mon-bk-5',
              exerciseId: 'exercise-lat-pulldown-001', // Front Lat Pulley
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-mon-bk-5-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r6-mon-bk-5-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-mon-bk-5-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r6-mon-bk-6',
              exerciseId: 'exercise-deadlift-001', // Deadlift
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-mon-bk-6-1',
                  setNumber: 1,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-mon-bk-6-2',
                  setNumber: 2,
                  targetReps: 8,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r6-mon-bk-6-3',
                  setNumber: 3,
                  targetReps: 5,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r6-mon-bk-7',
              exerciseId: 'exercise-back-extension-001', // Hyper Extension
              order: 7,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-mon-bk-7-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r6-mon-bk-7-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r6-mon-bk-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-r6-mon-bk-c1',
              exerciseId: 'exercise-lat-overhead-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-mon-bk-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r6-mon-bk-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-r6-mon-bk-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-mon-bk-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 2. Tuesday: Biceps
  static final _routine6TuesdayBiceps = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine6-tuesday-biceps-001',
      name: 'Routine 6: Tuesday Biceps',
      description: 'Tuesday Routine | Dedicated arm builder covering wide-grip EZ curls, close-grip EZ curls, concentration curls, low pulley curls, bent curls, reverse grip curls, and dumbbell curls.',
      currentRevisionId: 'rev-routine6-tuesday-biceps-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['biceps', 'routine', 'arms'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine6-tuesday-biceps-001',
      templateId: 'template-routine6-tuesday-biceps-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Tuesday Biceps routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-r6-tue-bi-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-r6-tue-bi-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-tue-bi-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r6-tue-bi-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-r6-tue-bi-1',
              exerciseId: 'exercise-barbell-curl-001', // Wide Grip EZ Curl
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-tue-bi-1-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r6-tue-bi-1-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-tue-bi-1-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r6-tue-bi-2',
              exerciseId:
                  'exercise-ez-close-grip-curl-001', // Close Grip EZ Curl
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-tue-bi-2-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r6-tue-bi-2-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-tue-bi-2-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r6-tue-bi-3',
              exerciseId:
                  'exercise-db-preacher-curl-single-001', // Concentration Curl
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-tue-bi-3-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r6-tue-bi-3-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-tue-bi-3-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r6-tue-bi-4',
              exerciseId: 'exercise-barbell-curl-001', // Low Pulley
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-tue-bi-4-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r6-tue-bi-4-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-tue-bi-4-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r6-tue-bi-5',
              exerciseId: 'exercise-barbell-curl-001', // Bent Curl
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-tue-bi-5-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r6-tue-bi-5-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-tue-bi-5-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r6-tue-bi-6',
              exerciseId: 'exercise-barbell-curl-001', // Reverse Grip Curl
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-tue-bi-6-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r6-tue-bi-6-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-tue-bi-6-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r6-tue-bi-7',
              exerciseId: 'exercise-db-curl-001', // Dumbbell Curl
              order: 7,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-tue-bi-7-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r6-tue-bi-7-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-tue-bi-7-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.5,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r6-tue-bi-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-r6-tue-bi-c1',
              exerciseId: 'exercise-lat-overhead-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-tue-bi-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r6-tue-bi-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-r6-tue-bi-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-tue-bi-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 3. Wednesday: Shoulder
  static final _routine6WednesdayShoulders = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine6-wednesday-shoulders-001',
      name: 'Routine 6: Wednesday Shoulders',
      description: 'Wednesday Routine | Comprehensive shoulder workout covering front raises, upright rows, dumbbell presses, side lateral raises, bent-over flies, military presses, and shoulder pushups.',
      currentRevisionId: 'rev-routine6-wednesday-shoulders-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['shoulders', 'routine', 'hypertrophy'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine6-wednesday-shoulders-001',
      templateId: 'template-routine6-wednesday-shoulders-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Wednesday Shoulder routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-r6-wed-sh-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-r6-wed-sh-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-wed-sh-w1-1',
                  setNumber: 1,
                  targetReps: 20,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r6-wed-sh-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-r6-wed-sh-1',
              exerciseId: 'exercise-front-raise-001', // Front Raise
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-wed-sh-1-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r6-wed-sh-1-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-wed-sh-1-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r6-wed-sh-2',
              exerciseId: 'exercise-upright-row-001', // Upright
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-wed-sh-2-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r6-wed-sh-2-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-wed-sh-2-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r6-wed-sh-3',
              exerciseId: 'exercise-seated-db-press-001', // Dumbbell Press
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-wed-sh-3-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-wed-sh-3-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-wed-sh-3-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r6-wed-sh-4',
              exerciseId: 'exercise-lateral-raise-001', // Side Lateral Raise
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-wed-sh-4-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r6-wed-sh-4-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-wed-sh-4-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r6-wed-sh-5',
              exerciseId: 'exercise-rear-delt-fly-001', // Bent over Fly
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-wed-sh-5-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r6-wed-sh-5-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-wed-sh-5-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r6-wed-sh-6',
              exerciseId: 'exercise-ohp-001', // Military Press
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-wed-sh-6-1',
                  setNumber: 1,
                  targetReps: 8,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-wed-sh-6-2',
                  setNumber: 2,
                  targetReps: 8,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r6-wed-sh-6-3',
                  setNumber: 3,
                  targetReps: 8,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r6-wed-sh-7',
              exerciseId: 'exercise-pushup-001', // Shoulder Pushups
              order: 7,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-wed-sh-7-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-wed-sh-7-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r6-wed-sh-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-r6-wed-sh-c1',
              exerciseId: 'exercise-cross-body-shoulder-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-wed-sh-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r6-wed-sh-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-r6-wed-sh-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-wed-sh-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 4. Thursday: Triceps
  static final _routine6ThursdayTriceps = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine6-thursday-triceps-001',
      name: 'Routine 6: Thursday Triceps',
      description: 'Thursday Routine | Focused tricep session featuring diamond pushups, skull crushers, close grip bench presses, overhead dumbbells, pulley pushdowns, and bench dips.',
      currentRevisionId: 'rev-routine6-thursday-triceps-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['triceps', 'routine', 'arms'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine6-thursday-triceps-001',
      templateId: 'template-routine6-thursday-triceps-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Thursday Triceps routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-r6-thu-tr-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-r6-thu-tr-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-thu-tr-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r6-thu-tr-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-r6-thu-tr-1',
              exerciseId: 'exercise-pushup-001', // Diamond Pushups
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-thu-tr-1-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r6-thu-tr-1-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-thu-tr-1-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r6-thu-tr-2',
              exerciseId: 'exercise-skull-crusher-001', // Skull Crusher
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-thu-tr-2-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-thu-tr-2-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-thu-tr-2-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r6-thu-tr-3',
              exerciseId: 'exercise-close-grip-bench-001', // Close Grip Bench
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-thu-tr-3-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-thu-tr-3-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-thu-tr-3-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r6-thu-tr-4',
              exerciseId:
                  'exercise-overhead-tricep-extension-001', // Overhead Dumbbell
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-thu-tr-4-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r6-thu-tr-4-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-thu-tr-4-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r6-thu-tr-5',
              exerciseId: 'exercise-tricep-pushdown-001', // Pulley Pushdown
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-thu-tr-5-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-r6-thu-tr-5-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-thu-tr-5-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r6-thu-tr-6',
              exerciseId: 'exercise-dips-001', // Bench Dips
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-thu-tr-6-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r6-thu-tr-6-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 9.5,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r6-thu-tr-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-r6-thu-tr-c1',
              exerciseId: 'exercise-overhead-tricep-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-thu-tr-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r6-thu-tr-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-r6-thu-tr-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r6-thu-tr-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 5. Friday: Chest (Interchangeable with Saturday)
  static final _routineFridayChest = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-friday-chest-001',
      name: 'Routine 6: Friday Chest',
      description: 'Friday Routine | Heavy chest volume including pushups, flat bench presses, incline bench presses, decline bench presses, flat/incline/decline dumbbell flies, and parallel dips.',
      currentRevisionId: 'rev-routine-friday-chest-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['chest', 'routine', 'push'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-friday-chest-001',
      templateId: 'template-routine-friday-chest-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Friday Chest routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-fri-ch-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-fri-ch-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-ch-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-fri-ch-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-fri-ch-1',
              exerciseId: 'exercise-pushup-001', // Pushups
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-ch-1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-fri-ch-1-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fri-ch-2',
              exerciseId: 'exercise-bench-001', // Flat Bench Press
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-ch-2-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-fri-ch-2-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-fri-ch-2-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fri-ch-3',
              exerciseId: 'exercise-incline-bench-001', // Incline Bench Press
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-ch-3-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-fri-ch-3-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-fri-ch-3-3',
                  setNumber: 3,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fri-ch-4',
              exerciseId: 'exercise-decline-bench-001', // Decline Bench Press
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-ch-4-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-fri-ch-4-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fri-ch-5',
              exerciseId:
                  'exercise-db-fly-001', // Dumbell Flat + Incline + Decline Fly
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-ch-5-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-fri-ch-5-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-fri-ch-5-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fri-ch-6',
              exerciseId: 'exercise-dips-001', // Parallel Dips (If Alive!!)
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-ch-6-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-fri-ch-6-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 10.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-fri-ch-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-fri-ch-c1',
              exerciseId: 'exercise-chest-doorway-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-ch-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-fri-ch-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-fri-ch-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-fri-ch-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 6. Saturday: Lower (Interchangeable with Friday)
  static final _routineSaturdayLower = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-saturday-lower-001',
      name: 'Routine 6: Saturday Lower Body',
      description: 'Saturday Routine | Lower body session featuring free squats, machine squats, thigh presses, leg extensions, leg curls, walking lunges, and calf raises.',
      currentRevisionId: 'rev-routine-saturday-lower-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['legs', 'routine', 'lower-body'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-saturday-lower-001',
      templateId: 'template-routine-saturday-lower-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Saturday Lower Body routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-sat-lw-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-sat-lw-w1',
              exerciseId: 'exercise-bodyweight-squat-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-lw-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sat-lw-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-sat-lw-1',
              exerciseId: 'exercise-bodyweight-squat-001', // Free Squat
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-lw-1-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sat-lw-1-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-lw-1-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sat-lw-2',
              exerciseId: 'exercise-squat-001', // Machine Squat
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-lw-2-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-lw-2-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sat-lw-3',
              exerciseId: 'exercise-leg-press-001', // Thigh Press
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-lw-3-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-lw-3-2',
                  setNumber: 2,
                  targetReps: 10,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sat-lw-4',
              exerciseId: 'exercise-leg-extension-001', // Leg Extension
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-lw-4-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sat-lw-4-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-lw-4-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sat-lw-5',
              exerciseId: 'exercise-lying-leg-curl-001', // Leg Curl
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-lw-5-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sat-lw-5-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-lw-5-3',
                  setNumber: 3,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sat-lw-6',
              exerciseId: 'exercise-walking-lunge-001', // Lunges
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-lw-6-1',
                  setNumber: 1,
                  targetReps: 12,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-lw-6-2',
                  setNumber: 2,
                  targetReps: 12,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-sat-lw-7',
              exerciseId: 'exercise-standing-calf-raise-001', // Calf Raise
              order: 7,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-lw-7-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sat-lw-7-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-sat-lw-7-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.5,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sat-lw-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-sat-lw-c1',
              exerciseId: 'exercise-hamstring-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-lw-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sat-lw-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-sat-lw-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-lw-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // ===================== 6-DAY ROUTINE TEMPLATES (Mon-Sat with Warm-ups & Cool-downs) =====================

  // 1. Monday: Chest
  static final _routineMondayChest = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-monday-chest-001',
      name: 'Routine 7: Monday Chest',
      description: 'Monday Routine | High-volume chest session covering weighted/non-weighted pushups, barbell & dumbbell bench presses, incline presses & flies, decline barbell, flat bench flies, rising cable presses, and pullovers.',
      currentRevisionId: 'rev-routine-monday-chest-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['chest', 'routine', 'push'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-monday-chest-001',
      templateId: 'template-routine-monday-chest-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Monday Chest routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-mon-ch-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-mon-ch-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-mon-ch-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-mon-ch-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-mon-ch-1',
              exerciseId:
                  'exercise-pushup-001', // Pushup (Weighted + Non Weighted)
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-mon-ch-1-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-mon-ch-1-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-mon-ch-1-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-mon-ch-1-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-ch-1-5',
                  setNumber: 5,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-ch-1-6',
                  setNumber: 6,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-mon-ch-2',
              exerciseId: 'exercise-bench-001', // Barbell Bench Press
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-mon-ch-2-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-mon-ch-2-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-mon-ch-2-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-ch-2-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-ch-2-5',
                  setNumber: 5,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-mon-ch-3',
              exerciseId: 'exercise-db-bench-001', // Dumbbell Bench Press
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-mon-ch-3-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-mon-ch-3-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-ch-3-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-mon-ch-4',
              exerciseId: 'exercise-incline-bench-001', // Incline Barbell Press
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-mon-ch-4-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-mon-ch-4-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-mon-ch-4-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-ch-4-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-ch-4-5',
                  setNumber: 5,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-mon-ch-5',
              exerciseId: 'exercise-incline-db-fly-001', // Incline Fly
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-mon-ch-5-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-mon-ch-5-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-mon-ch-5-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-ch-5-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-ch-5-5',
                  setNumber: 5,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-mon-ch-6',
              exerciseId: 'exercise-decline-bench-001', // Decline Barbell
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-mon-ch-6-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-mon-ch-6-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-mon-ch-6-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-ch-6-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-ch-6-5',
                  setNumber: 5,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-mon-ch-7',
              exerciseId: 'exercise-db-fly-001', // Flat Bench Fly
              order: 7,
              targetSets: [
                TargetSet(
                  id: 'ts-mon-ch-7-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-mon-ch-7-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-mon-ch-7-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-ch-7-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-ch-7-5',
                  setNumber: 5,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-mon-ch-8',
              exerciseId: 'exercise-rising-cable-press-001', // Rising
              order: 8,
              targetSets: [
                TargetSet(
                  id: 'ts-mon-ch-8-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-mon-ch-8-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-ch-8-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-mon-ch-9',
              exerciseId: 'exercise-dumbbell-pullover-001', // PullOver
              order: 9,
              targetSets: [
                TargetSet(
                  id: 'ts-mon-ch-9-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-mon-ch-9-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-mon-ch-9-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-ch-9-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-mon-ch-9-5',
                  setNumber: 5,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-mon-ch-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-mon-ch-c1',
              exerciseId: 'exercise-chest-doorway-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-mon-ch-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-mon-ch-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-mon-ch-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-mon-ch-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 2. Tuesday: Triceps
  static final _routineTuesdayTriceps = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-tuesday-triceps-001',
      name: 'Routine 7: Tuesday Triceps',
      description: 'Tuesday Routine | Tricep isolation session featuring rising cable extensions, rope pushdowns, rope up triceps, skull crushers, pulley pushdowns, and kickbacks.',
      currentRevisionId: 'rev-routine-tuesday-triceps-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['triceps', 'routine', 'arms'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-tuesday-triceps-001',
      templateId: 'template-routine-tuesday-triceps-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Tuesday Triceps routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-tue-tr-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-tue-tr-w1',
              exerciseId: 'exercise-arm-circles-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-tue-tr-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-tue-tr-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-tue-tr-1',
              exerciseId: 'exercise-rising-cable-press-001', // Rising
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-tue-tr-1-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-tue-tr-1-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-tue-tr-1-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tue-tr-2',
              exerciseId: 'exercise-rope-pushdown-001', // Ropes Pushdown
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-tue-tr-2-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-tue-tr-2-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-tue-tr-2-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-tue-tr-2-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-tue-tr-2-5',
                  setNumber: 5,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tue-tr-3',
              exerciseId: 'exercise-rope-pushdown-001', // Rope up Triceps
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-tue-tr-3-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-tue-tr-3-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-tue-tr-3-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-tue-tr-3-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-tue-tr-3-5',
                  setNumber: 5,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tue-tr-4',
              exerciseId: 'exercise-skull-crusher-001', // Skull Crusher
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-tue-tr-4-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-tue-tr-4-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-tue-tr-4-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-tue-tr-4-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-tue-tr-4-5',
                  setNumber: 5,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tue-tr-5',
              exerciseId: 'exercise-tricep-pushdown-001', // Pulley Pushdown
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-tue-tr-5-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-tue-tr-5-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-tue-tr-5-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-tue-tr-5-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-tue-tr-5-5',
                  setNumber: 5,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-tue-tr-6',
              exerciseId: 'exercise-dumbbell-kickback-001', // Kickback
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-tue-tr-6-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-tue-tr-6-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-tue-tr-6-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-tue-tr-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-tue-tr-c1',
              exerciseId: 'exercise-overhead-tricep-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-tue-tr-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-tue-tr-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-tue-tr-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-tue-tr-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 3. Wednesday: Back
  static final _routineWednesdayBack = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-wednesday-back-001',
      name: 'Routine 7: Wednesday Back',
      description: 'Wednesday Routine | Back session featuring pull-ups, front pulleys, single-arm rowing, bent rowing, reverse pulleys, seated rowing, and hyper extensions.',
      currentRevisionId: 'rev-routine-wednesday-back-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['back', 'routine', 'pull'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-wednesday-back-001',
      templateId: 'template-routine-wednesday-back-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Wednesday Back routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-wed-bk-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-wed-bk-w1',
              exerciseId: 'exercise-cat-cow-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-bk-w1-1',
                  setNumber: 1,
                  targetReps: 10,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-wed-bk-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-wed-bk-1',
              exerciseId: 'exercise-pullup-001', // Pullup
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-bk-1-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-bk-1-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-wed-bk-1-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-wed-bk-2',
              exerciseId: 'exercise-lat-pulldown-001', // Front Pully
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-bk-2-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-bk-2-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-bk-2-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-wed-bk-2-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-wed-bk-2-5',
                  setNumber: 5,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-wed-bk-3',
              exerciseId: 'exercise-single-arm-db-row-001', // Single Arm Rowing
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-bk-3-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-bk-3-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-bk-3-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-wed-bk-3-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-wed-bk-3-5',
                  setNumber: 5,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-wed-bk-4',
              exerciseId: 'exercise-row-001', // Bent Rowing
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-bk-4-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-bk-4-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-bk-4-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-wed-bk-4-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-wed-bk-4-5',
                  setNumber: 5,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-wed-bk-5',
              exerciseId:
                  'exercise-neutral-grip-lat-pulldown-001', // Reverse Pulley
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-bk-5-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-bk-5-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-bk-5-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-wed-bk-5-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-wed-bk-5-5',
                  setNumber: 5,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-wed-bk-6',
              exerciseId: 'exercise-seated-cable-row-001', // Seating Rowing
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-bk-6-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-bk-6-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-bk-6-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-wed-bk-6-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-wed-bk-6-5',
                  setNumber: 5,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-wed-bk-7',
              exerciseId: 'exercise-back-extension-001', // Hyper Extension
              order: 7,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-bk-7-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-wed-bk-7-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-wed-bk-7-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-wed-bk-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-wed-bk-c1',
              exerciseId: 'exercise-lat-overhead-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-bk-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-wed-bk-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-wed-bk-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-wed-bk-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 4. Thursday: Biceps
  static final _routineThursdayBiceps = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-thursday-biceps-001',
      name: 'Routine 7: Thursday Biceps',
      description: 'Thursday Routine | Dedicated bicep session featuring a dumbbell warmup, wide-grip and close-grip EZ barbell curls, low pulley curls, reverse grip EZ and barbell curls, hammer curls, and spider curls.',
      currentRevisionId: 'rev-routine-thursday-biceps-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['biceps', 'routine', 'arms'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-thursday-biceps-001',
      templateId: 'template-routine-thursday-biceps-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Thursday Biceps routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-thu-bi-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-thu-bi-w1',
              exerciseId: 'exercise-db-curl-001', // Warmup Dumbbell Curl
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-thu-bi-w1-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 5.0,
                ),
                TargetSet(
                  id: 'ts-thu-bi-w1-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 5.5,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-thu-bi-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-thu-bi-1',
              exerciseId:
                  'exercise-barbell-curl-001', // Wide Grip EZ Barbell Curl
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-thu-bi-1-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-thu-bi-1-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-thu-bi-1-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-thu-bi-2',
              exerciseId: 'exercise-ez-close-grip-curl-001', // Close Grip EZ Barbell Curl
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-thu-bi-2-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-thu-bi-2-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-thu-bi-2-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-thu-bi-3',
              exerciseId: 'exercise-barbell-curl-001', // Low Pulley Curl
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-thu-bi-3-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-thu-bi-3-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-thu-bi-3-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-thu-bi-4',
              exerciseId:
                  'exercise-barbell-curl-001', // Reverse Grip EZ Barbell Curl
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-thu-bi-4-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-thu-bi-4-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-thu-bi-5',
              exerciseId:
                  'exercise-barbell-curl-001', // Reverse Grip Barbell Curl
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-thu-bi-5-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-thu-bi-5-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-thu-bi-6',
              exerciseId: 'exercise-hammer-curl-001', // Hammer Curl
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-thu-bi-6-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-thu-bi-6-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-thu-bi-6-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-thu-bi-7',
              exerciseId: 'exercise-spider-curl-001', // Spider Curl
              order: 7,
              targetSets: [
                TargetSet(
                  id: 'ts-thu-bi-7-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-thu-bi-7-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-thu-bi-7-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 10.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-thu-bi-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-thu-bi-c1',
              exerciseId: 'exercise-lat-overhead-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-thu-bi-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-thu-bi-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-thu-bi-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-thu-bi-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 5. Friday: Lower Body
  static final _routine7FridayLowerBody = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine7-friday-lower-body-001',
      name: 'Routine 7: Friday Lower Body',
      description: 'Friday Routine | Lower body session covering squats, weighted squats, leg extensions, thigh presses, leg curls, lunges, and calf raises.',
      currentRevisionId: 'rev-routine7-friday-lower-body-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['legs', 'routine', 'lower-body'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine7-friday-lower-body-001',
      templateId: 'template-routine7-friday-lower-body-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Friday Lower Body routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-r7-fri-lw-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-r7-fri-lw-w1',
              exerciseId: 'exercise-bodyweight-squat-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r7-fri-lw-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r7-fri-lw-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-r7-fri-lw-1',
              exerciseId: 'exercise-bodyweight-squat-001', // Squats
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r7-fri-lw-1-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-1-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-1-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-1-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-1-5',
                  setNumber: 5,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r7-fri-lw-2',
              exerciseId: 'exercise-squat-001', // Weighted Squats
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-r7-fri-lw-2-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-2-2',
                  setNumber: 2,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-2-3',
                  setNumber: 3,
                  targetReps: 0,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-2-4',
                  setNumber: 4,
                  targetReps: 0,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r7-fri-lw-3',
              exerciseId: 'exercise-leg-extension-001', // Leg Extension
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-r7-fri-lw-3-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-3-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-3-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-3-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-3-5',
                  setNumber: 5,
                  targetReps: 5,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r7-fri-lw-4',
              exerciseId: 'exercise-leg-press-001', // Thigh Press
              order: 4,
              targetSets: [
                TargetSet(
                  id: 'ts-r7-fri-lw-4-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-4-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-4-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-4-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-4-5',
                  setNumber: 5,
                  targetReps: 5,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r7-fri-lw-5',
              exerciseId: 'exercise-lying-leg-curl-001', // Leg Curl
              order: 5,
              targetSets: [
                TargetSet(
                  id: 'ts-r7-fri-lw-5-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-5-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-5-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-5-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-5-5',
                  setNumber: 5,
                  targetReps: 5,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r7-fri-lw-6',
              exerciseId: 'exercise-walking-lunge-001', // Lunges
              order: 6,
              targetSets: [
                TargetSet(
                  id: 'ts-r7-fri-lw-6-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-6-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-6-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-6-4',
                  setNumber: 4,
                  targetReps: 4,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-6-5',
                  setNumber: 5,
                  targetReps: 5,
                  targetRpe: 10.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-r7-fri-lw-7',
              exerciseId: 'exercise-standing-calf-raise-001', // Calf Raise
              order: 7,
              targetSets: [
                TargetSet(
                  id: 'ts-r7-fri-lw-7-1',
                  setNumber: 1,
                  targetReps: 0,
                  targetRpe: 9.0,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-7-2',
                  setNumber: 2,
                  targetReps: 2,
                  targetRpe: 9.5,
                ),
                TargetSet(
                  id: 'ts-r7-fri-lw-7-3',
                  setNumber: 3,
                  targetReps: 3,
                  targetRpe: 10.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r7-fri-lw-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-r7-fri-lw-c1',
              exerciseId: 'exercise-hamstring-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r7-fri-lw-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-r7-fri-lw-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-r7-fri-lw-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-r7-fri-lw-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 6. Saturday: Rest / Active Recovery or Additional Session
  static final _routineSaturdayRecovery = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-routine-saturday-recovery-001',
      name: 'Routine 7: Saturday Recovery & Core',
      description: 'Saturday Routine | Active recovery and core stability session to round out your 6-day split.',
      currentRevisionId: 'rev-routine-saturday-recovery-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['recovery', 'core', 'routine'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-routine-saturday-recovery-001',
      templateId: 'template-routine-saturday-recovery-001',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial release for Saturday Recovery routine',
      blocks: [
        const WorkoutBlock(
          id: 'block-sat-rec-1',
          name: 'Warm-Up / Activation',
          items: [
            TemplateItem(
              id: 'item-sat-rec-w1',
              exerciseId: 'exercise-cat-cow-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-rec-w1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 5.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sat-rec-2',
          name: 'Working Sets',
          items: [
            TemplateItem(
              id: 'item-sat-rec-1',
              exerciseId: 'exercise-hanging-leg-raise-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-rec-1-1',
                  setNumber: 1,
                  targetReps: 15,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-sat-rec-1-2',
                  setNumber: 2,
                  targetReps: 15,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-sat-rec-1-3',
                  setNumber: 3,
                  targetReps: 15,
                  targetRpe: 9.0,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sat-rec-3',
          name: 'Cool-Down Stretch',
          items: [
            TemplateItem(
              id: 'item-sat-rec-c1',
              exerciseId: 'exercise-hamstring-stretch-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-rec-c1-1',
                  setNumber: 1,
                  targetDurationSeconds: 30,
                ),
              ],
            ),
          ],
        ),
        const WorkoutBlock(
          id: 'block-sat-rec-4',
          name: 'Relaxed Finish',
          items: [
            TemplateItem(
              id: 'item-sat-rec-f1',
              exerciseId: 'exercise-diaphragmatic-breathing-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-sat-rec-f1-1',
                  setNumber: 1,
                  targetDurationSeconds: 180,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
