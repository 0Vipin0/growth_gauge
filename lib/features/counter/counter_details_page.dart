import 'package:flutter/material.dart';

import 'chart/chart.dart';
import 'model/model.dart';

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
                      HeatmapPage(counter: counter),
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
                      HeatmapPage(counter: counter),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              children: counter.tags
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
                        List.from(counter.tags ?? []);

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
                            // Update the counter with new tags
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
}
