import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../common/presentation/widgets/responsive_form_layout.dart';
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
  final _name = TextEditingController();
  final _description = TextEditingController();
  BodyRegion _bodyRegion = BodyRegion.fullBody;
  MovementPattern _movementPattern = MovementPattern.isolation;
  MuscleGroup _primaryMuscle = MuscleGroup.glutes;
  EquipmentType _equipment = EquipmentType.bodyweight;
  MetricType _metricType = MetricType.weightAndReps;
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
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
              TextFormField(
                controller: _name,
                decoration: InputDecoration(
                  labelText: 'Exercise Name',
                  filled: true,
                  fillColor: colorScheme.surfaceContainer,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Enter a name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _description,
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                  filled: true,
                  fillColor: colorScheme.surfaceContainer,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 0,
                color: colorScheme.surfaceContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      DropdownButtonFormField<BodyRegion>(
                        initialValue: _bodyRegion,
                        decoration: const InputDecoration(
                          labelText: 'Body Region',
                          border: InputBorder.none,
                        ),
                        items: BodyRegion.values
                            .map(
                              (v) => DropdownMenuItem(
                                value: v,
                                child: Text(v.name),
                              ),
                            )
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _bodyRegion = v ?? _bodyRegion),
                      ),
                      const Divider(height: 1),
                      DropdownButtonFormField<MovementPattern>(
                        initialValue: _movementPattern,
                        decoration: const InputDecoration(
                          labelText: 'Movement Pattern',
                          border: InputBorder.none,
                        ),
                        items: MovementPattern.values
                            .map(
                              (v) => DropdownMenuItem(
                                value: v,
                                child: Text(v.name),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(
                          () => _movementPattern = v ?? _movementPattern,
                        ),
                      ),
                      const Divider(height: 1),
                      DropdownButtonFormField<MuscleGroup>(
                        initialValue: _primaryMuscle,
                        decoration: const InputDecoration(
                          labelText: 'Primary Muscle',
                          border: InputBorder.none,
                        ),
                        items: MuscleGroup.values
                            .map(
                              (v) => DropdownMenuItem(
                                value: v,
                                child: Text(v.name),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(
                          () => _primaryMuscle = v ?? _primaryMuscle,
                        ),
                      ),
                      const Divider(height: 1),
                      DropdownButtonFormField<EquipmentType>(
                        initialValue: _equipment,
                        decoration: const InputDecoration(
                          labelText: 'Required Equipment',
                          border: InputBorder.none,
                        ),
                        items: EquipmentType.values
                            .map(
                              (v) => DropdownMenuItem(
                                value: v,
                                child: Text(v.name),
                              ),
                            )
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _equipment = v ?? _equipment),
                      ),
                      const Divider(height: 1),
                      DropdownButtonFormField<MetricType>(
                        initialValue: _metricType,
                        decoration: const InputDecoration(
                          labelText: 'Tracking Metric',
                          border: InputBorder.none,
                        ),
                        items: MetricType.values
                            .map(
                              (v) => DropdownMenuItem(
                                value: v,
                                child: Text(v.name),
                              ),
                            )
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _metricType = v ?? _metricType),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _saving ? null : _save,
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _saving ? 'Saving…' : 'Save Exercise',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final result = await widget.useCases.createCustom(
      name: _name.text,
      description: _description.text,
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
