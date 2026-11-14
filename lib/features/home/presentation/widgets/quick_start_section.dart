import 'package:flutter/material.dart';

import '../../../common/presentation/widgets/widgets.dart';
import '../../../template/domain/workout_template.dart';
import '../../../template/infrastructure/template_repository.dart';

enum WorkoutSortOption() {
  recentCompleted,
  highestCount,
  newestCreated,
}

class const QuickStartSection({
  super.key,
  required final ITemplateRepository templateRepository,
  required final ValueChanged<WorkoutTemplate> onStartTemplate,
  final VoidCallback? onTemplateTap,
}) extends StatefulWidget {
  @override
  State<QuickStartSection> createState() => _QuickStartSectionState();
}

class _QuickStartSectionState() extends State<QuickStartSection> {
  WorkoutSortOption _selectedSort = WorkoutSortOption.newestCreated;

  List<WorkoutTemplate> _sortTemplates(List<WorkoutTemplate> templates) {
    final sorted = List<WorkoutTemplate>.from(templates);
    switch (_selectedSort) {
      case WorkoutSortOption.newestCreated:
        sorted.sort((a, b) => b.id.compareTo(a.id));
      case WorkoutSortOption.highestCount:
        sorted.sort((a, b) => b.name.compareTo(a.name));
      case WorkoutSortOption.recentCompleted:
        sorted.sort((a, b) => a.name.compareTo(b.name));
    }
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 900;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quick Start',
                  style:
                      (isDesktop ? textTheme.titleLarge : textTheme.titleMedium)
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                ),
                Row(
                  children: [
                    if (isDesktop) ...[
                      SizedBox(
                        width: 220,
                        child: AppDropdown<WorkoutSortOption>(
                          label: 'Workout Type',
                          hintText: 'Sort by',
                          prefixIcon: Icons.sort,
                          value: _selectedSort,
                          items: const [
                            AppDropdownItem(
                              value: WorkoutSortOption.newestCreated,
                              label: 'Newest Created',
                              icon: Icons.fiber_new,
                            ),
                            AppDropdownItem(
                              value: WorkoutSortOption.recentCompleted,
                              label: 'Most Recent Completed',
                              icon: Icons.history,
                            ),
                            AppDropdownItem(
                              value: WorkoutSortOption.highestCount,
                              label: 'Highest Count',
                              icon: Icons.local_fire_department,
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _selectedSort = value;
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    AppButton.ghost(
                      label: 'See All',
                      onPressed: widget.onTemplateTap ?? () {},
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            FutureBuilder(
              future: widget.templateRepository.getTemplates(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final templates = snapshot.hasData && !snapshot.data!.isError
                    ? snapshot.data!.dataOrNull ?? []
                    : <WorkoutTemplate>[];

                if (templates.isEmpty) {
                  return _EmptyTemplatesCard(colorScheme: colorScheme);
                }

                final sortedTemplates = _sortTemplates(templates);
                final displayCount = isDesktop ? 3 : 2;
                final displayTemplates = sortedTemplates
                    .take(displayCount)
                    .toList();

                final cardWidth = isDesktop
                    ? (constraints.maxWidth - 32) / 3
                    : constraints.maxWidth;

                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: displayTemplates.map((template) {
                    return SizedBox(
                      width: cardWidth,
                      child: QuickStartCard(
                        category: 'WORKOUT',
                        title: template.name,
                        duration: '20 min',
                        calories: '200 kcal',
                        onStart: () => widget.onStartTemplate(template),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class const _EmptyTemplatesCard({required final ColorScheme colorScheme})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Text(
        'No templates available.',
        style: Theme.of(context).textTheme.bodyMedium
            ?.copyWith(color: colorScheme.onSurfaceVariant),
      ),
    );
  }
}

class const QuickStartCard({
  super.key,
  required final String category,
  required final String title,
  required final String duration,
  required final String calories,
  required final VoidCallback onStart,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              category,
              style: textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 14,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                duration,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.local_fire_department,
                size: 14,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                calories,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: AppButton.primary(
              label: 'Start Workout',
              icon: Icons.play_arrow,
              onPressed: onStart,
            ),
          ),
        ],
      ),
    );
  }
}
