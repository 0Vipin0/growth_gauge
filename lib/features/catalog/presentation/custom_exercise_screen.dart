import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../common/presentation/utils/responsive_form_layout.dart';
import '../../common/presentation/widgets/widgets.dart';
import '../application/catalog_use_cases.dart';
import '../domain/exercise_enums.dart';

class const CustomExerciseScreen({
  super.key,
  required final CatalogUseCases useCases,
  required final String userId,
}) extends StatefulWidget {
  @override
  State<CustomExerciseScreen> createState() => _CustomExerciseScreenState();
}

class _CustomExerciseScreenState() extends State<CustomExerciseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _setupStepController = TextEditingController();
  final _executionStepController = TextEditingController();

  final List<String> _setupSteps = [];
  final List<String> _executionSteps = [];

  BodyRegion _bodyRegion = BodyRegion.fullBody;
  MovementPattern _movementPattern = MovementPattern.isolation;
  MuscleGroup _primaryMuscle = MuscleGroup.glutes;
  EquipmentType _equipment = EquipmentType.bodyweight;
  MetricType _metricType = MetricType.weightAndReps;
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _setupStepController.dispose();
    _executionStepController.dispose();
    super.dispose();
  }

  void _addSetupStep() {
    final text = _setupStepController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _setupSteps.add(text);
      _setupStepController.clear();
    });
  }

  void _addExecutionStep() {
    final text = _executionStepController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _executionSteps.add(text);
      _executionStepController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Create Custom Exercise'),
        centerTitle: true,
      ),
      body: ResponsiveFormLayout(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              AppTextField(
                controller: _nameController,
                label: 'Exercise Name',
                hintText: 'Enter exercise name...',
                prefixIcon: Icons.fitness_center,
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _descriptionController,
                label: 'Description',
                hintText: 'Enter exercise description (optional)...',
                prefixIcon: Icons.description_outlined,
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              AppCard(
                child: Column(
                  children: [
                    AppDropdown<BodyRegion>(
                      label: 'Body Region',
                      value: _bodyRegion,
                      prefixIcon: Icons.accessibility_new,
                      items: BodyRegion.values
                          .map(
                            (v) => AppDropdownItem<BodyRegion>(
                              value: v,
                              label: v.name,
                              icon: Icons.accessibility,
                            ),
                          )
                          .toList(),
                      onChanged: (v) =>
                          setState(() => _bodyRegion = v ?? _bodyRegion),
                    ),
                    const Divider(height: 24),
                    AppDropdown<MovementPattern>(
                      label: 'Movement Pattern',
                      value: _movementPattern,
                      prefixIcon: Icons.directions_run,
                      items: MovementPattern.values
                          .map(
                            (v) => AppDropdownItem<MovementPattern>(
                              value: v,
                              label: v.name,
                              icon: Icons.alt_route,
                            ),
                          )
                          .toList(),
                      onChanged: (v) => setState(
                        () => _movementPattern = v ?? _movementPattern,
                      ),
                    ),
                    const Divider(height: 24),
                    AppDropdown<MuscleGroup>(
                      label: 'Primary Muscle',
                      value: _primaryMuscle,
                      prefixIcon: Icons.monitor_weight_outlined,
                      items: MuscleGroup.values
                          .map(
                            (v) => AppDropdownItem<MuscleGroup>(
                              value: v,
                              label: v.name,
                              icon: Icons.fitness_center,
                            ),
                          )
                          .toList(),
                      onChanged: (v) =>
                          setState(() => _primaryMuscle = v ?? _primaryMuscle),
                    ),
                    const Divider(height: 24),
                    AppDropdown<EquipmentType>(
                      label: 'Required Equipment',
                      value: _equipment,
                      prefixIcon: Icons.sports_gymnastics,
                      items: EquipmentType.values
                          .map(
                            (v) => AppDropdownItem<EquipmentType>(
                              value: v,
                              label: v.name,
                              icon: Icons.fitness_center,
                            ),
                          )
                          .toList(),
                      onChanged: (v) =>
                          setState(() => _equipment = v ?? _equipment),
                    ),
                    const Divider(height: 24),
                    AppDropdown<MetricType>(
                      label: 'Tracking Metric',
                      value: _metricType,
                      prefixIcon: Icons.show_chart,
                      items: MetricType.values
                          .map(
                            (v) => AppDropdownItem<MetricType>(
                              value: v,
                              label: v.name,
                              icon: Icons.analytics,
                            ),
                          )
                          .toList(),
                      onChanged: (v) =>
                          setState(() => _metricType = v ?? _metricType),
                    ),
                  ],
                ),
              ),

              // Setup Steps Builder Section
              const SizedBox(height: 28),
              _buildStepSection(
                title: 'Setup Steps',
                subtitle: 'Preparation steps (e.g. rack height, stance, grip)',
                controller: _setupStepController,
                steps: _setupSteps,
                onAdd: _addSetupStep,
                badgeColor: colorScheme.primaryContainer,
                onBadgeColor: colorScheme.onPrimaryContainer,
                onDelete: (index) =>
                    setState(() => _setupSteps.removeAt(index)),
              ),

              // Execution Steps Builder Section
              const SizedBox(height: 28),
              _buildStepSection(
                title: 'Execution Steps',
                subtitle: 'Movement execution (e.g. descent, drive, lockout)',
                controller: _executionStepController,
                steps: _executionSteps,
                onAdd: _addExecutionStep,
                badgeColor: colorScheme.primary,
                onBadgeColor: colorScheme.onPrimary,
                onDelete: (index) =>
                    setState(() => _executionSteps.removeAt(index)),
              ),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: AppButton.primary(
                  label: _saving ? 'Saving…' : 'Save Exercise',
                  onPressed: _saving ? null : _save,
                  isLoading: _saving,
                  icon: Icons.check,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepSection({
    required String title,
    required String subtitle,
    required TextEditingController controller,
    required List<String> steps,
    required VoidCallback onAdd,
    required Color badgeColor,
    required Color onBadgeColor,
    required ValueChanged<int> onDelete,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppTextField(
                controller: controller,
                label: 'Step Description',
                hintText: 'Enter step detail...',
                prefixIcon: Icons.format_list_numbered,
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: IconButton.filledTonal(
                tooltip: 'Add Step',
                icon: const Icon(Icons.add),
                onPressed: onAdd,
              ),
            ),
          ],
        ),
        if (steps.isNotEmpty) ...[
          const SizedBox(height: 12),
          AppCard(
            child: Column(
              children: List.generate(steps.length, (index) {
                final stepNum = index + 1;
                final isLast = index == steps.length - 1;
                return Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: badgeColor,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '$stepNum',
                          style: TextStyle(
                            color: onBadgeColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text(
                            steps[index],
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Remove step',
                        icon: const Icon(Icons.delete_outline, size: 20),
                        color: colorScheme.error,
                        onPressed: () => onDelete(index),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _save() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an exercise name')),
      );
      return;
    }
    setState(() => _saving = true);
    final result = await widget.useCases.createCustom(
      name: _nameController.text,
      description: _descriptionController.text,
      createdById: widget.userId,
      bodyRegion: _bodyRegion,
      movementPattern: _movementPattern,
      primaryMuscle: _primaryMuscle,
      equipment: _equipment,
      metricType: _metricType,
      setupInstructions: _setupSteps,
      executionInstructions: _executionSteps,
    );
    if (!mounted) return;
    setState(() => _saving = false);
    if (result.isError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result.errorOrNull!.message)));
    } else {
      context.pop(true);
    }
  }
}
