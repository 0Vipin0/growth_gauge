import 'package:flutter/material.dart';

import '../../../core/ids/unique_id.dart';
import '../../../features/catalog/domain/exercise.dart';
import '../../../features/catalog/domain/exercise_enums.dart';
import '../../../features/catalog/infrastructure/exercise_repository.dart';
import '../application/template_use_cases.dart';
import '../domain/rest_policy.dart';
import '../domain/target_set.dart';
import '../domain/template_enums.dart';
import '../domain/template_item.dart';
import '../domain/workout_block.dart';
import '../domain/workout_template_revision.dart';
import '../infrastructure/template_repository.dart';

class TemplateEditorScreen extends StatefulWidget {
  const TemplateEditorScreen(
      {super.key,
      required this.revision,
      required this.repository,
      required this.exerciseRepository,
      required this.useCases,
      required this.userId});
  final WorkoutTemplateRevision revision;
  final ITemplateRepository repository;
  final IExerciseRepository exerciseRepository;
  final TemplateUseCases useCases;
  final String userId;

  @override
  State<TemplateEditorScreen> createState() => _TemplateEditorScreenState();
}

class _TemplateEditorScreenState extends State<TemplateEditorScreen> {
  late List<WorkoutBlock> _blocks;
  bool _saving = false;
  @override
  void initState() {
    super.initState();
    _blocks = [...widget.revision.blocks];
  }

