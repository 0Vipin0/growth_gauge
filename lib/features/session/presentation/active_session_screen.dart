import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/error/failures.dart';
import '../../../core/error/result.dart';
import '../../../features/catalog/infrastructure/exercise_repository.dart';
import '../application/session_use_cases.dart';
import '../domain/execution_set.dart';
import '../domain/session_enums.dart';
import '../domain/session_item.dart';
import '../domain/workout_session.dart';
import 'session_summary_screen.dart';

class ActiveSessionScreen extends StatefulWidget {
  const ActiveSessionScreen({
    super.key,
    required this.session,
    required this.useCases,
    required this.exerciseRepository,
  });

  final WorkoutSession session;
  final SessionUseCases useCases;
  final IExerciseRepository exerciseRepository;

  @override
  State<ActiveSessionScreen> createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen> {
  late WorkoutSession _session = widget.session;
  Timer? _ticker;
  DateTime _now = DateTime.now().toUtc();
  bool _busy = false;
  final Map<String, String> _exerciseNames = {};

  @override
  void initState() {
    super.initState();
    _loadExerciseNames();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _now = DateTime.now().toUtc());
    });
  }

  Future<void> _loadExerciseNames() async {
    final ids = _session.blocks
        .expand((block) => block.items)
        .map((item) => item.exerciseId)
        .toSet()
        .toList();
    final results =
        await Future.wait(ids.map(widget.exerciseRepository.findById));
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
    super.dispose();
  }

  Future<void> _apply<T>(Future<Result<T, Failure>> Function() action) async {
    if (_busy) return;
    setState(() => _busy = true);
    final result = await action();
    if (!mounted) return;
    setState(() {
      _busy = false;
      final updated = result.dataOrNull;
      if (updated is WorkoutSession) _session = updated;
    });
    if (result.isError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.errorOrNull!.message)),
      );
    }
  }

  Future<void> _record(ExecutionSet set) async {
    final weight = TextEditingController(
        text:
            set.actualWeight?.toString() ?? set.targetWeight?.toString() ?? '');
    final reps = TextEditingController(
        text: set.actualReps?.toString() ?? set.targetReps?.toString() ?? '');
    final duration = TextEditingController(
        text: set.actualDurationSeconds?.toString() ??
            set.targetDurationSeconds?.toString() ??
            '');
    final distance = TextEditingController(
        text: set.actualDistanceMeters?.toString() ??
            set.targetDistanceMeters?.toString() ??
            '');
    final calories = TextEditingController(
        text: set.actualCalories?.toString() ??
            set.targetCalories?.toString() ??
            '');
    final rpe = TextEditingController(text: set.rpe?.toString() ?? '');
    final rir = TextEditingController(text: set.rir?.toString() ?? '');
    final values =
        await showDialog<(double?, int?, int?, double?, int?, double?, int?)>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Set ${set.setNumber}'),
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            _measurementField(weight, 'Weight (kg)', decimal: true),
            _measurementField(reps, 'Repetitions'),
            _measurementField(duration, 'Duration (seconds)'),
            _measurementField(distance, 'Distance (meters)', decimal: true),
            _measurementField(calories, 'Calories'),
            _measurementField(rpe, 'RPE (0–10)', decimal: true),
            _measurementField(rir, 'Reps in reserve'),
          ]),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(
              context,
              (
                double.tryParse(weight.text),
                int.tryParse(reps.text),
                int.tryParse(duration.text),
                double.tryParse(distance.text),
                int.tryParse(calories.text),
                double.tryParse(rpe.text),
                int.tryParse(rir.text),
              ),
            ),
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
    await _apply(() => widget.useCases.recordSet(
          sessionId: _session.id,
          setId: set.id,
          weight: values.$1,
          reps: values.$2,
          durationSeconds: values.$3,
          distanceMeters: values.$4,
          calories: values.$5,
          rpe: values.$6,
          rir: values.$7,
        ));
  }

  Future<void> _editTarget(ExecutionSet set) async {
    final weight =
        TextEditingController(text: set.targetWeight?.toString() ?? '');
    final reps = TextEditingController(text: set.targetReps?.toString() ?? '');
    final values = await showDialog<(double?, int?)>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit targets for set ${set.setNumber}'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          _measurementField(weight, 'Target weight (kg)', decimal: true),
          _measurementField(reps, 'Target repetitions'),
        ]),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(context,
                (double.tryParse(weight.text), int.tryParse(reps.text))),
            child: const Text('Save targets'),
          ),
        ],
      ),
    );
    weight.dispose();
    reps.dispose();
    if (values == null) return;
    await _apply(() => widget.useCases.updateSetTarget(
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
        ));
  }

  Widget _measurementField(TextEditingController controller, String label,
          {bool decimal = false}) =>
      Padding(
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
        title:
            Text('${action[0].toUpperCase()}${action.substring(1)} workout?'),
        content: Text(abandon
            ? 'This marks the workout as abandoned. Its recorded data will be retained.'
            : 'This cancels the workout and retains its saved data.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Keep workout')),
          FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(action)),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    final result = abandon
        ? await widget.useCases
            .abandon(_session.id, reason: 'User abandoned workout')
        : await widget.useCases
            .cancel(_session.id, reason: 'User cancelled workout');
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
                    value: 'abandon', child: Text('Abandon workout')),
              const PopupMenuItem(
                  value: 'cancel', child: Text('Cancel workout')),
            ],
          ),
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Keep training')),
          FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Finish')),
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
    await Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => SessionSummaryScreen(session: result.dataOrNull!),
    ));
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
                : () => _apply(() => paused
                    ? widget.useCases.resume(_session.id)
                    : widget.useCases.pause(_session.id)),
            child: Text(paused ? 'Resume' : 'Pause'),
          ),
        ],
      ),
      body: Column(children: [
        Material(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _Metric(
                      label: 'Active',
                      value: _duration(_session.elapsedActiveSecondsAt(_now))),
                  _Metric(
                      label: 'Elapsed',
                      value:
                          _duration(_session.elapsedWallClockSecondsAt(_now))),
                ]),
          ),
        ),
        if (paused)
          const ListTile(
              leading: Icon(Icons.pause_circle_outline),
              title: Text('Workout paused')),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 100),
            children: [
              for (final block in _session.blocks) ...[
                Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                    child: Text(block.name,
                        style: Theme.of(context).textTheme.titleLarge)),
                for (final item in block.items)
                  _ExerciseCard(
                    item: item,
                    exerciseName:
                        _exerciseNames[item.exerciseId] ?? item.exerciseId,
                    onRecord: _record,
                    onEditTarget: _editTarget,
                    onSkip: (set) => _apply(() => widget.useCases
                        .skipSet(sessionId: _session.id, setId: set.id)),
                    onRest: (set) => _apply(() => widget.useCases.startRest(
                        sessionId: _session.id, executionSetId: set.id)),
                  ),
              ],
              const SizedBox(height: 24),
              for (final rest in _session.restIntervals
                  .where((entry) => entry.endedAt == null))
                Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.hourglass_top),
                    title: Text(
                        'Rest ${_duration(_now.difference(rest.startedAt).inSeconds)}'),
                    subtitle: Text(
                        'Target ${_duration(rest.plannedDurationSeconds)}'),
                    trailing: FilledButton(
                        onPressed: _busy
                            ? null
                            : () => _apply(() => widget.useCases.finishRest(
                                _session.id,
                                restIntervalId: rest.id)),
                        child: const Text('Done')),
                  ),
                ),
            ],
          ),
        ),
      ]),
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

