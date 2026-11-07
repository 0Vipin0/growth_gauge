import 'package:flutter/material.dart';

import '../application/catalog_use_cases.dart';
import '../domain/exercise.dart';
import '../domain/exercise_enums.dart';
import '../infrastructure/exercise_repository.dart';

class const ExerciseDetailScreen({
  super.key,
  required final Exercise exercise,
  required final IExerciseRepository repository,
  required final CatalogUseCases useCases,
  required final String userId,
}) extends StatefulWidget {
  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState() extends State<ExerciseDetailScreen> {
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
        const SnackBar(content: Text('Add another exercise first')),
      );
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<Exercise>(
                initialValue: target,
                decoration: const InputDecoration(labelText: 'Exercise'),
                items: candidates
                    .map(
                      (exercise) => DropdownMenuItem(
                        value: exercise,
                        child: Text(exercise.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) =>
                    setDialogState(() => target = value ?? target),
              ),
              DropdownButtonFormField<RelationshipType>(
                initialValue: type,
                decoration: const InputDecoration(labelText: 'Relationship'),
                items: RelationshipType.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(value.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) =>
                    setDialogState(() => type = value ?? type),
              ),
              TextField(
                controller: reason,
                decoration: const InputDecoration(
                  labelText: 'Reason (optional)',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Link'),
            ),
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
    String targetExerciseId,
    RelationshipType type,
  ) async {
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 800;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(title: Text(_exercise.name), centerTitle: true),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 32.0 : 20.0,
                vertical: 24.0,
              ),
              children: [
                if (_exercise.description.isNotEmpty) ...[
                  Text(
                    _exercise.description,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Movement & Body Region Metadata Grid
                Card(
                  elevation: 0,
                  color: colorScheme.surfaceContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _buildMetaRow(
                          context,
                          title: 'Movement Pattern',
                          value: _exercise.classification.movementPatterns
                              .map((e) => e.name)
                              .join(', '),
                        ),
                        const Divider(height: 24),
                        _buildMetaRow(
                          context,
                          title: 'Body Region',
                          value: _exercise.classification.bodyRegions
                              .map((e) => e.name)
                              .join(', '),
                        ),
                        const Divider(height: 24),
                        _buildMetaRow(
                          context,
                          title: 'Primary Muscles',
                          value: _exercise.classification.primaryMuscles
                              .map((e) => e.name)
                              .join(', '),
                        ),
                        const Divider(height: 24),
                        _buildMetaRow(
                          context,
                          title: 'Equipment Required',
                          value: _exercise.equipment.requiredEquipment
                              .map((e) => e.name)
                              .join(', '),
                        ),
                        const Divider(height: 24),
                        _buildMetaRow(
                          context,
                          title: 'Tracking Metric',
                          value: _exercise
                              .measurementProfile
                              .defaultMetricType
                              .name,
                        ),
                      ],
                    ),
                  ),
                ),

                if (_exercise.execution.techniqueCues.isNotEmpty) ...[
                  const SizedBox(height: 28),
                  Text(
                    'Technique Cues',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    elevation: 0,
                    color: colorScheme.surfaceContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: _exercise.execution.techniqueCues
                          .map(
                            (cue) => ListTile(
                              leading: Icon(
                                Icons.check_circle_outline,
                                color: colorScheme.primary,
                              ),
                              title: Text(cue),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],

                if (_exercise.relationships.isNotEmpty) ...[
                  const SizedBox(height: 28),
                  Text(
                    'Related Exercises',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    elevation: 0,
                    color: colorScheme.surfaceContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: _exercise.relationships
                          .map(
                            (relationship) => ListTile(
                              leading: const Icon(Icons.link),
                              title: FutureBuilder(
                                future: widget.repository.findById(
                                  relationship.targetExerciseId,
                                ),
                                builder: (context, snapshot) => Text(
                                  snapshot.data?.dataOrNull?.name ??
                                      relationship.targetExerciseId,
                                ),
                              ),
                              subtitle: Text(
                                relationship.type.name +
                                    (relationship.reason == null
                                        ? ''
                                        : ' · ${relationship.reason}'),
                              ),
                              trailing:
                                  _exercise.createdById == widget.userId &&
                                      _exercise.sourceType !=
                                          ExerciseSourceType.system
                                  ? IconButton(
                                      tooltip: 'Remove relationship',
                                      icon: const Icon(Icons.link_off),
                                      onPressed: () => _removeRelationship(
                                        relationship.targetExerciseId,
                                        relationship.type,
                                      ),
                                    )
                                  : null,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],

                if (_exercise.sourceType != ExerciseSourceType.system &&
                    _exercise.createdById == widget.userId)
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: OutlinedButton.icon(
                      onPressed: _addRelationship,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.add_link),
                      label: const Text('Add Related Exercise'),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetaRow(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
        ),
        Flexible(
          child: Text(
            value.isEmpty ? 'Not specified' : value,
            textAlign: TextAlign.end,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
