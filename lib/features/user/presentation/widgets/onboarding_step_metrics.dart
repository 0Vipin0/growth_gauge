import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/units/unit_types.dart';
import '../../application/onboarding_cubit.dart';

class const OnboardingStepMetrics({super.key}) extends StatefulWidget {
  @override
  State<OnboardingStepMetrics> createState() => _OnboardingStepMetricsState();
}

class _OnboardingStepMetricsState() extends State<OnboardingStepMetrics> {
  final TextEditingController _ageController = TextEditingController(
    text: '28',
  );
  final TextEditingController _heightController = TextEditingController(
    text: '178',
  );
  final TextEditingController _weightController = TextEditingController(
    text: '75.5',
  );

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final profile = state.profile;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Reusing ProfileScreen card/container layout style
              Card(
                elevation: 0,
                color: colorScheme.surfaceContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Core Measurements',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildMetricField(
                              context,
                              label: 'AGE',
                              controller: _ageController,
                              unit: 'yrs',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildMetricField(
                              context,
                              label: 'HEIGHT',
                              controller: _heightController,
                              unit: 'cm',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildMetricField(
                        context,
                        label: 'WEIGHT',
                        controller: _weightController,
                        unit: profile.weightUnit == WeightUnit.kilograms
                            ? 'kg'
                            : 'lb',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Reusing Unit Preferences SegmentedButtons from ProfileScreen
              Card(
                elevation: 0,
                color: colorScheme.surfaceContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Weight Unit',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SegmentedButton<WeightUnit>(
                            segments: const [
                              ButtonSegment(
                                value: WeightUnit.kilograms,
                                label: Text('KG'),
                              ),
                              ButtonSegment(
                                value: WeightUnit.pounds,
                                label: Text('LB'),
                              ),
                            ],
                            selected: {profile.weightUnit},
                            onSelectionChanged: (set) {
                              final isMetric =
                                  set.first == WeightUnit.kilograms;
                              context.read<OnboardingCubit>().updateProfile(
                                (p) => p.copyWith(
                                  weightUnit: set.first,
                                  heightUnit: isMetric
                                      ? HeightUnit.centimeters
                                      : HeightUnit.feetAndInches,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Reused directly from ProfileScreen implementation[cite: 23]
  Widget _buildMetricField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    required String unit,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            fillColor: colorScheme.surfaceContainerHighest,
            suffixText: unit,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
