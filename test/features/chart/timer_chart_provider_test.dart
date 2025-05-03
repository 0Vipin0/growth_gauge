import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/features/chart/chart.dart';
import 'package:growth_gauge/features/timer/chart/duration_interval.dart';
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
          TimerLog(
              id: 'log1',
              action: 'Started',
              timestamp: DateTime(2025, 4, 28),
              interval: const Duration(minutes: 2)),
        ],
        tags: [],
      );

      // Act
      provider.interval = DurationInterval.minute;
      final barGroups = provider.processDataForChart(timer);

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
  });
}
