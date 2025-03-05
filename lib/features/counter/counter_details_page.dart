import 'package:flutter/material.dart';

import 'counter_change_graph.dart';
import 'counter_model.dart';

class CounterDetailsPage extends StatelessWidget {
  final CounterModel counter;

  const CounterDetailsPage({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(counter.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              counter.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              counter.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Current Count: ${counter.count}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Changes in the last 7 days',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: CounterChangeGraph(counter: counter),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
