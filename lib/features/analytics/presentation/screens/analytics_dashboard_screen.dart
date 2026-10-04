import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/analytics_cubit.dart';
import '../widgets/pr_badge_card.dart';
import '../widgets/volume_bar_chart.dart';
import '../widgets/workout_frequency_heatmap.dart';
import 'exercise_progression_screen.dart';
import 'pr_trophy_screen.dart';

/// Central dashboard for analytics: weekly volume, workout frequency heatmap,
/// and recent PR achievements.
class const AnalyticsDashboardScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics & Progress'),
        actions: [
          IconButton(
            icon: const Icon(Icons.emoji_events),
            tooltip: 'All PR Trophies',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<AnalyticsCubit>(),
                    child: const PrTrophyScreen(),
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.show_chart),
            tooltip: 'Exercise Progression',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<AnalyticsCubit>(),
                    child: const ExerciseProgressionScreen(),
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Rebuild Analytics',
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              await context.read<AnalyticsCubit>().triggerRebuild();
              messenger.showSnackBar(
                const SnackBar(content: Text('Analytics rebuilt successfully.')),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<AnalyticsCubit, AnalyticsState>(
        builder: (context, state) {
          if (state.isLoading && state.history.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null && state.history.isEmpty) {
            return Center(
              child: Text(
                'Error loading analytics: ${state.errorMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => context.read<AnalyticsCubit>().triggerRebuild(),
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                WorkoutFrequencyHeatmap(summaries: state.history),
                const SizedBox(height: 16),
                VolumeBarChart(stats: state.weeklyVolume),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Personal Records',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: context.read<AnalyticsCubit>(),
                              child: const PrTrophyScreen(),
                            ),
                          ),
                        );
                      },
                      child: const Text('View All'),
                    ),
                  ],
                ),
                if (state.personalRecords.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: Center(
                      child: Text(
                        'Complete workouts to unlock PR trophies!',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                else
                  ...state.personalRecords.take(5).map(
                        (pr) => PrBadgeCard(record: pr),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
