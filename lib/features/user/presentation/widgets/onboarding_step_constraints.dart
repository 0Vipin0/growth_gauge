import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../catalog/domain/exercise_enums.dart';
import '../../../common/presentation/utils/responsive_form_layout.dart';
import '../../../common/presentation/widgets/widgets.dart';
import '../../application/onboarding_cubit.dart';
import '../../domain/user_enums.dart';

class const OnboardingStepConstraints({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final training = state.trainingProfile;
        final equipment = state.equipmentInventory.ownedEquipment;

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
                  'Your experience level, session duration limits, and available equipment inventory ensure that generated workout routines match your capability and setting without requiring manual adjustments.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Training Experience Level',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                AppDropdown<TrainingExperience>(
                  label: 'Experience Level',
                  value: training.trainingExperience,
                  items: TrainingExperience.values.map((exp) {
                    return AppDropdownItem(
                      value: exp,
                      label: exp.name.toUpperCase(),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      context.read<OnboardingCubit>().updateTrainingProfile(
                        (tp) => tp.copyWith(trainingExperience: val),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Preferred Session Duration',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${training.preferredSessionDurationMinutes} mins',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Slider(
                  value: training.preferredSessionDurationMinutes.toDouble(),
                  min: 20,
                  max: 120,
                  divisions: 10,
                  label: '${training.preferredSessionDurationMinutes} mins',
                  onChanged: (val) {
                    context.read<OnboardingCubit>().updateTrainingProfile(
                      (tp) => tp.copyWith(
                        preferredSessionDurationMinutes: val.toInt(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Available Equipment Inventory',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children:
                      [
                        EquipmentType.barbell,
                        EquipmentType.dumbbell,
                        EquipmentType.kettlebell,
                        EquipmentType.resistanceBand,
                        EquipmentType.pullUpBar,
                      ].map((item) {
                        final isOwned = equipment.contains(item);
                        return FilterChip(
                          label: Text(item.name.toUpperCase()),
                          selected: isOwned,
                          onSelected: (selected) {
                            final updatedList = List<EquipmentType>.from(
                              equipment,
                            );
                            if (selected) {
                              updatedList.add(item);
                            } else {
                              updatedList.remove(item);
                            }
                            context
                                .read<OnboardingCubit>()
                                .updateEquipmentInventory(
                                  (inv) => inv.copyWith(
                                    ownedEquipment: updatedList,
                                    updatedAt: DateTime.now(),
                                  ),
                                );
                          },
                        );
                      }).toList(),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    'Note: All of these training constraints and equipment details can be updated anytime later in your profile page as well.',
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
      },
    );
  }
}
