import '../../domain/target_set.dart';
import '../../domain/template_enums.dart';
import '../../domain/template_item.dart';
import '../../domain/workout_block.dart';
import '../../domain/workout_template.dart';
import '../../domain/workout_template_revision.dart';

class const TemplateSeedBundle({
  required final WorkoutTemplate template,
  required final WorkoutTemplateRevision initialRevision,
});

/// Canonical system workout template seed data containing 20 diverse programs.
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
  ];

  // 1. Full Body Strength A
  static final _fullBodyStrengthA = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-full-body-strength-a',
      name: 'Full Body Strength A',
      description: 'Foundational strength workout focusing on heavy compound squat, bench, and row movements[cite: 2, 4].',
      currentRevisionId: 'rev-full-body-strength-a-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['strength', 'full-body', 'beginner-friendly'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-full-body-strength-a-001',
      templateId: 'template-full-body-strength-a',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      changeSummary: 'Initial system release',
      blocks: [
        const WorkoutBlock(
          id: 'block-fba-1',
          name: 'Main Lifts',
          items: [
            TemplateItem(
              id: 'item-fba-1',
              exerciseId: 'exercise-squat-001', // Barbell Back Squat
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-fba-1-1',
                  setNumber: 1,
                  setType: SetType.warmup,
                  targetWeight: 60.0,
                  targetReps: 10,
                ),
                TargetSet(
                  id: 'ts-fba-1-2',
                  setNumber: 2,
                  targetWeight: 100.0,
                  targetReps: 5,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-fba-1-3',
                  setNumber: 3,
                  targetWeight: 100.0,
                  targetReps: 5,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-fba-1-4',
                  setNumber: 4,
                  targetWeight: 100.0,
                  targetReps: 5,
                  targetRpe: 9.0,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fba-2',
              exerciseId: 'exercise-bench-001', // Barbell Bench Press
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-fba-2-1',
                  setNumber: 1,
                  setType: SetType.warmup,
                  targetWeight: 50.0,
                  targetReps: 10,
                ),
                TargetSet(
                  id: 'ts-fba-2-2',
                  setNumber: 2,
                  targetWeight: 80.0,
                  targetReps: 8,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-fba-2-3',
                  setNumber: 3,
                  targetWeight: 80.0,
                  targetReps: 8,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fba-3',
              exerciseId: 'exercise-barbell-row-001', // Barbell Row
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-fba-3-1',
                  setNumber: 1,
                  targetWeight: 70.0,
                  targetReps: 8,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-fba-3-2',
                  setNumber: 2,
                  targetWeight: 70.0,
                  targetReps: 8,
                  targetRpe: 8.5,
                ),
                TargetSet(
                  id: 'ts-fba-3-3',
                  setNumber: 3,
                  targetWeight: 70.0,
                  targetReps: 8,
                  targetRpe: 9.0,
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
      description: 'Complementary full-body session featuring deadlifts and overhead presses[cite: 2, 4].',
      currentRevisionId: 'rev-full-body-strength-b-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['strength', 'full-body', 'posterior-chain'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-full-body-strength-b-001',
      templateId: 'template-full-body-strength-b',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      blocks: [
        const WorkoutBlock(
          id: 'block-fbb-1',
          name: 'Compound Sequence',
          items: [
            TemplateItem(
              id: 'item-fbb-1',
              exerciseId: 'exercise-deadlift-001', // Conventional Deadlift
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-fbb-1-1',
                  setNumber: 1,
                  setType: SetType.warmup,
                  targetWeight: 80.0,
                  targetReps: 5,
                ),
                TargetSet(
                  id: 'ts-fbb-1-2',
                  setNumber: 2,
                  targetWeight: 120.0,
                  targetReps: 5,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fbb-2',
              exerciseId: 'exercise-ohp-001', // Overhead Press
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-fbb-2-1',
                  setNumber: 1,
                  targetWeight: 50.0,
                  targetReps: 6,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-fbb-2-2',
                  setNumber: 2,
                  targetWeight: 50.0,
                  targetReps: 6,
                  targetRpe: 8.5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-fbb-3',
              exerciseId: 'exercise-pullup-001', // Pull-Up
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-fbb-3-1',
                  setNumber: 1,
                  targetReps: 8,
                  targetRpe: 8.0,
                ),
                TargetSet(
                  id: 'ts-fbb-3-2',
                  setNumber: 2,
                  targetReps: 8,
                  targetRpe: 8.5,
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
      description: 'Horizontal and vertical pressing power[cite: 4].',
      currentRevisionId: 'rev-upper-push-a-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['push', 'upper-body', 'chest'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-upper-push-a-001',
      templateId: 'template-upper-push-a',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      blocks: [
        const WorkoutBlock(
          id: 'block-upa-1',
          name: 'Pressing Bloc',
          items: [
            TemplateItem(
              id: 'item-upa-1',
              exerciseId: 'exercise-bench-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-upa-1-1',
                  setNumber: 1,
                  targetWeight: 82.5,
                  targetReps: 8,
                ),
                TargetSet(
                  id: 'ts-upa-1-2',
                  setNumber: 2,
                  targetWeight: 82.5,
                  targetReps: 8,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upa-2',
              exerciseId:
                  'exercise-incline-bench-001', // Incline Barbell Bench Press
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upa-2-1',
                  setNumber: 1,
                  targetWeight: 70.0,
                  targetReps: 10,
                ),
                TargetSet(
                  id: 'ts-upa-2-2',
                  setNumber: 2,
                  targetWeight: 70.0,
                  targetReps: 10,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upa-3',
              exerciseId:
                  'exercise-tricep-pushdown-001', // Cable Tricep Pushdown
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-upa-3-1',
                  setNumber: 1,
                  targetWeight: 25.0,
                  targetReps: 12,
                ),
                TargetSet(
                  id: 'ts-upa-3-2',
                  setNumber: 2,
                  targetWeight: 25.0,
                  targetReps: 12,
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
      description: 'Shoulder and incline focus push session[cite: 4].',
      currentRevisionId: 'rev-upper-push-b-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['push', 'shoulders', 'triceps'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-upper-push-b-001',
      templateId: 'template-upper-push-b',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      blocks: [
        const WorkoutBlock(
          id: 'block-upb-1',
          name: 'Shoulder Power',
          items: [
            TemplateItem(
              id: 'item-upb-1',
              exerciseId: 'exercise-ohp-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-upb-1-1',
                  setNumber: 1,
                  targetWeight: 52.5,
                  targetReps: 6,
                ),
                TargetSet(
                  id: 'ts-upb-1-2',
                  setNumber: 2,
                  targetWeight: 52.5,
                  targetReps: 6,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upb-2',
              exerciseId:
                  'exercise-lateral-raise-001', // Dumbbell Lateral Raise
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upb-2-1',
                  setNumber: 1,
                  targetWeight: 12.5,
                  targetReps: 15,
                ),
                TargetSet(
                  id: 'ts-upb-2-2',
                  setNumber: 2,
                  targetWeight: 12.5,
                  targetReps: 15,
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
      description: 'Back thickness and bicep volume[cite: 4].',
      currentRevisionId: 'rev-upper-pull-a-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['pull', 'back', 'biceps'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-upper-pull-a-001',
      templateId: 'template-upper-pull-a',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      blocks: [
        const WorkoutBlock(
          id: 'block-upla-1',
          name: 'Pull Block A',
          items: [
            TemplateItem(
              id: 'item-upla-1',
              exerciseId: 'exercise-barbell-row-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-upla-1-1',
                  setNumber: 1,
                  targetWeight: 75.0,
                  targetReps: 8,
                ),
                TargetSet(
                  id: 'ts-upla-1-2',
                  setNumber: 2,
                  targetWeight: 75.0,
                  targetReps: 8,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upla-2',
              exerciseId: 'exercise-lat-pulldown-001', // Lat Pulldown
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-upla-2-1',
                  setNumber: 1,
                  targetWeight: 60.0,
                  targetReps: 10,
                ),
                TargetSet(
                  id: 'ts-upla-2-2',
                  setNumber: 2,
                  targetWeight: 60.0,
                  targetReps: 10,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-upla-3',
              exerciseId: 'exercise-db-curl-001', // Dumbbell Bicep Curl
              order: 3,
              targetSets: [
                TargetSet(
                  id: 'ts-upla-3-1',
                  setNumber: 1,
                  targetWeight: 15.0,
                  targetReps: 10,
                ),
                TargetSet(
                  id: 'ts-upla-3-2',
                  setNumber: 2,
                  targetWeight: 15.0,
                  targetReps: 10,
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
      description: 'Vertical pull and rear delt specialization[cite: 4].',
      currentRevisionId: 'rev-upper-pull-b-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['pull', 'lats', 'rear-delts'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-upper-pull-b-001',
      templateId: 'template-upper-pull-b',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      blocks: [
        const WorkoutBlock(
          id: 'block-uplb-1',
          name: 'Vertical & Rear Delts',
          items: [
            TemplateItem(
              id: 'item-uplb-1',
              exerciseId: 'exercise-pullup-001',
              order: 1,
              targetSets: [
                TargetSet(id: 'ts-uplb-1-1', setNumber: 1, targetReps: 8),
                TargetSet(id: 'ts-uplb-1-2', setNumber: 2, targetReps: 7),
              ],
            ),
            TemplateItem(
              id: 'item-uplb-2',
              exerciseId: 'exercise-face-pull-001', // Cable Face Pull
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-uplb-2-1',
                  setNumber: 1,
                  targetWeight: 20.0,
                  targetReps: 15,
                ),
                TargetSet(
                  id: 'ts-uplb-2-2',
                  setNumber: 2,
                  targetWeight: 20.0,
                  targetReps: 15,
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
      description: 'Squat and machine press heavy leg session[cite: 4].',
      currentRevisionId: 'rev-lower-quad-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['legs', 'quads', 'strength'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-lower-quad-001',
      templateId: 'template-lower-quad',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      blocks: [
        const WorkoutBlock(
          id: 'block-lq-1',
          name: 'Quad Block',
          items: [
            TemplateItem(
              id: 'item-lq-1',
              exerciseId: 'exercise-squat-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lq-1-1',
                  setNumber: 1,
                  targetWeight: 100.0,
                  targetReps: 6,
                ),
                TargetSet(
                  id: 'ts-lq-1-2',
                  setNumber: 2,
                  targetWeight: 100.0,
                  targetReps: 6,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lq-2',
              exerciseId: 'exercise-leg-press-001', // Leg Press
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lq-2-1',
                  setNumber: 1,
                  targetWeight: 180.0,
                  targetReps: 10,
                ),
                TargetSet(
                  id: 'ts-lq-2-2',
                  setNumber: 2,
                  targetWeight: 200.0,
                  targetReps: 10,
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
      description: 'Hamstring and posterior chain builder[cite: 4].',
      currentRevisionId: 'rev-lower-hinge-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['legs', 'hamstrings', 'deadlift'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-lower-hinge-001',
      templateId: 'template-lower-hinge',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      blocks: [
        const WorkoutBlock(
          id: 'block-lh-1',
          name: 'Hinge Block',
          items: [
            TemplateItem(
              id: 'item-lh-1',
              exerciseId: 'exercise-deadlift-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lh-1-1',
                  setNumber: 1,
                  targetWeight: 130.0,
                  targetReps: 5,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lh-2',
              exerciseId:
                  'exercise-barbell-rdl-001', // Barbell Romanian Deadlift
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lh-2-1',
                  setNumber: 1,
                  targetWeight: 90.0,
                  targetReps: 8,
                ),
                TargetSet(
                  id: 'ts-lh-2-2',
                  setNumber: 2,
                  targetWeight: 90.0,
                  targetReps: 8,
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
      description: 'Volume-driven chest and shoulder session[cite: 4].',
      currentRevisionId: 'rev-push-hyp-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['hypertrophy', 'push', 'chest'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-push-hyp-001',
      templateId: 'template-push-hypertrophy',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      blocks: [
        const WorkoutBlock(
          id: 'block-ph-1',
          name: 'Hypertrophy Circuit',
          items: [
            TemplateItem(
              id: 'item-ph-1',
              exerciseId: 'exercise-db-bench-001', // Dumbbell Bench Press
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ph-1-1',
                  setNumber: 1,
                  targetWeight: 32.0,
                  targetReps: 10,
                ),
                TargetSet(
                  id: 'ts-ph-1-2',
                  setNumber: 2,
                  targetWeight: 32.0,
                  targetReps: 10,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ph-2',
              exerciseId: 'exercise-cable-crossover-001', // Cable Crossover
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-ph-2-1',
                  setNumber: 1,
                  targetWeight: 15.0,
                  targetReps: 12,
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
      description: 'High volume back isolation and rowing[cite: 4].',
      currentRevisionId: 'rev-pull-hyp-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['hypertrophy', 'pull', 'back'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-pull-hyp-001',
      templateId: 'template-pull-hypertrophy',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      blocks: [
        const WorkoutBlock(
          id: 'block-plh-1',
          name: 'Pull Volume',
          items: [
            TemplateItem(
              id: 'item-plh-1',
              exerciseId: 'exercise-seated-cable-row-001', // Seated Cable Row
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-plh-1-1',
                  setNumber: 1,
                  targetWeight: 65.0,
                  targetReps: 10,
                ),
                TargetSet(
                  id: 'ts-plh-1-2',
                  setNumber: 2,
                  targetWeight: 65.0,
                  targetReps: 10,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 11. Leg Day Balanced
  static final _legDayBalanced = TemplateSeedBundle(
    template: WorkoutTemplate(
      id: 'template-leg-balanced',
      name: 'Balanced Leg Session',
      description:
          'Complete workout addressing quads, glutes, and calves[cite: 4].',
      currentRevisionId: 'rev-leg-bal-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['legs', 'balanced', 'glutes'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-leg-bal-001',
      templateId: 'template-leg-balanced',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      blocks: [
        const WorkoutBlock(
          id: 'block-lb-1',
          name: 'Leg Block',
          items: [
            TemplateItem(
              id: 'item-lb-1',
              exerciseId: 'exercise-front-squat-001', // Barbell Front Squat
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lb-1-1',
                  setNumber: 1,
                  targetWeight: 80.0,
                  targetReps: 8,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-lb-2',
              exerciseId:
                  'exercise-barbell-hip-thrust-001', // Barbell Hip Thrust
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-lb-2-1',
                  setNumber: 1,
                  targetWeight: 100.0,
                  targetReps: 10,
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
      description:
          'Heavy compound initiation followed by high rep isolation[cite: 4].',
      currentRevisionId: 'rev-upp-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['upper-body', 'power', 'pump'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-upp-001',
      templateId: 'template-upper-power-pump',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      blocks: [
        const WorkoutBlock(
          id: 'block-upp-1',
          name: 'Power & Pump',
          items: [
            TemplateItem(
              id: 'item-upp-1',
              exerciseId: 'exercise-bench-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-upp-1-1',
                  setNumber: 1,
                  targetWeight: 90.0,
                  targetReps: 3,
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
      description: 'Isolation and machine-focused lower body builder[cite: 4].',
      currentRevisionId: 'rev-low-hyp-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['legs', 'hypertrophy', 'isolation'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-low-hyp-001',
      templateId: 'template-lower-hypertrophy',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      blocks: [
        const WorkoutBlock(
          id: 'block-lhy-1',
          name: 'Machine Block',
          items: [
            TemplateItem(
              id: 'item-lhy-1',
              exerciseId: 'exercise-leg-extension-001', // Leg Extension Machine
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-lhy-1-1',
                  setNumber: 1,
                  targetWeight: 50.0,
                  targetReps: 12,
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
      description: 'Dedicated accessory session for arms and delts[cite: 4].',
      currentRevisionId: 'rev-arm-shd-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['arms', 'shoulders', 'accessories'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-arm-shd-001',
      templateId: 'template-arms-shoulders',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      blocks: [
        const WorkoutBlock(
          id: 'block-as-1',
          name: 'Arm Blaster',
          type: WorkoutBlockType.superset,
          rounds: 3,
          items: [
            TemplateItem(
              id: 'item-as-1',
              exerciseId: 'exercise-barbell-curl-001', // Barbell Bicep Curl
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-as-1-1',
                  setNumber: 1,
                  targetWeight: 30.0,
                  targetReps: 10,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-as-2',
              exerciseId:
                  'exercise-skull-crusher-001', // Lying Tricep Extension
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-as-2-1',
                  setNumber: 1,
                  targetWeight: 35.0,
                  targetReps: 10,
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
      description: 'Abs and functional carrying conditioning[cite: 4].',
      currentRevisionId: 'rev-core-cond-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['core', 'conditioning', 'abs'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-core-cond-001',
      templateId: 'template-core-conditioning',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      blocks: [
        const WorkoutBlock(
          id: 'block-cc-1',
          name: 'Circuit Block',
          type: WorkoutBlockType.circuit,
          rounds: 4,
          items: [
            TemplateItem(
              id: 'item-cc-1',
              exerciseId: 'exercise-plank-001', // Forearm Plank
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-cc-1-1',
                  setNumber: 1,
                  targetDurationSeconds: 60,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-cc-2',
              exerciseId: 'exercise-farmers-walk-001', // Farmer's Walk
              order: 2,
              targetSets: [
                TargetSet(
                  id: 'ts-cc-2-1',
                  setNumber: 1,
                  targetWeight: 24.0,
                  targetDistanceMeters: 40.0,
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
      description: 'Incline press heavy session emphasizing upper pectorals[cite: 2, 4].',
      currentRevisionId: 'rev-up-chest-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['chest', 'hypertrophy', 'incline'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-up-chest-001',
      templateId: 'template-upper-chest',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      blocks: [
        const WorkoutBlock(
          id: 'block-uc-1',
          name: 'Chest Focus',
          items: [
            TemplateItem(
              id: 'item-uc-1',
              exerciseId: 'exercise-incline-bench-001',
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-uc-1-1',
                  setNumber: 1,
                  targetWeight: 75.0,
                  targetReps: 8,
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
      description: 'Single-leg strength using split squats[cite: 2, 4].',
      currentRevisionId: 'rev-uni-legs-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['legs', 'unilateral', 'balance'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-uni-legs-001',
      templateId: 'template-unilateral-legs',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      blocks: [
        const WorkoutBlock(
          id: 'block-ul-1',
          name: 'Unilateral Block',
          items: [
            TemplateItem(
              id: 'item-ul-1',
              exerciseId:
                  'exercise-bulgarian-squat-001', // Bulgarian Split Squat
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ul-1-1',
                  setNumber: 1,
                  targetWeight: 20.0,
                  targetReps: 10,
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
      description:
          'Explosive pulling and carrying session with hex bars[cite: 2, 4].',
      currentRevisionId: 'rev-tb-power-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['power', 'functional', 'deadlift'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-tb-power-001',
      templateId: 'template-trap-bar-power',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      blocks: [
        const WorkoutBlock(
          id: 'block-tbp-1',
          name: 'Trap Bar Block',
          items: [
            TemplateItem(
              id: 'item-tbp-1',
              exerciseId: 'exercise-trap-bar-deadlift-001', // Trap Bar Deadlift
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-tbp-1-1',
                  setNumber: 1,
                  targetWeight: 140.0,
                  targetReps: 5,
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
      description:
          'Time-efficient session hitting all major patterns quickly[cite: 4].',
      currentRevisionId: 'rev-exp-full-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['express', 'full-body', 'quick'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-exp-full-001',
      templateId: 'template-express-full',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      blocks: [
        const WorkoutBlock(
          id: 'block-ef-1',
          name: 'Express Circuit',
          items: [
            TemplateItem(
              id: 'item-ef-1',
              exerciseId: 'exercise-goblet-squat-001', // Goblet Squat
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-ef-1-1',
                  setNumber: 1,
                  targetWeight: 24.0,
                  targetReps: 12,
                ),
              ],
            ),
            TemplateItem(
              id: 'item-ef-2',
              exerciseId: 'exercise-pushup-001', // Push-Up
              order: 2,
              targetSets: [
                TargetSet(id: 'ts-ef-2-1', setNumber: 1, targetReps: 15),
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
      description:
          'Intense hip-hinge and glute specialization workout[cite: 4].',
      currentRevisionId: 'rev-post-chain-001',
      createdById: _systemUser,
      createdAt: _epoch,
      updatedAt: _epoch,
      tags: ['posterior-chain', 'glutes', 'hamstrings'],
    ),
    initialRevision: WorkoutTemplateRevision(
      id: 'rev-post-chain-001',
      templateId: 'template-posterior-chain',
      revisionNumber: 1,
      status: TemplateRevisionStatus.published,
      createdById: _systemUser,
      createdAt: _epoch,
      blocks: [
        const WorkoutBlock(
          id: 'block-pc-1',
          name: 'Posterior Block',
          items: [
            TemplateItem(
              id: 'item-pc-1',
              exerciseId:
                  'exercise-cable-pull-through-001', // Cable Pull-Through
              order: 1,
              targetSets: [
                TargetSet(
                  id: 'ts-pc-1-1',
                  setNumber: 1,
                  targetWeight: 35.0,
                  targetReps: 12,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
