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
  final TextEditingController _nameController = TextEditingController(
    text: 'Athlete',
  );
  final TextEditingController _ageController = TextEditingController(
    text: '28',
  );
  final TextEditingController _heightController = TextEditingController(
    text: '178',
  );
  final TextEditingController _weightController = TextEditingController(
    text: '75.5',
  );
  final TextEditingController _neckController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _hipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncProfile(context);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _neckController.dispose();
    _waistController.dispose();
    _hipController.dispose();
    super.dispose();
  }

  void _syncProfile(BuildContext context) {
    context.read<OnboardingCubit>().updateProfile(
      (p) => p.copyWith(displayName: _nameController.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final profile = state.profile;

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
                  'Your core biometrics and unit preferences allows to accurately calculate calorie burn, training volume metrics, body composition progress, and customize your overall fitness experience.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 20),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profile Information *',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: 'DISPLAY NAME *',
                        controller: _nameController,
                        onChanged: (_) => _syncProfile(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Core Measurements *',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              label: 'AGE *',
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
                              suffixUnit:
                                  profile.heightUnit == HeightUnit.centimeters
                                  ? 'cm'
                                  : 'in',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: 'WEIGHT *',
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Optional Body Metrics',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Used for estimating body fat percentage and composition trends.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              label: 'NECK',
                              controller: _neckController,
                              keyboardType: TextInputType.number,
                              suffixUnit: 'cm',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AppTextField(
                              label: 'WAIST',
                              controller: _waistController,
                              keyboardType: TextInputType.number,
                              suffixUnit: 'cm',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: 'HIP',
                        controller: _hipController,
                        keyboardType: TextInputType.number,
                        suffixUnit: 'cm',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                AppCard(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Weight Unit',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 150,
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
                                context.read<OnboardingCubit>().updateProfile(
                                  (p) => p.copyWith(weightUnit: val),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Distance Unit',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 150,
                            child: AppSegmentedControl<DistanceUnit>(
                              selectedValue: profile.distanceUnit,
                              items: const [
                                AppSegmentedControlItem(
                                  value: DistanceUnit.kilometers,
                                  label: 'KM',
                                ),
                                AppSegmentedControlItem(
                                  value: DistanceUnit.miles,
                                  label: 'MI',
                                ),
                              ],
                              onValueChanged: (val) {
                                context.read<OnboardingCubit>().updateProfile(
                                  (p) => p.copyWith(distanceUnit: val),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Height Unit',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 160,
                            child: AppSegmentedControl<HeightUnit>(
                              selectedValue: profile.heightUnit,
                              items: const [
                                AppSegmentedControlItem(
                                  value: HeightUnit.centimeters,
                                  label: 'CM',
                                ),
                                AppSegmentedControlItem(
                                  value: HeightUnit.feetAndInches,
                                  label: 'FT/IN',
                                ),
                              ],
                              onValueChanged: (val) {
                                context.read<OnboardingCubit>().updateProfile(
                                  (p) => p.copyWith(heightUnit: val),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    'Note: All of these values can be updated anytime later in your profile screen.',
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
