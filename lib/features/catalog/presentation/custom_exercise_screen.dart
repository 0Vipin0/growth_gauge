import 'package:flutter/material.dart';

import '../application/catalog_use_cases.dart';
import '../domain/exercise_enums.dart';

class CustomExerciseScreen extends StatefulWidget {
  const CustomExerciseScreen(
      {super.key, required this.useCases, required this.userId});
  final CatalogUseCases useCases;
  final String userId;

  @override
  State<CustomExerciseScreen> createState() => _CustomExerciseScreenState();
}

class _CustomExerciseScreenState extends State<CustomExerciseScreen> {
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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Create exercise')),
        body: Form(
            key: _formKey,
            child: ListView(padding: const EdgeInsets.all(20), children: [
              TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Enter a name' : null),
              const SizedBox(height: 12),
              TextFormField(
                  controller: _description,
                  minLines: 3,
                  maxLines: 5,
                  decoration: const InputDecoration(
                      labelText: 'Description', alignLabelWithHint: true)),
              const SizedBox(height: 12),
              DropdownButtonFormField<BodyRegion>(
                initialValue: _bodyRegion,
                decoration: const InputDecoration(labelText: 'Body region'),
                items: BodyRegion.values
                    .map((value) =>
                        DropdownMenuItem(value: value, child: Text(value.name)))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _bodyRegion = value ?? _bodyRegion),
              ),
              DropdownButtonFormField<MovementPattern>(
                initialValue: _movementPattern,
                decoration:
                    const InputDecoration(labelText: 'Movement pattern'),
                items: MovementPattern.values
                    .map((value) =>
                        DropdownMenuItem(value: value, child: Text(value.name)))
                    .toList(),
                onChanged: (value) => setState(
                    () => _movementPattern = value ?? _movementPattern),
              ),
              DropdownButtonFormField<MuscleGroup>(
                initialValue: _primaryMuscle,
                decoration: const InputDecoration(labelText: 'Primary muscle'),
                items: MuscleGroup.values
                    .map((value) =>
                        DropdownMenuItem(value: value, child: Text(value.name)))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _primaryMuscle = value ?? _primaryMuscle),
              ),
              DropdownButtonFormField<EquipmentType>(
                initialValue: _equipment,
                decoration:
                    const InputDecoration(labelText: 'Required equipment'),
                items: EquipmentType.values
                    .map((value) =>
                        DropdownMenuItem(value: value, child: Text(value.name)))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _equipment = value ?? _equipment),
              ),
              DropdownButtonFormField<MetricType>(
                initialValue: _metricType,
                decoration: const InputDecoration(labelText: 'Tracking metric'),
                items: MetricType.values
                    .map((value) =>
                        DropdownMenuItem(value: value, child: Text(value.name)))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _metricType = value ?? _metricType),
              ),
              const SizedBox(height: 20),
              FilledButton(
                  onPressed: _saving ? null : _save,
                  child: Text(_saving ? 'Saving…' : 'Save exercise')),
            ])),
      );

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
        metricType: _metricType);
    if (!mounted) return;
    setState(() => _saving = false);
    if (result.isError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result.errorOrNull!.message)));
    } else {
      Navigator.of(context).pop(true);
    }
  }
}
