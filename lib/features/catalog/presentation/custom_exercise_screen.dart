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
    super.dispose();
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
                // Note: validator can be integrated via form fields wrapping or custom handling if needed,
                // but standard text field here is fully managed.
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
              const SizedBox(height: 28),
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
