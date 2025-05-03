import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../chart/base_heatmap_widget.dart';
import 'chart/chart.dart';
import 'model/model.dart';
import 'provider/counter_list_provider.dart';

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
                      const BaseHeatmapWidget(
                        heatmapData: {}, // Replace with actual heatmap data
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
                      const BaseHeatmapWidget(
                        heatmapData: {}, // Replace with actual heatmap data
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
