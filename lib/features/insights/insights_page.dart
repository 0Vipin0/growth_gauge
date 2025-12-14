import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../insights.dart';
import 'widgets/activity_heatmap.dart';
import 'widgets/x_day_chart.dart';

class InsightsPage extends StatelessWidget {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String? activityId = ModalRoute.of(context)!.settings.arguments as String?;
    final provider = Provider.of<InsightsProvider>(context);

    if (activityId == null) {
      return Scaffold(appBar: AppBar(title: const Text('Insights')), body: const Center(child: Text('No activity selected')));
    }

    final now = DateTime.now();
    final from = now.subtract(const Duration(days: 30));

    // Trigger fetch if empty
    if (provider.daily.isEmpty && !provider.isLoading) {
      provider.fetchDailyAggregates(activityId, from, now);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Insights')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Last 30 Days', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (provider.isLoading) const LinearProgressIndicator() else Column(children: [ActivityHeatmap(data: provider.daily), const SizedBox(height: 12), XDayChart(data: provider.daily)]),
          ],
        ),
      ),
    );
  }
}
