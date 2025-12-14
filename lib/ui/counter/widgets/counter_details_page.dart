import 'package:flutter/material.dart';
import 'package:growth_gauge/data/models/models.dart';
import 'package:provider/provider.dart';

import '../../chart/provider/counter_chart_provider.dart';
import '../../chart/widgets/base_chart_widget.dart';
import '../../chart/widgets/base_heatmap_widget.dart';
import '../provider/provider.dart';

class CounterDetailsPage extends StatelessWidget {
  final CounterModel counter;

  const CounterDetailsPage({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(counter.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(counter.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text(
              'Current Count: ${counter.count}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    final counterProvider = Provider.of<CounterListProvider>(
                        context,
                        listen: false);
                    counterProvider.initializeTags(counter.tags);

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
                                    counterProvider.addTag(value);
                                    tagController.clear();
                                  }
                                },
                              ),
                              const SizedBox(height: 8),
                              Consumer<CounterListProvider>(
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
                                counterProvider.saveTags(counter);
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
                Consumer<CounterListProvider>(
                  builder: (context, provider, child) {
                    return Wrap(
                      spacing: 8.0,
                      children: provider
                              .getCounter(counter)
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
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 800) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 400,
                        height: 400,
                        child: ChartPage(counter: counter),
                      ),
                      BaseHeatmapWidget(
                        heatmapData: Provider.of<CounterListProvider>(
                          context,
                        ).extractCountsByDay(counter),
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
                        child: ChartPage(counter: counter),
                      ),
                      const SizedBox(height: 15),
                      BaseHeatmapWidget(
                        heatmapData: Provider.of<CounterListProvider>(context)
                            .extractCountsByDay(counter),
                      ),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class HeatmapPage extends StatelessWidget {
  final CounterModel counter;

  const HeatmapPage({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: BaseHeatmapWidget(
        heatmapData: Provider.of<CounterListProvider>(context)
            .extractCountsByDay(counter),
      ),
    );
  }
}

class ChartPage extends StatelessWidget {
  final CounterModel counter;

  const ChartPage({super.key, required this.counter});

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
          const SizedBox(height: 20),
          Consumer<CounterChartProvider>(
            builder: (context, chartProvider, child) {
              final barGroups = chartProvider.processDataForChart(counter);
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
