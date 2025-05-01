import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/features/timer/model/model.dart';
import 'package:growth_gauge/features/timer/provider/reusable_timer_provider.dart';

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

    test('startOrPauseTimer toggles the timer state', () {
      // Act
      provider.startOrPauseTimer();

      // Assert
      expect(provider.isRunning, true);

      // Act again
      provider.startOrPauseTimer();

      // Assert
      expect(provider.isRunning, false);
    });

    test('resetTimer resets the timer and clears logs', () {
      // Act
      provider.resetTimer();

      // Assert
      expect(provider.currentInterval, Duration.zero);
      expect(provider.timer.logs.last.action, 'Reset');
    });

    test('resetTimer resets the timer state', () {
      // Act
      provider.resetTimer();

      // Assert
      expect(provider.currentInterval, Duration.zero);
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
