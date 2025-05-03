import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/features/counter/chart/counter_chart_provider.dart';
import 'package:growth_gauge/features/counter/model/model.dart';

final testCounter = CounterModel(
  id: '1',
  name: 'Test Counter',
  count: 5,
  description: 'Test Description',
  logs: [
    CounterLog(
      id: 'log1',
      action: 'Incremented',
      timestamp: DateTime(2025, 4, 28),
    ),
  ],
);

void main() {
  late CounterChartProvider provider;

  setUp(() {
    provider = CounterChartProvider();
  });

  group('CounterChartProvider Tests', () {
    test('processDataForChart', () {
      // Arrange
      final counter = CounterModel(
        id: '1',
        name: 'Test Counter',
        count: 5,
        description: 'Test Description',
        logs: [
          CounterLog(
              id: 'log1',
              action: 'Incremented',
              timestamp: DateTime(2025, 4, 28)),
        ],
        tags: [],
      );

      // Act
      provider.processDataForChart(counter);

      // Assert
      expect(provider.barGroups.isNotEmpty, true);
    });

    test('generateBarGroups', () {
      // Arrange
      final dailyCounts = {'2025-04-28': 5};
      final startDate = DateTime(2025, 4, 27);
      final endDate = DateTime(2025, 4, 30);

      // Act
      final barGroups =
          provider.generateBarGroups(dailyCounts, startDate, endDate);

      // Assert
      expect(barGroups.isNotEmpty, true);
    });

    test('getDayOfWeek', () {
      // Act
      final day = withClock(
        Clock.fixed(DateTime(2000)),
        () {
          // This will always return 'Sun' for the fixed date
          return provider.getDayOfWeek(0);
        },
      );

      // Assert
      expect(day, 'Sun');
    });

    test('processDataForChart processes data correctly', () {
      // Act
      provider.processDataForChart(testCounter);

      // Assert
      expect(provider.barGroups.isNotEmpty, true);
    });

    // Add more tests for other methods
  });
}
