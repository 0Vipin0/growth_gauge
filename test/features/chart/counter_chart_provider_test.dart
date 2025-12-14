import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/data/models/counter_model.dart';
import 'package:growth_gauge/ui/chart/provider/counter_chart_provider.dart';


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
      final barGroups = provider.processDataForChart(counter);

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
  });
}
