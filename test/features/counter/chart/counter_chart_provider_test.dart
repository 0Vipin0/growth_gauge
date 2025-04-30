import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:growth_gauge/features/counter/chart/counter_chart_provider.dart';
import 'package:growth_gauge/features/counter/model/model.dart';

void main() {
  CounterChartProvider provider;
  final testCounters = [
    CounterModel(
      id: '1',
      name: 'Test Counter',
      count: 0,
      description: 'Test Description',
      logs: [],
      tags: [],
    ),
  ];

  setUp(() {
    provider = CounterChartProvider();
  });

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