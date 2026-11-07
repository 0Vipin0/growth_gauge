import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_router.dart';
import '../../../session/domain/session_enums.dart';
import '../../../session/infrastructure/session_repository.dart';
import '../../application/analytics_cubit.dart';
import '../widgets/pr_badge_card.dart';
import '../widgets/volume_bar_chart.dart';
import '../widgets/workout_frequency_heatmap.dart';

/// Central dashboard for analytics: weekly volume, workout frequency heatmap,
/// latest completed workout sessions, and recent PR achievements.
class const AnalyticsDashboardScreen({
  super.key,
  final IWorkoutSessionRepository? sessionRepository,
  final String? userId,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Analytics & Progress'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.emoji_events),
            tooltip: 'All PR Trophies',
            onPressed: () {
              context.push(
                appRoutePrTrophies,
                extra: context.read<AnalyticsCubit>(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.show_chart),
            tooltip: 'Exercise Progression',
            onPressed: () {
              context.push(
                appRouteExerciseProgression,
                extra: context.read<AnalyticsCubit>(),
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
                const SnackBar(
                  content: Text('Analytics rebuilt successfully.'),
                ),
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
            child: SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth >= 900 ? 32 : 20,
                      vertical: 24,
                    ),
                    children: [
                      WorkoutFrequencyHeatmap(summaries: state.history),
                      const SizedBox(height: 16),
                      VolumeBarChart(stats: state.weeklyVolume),
                      const SizedBox(height: 24),

                      // Latest Completed Workout Sessions Section
                      if (sessionRepository != null) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Latest Completed Workouts',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        FutureBuilder(
                          future: sessionRepository!.listAll(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Center(
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              );
                            }

                            final result = snapshot.data!;
                            if (result.isError) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
                                child: Text(
                                  'Could not load completed sessions.',
                                  style: TextStyle(color: colorScheme.error),
                                ),
                              );
                            }

                            // Filter for completed sessions belonging to user (if userId provided) and sort by completion date descending
                            final sessions = result.dataOrNull ?? [];
                            final completedSessions =
                                sessions
                                    .where(
                                      (s) =>
                                          s.status == SessionStatus.completed &&
                                          (userId == null ||
                                              s.userId == userId),
                                    )
                                    .toList()
                                  ..sort(
                                    (a, b) => (b.completedAt ?? b.createdAt)
                                        .compareTo(
                                          a.completedAt ?? a.createdAt,
                                        ),
                                  );

                            if (completedSessions.isEmpty) {
                              return Card(
                                elevation: 0,
                                color: colorScheme.surfaceContainer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Center(
                                    child: Text(
                                      'No completed workout sessions logged yet.',
                                      style: TextStyle(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }

                            return Column(
                              children: completedSessions.take(3).map((
                                session,
                              ) {
                                final completedDate =
                                    session.completedAt ?? session.createdAt;
                                final durationMinutes =
                                    session.startedAt != null
                                    ? completedDate
                                          .difference(session.startedAt!)
                                          .inMinutes
                                    : null;

                                return Card(
                                  elevation: 0,
                                  color: colorScheme.surfaceContainer,
                                  margin: const EdgeInsets.only(bottom: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: colorScheme.primaryContainer
                                                .withValues(alpha: 0.3),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.check_circle_outline,
                                            color: colorScheme.primary,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                session.templateName,
                                                style: theme
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          colorScheme.onSurface,
                                                    ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                'Completed on ${completedDate.toLocal().toString().split('.').first}'
                                                '${durationMinutes != null ? ' • $durationMinutes mins' : ''}',
                                                style: theme.textTheme.bodySmall
                                                    ?.copyWith(
                                                      color: colorScheme
                                                          .onSurfaceVariant,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Personal Records Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Personal Records',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.push(
                                appRoutePrTrophies,
                                extra: context.read<AnalyticsCubit>(),
                              );
                            },
                            child: const Text('View All'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
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
                        ...state.personalRecords
                            .take(5)
                            .map(
                              (pr) => Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: PrBadgeCard(record: pr),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
