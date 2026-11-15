import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/features/analytics/domain/calorie_calculator.dart';
import 'package:growth_gauge/features/analytics/domain/daily_workout_summary.dart';

void main() {
  group('CalorieCalculator', () {
    test('returns 0 for zero or negative activeSeconds and volumeLoadKg', () {
      expect(
        CalorieCalculator.estimateBurned(activeSeconds: 0, volumeLoadKg: 0),
        0,
      );
      expect(
        CalorieCalculator.estimateBurned(activeSeconds: -10, volumeLoadKg: -5),
        0,
      );
    });

    test(
      'calculates correct calories for typical 45-min resistance workout',
      () {
        // 45 minutes = 2700 seconds
        // 75 kg body weight, MET 6.0: (6.0 * 3.5 * 75) / 200 = 7.875 kcal / min
        // 45 min * 7.875 = 354.375 kcal base
        // Volume 5,000 kg * 0.015 = 75.0 kcal volume
        // Total = 429.375 -> 429 kcal
        final calories = CalorieCalculator.estimateBurned(
          activeSeconds: 2700,
          volumeLoadKg: 5000,
        );
        expect(calories, 429);
      },
    );

    test('scales calories with user body weight', () {
      final calories60kg = CalorieCalculator.estimateBurned(
        activeSeconds: 1800,
        volumeLoadKg: 2000,
        userWeightKg: 60.0,
      );
      final calories90kg = CalorieCalculator.estimateBurned(
        activeSeconds: 1800,
        volumeLoadKg: 2000,
        userWeightKg: 90.0,
      );
      expect(calories90kg, greaterThan(calories60kg));
    });

    test('DailyWorkoutSummaryCalorieX aggregates list of summaries', () {
      final summaries = [
        DailyWorkoutSummary(
          id: 's1',
          date: DateTime(2026, 11),
          sessionId: 'sess-1',
          userId: 'u1',
          templateName: 'Upper Body',
          durationSeconds: 3600,
          activeSeconds: 2400,
          volumeLoadKg: 4000,
          totalCompletedSets: 12,
          totalCompletedReps: 100,
        ),
        DailyWorkoutSummary(
          id: 's2',
          date: DateTime(2026, 11, 2),
          sessionId: 'sess-2',
          userId: 'u1',
          templateName: 'Lower Body',
          durationSeconds: 3000,
          activeSeconds: 1800,
          volumeLoadKg: 6000,
          totalCompletedSets: 10,
          totalCompletedReps: 80,
        ),
      ];

      final total = summaries.calculateTotalCalories();
      final expected1 = CalorieCalculator.estimateBurned(
        activeSeconds: 2400,
        volumeLoadKg: 4000,
      );
      final expected2 = CalorieCalculator.estimateBurned(
        activeSeconds: 1800,
        volumeLoadKg: 6000,
      );

      expect(total, expected1 + expected2);
    });
  });
}
