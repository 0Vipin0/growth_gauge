import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chart_provider.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChartProvider>(
      builder: (context, chartProvider, child) {
        final maxY = chartProvider.barGroups
                .map((group) => group.barRods.first.toY)
                .fold(0.0, (max, y) => y > max ? y : max) +
            5;

        return !chartProvider.isProcessed
            ? const CircularProgressIndicator()
            : AspectRatio(
                aspectRatio: 1.5,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: maxY,
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                  chartProvider.getDayOfWeek(value.toInt()),
                                  style: const TextStyle(fontSize: 12)),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return Text(
                              value % 1 == 0
                                  ? value.toInt().toString()
                                  : '', // Show only integer values
                              textAlign: TextAlign.right,
                              style: const TextStyle(fontSize: 12),
                            );
                          },
                          reservedSize: 28, // Adjust for label width
                          interval: calculateYAxisInterval(
                              maxY), // Calculate interval dynamically
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: chartProvider.barGroups,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipItem: (
                          BarChartGroupData group,
                          int groupIndex,
                          BarChartRodData rod,
                          int rodIndex,
                        ) {
                          return BarTooltipItem(
                            rod.toY.toInt().toString(),
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  // Function to calculate Y-axis interval dynamically based on maxY
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
