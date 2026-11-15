import 'package:flutter/material.dart';

import '../../../common/presentation/widgets/widgets.dart';

class const ExploreBanner({
  super.key,
  final VoidCallback? onCatalogTap,
  final VoidCallback? onTemplateTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return AppCard(
      variant: AppCardVariant.selected,
      onTap: onCatalogTap,
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'NEW COLLECTION',
                    style: textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Explore Library',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Find your next challenge among hundreds of workouts.',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          AppButton.transport(
            icon: Icons.chevron_right,
            onPressed: onTemplateTap ?? () {},
            tooltip: 'View templates',
          ),
        ],
      ),
    );
  }
}
