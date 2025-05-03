import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../chart/chart.dart';
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
    heatMapDatasets = Provider.of<CounterListProvider>(
      context,
    ).extractCountsByDay(widget.counter);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: BaseHeatmapWidget(
        heatmapData: heatMapDatasets,
      ),
    );
  }
}
