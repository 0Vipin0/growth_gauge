import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/error/failures.dart';
import '../../../core/error/result.dart';
import '../../catalog/infrastructure/exercise_repository.dart';
import '../application/session_use_cases.dart';
import '../application/workout_session_bloc.dart';
import '../domain/execution_set.dart';
import '../domain/session_enums.dart';
import '../domain/session_item.dart';
import '../domain/workout_session.dart';
import 'session_summary_screen.dart';

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
        () => widget.useCases.finishRest(_session.id, restIntervalId: rest.id),
      ).whenComplete(() => _finishingRestIds.remove(rest.id));
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
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _measurementField(weight, 'Weight (kg)', decimal: true),
                  _measurementField(reps, 'Repetitions'),
                  _measurementField(duration, 'Duration (seconds)'),
                  _measurementField(
                    distance,
                    'Distance (meters)',
                    decimal: true,
                  ),
                  _measurementField(calories, 'Calories'),
                  _measurementField(rpe, 'RPE (0–10)', decimal: true),
                  _measurementField(rir, 'Reps in reserve'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, (
                  double.tryParse(weight.text),
                  int.tryParse(reps.text),
                  int.tryParse(duration.text),
                  double.tryParse(distance.text),
                  int.tryParse(calories.text),
                  double.tryParse(rpe.text),
                  int.tryParse(rir.text),
                )),
                child: const Text('Save set'),
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
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _measurementField(weight, 'Target weight (kg)', decimal: true),
            _measurementField(reps, 'Target repetitions'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, (
              double.tryParse(weight.text),
              int.tryParse(reps.text),
            )),
            child: const Text('Save targets'),
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
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep set'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete set'),
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
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: decimal),
      decoration: InputDecoration(labelText: label),
    ),
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
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep workout'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(action),
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
    Navigator.of(context).pop();
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
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep training'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Finish'),
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
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => SessionSummaryScreen(session: result.dataOrNull!),
      ),
    );
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
    return Scaffold(
      appBar: AppBar(
        title: Text(_session.templateName),
        actions: [
          TextButton(
            onPressed: _busy
                ? null
                : () => _apply(
                    () => paused
                        ? widget.useCases.resume(_session.id)
                        : widget.useCases.pause(_session.id),
                  ),
            child: Text(paused ? 'Resume' : 'Pause'),
          ),
        ],
      ),
      body: Column(
        children: [
          Material(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _Metric(
                    label: 'Active',
                    value: _duration(_session.elapsedActiveSecondsAt(_now)),
                  ),
                  _Metric(
                    label: 'Elapsed',
                    value: _duration(_session.elapsedWallClockSecondsAt(_now)),
                  ),
                ],
              ),
            ),
          ),
          if (paused)
            const ListTile(
              leading: Icon(Icons.pause_circle_outline),
              title: Text('Workout paused'),
            ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 100),
              children: [
                for (final block in _session.blocks) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                    child: Text(
                      block.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  for (final item in block.items)
                    _ExerciseCard(
                      item: item,
                      exerciseName:
                          _exerciseNames[item.exerciseId] ?? item.exerciseId,
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
                ],
                const SizedBox(height: 24),
                for (final rest in _session.restIntervals.where(
                  (entry) => entry.endedAt == null,
                ))
                  Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.hourglass_top),
                      title: Text(
                        'Rest ${_duration(_now.difference(rest.startedAt).inSeconds)}',
                      ),
                      subtitle: Text(
                        'Target ${_duration(rest.plannedDurationSeconds)}',
                      ),
                      trailing: Wrap(
                        spacing: 4,
                        children: [
                          if (rest.allowExtend)
                            IconButton(
                              tooltip: 'Extend rest by 15 seconds',
                              onPressed:
                                  _busy ||
                                      (rest.maximumDurationSeconds != null &&
                                          rest.plannedDurationSeconds >=
                                              rest.maximumDurationSeconds!)
                                  ? null
                                  : () => _apply(
                                      () => widget.useCases.extendRest(
                                        _session.id,
                                        restIntervalId: rest.id,
                                      ),
                                    ),
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                          if (rest.allowSkip)
                            TextButton(
                              onPressed:
                                  _busy ||
                                      _now
                                              .difference(rest.startedAt)
                                              .inSeconds <
                                          rest.minimumDurationSeconds
                                  ? null
                                  : () => _apply(
                                      () => widget.useCases.skipRest(
                                        _session.id,
                                        restIntervalId: rest.id,
                                      ),
                                    ),
                              child: const Text('Skip'),
                            ),
                          FilledButton(
                            onPressed:
                                _busy ||
                                    _now.difference(rest.startedAt).inSeconds <
                                        rest.minimumDurationSeconds ||
                                    (!rest.allowSkip &&
                                        _now
                                                .difference(rest.startedAt)
                                                .inSeconds <
                                            rest.plannedDurationSeconds)
                                ? null
                                : () => _apply(
                                    () => widget.useCases.finishRest(
                                      _session.id,
                                      restIntervalId: rest.id,
                                    ),
                                  ),
                            child: const Text('Done'),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: FilledButton.icon(
          onPressed: _busy || paused ? null : _complete,
          icon: const Icon(Icons.check),
          label: const Text('Complete workout'),
        ),
      ),
    );
  }
}

class const _ExerciseCard({
  required final SessionItem item,
  required final String exerciseName,
  required final bool actionsEnabled,
  required final ValueChanged<ExecutionSet> onRecord,
  required final ValueChanged<ExecutionSet> onEditTarget,
  required final ValueChanged<ExecutionSet> onDelete,
  required final ValueChanged<ExecutionSet> onSkip,
  required final ValueChanged<ExecutionSet> onRest,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(exerciseName, style: Theme.of(context).textTheme.titleMedium),
          for (final set in item.sets)
            ListTile(
              dense: true,
              title: Text(
                'Set ${set.setNumber}  ·  ${set.targetWeight == null ? '' : '${set.targetWeight} kg'} ${set.targetReps == null ? '' : '× ${set.targetReps}'}',
              ),
              subtitle: Text(set.status.name.toUpperCase()),
              trailing: set.status == ExecutionSetStatus.completed
                  ? PopupMenuButton<_SetAction>(
                      enabled: actionsEnabled,
                      onSelected: (action) {
                        if (action == _SetAction.startRest) {
                          onRest(set);
                        } else {
                          onDelete(set);
                        }
                      },
                      itemBuilder: (context) => [
                        if (set.plannedRestSeconds > 0)
                          const PopupMenuItem(
                            value: _SetAction.startRest,
                            child: Text('Start rest'),
                          ),
                        const PopupMenuItem(
                          value: _SetAction.delete,
                          child: Text('Delete set'),
                        ),
                      ],
                    )
                  : set.status == ExecutionSetStatus.skipped
                  ? PopupMenuButton<_SetAction>(
                      enabled: actionsEnabled,
                      onSelected: (_) => onDelete(set),
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: _SetAction.delete,
                          child: Text('Delete set'),
                        ),
                      ],
                    )
                  : PopupMenuButton<_SetAction>(
                      enabled: actionsEnabled,
                      onSelected: (action) {
                        switch (action) {
                          case _SetAction.editTarget:
                            onEditTarget(set);
                          case _SetAction.record:
                            onRecord(set);
                          case _SetAction.startRest:
                            onRest(set);
                          case _SetAction.skip:
                            onSkip(set);
                          case _SetAction.delete:
                            onDelete(set);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: _SetAction.editTarget,
                          child: Text('Edit target'),
                        ),
                        const PopupMenuItem(
                          value: _SetAction.record,
                          child: Text('Log set'),
                        ),
                        const PopupMenuItem(
                          value: _SetAction.skip,
                          child: Text('Skip set'),
                        ),
                        const PopupMenuItem(
                          value: _SetAction.delete,
                          child: Text('Delete set'),
                        ),
                      ],
                    ),
            ),
        ],
      ),
    ),
  );
}

enum _SetAction() {
  editTarget,
  record,
  startRest,
  skip,
  delete,
}

class const _Metric({required final String label, required final String value})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(value, style: Theme.of(context).textTheme.titleLarge),
      Text(label, style: Theme.of(context).textTheme.labelMedium),
    ],
  );
}
