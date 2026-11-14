import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:go_router/go_router.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../../core/routing/app_router.dart';
import '../../../catalog/infrastructure/exercise_repository.dart';
import '../../../common/presentation/utils/responsive_layout.dart';
import '../../../common/presentation/widgets/widgets.dart';
import '../../application/session_use_cases.dart';
import '../../application/workout_session_bloc.dart';
import '../../domain/execution_set.dart';
import '../../domain/session_enums.dart';
import '../../domain/workout_session.dart';
import '../widgets/widgets.dart';

class const ActiveSessionScreen({
  super.key,
  required final WorkoutSession session,
  required final SessionUseCases useCases,
  required final IExerciseRepository exerciseRepository,
}) extends StatefulWidget {
  @override
  State<ActiveSessionScreen> createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState()
    extends State<ActiveSessionScreen>
    with WidgetsBindingObserver {
  late WorkoutSession _session = widget.session;
  late final WorkoutSessionBloc _sessionBloc;
  StreamSubscription<WorkoutSessionState>? _sessionSubscription;
  Timer? _ticker;
  DateTime _now = DateTime.now().toUtc();
  bool _busy = false;
  bool _backgroundPausePending = false;
  int _activeSetIndex = 0;
  final Map<String, String> _exerciseNames = {};
  final Set<String> _finishingRestIds = {};

  @override
  void initState() {
    super.initState();
    _sessionBloc = WorkoutSessionBloc(initialSession: widget.session);
    _sessionSubscription = _sessionBloc.stream.listen((state) {
      if (!mounted) return;
      setState(() {
        _session = state.session;
        _busy = state.isBusy;
      });
    });
    WidgetsBinding.instance.addObserver(this);
    _loadExerciseNames();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _backgroundPausePending = false;
      return;
    }
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      _pauseForBackground();
    }
  }

  Future<void> _pauseForBackground() async {
    if (_backgroundPausePending ||
        _session.status != SessionStatus.inProgress) {
      return;
    }
    _backgroundPausePending = true;
    while (_busy && mounted) {
      await Future<void>.delayed(const Duration(milliseconds: 25));
    }
    if (!mounted || _session.status != SessionStatus.inProgress) return;
    await _apply(
      () => widget.useCases.pause(
        _session.id,
        reason: InterruptionReason.applicationBackground,
      ),
    );
  }

  void _tick() {
    if (!mounted) return;
    final now = DateTime.now().toUtc();
    setState(() => _now = now);
    for (final rest in _session.restIntervals.where(
      (entry) =>
          entry.endedAt == null &&
          !now.isBefore(
            entry.startedAt.add(
              Duration(seconds: entry.plannedDurationSeconds),
            ),
          ),
    )) {
      if (!_finishingRestIds.add(rest.id)) continue;
      _apply(
            () => widget.useCases.finishRest(
              _session.id,
              restIntervalId: rest.id,
            ),
          )
          .then((result) {
            if (result?.isSuccess == true) {
              unawaited(HapticFeedback.mediumImpact());
            }
          })
          .whenComplete(() => _finishingRestIds.remove(rest.id));
    }
  }

  Future<void> _loadExerciseNames() async {
    final ids = _session.blocks
        .expand((block) => block.items)
        .map((item) => item.exerciseId)
        .toSet()
        .toList();
    final results = await Future.wait(
      ids.map(widget.exerciseRepository.findById),
    );
    if (!mounted) return;
    setState(() {
      for (var index = 0; index < ids.length; index++) {
        final exercise = results[index].dataOrNull;
        if (exercise != null) _exerciseNames[ids[index]] = exercise.name;
      }
    });
  }

  Future<void> _showExerciseGuidance(
    String exerciseId,
    String exerciseName,
  ) async {
    final result = await widget.exerciseRepository.findById(exerciseId);
    if (!mounted) return;
    final exercise = result.dataOrNull;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            controller: scrollController,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                exercise?.name ?? exerciseName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              if (exercise != null) ...[
                if (exercise.execution.setupInstructions.isNotEmpty) ...[
                  const Text(
                    'Setup Steps',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...exercise.execution.setupInstructions.map(
                    (step) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• '),
                          Expanded(child: Text(step)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                if (exercise.execution.executionInstructions.isNotEmpty) ...[
                  const Text(
                    'Execution Steps',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...exercise.execution.executionInstructions.map(
                    (step) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• '),
                          Expanded(child: Text(step)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                if (exercise.execution.techniqueCues.isNotEmpty) ...[
                  const Text(
                    'Technique Cues',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...exercise.execution.techniqueCues.map(
                    (cue) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            size: 16,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 8),
                          Expanded(child: Text(cue)),
                        ],
                      ),
                    ),
                  ),
                ],
              ] else ...[
                const Text('No guidance details available for this exercise.'),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ticker?.cancel();
    unawaited(_sessionSubscription?.cancel());
    unawaited(_sessionBloc.close());
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<Result<WorkoutSession, Failure>?> _apply(
    Future<Result<WorkoutSession, Failure>> Function() action,
  ) async {
    if (_sessionBloc.state.isBusy) return null;
    final result = await _sessionBloc.execute(action);
    if (!mounted || result == null) return result;
    if (result.isError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result.errorOrNull!.message)));
    }
    return result;
  }

  Future<void> _record(ExecutionSet set) async {
    final weight = TextEditingController(
      text: set.actualWeight?.toString() ?? set.targetWeight?.toString() ?? '',
    );
    final reps = TextEditingController(
      text: set.actualReps?.toString() ?? set.targetReps?.toString() ?? '',
    );
    final duration = TextEditingController(
      text:
          set.actualDurationSeconds?.toString() ??
          set.targetDurationSeconds?.toString() ??
          '',
    );
    final distance = TextEditingController(
      text:
          set.actualDistanceMeters?.toString() ??
          set.targetDistanceMeters?.toString() ??
          '',
    );
    final calories = TextEditingController(
      text:
          set.actualCalories?.toString() ??
          set.targetCalories?.toString() ??
          '',
    );
    final rpe = TextEditingController(text: set.rpe?.toString() ?? '');
    final rir = TextEditingController(text: set.rir?.toString() ?? '');

    final values =
        await showDialog<(double?, int?, int?, double?, int?, double?, int?)>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Set ${set.setNumber}'),
            content: SizedBox(
              width: 400,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _measurementField(weight, 'Weight (kg)', decimal: true),
                    const SizedBox(height: 12),
                    _measurementField(reps, 'Repetitions'),
                    const SizedBox(height: 12),
                    _measurementField(duration, 'Duration (seconds)'),
                    const SizedBox(height: 12),
                    _measurementField(
                      distance,
                      'Distance (meters)',
                      decimal: true,
                    ),
                    const SizedBox(height: 12),
                    _measurementField(calories, 'Calories'),
                    const SizedBox(height: 12),
                    _measurementField(rpe, 'RPE (0–10)', decimal: true),
                    const SizedBox(height: 12),
                    _measurementField(rir, 'Reps in reserve'),
                  ],
                ),
              ),
            ),
            actions: [
              AppButton.ghost(
                label: 'Cancel',
                onPressed: () => Navigator.pop(context),
              ),
              AppButton.primary(
                label: 'Save set',
                onPressed: () => Navigator.pop(context, (
                  double.tryParse(weight.text),
                  int.tryParse(reps.text),
                  int.tryParse(duration.text),
                  double.tryParse(distance.text),
                  int.tryParse(calories.text),
                  double.tryParse(rpe.text),
                  int.tryParse(rir.text),
                )),
              ),
            ],
          ),
        );
    weight.dispose();
    reps.dispose();
    duration.dispose();
    distance.dispose();
    calories.dispose();
    rpe.dispose();
    rir.dispose();
    if (values == null) return;
    final result = await _apply(
      () => widget.useCases.recordSet(
        sessionId: _session.id,
        setId: set.id,
        weight: values.$1,
        reps: values.$2,
        durationSeconds: values.$3,
        distanceMeters: values.$4,
        calories: values.$5,
        rpe: values.$6,
        rir: values.$7,
      ),
    );
    if (result?.isSuccess == true &&
        set.restAutoStart &&
        set.plannedRestSeconds > 0) {
      await _apply(
        () => widget.useCases.startRest(
          sessionId: _session.id,
          executionSetId: set.id,
        ),
      );
    }
  }

  Future<void> _editTarget(ExecutionSet set) async {
    final weight = TextEditingController(
      text: set.targetWeight?.toString() ?? '',
    );
    final reps = TextEditingController(text: set.targetReps?.toString() ?? '');
    final values = await showDialog<(double?, int?)>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit targets for set ${set.setNumber}'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _measurementField(weight, 'Target weight (kg)', decimal: true),
              const SizedBox(height: 12),
              _measurementField(reps, 'Target repetitions'),
            ],
          ),
        ),
        actions: [
          AppButton.ghost(
            label: 'Cancel',
            onPressed: () => Navigator.pop(context),
          ),
          AppButton.primary(
            label: 'Save targets',
            onPressed: () => Navigator.pop(context, (
              double.tryParse(weight.text),
              int.tryParse(reps.text),
            )),
          ),
        ],
      ),
    );
    weight.dispose();
    reps.dispose();
    if (values == null) return;
    await _apply(
      () => widget.useCases.updateSetTarget(
        sessionId: _session.id,
        setId: set.id,
        weight: values.$1,
        reps: values.$2,
        durationSeconds: set.targetDurationSeconds,
        distanceMeters: set.targetDistanceMeters,
        calories: set.targetCalories,
        rpe: set.targetRpe,
        rir: set.targetRir,
        percentageOf1Rm: set.percentageOf1Rm,
      ),
    );
  }

  Future<void> _deleteSet(ExecutionSet set) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete set ${set.setNumber}?'),
        content: const Text(
          'The set will be removed from this session. Its audit history will be retained.',
        ),
        actions: [
          AppButton.ghost(
            label: 'Keep set',
            onPressed: () => Navigator.pop(context, false),
          ),
          AppButton.destructive(
            label: 'Delete set',
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    await _apply(
      () => widget.useCases.deleteSet(
        sessionId: _session.id,
        setId: set.id,
        reason: 'User deleted set from active session',
      ),
    );
  }

  Widget _measurementField(
    TextEditingController controller,
    String label, {
    bool decimal = false,
  }) => AppTextField(
    controller: controller,
    label: label,
    keyboardType: TextInputType.numberWithOptions(decimal: decimal),
  );

  Future<void> _endSession({required bool abandon}) async {
    final action = abandon ? 'abandon' : 'cancel';
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          '${action[0].toUpperCase()}${action.substring(1)} workout?',
        ),
        content: Text(
          abandon
              ? 'This marks the workout as abandoned. Its recorded data will be retained.'
              : 'This cancels the workout and retains its saved data.',
        ),
        actions: [
          AppButton.ghost(
            label: 'Keep workout',
            onPressed: () => Navigator.pop(context, false),
          ),
          AppButton.destructive(
            label: action,
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    final result = abandon
        ? await widget.useCases.abandon(
            _session.id,
            reason: 'User abandoned workout',
          )
        : await widget.useCases.cancel(
            _session.id,
            reason: 'User cancelled workout',
          );
    if (!mounted) return;
    if (result.isError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result.errorOrNull!.message)));
      return;
    }
    context.pop();
  }

  Future<void> _complete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Finish workout?'),
        content: const Text('This saves the session as completed.'),
        actions: [
          PopupMenuButton<String>(
            enabled: !_busy,
            onSelected: (action) => _endSession(abandon: action == 'abandon'),
            itemBuilder: (context) => [
              if (_session.status == SessionStatus.inProgress ||
                  _session.status == SessionStatus.paused)
                const PopupMenuItem(
                  value: 'abandon',
                  child: Text('Abandon workout'),
                ),
              const PopupMenuItem(
                value: 'cancel',
                child: Text('Cancel workout'),
              ),
            ],
          ),
          AppButton.ghost(
            label: 'Keep training',
            onPressed: () => Navigator.pop(context, false),
          ),
          AppButton.primary(
            label: 'Finish',
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => _busy = true);
    final result = await widget.useCases.complete(_session.id);
    if (!mounted) return;
    setState(() => _busy = false);
    if (result.isError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result.errorOrNull!.message)));
      return;
    }
    context.pushReplacement(appRouteSessionSummary, extra: result.dataOrNull);
  }

  String _duration(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final secs = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return hours > 0 ? '$hours:$minutes:$secs' : '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    final paused = _session.status == SessionStatus.paused;
    final colorScheme = Theme.of(context).colorScheme;

    final allSetsWithInfo =
        <({ExecutionSet set, String exerciseName, String exerciseId})>[];
    for (final block in _session.blocks) {
      for (final item in block.items) {
        final exName = _exerciseNames[item.exerciseId] ?? item.exerciseId;
        for (final set in item.sets) {
          allSetsWithInfo.add((
            set: set,
            exerciseName: exName,
            exerciseId: item.exerciseId,
          ));
        }
      }
    }

    if (_activeSetIndex >= allSetsWithInfo.length &&
        allSetsWithInfo.isNotEmpty) {
      _activeSetIndex = allSetsWithInfo.length - 1;
    }
    if (_activeSetIndex < 0) _activeSetIndex = 0;

    final currentInfo = allSetsWithInfo.isNotEmpty
        ? allSetsWithInfo[_activeSetIndex]
        : null;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _endSession(abandon: true),
        ),
        title: Text(
          _session.templateName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          Semantics(
            button: true,
            label: paused ? 'Resume workout' : 'Pause workout',
            child: TextButton(
              onPressed: _busy
                  ? null
                  : () => _apply(
                      () => paused
                          ? widget.useCases.resume(_session.id)
                          : widget.useCases.pause(_session.id),
                    ),
              child: Text(paused ? 'Resume' : 'Pause'),
            ),
          ),
        ],
      ),
      body: ResponsiveContent(
        maxWidth: 850,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: [
            // Focused Active Exercise Card with Timers & Action Buttons
            ActiveExerciseCard(
              exerciseName: currentInfo?.exerciseName ?? 'Workout Active',
              currentSet: currentInfo?.set,
              isBusy: _busy,
              activeDurationText: _duration(
                _session.elapsedActiveSecondsAt(_now),
              ),
              elapsedDurationText: _duration(
                _session.elapsedWallClockSecondsAt(_now),
              ),
              onRecord: _record,
              onEditTarget: _editTarget,
              onDelete: _deleteSet,
              onSkip: (set) => _apply(
                () => widget.useCases.skipSet(
                  sessionId: _session.id,
                  setId: set.id,
                ),
              ),
              onNext: () {
                if (_activeSetIndex < allSetsWithInfo.length - 1) {
                  setState(() => _activeSetIndex++);
                }
              },
              onPrevious: () {
                if (_activeSetIndex > 0) {
                  setState(() => _activeSetIndex--);
                }
              },
              onShowGuidance: currentInfo != null
                  ? () => _showExerciseGuidance(
                      currentInfo.exerciseId,
                      currentInfo.exerciseName,
                    )
                  : null,
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),

            // Full Workout Blocks & Sets List
            WorkoutBlocksList(
              session: _session,
              exerciseNames: _exerciseNames,
              actionsEnabled: !_busy && !paused,
              onRecord: _record,
              onEditTarget: _editTarget,
              onDelete: _deleteSet,
              onSkip: (set) => _apply(
                () => widget.useCases.skipSet(
                  sessionId: _session.id,
                  setId: set.id,
                ),
              ),
              onRest: (set) => _apply(
                () => widget.useCases.startRest(
                  sessionId: _session.id,
                  executionSetId: set.id,
                ),
              ),
            ),
            const SizedBox(height: 60),
            SafeArea(
              minimum: const EdgeInsets.all(16),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 850),
                  child: SizedBox(
                    width: double.infinity,
                    child: AppButton.primary(
                      label: 'Complete workout',
                      icon: Icons.check,
                      onPressed: _busy || paused ? null : _complete,
                      isLoading: _busy,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
