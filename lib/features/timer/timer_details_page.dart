import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../chart/chart.dart';
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
      appBar: AppBar(title: Text(widget.timer.name)),
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
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    final timerProvider =
                        Provider.of<TimerListProvider>(context, listen: false);
                    timerProvider.initializeTags(widget.timer.tags);

                    showDialog(
                      context: context,
                      builder: (context) {
                        final TextEditingController tagController =
                            TextEditingController();

                        return AlertDialog(
                          title: const Text('Manage Tags'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: tagController,
                                decoration: const InputDecoration(
                                  labelText: 'Add Tag',
                                  border: OutlineInputBorder(),
                                ),
                                onSubmitted: (value) {
                                  if (value.isNotEmpty) {
                                    timerProvider.addTag(value);
                                    tagController.clear();
                                  }
                                },
                              ),
                              const SizedBox(height: 8),
                              Consumer<TimerListProvider>(
                                builder: (context, provider, child) {
                                  return Wrap(
                                    spacing: 8.0,
                                    children: provider.updatedTags
                                        .map((tag) => Chip(
                                              label: Text(tag),
                                              onDeleted: () {
                                                provider.removeTag(tag);
                                              },
                                            ))
                                        .toList(),
                                  );
                                },
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                timerProvider.saveTags(widget.timer);
                                Navigator.of(context).pop();
                              },
                              child: const Text('Save'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Manage Tags'),
                ),
                const SizedBox(width: 16),
                Consumer<TimerListProvider>(
                  builder: (context, provider, child) {
                    return Wrap(
                      spacing: 8.0,
                      children: provider
                              .getTimer(widget.timer)
                              .tags
                              ?.map((tag) => Chip(
                                    label: Text(tag),
                                  ))
                              .toList() ??
                          [],
                    );
                  },
                ),
              ],
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
                      BaseHeatmapWidget(
                        heatmapData: Provider.of<TimerListProvider>(context)
                            .extractCountsByDayPerDurationInterval(
                          widget.timer,
                          _selectedInterval,
                        ), // Replace with actual heatmap data
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
                      BaseHeatmapWidget(
                        heatmapData: Provider.of<TimerListProvider>(context)
                            .extractCountsByDayPerDurationInterval(
                          widget.timer,
                          _selectedInterval,
                        ), // Replace with actual heatmap data
                      ),
                    ],
                  );
                }
              },
            ),
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
              Provider.of<TimerChartProvider>(context, listen: false).interval =
                  _selectedInterval;
              Provider.of<TimerChartProvider>(context, listen: false)
                  .processDataForChart(
                Provider.of<TimerListProvider>(
                  context,
                  listen: false,
                ).getTimer(widget.timer),
              );
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
    }
  }
}

class HeatmapPage extends StatelessWidget {
  final TimerModel timer;
  final DurationInterval durationInterval;

  const HeatmapPage({
    super.key,
    required this.timer,
    required this.durationInterval,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: BaseHeatmapWidget(
        heatmapData: Provider.of<TimerListProvider>(
          context,
        ).extractCountsByDayPerDurationInterval(
          timer,
          durationInterval,
        ),
      ),
    );
  }
}

class ChartPage extends StatelessWidget {
  final TimerModel timer;
  final DurationInterval durationInterval;

  const ChartPage({
    super.key,
    required this.timer,
    required this.durationInterval,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Exercise Counts - Last 7 Days',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            'Time Spent per ${durationInterval.getUnitLabel()}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 20),
          Consumer<TimerChartProvider>(
            builder: (context, chartProvider, child) {
              chartProvider.interval = durationInterval;
              final barGroups = chartProvider.processDataForChart(timer);
              final maxY = barGroups
                      .map((group) => group.barRods.first.toY)
                      .fold(0.0, (max, y) => y > max ? y : max) +
                  5;

              return !chartProvider.isProcessed
                  ? const CircularProgressIndicator()
                  : BaseChartWidget(
                      barGroups: barGroups,
                      dayLabel: (value) => chartProvider.getDayOfWeek(value),
                      yAxisInterval: calculateYAxisInterval(maxY),
                    );
            },
          ),
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

  static double calculateYAxisInterval(double maxY) {
    if (maxY <= 10) {
      return 1;
    } else if (maxY <= 50) {
      return 5;
    } else if (maxY <= 100) {
      return 10;
    } else {
      return 20; // Or some other logic for larger maxY values
    }
  }
}
