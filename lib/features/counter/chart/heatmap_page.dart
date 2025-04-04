import 'package:flutter/material.dart';

import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:provider/provider.dart';

import '../counter.dart';

class HeatmapPage extends StatefulWidget {
  final CounterModel counter;

  const HeatmapPage({super.key, required this.counter});

  @override
  State<StatefulWidget> createState() => _HeatMapCalendarExample();
}

class _HeatMapCalendarExample extends State<HeatmapPage> {
  late Map<DateTime, int> heatMapDatasets;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onPrimaryFixedVariant;
    heatMapDatasets = Provider.of<CounterListProvider>(context)
        .extractCountsByDay(widget.counter);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: HeatMapCalendar(
        defaultColor: Theme.of(context).scaffoldBackgroundColor,
        textColor: Theme.of(context).colorScheme.onSurface,
        weekTextColor: Theme.of(context).colorScheme.onSurface,
        datasets: heatMapDatasets,
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
      ),
    );
  }
}
