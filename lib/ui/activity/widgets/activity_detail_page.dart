import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:growth_gauge/data/models/models.dart';
import 'package:growth_gauge/ui/core/routes.dart';
import 'package:provider/provider.dart';

import '../provider/activity_provider.dart';

class ActivityDetailPage extends StatelessWidget {
  const ActivityDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String? activityId =
        ModalRoute.of(context)!.settings.arguments as String?;
    final provider = Provider.of<ActivityProvider>(context);
    final activity =
        provider.activities.firstWhereOrNull((a) => a.id == activityId);

    if (activity == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Activity')),
        body: const Center(child: Text('Activity not found')),
      );
    }

    final logs = provider.logs
        .where((l) => l.activityId == activity.id)
        .toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return Scaffold(
      appBar: AppBar(
        title: Text(activity.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.insights),
            onPressed: () => Navigator.pushNamed(
                context, AppRoutes.activityInsights,
                arguments: activity.id),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Unit: ${activity.unit}',
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 12),
            const Text('Recent Performance',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (logs.isEmpty)
              const Text('No logs yet')
            else
              SizedBox(
                height: 220,
                child: LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (v, meta) {
                                final index = v.toInt();
                                if (index >= 0 && index < logs.length) {
                                  final d = logs[index].timestamp;
                                  return Text('${d.month}/${d.day}');
                                }
                                return const Text('');
                              })),
                      leftTitles:
                          const AxisTitles(sideTitles: SideTitles(showTitles: true)),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                          spots: logs
                              .asMap()
                              .entries
                              .map((e) =>
                                  FlSpot(e.key.toDouble(), e.value.value))
                              .toList())
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 12),
            const Text('Logs', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (logs.isEmpty)
              const SizedBox.shrink()
            else
              Expanded(
                child: ListView.separated(
                  itemCount: logs.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final l = logs[index];
                    return ListTile(
                        title: Text('${l.value}'),
                        subtitle: Text(l.timestamp.toLocal().toString()));
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Quick log: add a sample log entry equal to 1 more than last or 1
          final value = logs.isEmpty ? 1.0 : logs.last.value + 1.0;
          provider.logActivityEntry(
              ActivityLog(activityId: activity.id, value: value));
        },
      ),
    );
  }
}
