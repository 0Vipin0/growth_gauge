import 'package:flutter/material.dart';

import '../domain/exercise.dart';

class ExerciseDetailScreen extends StatelessWidget {
  const ExerciseDetailScreen({super.key, required this.exercise});
  final Exercise exercise;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(exercise.name)),
        body: ListView(padding: const EdgeInsets.all(20), children: [
          Text(exercise.description,
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 20),
          _section(
              context,
              'Movement',
              exercise.classification.movementPatterns
                  .map((e) => e.name)
                  .join(', ')),
          _section(
              context,
              'Body region',
              exercise.classification.bodyRegions
                  .map((e) => e.name)
                  .join(', ')),
          _section(
              context,
              'Primary muscles',
              exercise.classification.primaryMuscles
                  .map((e) => e.name)
                  .join(', ')),
          _section(
              context,
              'Equipment',
              exercise.equipment.requiredEquipment
                  .map((e) => e.name)
                  .join(', ')),
          _section(context, 'Tracking',
              exercise.measurementProfile.defaultMetricType.name),
          if (exercise.execution.techniqueCues.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text('Technique cues',
                style: Theme.of(context).textTheme.titleMedium),
            ...exercise.execution.techniqueCues.map((cue) =>
                ListTile(leading: const Icon(Icons.check), title: Text(cue))),
          ],
        ]),
      );

  Widget _section(BuildContext context, String title, String value) => ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(title, style: Theme.of(context).textTheme.labelLarge),
        subtitle: Text(value.isEmpty ? 'Not specified' : value),
      );
}
