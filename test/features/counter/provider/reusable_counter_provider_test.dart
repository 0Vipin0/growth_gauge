import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:growth_gauge/features/counter/provider/reusable_counter_provider.dart';

void main() {
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
  });
}