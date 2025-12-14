import 'package:flutter/material.dart';
import '../model/daily_aggregate.dart';

class ActivityHeatmap extends StatelessWidget {
  final List<DailyAggregate> data;
  final int columns;

  const ActivityHeatmap({super.key, required this.data, this.columns = 7});

  Color _colorFor(double value, double max) {
    if (max <= 0) return Colors.grey.shade200;
    final t = (value / max).clamp(0.0, 1.0);
    return Color.lerp(Colors.green.shade100, Colors.green.shade900, t)!;
  }

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox.shrink();
    final max = data.map((d) => d.total).fold<double>(0.0, (p, e) => e > p ? e : p);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: columns, crossAxisSpacing: 4, mainAxisSpacing: 4),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final d = data[index];
        return Tooltip(
          message: '${d.day.toLocal().toIso8601String().split('T').first}: ${d.total}',
          child: Container(
            decoration: BoxDecoration(color: _colorFor(d.total, max), borderRadius: BorderRadius.circular(4)),
            width: 20,
            height: 20,
          ),
        );
      },
    );
  }
}
