import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/presentation/utils/responsive_form_layout.dart';
import '../../../common/presentation/widgets/widgets.dart';
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
  final TextEditingController _descriptionController = TextEditingController(
    text: 'Build upper body pushing strength and chest mass.',
  );
  final TextEditingController _targetController = TextEditingController(
    text: '100',
  );

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
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
      description: _descriptionController.text.trim(),
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
    final colorScheme = theme.colorScheme;

    return ResponsiveFormLayout(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Why we need this:',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Setting a clear training goal gives your workout routine purposeful direction, enabling to track progress milestones and celebrate your personal fitness achievements.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Set Your Initial Goal',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Goal Name',
              controller: _nameController,
              onChanged: (_) => _syncGoal(context),
            ),
            const SizedBox(height: 16),
            AppDropdown<GoalType>(
              label: 'Goal Type',
              value: _selectedType,
              items: GoalType.values.map((t) {
                return AppDropdownItem(value: t, label: t.name.toUpperCase());
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() => _selectedType = val);
                  _syncGoal(context);
                }
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Goal Description (optional)',
              controller: _descriptionController,
              maxLines: 2,
              onChanged: (_) => _syncGoal(context),
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Target Value',
              controller: _targetController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (_) => _syncGoal(context),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                'Note: This goal and description can be updated, completed, or managed anytime later from your goals and profile sections.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
