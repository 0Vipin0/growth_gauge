import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../chart/chart.dart';
import '../model/model.dart';
import '../provider/provider.dart';
import 'duration_interval.dart';

class HeatmapPage extends StatefulWidget {
  final TimerModel timer;
  final DurationInterval durationInterval;

  const HeatmapPage({
    super.key,
    required this.timer,
    required this.durationInterval,
  });

  @override
  State<StatefulWidget> createState() => _HeatMapCalendarExample();
}

class _HeatMapCalendarExample extends State<HeatmapPage> {
  late Map<DateTime, int> heatMapDatasets;

  @override
  Widget build(BuildContext context) {
    heatMapDatasets = Provider.of<TimerListProvider>(
      context,
    ).extractCountsByDayPerDurationInterval(
      widget.timer,
      widget.durationInterval,
    );
    return Padding(
      padding: const EdgeInsets.all(20),
      child: BaseHeatmapWidget(
        heatmapData: heatMapDatasets,
      ),
    );
  }
}
