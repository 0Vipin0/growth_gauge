import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:growth_gauge/features/counter/chart/counter_chart_provider.dart';

void main() {
  group('CounterChartProvider Tests', () {
    test('processDataForChart', () {
      // Arrange
      final counter = testCounters[0];

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
      final barGroups = provider.generateBarGroups(dailyCounts, startDate, endDate);

      // Assert
      expect(barGroups.isNotEmpty, true);
    });

    test('getDayOfWeek', () {
      // Act
      final day = provider.getDayOfWeek(0);

      // Assert
      expect(day, 'Sun');
    });
  });
}