import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/features/timer/chart/duration_interval.dart';
import 'package:growth_gauge/features/timer/chart/timer_chart_provider.dart';
import 'package:growth_gauge/features/timer/model/model.dart';

final testTimer = TimerModel(
  id: '1',
  name: 'Test Timer',
  interval: const Duration(minutes: 5),
  description: 'Test Description',
  logs: [
    TimerLog(
      id: 'log1',
      action: 'Started',
      timestamp: DateTime(2025, 4, 28),
      interval: const Duration(minutes: 2),
    ),
  ],
);

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
          TimerLog(
              id: 'log1',
              action: 'Started',
              timestamp: DateTime(2025, 4, 28),
              interval: const Duration(minutes: 2)),
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
      final barGroups = provider.generateBarGroups(
          dailyDurations, startDate, endDate, DurationInterval.minute);

      // Assert
      expect(barGroups.isNotEmpty, true);
    });

    test('getDayOfWeek', () {
      // Act
      // This method depends on DateTime.now() so we need to mock it or set a fixed date
      // TODO: Mock DateTime.now() or set a fixed date for testing
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

    test('getChartTitle', () {
      // Act
      final title = provider.getChartTitle(DurationInterval.minute);

      // Assert
      expect(title, contains('Total Time Spent'));
    });

    test('processDataForChart processes data correctly', () {
      // Act
      provider.processDataForChart(testTimer, DurationInterval.minute);

      // Assert
      expect(provider.barGroups.isNotEmpty, true);
    });

    // Add more tests for other methods
  });
}
