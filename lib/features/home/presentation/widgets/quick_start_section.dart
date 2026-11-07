import 'package:flutter/material.dart';

import '../../../common/presentation/widgets/widgets.dart';
import '../../../template/domain/workout_template.dart';
import '../../../template/infrastructure/template_repository.dart';

class const QuickStartSection({
  super.key,
  required final ITemplateRepository templateRepository,
  required final ValueChanged<WorkoutTemplate> onStartTemplate,
  final VoidCallback? onTemplateTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Quick Start',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            AppButton.ghost(
              label: 'See All',
              onPressed: onTemplateTap ?? () {},
            ),
          ],
        ),
        const SizedBox(height: 12),
        FutureBuilder(
          future: templateRepository.getTemplates(),
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

            final displayTemplates = templates.take(2).toList();

            return LayoutBuilder(
              builder: (context, constraints) {
                final cardWidth = constraints.maxWidth > 700
                    ? (constraints.maxWidth - 16) / 2
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
                        onStart: () => onStartTemplate(template),
                      ),
                    );
                  }).toList(),
                );
              },
            );
          },
        ),
      ],
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
