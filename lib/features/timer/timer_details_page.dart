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
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              children: widget.timer.tags
                      ?.map((tag) => Chip(
                            label: Text(tag),
                          ))
                      .toList() ??
                  [],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    final TextEditingController tagController =
                        TextEditingController();
                    final List<String> updatedTags =
                        List.from(widget.timer.tags ?? []);

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
                              if (value.isNotEmpty &&
                                  !updatedTags.contains(value)) {
                                updatedTags.add(value);
                                tagController.clear();
                              }
                            },
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8.0,
                            children: updatedTags
                                .map((tag) => Chip(
                                      label: Text(tag),
                                      onDeleted: () {
                                        updatedTags.remove(tag);
                                      },
                                    ))
                                .toList(),
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
                            Provider.of<TimerListProvider>(
                              context,
                              listen: false,
                            ).updateTimer(
                              widget.timer.copyWith(tags: updatedTags),
                            );
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
              Provider.of<TimerChartProvider>(
                context,
                listen: false,
              ).processDataForChart(
                Provider.of<TimerListProvider>(
                  context,
                  listen: false,
                ).getTimer(widget.timer),
                _selectedInterval,
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
