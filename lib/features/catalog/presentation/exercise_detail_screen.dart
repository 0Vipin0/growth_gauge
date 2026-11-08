import 'package:flutter/material.dart';

import '../../common/presentation/widgets/widgets.dart';
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
        const SnackBar(content: Text('Add another exercise first')),
      );
      return;
    }

    var target = candidates.first;
    var type = RelationshipType.alternative;
    final reasonController = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Link related exercise'),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppDropdown<Exercise>(
                  label: 'Exercise',
                  value: target,
                  prefixIcon: Icons.fitness_center,
                  items: candidates
                      .map(
                        (exercise) => AppDropdownItem<Exercise>(
                          value: exercise,
                          label: exercise.name,
                          icon: Icons.fitness_center,
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setDialogState(() => target = value ?? target),
                ),
                const SizedBox(height: 16),
                AppDropdown<RelationshipType>(
                  label: 'Relationship',
                  value: type,
                  prefixIcon: Icons.link,
                  items: RelationshipType.values
                      .map(
                        (value) => AppDropdownItem<RelationshipType>(
                          value: value,
                          label: value.displayName,
                          icon: Icons.compare_arrows,
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setDialogState(() => type = value ?? type),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: reasonController,
                  label: 'Reason (optional)',
                  hintText: 'Enter reason for linking...',
                  prefixIcon: Icons.note_alt_outlined,
                ),
              ],
            ),
          ),
          actions: [
            AppButton.ghost(
              label: 'Cancel',
              onPressed: () => Navigator.pop(dialogContext, false),
            ),
            AppButton.primary(
              label: 'Link',
              onPressed: () => Navigator.pop(dialogContext, true),
            ),
          ],
        ),
      ),
    );
    final reasonText = reasonController.text;
    reasonController.dispose();
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
                AppCard(
                  child: Column(
                    children: [
                      _buildMetaRow(
                        context,
                        title: 'Movement Pattern',
                        value: _exercise.classification.movementPatterns
                            .map((e) => e.displayName) 
                            .join(', '),
                      ),
                      const Divider(height: 24),
                      _buildMetaRow(
                        context,
                        title: 'Body Region',
                        value: _exercise.classification.bodyRegions
                            .map((e) => e.displayName) 
                            .join(', '),
                      ),
                      const Divider(height: 24),
                      _buildMetaRow(
                        context,
                        title: 'Primary Muscles',
                        value: _exercise.classification.primaryMuscles
                            .map((e) => e.displayName) 
                            .join(', '),
                      ),
                      const Divider(height: 24),
                      _buildMetaRow(
                        context,
                        title: 'Equipment Required',
                        value: _exercise.equipment.requiredEquipment
                            .map((e) => e.displayName) 
                            .join(', '),
                      ),
                      const Divider(height: 24),
                      _buildMetaRow(
                        context,
                        title: 'Tracking Metric',
                        value: _exercise
                            .measurementProfile
                            .defaultMetricType
                            .displayName, 
                      ),
                    ],
                  ),
                ),

                if (_exercise.execution.setupInstructions.isNotEmpty)
                  _buildStepList(
                    context,
                    title: 'Setup Steps',
                    steps: _exercise.execution.setupInstructions,
                    badgeColor: colorScheme.primaryContainer,
                    onBadgeColor: colorScheme.onPrimaryContainer,
                  ),

                if (_exercise.execution.executionInstructions.isNotEmpty)
                  _buildStepList(
                    context,
                    title: 'Execution Steps',
                    steps: _exercise.execution.executionInstructions,
                    badgeColor: colorScheme.primary,
                    onBadgeColor: colorScheme.onPrimary,
                  ),

                if (_exercise.execution.breathingInstructions != null &&
                    _exercise.execution.breathingInstructions!
                        .trim()
                        .isNotEmpty) ...[
                  const SizedBox(height: 28),
                  Text(
                    'Breathing Guidance',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  AppCard(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.air,
                            color: colorScheme.onPrimaryContainer,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            _exercise.execution.breathingInstructions!,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

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
                  AppCard(
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
                  AppCard(
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
                                relationship.type.displayName + 
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
                    child: AppButton.outlined(
                      label: 'Add Related Exercise',
                      icon: Icons.add_link,
                      onPressed: _addRelationship,
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

  Widget _buildStepList(
    BuildContext context, {
    required String title,
    required List<String> steps,
    required Color badgeColor,
    required Color onBadgeColor,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 28),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        AppCard(
          child: Column(
            children: List.generate(steps.length, (index) {
              final stepNumber = index + 1;
              final isLast = index == steps.length - 1;
              return Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: badgeColor,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$stepNumber',
                        style: TextStyle(
                          color: onBadgeColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        steps[index],
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
