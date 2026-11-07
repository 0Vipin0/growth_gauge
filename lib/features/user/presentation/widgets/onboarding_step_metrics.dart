import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/units/unit_types.dart';
import '../../../common/presentation/utils/responsive_form_layout.dart';
import '../../../common/presentation/widgets/widgets.dart';
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

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final profile = state.profile;

        return ResponsiveFormLayout(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Core Measurements',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              label: 'AGE',
                              controller: _ageController,
                              keyboardType: TextInputType.number,
                              suffixUnit: 'yrs',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AppTextField(
                              label: 'HEIGHT',
                              controller: _heightController,
                              keyboardType: TextInputType.number,
                              suffixUnit: 'cm',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: 'WEIGHT',
                        controller: _weightController,
                        keyboardType: TextInputType.number,
                        suffixUnit: profile.weightUnit == WeightUnit.kilograms
                            ? 'kg'
                            : 'lb',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                AppCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Weight Unit',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: AppSegmentedControl<WeightUnit>(
                          selectedValue: profile.weightUnit,
                          items: const [
                            AppSegmentedControlItem(
                              value: WeightUnit.kilograms,
                              label: 'KG',
                            ),
                            AppSegmentedControlItem(
                              value: WeightUnit.pounds,
                              label: 'LB',
                            ),
                          ],
                          onValueChanged: (val) {
                            final isMetric = val == WeightUnit.kilograms;
                            context.read<OnboardingCubit>().updateProfile(
                              (p) => p.copyWith(
                                weightUnit: val,
                                heightUnit: isMetric
                                    ? HeightUnit.centimeters
                                    : HeightUnit.feetAndInches,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
