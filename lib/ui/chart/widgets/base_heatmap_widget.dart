import 'package:flutter/material.dart';

import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class BaseHeatmapWidget extends StatelessWidget {
  final Map<DateTime, int> heatmapData;

  const BaseHeatmapWidget({
    super.key,
    required this.heatmapData,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onPrimaryFixedVariant;
    return HeatMapCalendar(
      defaultColor: Theme.of(context).scaffoldBackgroundColor,
      textColor: Theme.of(context).colorScheme.onSurface,
      weekTextColor: Theme.of(context).colorScheme.onSurface,
      datasets: heatmapData,
      colorMode: ColorMode.color,
      colorsets: {
        1: primaryColor.withValues(alpha: 0.1),
        5: primaryColor.withValues(alpha: 0.2),
        10: primaryColor.withValues(alpha: 0.3),
        15: primaryColor.withValues(alpha: 0.4),
        20: primaryColor.withValues(alpha: 0.6),
        25: primaryColor.withValues(alpha: 0.8),
        30: primaryColor.withValues(alpha: 0.9),
      },
    );
  }
}
