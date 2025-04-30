import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/features/timer/chart/duration_interval.dart';
import 'package:growth_gauge/features/timer/chart/timer_chart_provider.dart';
import 'package:growth_gauge/features/timer/model/model.dart';

void main() {
  late TimerChartProvider provider;

  setUp(() {
    provider = TimerChartProvider();
  });

  group('TimerChartProvider Tests', () {
    test('processDataForChart', () {
      // Arrange
      final timer = TimerModel(
        id: '1',
        name: 'Test Timer',
        interval: const Duration(minutes: 5),
        description: 'Test Description',
        logs: [
          TimerLog(id: 'log1', action: 'Started', timestamp: DateTime(2025, 4, 28), interval: const Duration(minutes: 2)),
        ],
        tags: [],
      );

      // Act
      provider.processDataForChart(timer, DurationInterval.minute);

      // Assert
      expect(provider.barGroups.isNotEmpty, true);
    });

    test('generateBarGroups', () {
      // Arrange
      final dailyDurations = {'2025-04-28': const Duration(minutes: 5)};
      final startDate = DateTime(2025, 4, 27);
      final endDate = DateTime(2025, 4, 30);

      // Act
      final barGroups = provider.generateBarGroups(dailyDurations, startDate, endDate, DurationInterval.minute);

      // Assert
      expect(barGroups.isNotEmpty, true);
    });

    test('getDayOfWeek', () {
      // Act
      final day = provider.getDayOfWeek(0); // Adjusted to match 'Sun'

      // Assert
      expect(day, 'Sun');
    });

    test('getChartTitle', () {
      // Act
      final title = provider.getChartTitle(DurationInterval.minute);

      // Assert
      expect(title, contains('Total Time Spent'));
    });
  });
}