  Future<void> _addBlock() async {
    final name =
        TextEditingController(text: 'Workout block ${_blocks.length + 1}');
    var type = WorkoutBlockType.standard;
    final rounds = TextEditingController(text: '1');
    final value = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add block'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(
                controller: name,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Block name')),
            DropdownButtonFormField<WorkoutBlockType>(
              initialValue: type,
              decoration: const InputDecoration(labelText: 'Block type'),
              items: WorkoutBlockType.values
                  .map((value) =>
                      DropdownMenuItem(value: value, child: Text(value.name)))
                  .toList(),
              onChanged: (value) => setDialogState(() => type = value ?? type),
            ),
            _numberField(rounds, 'Rounds'),
          ]),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: const Text('Cancel')),
            FilledButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: const Text('Add')),
          ],
        ),
      ),
    );
    final cleanName = name.text.trim();
    final roundCount = int.tryParse(rounds.text) ?? 1;
    name.dispose();
    rounds.dispose();
    if (value != true || cleanName.isEmpty || roundCount < 1 || !mounted) {
      return;
    }
    setState(() => _blocks.add(WorkoutBlock(
        id: UniqueId.generate().value,
        name: cleanName,
        type: type,
        rounds: roundCount)));
  }

  Future<void> _addExercise(int blockIndex) async {
    final availableResult = await widget.exerciseRepository.findAll();
    if (availableResult.isError || !mounted) return;
    final exercises = availableResult.dataOrNull!
        .where((exercise) => exercise.status == ExerciseStatus.active)
        .toList();
    if (exercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('The exercise catalog is empty')));
      return;
    }

    var selectedExercise = exercises.first;
    final setCountController = TextEditingController(text: '3');
    final repsController = TextEditingController(text: '8');
    final durationController = TextEditingController(text: '30');
    final distanceController = TextEditingController(text: '1');
    final caloriesController = TextEditingController(text: '100');
    final weightController = TextEditingController();
    final restController = TextEditingController(text: '90');
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Prescribe exercise'),
          content: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              DropdownButtonFormField<Exercise>(
                initialValue: selectedExercise,
                decoration: const InputDecoration(labelText: 'Exercise'),
                items: exercises
                    .map((exercise) => DropdownMenuItem(
                        value: exercise, child: Text(exercise.name)))
                    .toList(),
                onChanged: (value) => setDialogState(
                    () => selectedExercise = value ?? selectedExercise),
              ),
              _numberField(setCountController, 'Sets'),
              if (selectedExercise.measurementProfile.supportsReps)
                _numberField(repsController, 'Reps'),
              if (selectedExercise.measurementProfile.supportsDuration)
                _numberField(durationController, 'Duration (seconds)'),
              if (selectedExercise.measurementProfile.supportsDistance)
                _decimalField(distanceController, 'Distance (metres)'),
              if (selectedExercise.measurementProfile.supportsCalories)
                _numberField(caloriesController, 'Calories'),
              if (selectedExercise.measurementProfile.supportsWeight)
                TextField(
                  controller: weightController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      labelText: 'Target weight (kg, optional)'),
                ),
              _numberField(restController, 'Rest (seconds)'),
            ]),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: const Text('Cancel')),
            FilledButton(
                onPressed: () {
                  final count = int.tryParse(setCountController.text);
                  final reps = int.tryParse(repsController.text);
                  final duration = int.tryParse(durationController.text);
                  final distance = double.tryParse(distanceController.text);
                  final calories = int.tryParse(caloriesController.text);
                  final rest = int.tryParse(restController.text);
                  final weight = double.tryParse(weightController.text);
                  if (count == null ||
                      count < 1 ||
                      count > 30 ||
                      rest == null ||
                      rest < 0 ||
                      rest > 3600 ||
                      (selectedExercise.measurementProfile.supportsReps &&
                          (reps == null || reps < 1 || reps > 1000)) ||
                      (selectedExercise.measurementProfile.supportsDuration &&
                          (duration == null ||
                              duration < 1 ||
                              duration > 86400)) ||
                      (selectedExercise.measurementProfile.supportsDistance &&
                          (distance == null || distance <= 0)) ||
                      (selectedExercise.measurementProfile.supportsCalories &&
                          (calories == null || calories < 1)) ||
                      (weightController.text.trim().isNotEmpty &&
                          (weight == null || weight < 0 || weight > 1000))) {
                    return;
                  }
                  Navigator.pop(dialogContext, true);
                },
                child: const Text('Add exercise')),
          ],
        ),
      ),
    );

    final setCount = int.tryParse(setCountController.text) ?? 0;
    final reps = int.tryParse(repsController.text);
    final duration = int.tryParse(durationController.text);
    final distance = double.tryParse(distanceController.text);
    final calories = int.tryParse(caloriesController.text);
    final rest = int.tryParse(restController.text) ?? 90;
    final weight = double.tryParse(weightController.text);
    setCountController.dispose();
    repsController.dispose();
    durationController.dispose();
    distanceController.dispose();
    caloriesController.dispose();
    weightController.dispose();
    restController.dispose();
    if (confirmed != true || !mounted) return;

    final block = _blocks[blockIndex];
    final sets = List.generate(
      setCount,
      (index) => TargetSet(
        id: UniqueId.generate().value,
        setNumber: index + 1,
        targetReps:
            selectedExercise.measurementProfile.supportsReps ? reps : null,
        targetDurationSeconds:
            selectedExercise.measurementProfile.supportsDuration
                ? duration
                : null,
        targetDistanceMeters:
            selectedExercise.measurementProfile.supportsDistance
                ? distance
                : null,
        targetCalories: selectedExercise.measurementProfile.supportsCalories
            ? calories
            : null,
        targetWeight:
            selectedExercise.measurementProfile.supportsWeight ? weight : null,
        restPolicy: RestPolicy(
          id: UniqueId.generate().value,
          targetSeconds: rest,
        ),
      ),
    );
    final item = TemplateItem(
      id: UniqueId.generate().value,
      exerciseId: selectedExercise.id,
      order: block.items.length,
      targetSets: sets,
    );
    setState(() =>
        _blocks[blockIndex] = block.copyWith(items: [...block.items, item]));
  }

  Widget _numberField(
    TextEditingController controller,
    String label,
  ) =>
      TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: label),
      );

  Widget _decimalField(TextEditingController controller, String label) =>
      TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(labelText: label),
      );

  Future<void> _save({bool publish = false}) async {
    setState(() => _saving = true);
    final result =
        await widget.useCases.updateDraftBlocks(widget.revision.id, _blocks);
    if (result.isError) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result.errorOrNull!.message)));
      }
      return;
    }
    if (publish) {
      final published = await widget.useCases.publish(widget.revision.id);
      if (published.isError) {
        if (mounted) {
          setState(() => _saving = false);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(published.errorOrNull!.message)));
        }
        return;
      }
    }
    if (mounted) {
      setState(() => _saving = false);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: Text('Edit revision ${widget.revision.revisionNumber}')),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: _addBlock,
            icon: const Icon(Icons.add),
            label: const Text('Add block')),
        bottomNavigationBar: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(children: [
                  Expanded(
                      child: OutlinedButton(
                          onPressed: _saving ? null : () => _save(),
                          child: const Text('Save draft'))),
                  const SizedBox(width: 12),
                  Expanded(
                      child: FilledButton(
                          onPressed:
                              _saving ? null : () => _save(publish: true),
                          child:
                              Text(_saving ? 'Saving…' : 'Publish revision'))),
                ]))),
        body: _blocks.isEmpty
            ? const Center(child: Text('Add a block to organise this workout'))
            : ReorderableListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _blocks.length,
                onReorderItem: (oldIndex, newIndex) => setState(() {
                  final block = _blocks.removeAt(oldIndex);
                  _blocks.insert(newIndex, block);
                }),
                itemBuilder: (context, index) {
                  final block = _blocks[index];
                  return Card(
                    key: ValueKey(block.id),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.drag_handle),
                            title: Text(block.name),
                            subtitle: Text(
                                '${block.type.name} · ${block.rounds} round(s)'),
                            trailing: IconButton(
                              tooltip: 'Remove block',
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () =>
                                  setState(() => _blocks.removeAt(index)),
                            ),
                          ),
                          ...block.items.asMap().entries.map((entry) {
                            final itemIndex = entry.key;
                            final item = entry.value;
                            return ListTile(
                              dense: true,
                              leading: const Icon(Icons.fitness_center),
                              title: FutureBuilder(
                                future: widget.exerciseRepository
                                    .findById(item.exerciseId),
                                builder: (context, snapshot) => Text(
                                  snapshot.data?.dataOrNull?.name ??
                                      item.exerciseId,
                                ),
                              ),
                              subtitle: Text(_prescriptionSummary(item)),
                              trailing: IconButton(
                                tooltip: 'Remove exercise',
                                icon: const Icon(Icons.close),
                                onPressed: () =>
                                    _removeExercise(index, itemIndex),
                              ),
                            );
                          }),
                          TextButton.icon(
                            onPressed: () => _addExercise(index),
                            icon: const Icon(Icons.add),
                            label: const Text('Add exercise'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      );

  String _prescriptionSummary(TemplateItem item) {
    if (item.targetSets.isEmpty) return 'No sets prescribed';
    final first = item.targetSets.first;
    final reps =
        first.targetReps == null ? 'time-based' : '${first.targetReps} reps';
    final weight =
        first.targetWeight == null ? '' : ' · ${first.targetWeight} kg';
    final rest = first.restPolicy == null
        ? ''
        : ' · ${first.restPolicy!.targetSeconds}s rest';
    return '${item.targetSets.length} sets · $reps$weight$rest';
  }

  void _removeExercise(int blockIndex, int itemIndex) {
    final items = [..._blocks[blockIndex].items]..removeAt(itemIndex);
    final reordered = [
      for (var index = 0; index < items.length; index++)
        items[index].copyWith(order: index),
    ];
    setState(() =>
        _blocks[blockIndex] = _blocks[blockIndex].copyWith(items: reordered));
  }
}
