import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/analytics_cubit.dart';
import '../widgets/progression_line_chart.dart';

/// Screen displaying 1RM estimated curve and set history for a selected exercise.
class const ExerciseProgressionScreen({
  super.key,
  final String? initialExerciseId,
}) extends StatefulWidget {
  @override
  State<ExerciseProgressionScreen> createState() =>
      _ExerciseProgressionScreenState();
}

class _ExerciseProgressionScreenState()
    extends State<ExerciseProgressionScreen> {
  // Common standard exercises to quick-pick
  final List<Map<String, String>> _exercises = const [
    {'id': 'exercise-squat-001', 'name': 'Barbell Back Squat'},
    {'id': 'exercise-bench-001', 'name': 'Barbell Bench Press'},
    {'id': 'exercise-deadlift-001', 'name': 'Conventional Deadlift'},
    {'id': 'exercise-ohp-001', 'name': 'Overhead Press'},
    {'id': 'exercise-row-001', 'name': 'Barbell Row'},
    {'id': 'exercise-pullup-001', 'name': 'Pull-Up'},
    {'id': 'exercise-rdl-001', 'name': 'Dumbbell RDL'},
  ];

  late String _currentExerciseId;

  @override
  void initState() {
    super.initState();
    _currentExerciseId = widget.initialExerciseId ?? _exercises.first['id']!;
    context.read<AnalyticsCubit>().selectExercise(_currentExerciseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise Progression')),
      body: BlocBuilder<AnalyticsCubit, AnalyticsState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: DropdownButtonFormField<String>(
                  initialValue: _currentExerciseId,
                  decoration: const InputDecoration(
                    labelText: 'Select Exercise',
                    border: OutlineInputBorder(),
                  ),
                  items: _exercises.map((e) {
                    return DropdownMenuItem<String>(
                      value: e['id'],
                      child: Text(e['name']!),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _currentExerciseId = val);
                      context.read<AnalyticsCubit>().selectExercise(val);
                    }
                  },
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    ProgressionLineChart(metrics: state.exerciseProgression),
                    const SizedBox(height: 24),
                    Text(
                      'Completed Sets History',
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    if (state.exerciseProgression.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'No completed sets logged yet for this exercise.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      )
                    else
                      ...state.exerciseProgression.reversed.map((set) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            dense: true,
                            leading: CircleAvatar(
                              radius: 14,
                              child: Text(
                                set.setType.substring(0, 1).toUpperCase(),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                            title: Text(
                              '${set.weightKg?.toStringAsFixed(1) ?? 'BW'} kg × ${set.reps ?? 0} reps',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${set.timestamp.year}-${set.timestamp.month.toString().padLeft(2, '0')}-${set.timestamp.day.toString().padLeft(2, '0')}'
                              '${set.rpe != null ? ' • RPE ${set.rpe}' : ''}',
                            ),
                            trailing: Text(
                              set.estimated1Rm != null
                                  ? '1RM ~ ${set.estimated1Rm!.toStringAsFixed(1)} kg'
                                  : '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
