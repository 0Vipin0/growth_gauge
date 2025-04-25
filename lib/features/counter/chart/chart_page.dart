import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../counter.dart';
import 'chart_widget.dart';
import 'counter_chart_provider.dart';

class ChartPage extends StatefulWidget {
  final CounterModel counter;

  const ChartPage({super.key, required this.counter});

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
    Provider.of<CounterChartProvider>(
      context,
      listen: false,
    ).processDataForChart(
      Provider.of<CounterListProvider>(
        context,
        listen: false,
      ).getCounter(widget.counter),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Exercise Counts - Last 7 Days',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ChartWidget(),
          SizedBox(height: 20),
          Text(
            'Days are based on the last 7 days.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
