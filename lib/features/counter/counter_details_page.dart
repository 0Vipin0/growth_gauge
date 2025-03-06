import 'package:flutter/material.dart';

import '../chart/chart.dart';
import '../counter/counter.dart';

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
        child: ListView(
          children: [
            Text(
              counter.description,
              style: const TextStyle(fontSize: 16),
            ),
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
                          child: ChartPage(counter: counter)),
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
                          child: ChartPage(counter: counter)),
                      const SizedBox(height: 15),
                      HeatmapPage(counter: counter),
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
}
