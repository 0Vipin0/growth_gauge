import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../model/model.dart';
import '../provider/provider.dart';
import 'chart_widget.dart';
import 'duration_interval.dart';
import 'timer_chart_provider.dart';

class ChartPage extends StatefulWidget {
  final TimerModel timer;
  final DurationInterval durationInterval;

  const ChartPage(
      {super.key, required this.timer, required this.durationInterval});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    Provider.of<TimerChartProvider>(context, listen: false).processDataForChart(
        Provider.of<TimerListProvider>(context, listen: false)
            .getTimer(widget.timer),
        widget.durationInterval);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Exercise Counts - Last 7 Days',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'Time Spent per ${widget.durationInterval.getUnitLabel()}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 20),
          const ChartWidget(),
          const SizedBox(height: 20),
          const Text(
            'Days are based on the last 7 days.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
