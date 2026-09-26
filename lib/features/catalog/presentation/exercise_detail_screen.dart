import 'package:flutter/material.dart';

import '../application/catalog_use_cases.dart';
import '../domain/exercise.dart';
import '../domain/exercise_enums.dart';
import '../infrastructure/exercise_repository.dart';

class ExerciseDetailScreen extends StatefulWidget {
  const ExerciseDetailScreen({
    super.key,
    required this.exercise,
    required this.repository,
    required this.useCases,
    required this.userId,
  });
  final Exercise exercise;
  final IExerciseRepository repository;
  final CatalogUseCases useCases;
  final String userId;

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  late Exercise _exercise;

  @override
  void initState() {
    super.initState();
    _exercise = widget.exercise;
  }

  Future<void> _addRelationship() async {
    final result = await widget.useCases.list();
    if (result.isError || !mounted) return;
    final candidates = result.dataOrNull!
        .where((exercise) => exercise.id != _exercise.id)
        .toList();
    if (candidates.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Add another exercise first')));
      return;
    }

    var target = candidates.first;
    var type = RelationshipType.alternative;
    final reason = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Link related exercise'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            DropdownButtonFormField<Exercise>(
              initialValue: target,
              decoration: const InputDecoration(labelText: 'Exercise'),
              items: candidates
                  .map((exercise) => DropdownMenuItem(
                      value: exercise, child: Text(exercise.name)))
                  .toList(),
              onChanged: (value) =>
                  setDialogState(() => target = value ?? target),
            ),
            DropdownButtonFormField<RelationshipType>(
              initialValue: type,
              decoration: const InputDecoration(labelText: 'Relationship'),
              items: RelationshipType.values
                  .map((value) =>
                      DropdownMenuItem(value: value, child: Text(value.name)))
                  .toList(),
              onChanged: (value) => setDialogState(() => type = value ?? type),
            ),
            TextField(
              controller: reason,
              decoration: const InputDecoration(labelText: 'Reason (optional)'),
            ),
          ]),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: const Text('Cancel')),
            FilledButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: const Text('Link')),
          ],
        ),
      ),
    );
    final reasonText = reason.text;
    reason.dispose();
    if (confirmed != true || !mounted) return;

    final saved = await widget.useCases.addRelationship(
      sourceExerciseId: _exercise.id,
      targetExerciseId: target.id,
      actorId: widget.userId,
      type: type,
      reason: reasonText,
    );
    if (!mounted) return;
    if (saved.isError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(saved.errorOrNull!.message)));
      return;
    }
    final latest = await widget.repository.findById(_exercise.id);
    if (latest.isSuccess && mounted) {
      setState(() => _exercise = latest.dataOrNull!);
    }
  }

  Future<void> _removeRelationship(
      String targetExerciseId, RelationshipType type) async {
    final result = await widget.useCases.removeRelationship(
      sourceExerciseId: _exercise.id,
      targetExerciseId: targetExerciseId,
      actorId: widget.userId,
      type: type,
    );
    if (result.isError && mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result.errorOrNull!.message)));
      return;
    }
    final latest = await widget.repository.findById(_exercise.id);
    if (latest.isSuccess && mounted) {
      setState(() => _exercise = latest.dataOrNull!);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(_exercise.name)),
        body: ListView(padding: const EdgeInsets.all(20), children: [
          Text(_exercise.description,
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 20),
          _section(
              context,
              'Movement',
              _exercise.classification.movementPatterns
                  .map((e) => e.name)
                  .join(', ')),
          _section(
              context,
              'Body region',
              _exercise.classification.bodyRegions
                  .map((e) => e.name)
                  .join(', ')),
          _section(
              context,
              'Primary muscles',
              _exercise.classification.primaryMuscles
                  .map((e) => e.name)
                  .join(', ')),
          _section(
              context,
              'Equipment',
              _exercise.equipment.requiredEquipment
                  .map((e) => e.name)
                  .join(', ')),
          _section(context, 'Tracking',
              _exercise.measurementProfile.defaultMetricType.name),
          if (_exercise.relationships.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text('Related exercises',
                style: Theme.of(context).textTheme.titleMedium),
            ..._exercise.relationships.map((relationship) => ListTile(
                  leading: const Icon(Icons.link),
                  title: FutureBuilder(
                    future: widget.repository
                        .findById(relationship.targetExerciseId),
                    builder: (context, snapshot) => Text(
                      snapshot.data?.dataOrNull?.name ??
                          relationship.targetExerciseId,
                    ),
                  ),
                  subtitle: Text(relationship.type.name +
                      (relationship.reason == null
                          ? ''
                          : ' · ${relationship.reason}')),
                  trailing: _exercise.createdById == widget.userId &&
                          _exercise.sourceType != ExerciseSourceType.system
                      ? IconButton(
                          tooltip: 'Remove relationship',
                          icon: const Icon(Icons.link_off),
                          onPressed: () => _removeRelationship(
                              relationship.targetExerciseId, relationship.type),
                        )
                      : null,
                )),
          ],
          if (_exercise.execution.techniqueCues.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text('Technique cues',
                style: Theme.of(context).textTheme.titleMedium),
            ..._exercise.execution.techniqueCues.map((cue) =>
                ListTile(leading: const Icon(Icons.check), title: Text(cue))),
          ],
          if (_exercise.sourceType != ExerciseSourceType.system &&
              _exercise.createdById == widget.userId)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: OutlinedButton.icon(
                onPressed: _addRelationship,
                icon: const Icon(Icons.add_link),
                label: const Text('Add related exercise'),
              ),
            ),
        ]),
      );

  Widget _section(BuildContext context, String title, String value) => ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(title, style: Theme.of(context).textTheme.labelLarge),
        subtitle: Text(value.isEmpty ? 'Not specified' : value),
      );
}
