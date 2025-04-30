import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:growth_gauge/features/timer/chart/timer_chart_provider.dart';

void main() {
  group('TimerChartProvider Tests', () {
    test('processDataForChart', () {
      // Arrange
      final timer = testTimers[0];

      // Act
      provider.processDataForChart(timer, DurationInterval.minute);

      // Assert
      expect(provider.barGroups.isNotEmpty, true);
    });

    test('generateBarGroups', () {
      // Arrange
      final dailyDurations = {'2025-04-28': Duration(minutes: 5)};
      final startDate = DateTime(2025, 4, 27);
      final endDate = DateTime(2025, 4, 30);

      // Act
      final barGroups = provider.generateBarGroups(dailyDurations, startDate, endDate, DurationInterval.minute);

      // Assert
      expect(barGroups.isNotEmpty, true);
    });

    test('getDayOfWeek', () {
      // Act
      final day = provider.getDayOfWeek(0);

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