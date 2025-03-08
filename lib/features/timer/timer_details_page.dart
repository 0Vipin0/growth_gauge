import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'chart/chart.dart';
import 'model/model.dart';
import 'provider/provider.dart';

class TimerDetailsPage extends StatefulWidget {
  final TimerModel timer;

  const TimerDetailsPage({super.key, required this.timer});

  @override
  State<TimerDetailsPage> createState() => _TimerDetailsPageState();
}

class _TimerDetailsPageState extends State<TimerDetailsPage> {
  DurationInterval _selectedInterval =
      DurationInterval.minute; // Default interval

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.timer.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              widget.timer.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Total Duration: ${widget.timer.interval.inSeconds} seconds',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            _buildIntervalDropdown(),
            // Dropdown for interval selection
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 800) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 400,
                        height: 400,
                        child: ChartPage(
                          timer: widget.timer,
                          durationInterval: _selectedInterval,
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        height: 400,
                        child: HeatmapPage(
                          timer: widget.timer,
                          durationInterval: _selectedInterval,
                        ), // Assuming you adapt HeatmapPage
                      ),
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 400,
                        height: 400,
                        child: ChartPage(
                          timer: widget.timer,
                          durationInterval: _selectedInterval,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: 400,
                        height: 400,
                        child: HeatmapPage(
                          timer: widget.timer,
                          durationInterval: _selectedInterval,
                        ), // Assuming you adapt HeatmapPage
                      ),
                    ],
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIntervalDropdown() {
    return Row(
      children: [
        const Text('Bar Chart Interval: '),
        DropdownButton<DurationInterval>(
          value: _selectedInterval,
          items: DurationInterval.values.map((DurationInterval interval) {
            return DropdownMenuItem<DurationInterval>(
              value: interval,
              child: Text(_getIntervalLabel(interval)),
            );
          }).toList(),
          onChanged: (DurationInterval? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedInterval = newValue;
              });
              Provider.of<TimerChartProvider>(context, listen: false)
                  .processDataForChart(
                      Provider.of<TimerListProvider>(context, listen: false)
                          .getTimer(widget.timer),
                      _selectedInterval);
            }
          },
        ),
      ],
    );
  }

  String _getIntervalLabel(DurationInterval interval) {
    switch (interval) {
      case DurationInterval.tenSeconds:
        return '10 Seconds';
      case DurationInterval.thirtySeconds:
        return '30 Seconds';
      case DurationInterval.minute:
        return 'Minute';
      case DurationInterval.twoMinutes:
        return '2 Minutes';
      default:
        return 'Minute'; // Default case, should not happen but good to have
    }
  }
}
