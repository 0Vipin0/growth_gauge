import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/core/database/app_database.dart';
import 'package:growth_gauge/features/catalog/domain/exercise_enums.dart';
import 'package:growth_gauge/features/user/application/goal_cubit.dart';
import 'package:growth_gauge/features/user/application/measurement_cubit.dart';
import 'package:growth_gauge/features/user/application/user_use_cases.dart';
import 'package:growth_gauge/features/user/domain/training_goal.dart';
import 'package:growth_gauge/features/user/domain/user_enums.dart';
import 'package:growth_gauge/features/user/infrastructure/user_repository.dart';
import 'package:growth_gauge/features/user/presentation/screens/goals_screen.dart';
import 'package:growth_gauge/features/user/presentation/screens/measurements_screen.dart';
import 'package:growth_gauge/features/user/presentation/widgets/equipment_inventory_sheet.dart';
import 'package:growth_gauge/features/user/presentation/widgets/goal_progress_card.dart';

void main() {
  group('User Widgets', () {
    testWidgets('GoalProgressCard renders progress and handles callbacks', (
      tester,
    ) async {
      bool updated = false;
      bool completed = false;

      final goal = TrainingGoal(
        id: 'g-1',
        userId: 'u-1',
        type: GoalType.strength,
        name: 'Bench Press Goal',
        startValue: 60,
        targetValue: 100,
        currentValue: 80,
        startDate: DateTime(2026),
        createdAt: DateTime(2026),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GoalProgressCard(
              goal: goal,
              onUpdateProgress: () => updated = true,
              onComplete: () => completed = true,
            ),
          ),
        ),
      );

      expect(find.text('Bench Press Goal'), findsOneWidget);
      expect(find.text('Strength'), findsOneWidget);
      expect(find.text('Current: 80.0 kg (50%)'), findsOneWidget);
      expect(find.text('Start: 60.0 kg'), findsOneWidget);
      expect(find.text('Target: 100.0 kg'), findsOneWidget);

      await tester.tap(find.text('Update'));
      await tester.pump();
      expect(updated, isTrue);

      await tester.tap(find.text('Complete'));
      await tester.pump();
      expect(completed, isTrue);
    });

    testWidgets(
      'EquipmentInventorySheet toggles equipment and triggers onSaved',
      (tester) async {
        List<EquipmentType>? saved;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EquipmentInventorySheet(
                initialSelection: const [EquipmentType.barbell],
                onSaved: (selection) => saved = selection,
              ),
            ),
          ),
        );

        expect(find.text('Available Equipment'), findsOneWidget);
        expect(find.text('Barbell & Plates'), findsOneWidget);
        expect(find.text('Dumbbells'), findsOneWidget);

        // Tap Dumbbells to select it
        await tester.tap(find.text('Dumbbells'));
        await tester.pump();

        // Tap Save
        await tester.tap(find.text('Save'));
        await tester.pump();

        expect(saved, isNotNull);
        expect(saved, contains(EquipmentType.barbell));
        expect(saved, contains(EquipmentType.dumbbell));
      },
    );

    testWidgets('GoalsScreen renders empty state when no goals', (
      tester,
    ) async {
      final db = AppDatabase.inMemory();
      final repo = UserRepository(db);
      final useCases = UserUseCases(repo);
      final cubit = GoalCubit(useCases: useCases, userId: 'empty-user');

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(value: cubit, child: const GoalsScreen()),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('No goals set yet'), findsOneWidget);
      expect(find.text('Add Goal'), findsOneWidget);

      await cubit.close();
      await db.close();
    });

    testWidgets('MeasurementsScreen renders filter chips and empty state', (
      tester,
    ) async {
      final db = AppDatabase.inMemory();
      final repo = UserRepository(db);
      final useCases = UserUseCases(repo);
      final cubit = MeasurementCubit(useCases: useCases, userId: 'empty-user');

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: cubit,
            child: const MeasurementsScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('All'), findsOneWidget);
      expect(find.text('Body Weight'), findsOneWidget);
      expect(find.text('No measurements recorded yet'), findsOneWidget);

      await cubit.close();
      await db.close();
    });
  });
}
