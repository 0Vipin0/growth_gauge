import 'package:flutter/material.dart';

class const AppStatCard({
    super.key,
    required final String title,
    required final String value,
    final String? trendDelta,
    final bool isPositiveTrend = true,
    required final IconData icon,
    final Color? iconContainerColor,
    final Color? iconColor,
  }) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconContainerColor ?? colorScheme.surfaceContainerHigh,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: iconColor ?? colorScheme.primary,
                ),
              ),
              if (trendDelta != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isPositiveTrend
                        ? colorScheme.primary.withValues(alpha: 0.15)
                        : colorScheme.errorContainer.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    trendDelta!,
                    style: textTheme.labelSmall?.copyWith(
                      color: isPositiveTrend
                          ? colorScheme.primary
                          : colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(value, style: textTheme.headlineMedium),
          const SizedBox(height: 4),
          Text(
            title,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