class _ExerciseCard extends StatelessWidget {
  const _ExerciseCard(
      {required this.item,
      required this.exerciseName,
      required this.onRecord,
      required this.onEditTarget,
      required this.onSkip,
      required this.onRest});

  final SessionItem item;
  final String exerciseName;
  final ValueChanged<ExecutionSet> onRecord;
  final ValueChanged<ExecutionSet> onEditTarget;
  final ValueChanged<ExecutionSet> onSkip;
  final ValueChanged<ExecutionSet> onRest;

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(exerciseName, style: Theme.of(context).textTheme.titleMedium),
            for (final set in item.sets)
              ListTile(
                dense: true,
                title: Text(
                    'Set ${set.setNumber}  ·  ${set.targetWeight == null ? '' : '${set.targetWeight} kg'} ${set.targetReps == null ? '' : '× ${set.targetReps}'}'),
                subtitle: Text(set.status.name.toUpperCase()),
                trailing: set.status == ExecutionSetStatus.completed ||
                        set.status == ExecutionSetStatus.skipped
                    ? const Icon(Icons.check_circle_outline)
                    : Wrap(spacing: 2, children: [
                        IconButton(
                            tooltip: 'Edit target',
                            onPressed: () => onEditTarget(set),
                            icon: const Icon(Icons.edit_outlined)),
                        IconButton(
                            tooltip: 'Log set',
                            onPressed: () => onRecord(set),
                            icon: const Icon(Icons.check)),
                        if (set.plannedRestSeconds > 0)
                          IconButton(
                              tooltip: 'Start rest',
                              onPressed: () => onRest(set),
                              icon: const Icon(Icons.timer_outlined)),
                        IconButton(
                            tooltip: 'Skip set',
                            onPressed: () => onSkip(set),
                            icon: const Icon(Icons.skip_next)),
                      ]),
              ),
          ]),
        ),
      );
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Column(children: [
        Text(value, style: Theme.of(context).textTheme.titleLarge),
        Text(label, style: Theme.of(context).textTheme.labelMedium),
      ]);
}
