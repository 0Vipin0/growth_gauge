import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/goal_cubit.dart';
import '../../domain/training_goal.dart';
import '../../domain/user_enums.dart';
import '../widgets/goal_progress_card.dart';

class const GoalsScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Training Goals')),
      body: BlocConsumer<GoalCubit, GoalState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.goals.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.goals.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.flag_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No goals set yet',
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 8),
                  const Text('Tap the button below to set your first goal.'),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => _showAddGoalDialog(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Goal'),
                  ),
                ],
              ),
            );
          }

          final activeGoals = state.activeGoals;
          final achievedGoals = state.achievedGoals;
          final otherGoals = state.goals
              .where(
                (g) =>
                    g.status != GoalStatus.active &&
                    g.status != GoalStatus.achieved,
              )
              .toList();

          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              if (activeGoals.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 8,
                  ),
                  child: Text(
                    'Active Goals (${activeGoals.length})',
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                ...activeGoals.map(
                  (goal) => GoalProgressCard(
                    goal: goal,
                    onUpdateProgress: () =>
                        _showUpdateProgressDialog(context, goal),
                    onComplete: () =>
                        context.read<GoalCubit>().completeGoal(goal.id),
                    onAbandon: () =>
                        context.read<GoalCubit>().abandonGoal(goal.id),
                    onDelete: () =>
                        context.read<GoalCubit>().deleteGoal(goal.id),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              if (achievedGoals.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 8,
                  ),
                  child: Text(
                    'Achieved Goals (${achievedGoals.length})',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                ),
                ...achievedGoals.map(
                  (goal) => GoalProgressCard(
                    goal: goal,
                    onDelete: () =>
                        context.read<GoalCubit>().deleteGoal(goal.id),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              if (otherGoals.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 8,
                  ),
                  child: Text(
                    'Archived / Abandoned (${otherGoals.length})',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                ...otherGoals.map(
                  (goal) => GoalProgressCard(
                    goal: goal,
                    onDelete: () =>
                        context.read<GoalCubit>().deleteGoal(goal.id),
                  ),
                ),
              ],
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddGoalDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddGoalDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final startValueController = TextEditingController(text: '0.0');
    final targetValueController = TextEditingController();
    final unitController = TextEditingController(text: 'kg');
    GoalType selectedType = GoalType.strength;
    DateTime? selectedTargetDate;

    showDialog<void>(
      context: context,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (dialogCtx, setState) {
            return AlertDialog(
              title: const Text('Add Training Goal'),
              content: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Goal Name *',
                          hintText: 'e.g., Bench Press 100kg',
                        ),
                        validator: (value) =>
                            (value == null || value.trim().isEmpty)
                            ? 'Please enter a goal name'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<GoalType>(
                        initialValue: selectedType,
                        decoration: const InputDecoration(labelText: 'Type'),
                        items: GoalType.values.map((t) {
                          return DropdownMenuItem(
                            value: t,
                            child: Text(t.name.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              selectedType = val;
                              if (val == GoalType.repetition) {
                                unitController.text = 'reps';
                              } else if (val == GoalType.distance) {
                                unitController.text = 'km';
                              } else if (val == GoalType.duration) {
                                unitController.text = 'min';
                              } else if (val == GoalType.strength ||
                                  val == GoalType.volume ||
                                  val == GoalType.bodyWeight) {
                                unitController.text = 'kg';
                              }
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: startValueController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              decoration: const InputDecoration(
                                labelText: 'Start Value',
                              ),
                              validator: (v) => double.tryParse(v ?? '') == null
                                  ? 'Invalid number'
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: targetValueController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              decoration: const InputDecoration(
                                labelText: 'Target Value *',
                              ),
                              validator: (v) => double.tryParse(v ?? '') == null
                                  ? 'Invalid number'
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: unitController,
                        decoration: const InputDecoration(
                          labelText: 'Unit',
                          hintText: 'kg, reps, km, etc.',
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description (optional)',
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 12),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          selectedTargetDate == null
                              ? 'Target Date: Not set'
                              : 'Target: ${selectedTargetDate!.toLocal().toString().split(' ')[0]}',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            final now = DateTime.now();
                            final picked = await showDatePicker(
                              context: dialogCtx,
                              initialDate: now.add(const Duration(days: 30)),
                              firstDate: now,
                              lastDate: now.add(const Duration(days: 365 * 5)),
                            );
                            if (picked != null) {
                              setState(() => selectedTargetDate = picked);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogCtx).pop(),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      final startVal =
                          double.tryParse(startValueController.text) ?? 0.0;
                      final targetVal =
                          double.tryParse(targetValueController.text) ?? 0.0;
                      context.read<GoalCubit>().createGoal(
                        type: selectedType,
                        name: nameController.text.trim(),
                        description: descriptionController.text.trim(),
                        startValue: startVal,
                        targetValue: targetVal,
                        unit: unitController.text.trim().isEmpty
                            ? 'kg'
                            : unitController.text.trim(),
                        targetDate: selectedTargetDate,
                      );
                      Navigator.of(dialogCtx).pop();
                    }
                  },
                  child: const Text('Create'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showUpdateProgressDialog(BuildContext context, TrainingGoal goal) {
    final controller = TextEditingController(
      text: goal.currentValue.toStringAsFixed(1),
    );
    showDialog<void>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text('Update ${goal.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Target: ${goal.targetValue} ${goal.unit}'),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'New Current Value (${goal.unit})',
              ),
              autofocus: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final val = double.tryParse(controller.text);
              if (val != null) {
                context.read<GoalCubit>().updateProgress(goal.id, val);
                Navigator.of(dialogCtx).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
