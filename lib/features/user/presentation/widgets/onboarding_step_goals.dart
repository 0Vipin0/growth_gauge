import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/onboarding_cubit.dart';
import '../../domain/training_goal.dart';
import '../../domain/user_enums.dart';

class const OnboardingStepGoals({super.key}) extends StatefulWidget {
  @override
  State<OnboardingStepGoals> createState() => _OnboardingStepGoalsState();
}

class _OnboardingStepGoalsState() extends State<OnboardingStepGoals> {
  GoalType _selectedType = GoalType.strength;
  final TextEditingController _nameController = TextEditingController(
    text: 'Bench Press 100kg',
  );
  final TextEditingController _targetController = TextEditingController(
    text: '100',
  );

  @override
  void dispose() {
    _nameController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  void _syncGoal(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    final targetVal = double.tryParse(_targetController.text) ?? 100.0;

    final goal = TrainingGoal(
      id: 'onboarding-goal-${DateTime.now().millisecondsSinceEpoch}',
      userId: cubit.userId,
      type: _selectedType,
      name: _nameController.text.trim(),
      startValue: 0.0,
      targetValue: targetVal,
      currentValue: 0.0,
      unit: _selectedType == GoalType.repetition ? 'reps' : 'kg',
      startDate: DateTime.now(),
      createdAt: DateTime.now(),
    );

    cubit.updateGoal(goal);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Set Your Initial Goal',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Goal Name',
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => _syncGoal(context),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<GoalType>(
            initialValue: _selectedType,
            decoration: const InputDecoration(
              labelText: 'Goal Type',
              border: OutlineInputBorder(),
            ),
            items: GoalType.values.map((t) {
              return DropdownMenuItem(
                value: t,
                child: Text(t.name.toUpperCase()),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() => _selectedType = val);
                _syncGoal(context);
              }
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _targetController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Target Value',
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => _syncGoal(context),
          ),
        ],
      ),
    );
  }
}
