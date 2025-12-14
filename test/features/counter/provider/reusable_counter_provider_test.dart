import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/data/models/models.dart';

import 'package:growth_gauge/ui/counter/provider/reusable_counter_provider.dart';

void main() {
  late ReusableCounterProvider provider;

  setUp(() {
    provider = ReusableCounterProvider(
      counter: CounterModel(
        id: '1',
        name: 'Test Counter',
        count: 0,
        description: 'Test Description',
        logs: [],
        tags: [],
      ),
    );
  });

  group('ReusableCounterProvider Tests', () {
    test('increaseCounter', () {
      // Act
      provider.increaseCounter();

      // Assert
      expect(provider.count, 1);
    });

    test('decreaseCounter', () {
      // Act
      provider.decreaseCounter();

      // Assert
      expect(provider.count, -1);
    });

    test('increaseCounter increments the counter', () {
      // Act
      provider.increaseCounter();

      // Assert
      expect(provider.count, 1);
    });

    test('decreaseCounter decrements the counter', () {
      // Act
      provider.decreaseCounter();

      // Assert
      expect(provider.count, -1);
    });

    // Add more tests for other methods
  });
}
