import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../catalog/catalog.dart';
import '../../../common/presentation/widgets/widgets.dart';
import '../../../session/domain/session_enums.dart';
import '../../../session/infrastructure/session_repository.dart';
import '../../application/analytics_cubit.dart';
import '../widgets/progression_line_chart.dart';

/// Screen displaying 1RM estimated curve and set history for a selected exercise,
/// with dynamic exercise selection derived from completed workout sessions.
class const ExerciseProgressionScreen({
  super.key,
  required final IWorkoutSessionRepository sessionRepository,
  required final IExerciseRepository exerciseRepository,
  final String? initialExerciseId,
}) extends StatefulWidget {
  @override
  State<ExerciseProgressionScreen> createState() =>
      _ExerciseProgressionScreenState();
}

class _ExerciseProgressionScreenState()
    extends State<ExerciseProgressionScreen> {
  List<Map<String, String>> _availableExercises = [];
  String? _currentExerciseId;
  bool _isLoadingExercises = true;

  @override
  void initState() {
    super.initState();
    _loadExercisesFromSessions();
  }

  Future<void> _loadExercisesFromSessions() async {
    setState(() => _isLoadingExercises = true);

    // 1. Fetch completed sessions
    final sessionsResult = await widget.sessionRepository.listAll();
    final completedSessions = (sessionsResult.dataOrNull ?? [])
        .where((s) => s.status == SessionStatus.completed)
        .toList();

    // 2. Extract unique exercise IDs performed across all completed sessions
    final exerciseIds = <String>{};
    for (final session in completedSessions) {
      for (final block in session.blocks) {
        for (final item in block.items) {
          exerciseIds.add(item.exerciseId);
        }
      }
    }

    // 3. Resolve names for each exercise ID via ExerciseRepository
    final exercisesList = <Map<String, String>>[];
    for (final id in exerciseIds) {
      final res = await widget.exerciseRepository.findById(id);
      final exercise = res.dataOrNull;
      if (exercise != null) {
        exercisesList.add({'id': exercise.id, 'name': exercise.name});
      }
    }

    // Sort exercises alphabetically
    exercisesList.sort((a, b) => a['name']!.compareTo(b['name']!));

    if (!mounted) return;

    setState(() {
      _availableExercises = exercisesList;
      _isLoadingExercises = false;

      if (_availableExercises.isNotEmpty) {
        _currentExerciseId =
            widget.initialExerciseId != null &&
                _availableExercises.any(
                  (e) => e['id'] == widget.initialExerciseId,
                )
            ? widget.initialExerciseId!
            : _availableExercises.first['id'];

        context.read<AnalyticsCubit>().selectExercise(_currentExerciseId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Exercise Progression'),
        centerTitle: true,
      ),
      body: BlocBuilder<AnalyticsCubit, AnalyticsState>(
        builder: (context, state) {
          return SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Column(
                  children: [
                    // Dynamic Exercise Dropdown Selection using AppDropdown
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth >= 900 ? 32 : 20,
                        vertical: 16.0,
                      ),
                      child: _isLoadingExercises
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : AppDropdown<String>(
                              label: _availableExercises.isEmpty
                                  ? 'No Completed Exercises Found'
                                  : 'Select Exercise',
                              value: _currentExerciseId,
                              hintText: 'Choose an exercise',
                              prefixIcon: Icons.fitness_center,
                              items: _availableExercises
                                  .map(
                                    (e) => AppDropdownItem<String>(
                                      value: e['id']!,
                                      label: e['name']!,
                                      icon: Icons.fitness_center,
                                    ),
                                  )
                                  .toList(),
                              onChanged: _availableExercises.isEmpty
                                  ? (_) {}
                                  : (val) {
                                      if (val != null) {
                                        setState(
                                          () => _currentExerciseId = val,
                                        );
                                        context
                                            .read<AnalyticsCubit>()
                                            .selectExercise(val);
                                      }
                                    },
                            ),
                    ),

                    // Progression Chart & Completed Set History List
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth >= 900 ? 32 : 20,
                          vertical: 8,
                        ),
                        children: [
                          ProgressionLineChart(
                            metrics: state.exerciseProgression,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Completed Sets History',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (state.exerciseProgression.isEmpty)
                            AppCard(
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Center(
                                  child: Text(
                                    'No completed sets logged yet for this exercise.',
                                    style: TextStyle(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          else
                            ...state.exerciseProgression.reversed.map((set) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: AppCard(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            colorScheme.primaryContainer,
                                        foregroundColor:
                                            colorScheme.onPrimaryContainer,
                                        radius: 16,
                                        child: Text(
                                          set.setType.isNotEmpty
                                              ? set.setType
                                                    .substring(0, 1)
                                                    .toUpperCase()
                                              : 'W',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${set.weightKg?.toStringAsFixed(1) ?? 'BW'} kg × ${set.reps ?? 0} reps',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              '${set.timestamp.year}-${set.timestamp.month.toString().padLeft(2, '0')}-${set.timestamp.day.toString().padLeft(2, '0')}'
                                              '${set.rpe != null ? ' • RPE ${set.rpe}' : ''}',
                                              style: TextStyle(
                                                color: colorScheme
                                                    .onSurfaceVariant,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (set.estimated1Rm != null)
                                        Text(
                                          '1RM ~ ${set.estimated1Rm!.toStringAsFixed(1)} kg',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: colorScheme.primary,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
