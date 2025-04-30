import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:growth_gauge/features/timer/provider/reusable_timer_provider.dart';
import 'package:growth_gauge/features/timer/model/model.dart';

void main() {
  late ReusableTimerProvider provider;
  late TimerModel testTimer;

  setUp(() {
    testTimer = TimerModel(
      id: '1',
      name: 'Test Timer',
      interval: Duration.zero,
      description: 'Test Description',
      logs: [],
    );
    provider = ReusableTimerProvider(timer: testTimer);
  });

  group('ReusableTimerProvider Tests', () {
    test('startOrPauseTimer starts the timer if not running', () {
      // Act
      provider.startOrPauseTimer();

      // Assert
      expect(provider.isRunning, true);
    });

    test('resetTimer resets the timer and clears logs', () {
      // Act
      provider.resetTimer();

      // Assert
      expect(provider.currentInterval, Duration.zero);
      expect(provider.timer.logs.last.action, 'Reset');
    });

    test('dispose', () {
      // Act
      provider.dispose();

      // Assert
      expect(provider.isRunning, false);
    });

    // Add more tests for other methods
  });
}