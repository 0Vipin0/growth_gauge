import 'package:flutter/material.dart';

import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:provider/provider.dart';

import 'package:growth_gauge/features/timer/chart/duration_interval.dart';
import '../timer.dart';

class HeatmapPage extends StatefulWidget {
  final TimerModel timer;
  final DurationInterval durationInterval;

  const HeatmapPage(
      {super.key, required this.timer, required this.durationInterval});

  @override
  State<StatefulWidget> createState() => _HeatMapCalendarExample();
}

class _HeatMapCalendarExample extends State<HeatmapPage> {
  late Map<DateTime, int> heatMapDatasets;

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).colorScheme.primary;
    heatMapDatasets = Provider.of<TimerListProvider>(context)
        .extractCountsByDayPerDurationInterval(
            widget.timer, widget.durationInterval);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: HeatMapCalendar(
        defaultColor: Theme.of(context).scaffoldBackgroundColor,
        textColor: Theme.of(context).colorScheme.onSurface,
        weekTextColor: Theme.of(context).colorScheme.onSurface,
        datasets: heatMapDatasets,
        colorMode: ColorMode.color,
        colorsets: {
          1: primaryColor.withOpacity(0.1),
          5: primaryColor.withOpacity(0.2),
          10: primaryColor.withOpacity(0.3),
          15: primaryColor.withOpacity(0.4),
          20: primaryColor.withOpacity(0.6),
          25: primaryColor.withOpacity(0.8),
          30: primaryColor.withOpacity(0.9),
        },
      ),
    );
  }
}
