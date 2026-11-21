import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/units/unit_converter.dart';
import '../../../../core/units/unit_types.dart';
import '../../../common/presentation/utils/responsive_form_layout.dart';
import '../../../common/presentation/widgets/widgets.dart';
import '../../application/onboarding_cubit.dart';
import '../../domain/user_enums.dart';

class const OnboardingStepMetrics({super.key}) extends StatefulWidget {
  @override
  State<OnboardingStepMetrics> createState() => _OnboardingStepMetricsState();
}

class _OnboardingStepMetricsState() extends State<OnboardingStepMetrics> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _neckController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _hipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<OnboardingCubit>().state;
    _nameController.text = state.profile.displayName;
    _ageController.text = state.profile.ageYears?.toString() ?? '';
    _heightController.text = state.trainingProfile.baselineHeightCm == null
        ? ''
        : _heightForUnit(
            state.trainingProfile.baselineHeightCm!,
            state.profile.heightUnit,
          ).toStringAsFixed(1);
    _weightController.text = state.trainingProfile.baselineWeightKg == null
        ? ''
        : UnitConverter.weightFromCanonical(
            state.trainingProfile.baselineWeightKg!,
            state.profile.weightUnit,
          ).toStringAsFixed(1);
    _heartRateController.text =
        state.trainingProfile.restingHeartRateBpm?.toString() ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _heartRateController.dispose();
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

  double _heightForUnit(double heightCm, HeightUnit unit) =>
      unit == HeightUnit.centimeters
      ? heightCm
      : UnitConverter.cmToInches(heightCm);

  void _syncHeight(BuildContext context, String value, HeightUnit unit) {
    final parsed = double.tryParse(value);
    final heightCm = parsed == null
        ? null
        : unit == HeightUnit.centimeters
        ? parsed
        : UnitConverter.inchesToCm(parsed);
    context.read<OnboardingCubit>().updateTrainingProfile(
      (profile) => profile.copyWith(baselineHeightCm: heightCm),
    );
  }

  void _syncOptionalMeasurement(
    BuildContext context,
    MeasurementType type,
    String value,
  ) {
    context.read<OnboardingCubit>().updateOptionalMeasurement(
      type,
      double.tryParse(value),
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
                              onChanged: (value) =>
                                  context.read<OnboardingCubit>().updateProfile(
                                    (p) => p.copyWith(
                                      ageYears: int.tryParse(value),
                                    ),
                                  ),
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
                              onChanged: (value) => _syncHeight(
                                context,
                                value,
                                profile.heightUnit,
                              ),
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
                        onChanged: (value) {
                          final parsed = double.tryParse(value);
                          context.read<OnboardingCubit>().updateTrainingProfile(
                            (training) => training.copyWith(
                              baselineWeightKg: parsed == null
                                  ? null
                                  : UnitConverter.weightToCanonical(
                                      parsed,
                                      profile.weightUnit,
                                    ),
                            ),
                          );
                        },
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
                        'Optional Health Context',
                        style: theme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 12),
                      AppDropdown<BiologicalSex?>(
                        label: 'Biological Sex (optional)',
                        value: profile.biologicalSex,
                        items: [
                          const AppDropdownItem(
                            value: null,
                            label: 'Prefer not to select',
                          ),
                          ...BiologicalSex.values.map(
                            (sex) => AppDropdownItem(
                              value: sex,
                              label: switch (sex) {
                                BiologicalSex.female => 'Female',
                                BiologicalSex.male => 'Male',
                                BiologicalSex.intersex => 'Intersex',
                                BiologicalSex.preferNotToSay =>
                                  'Prefer not to say',
                              },
                            ),
                          ),
                        ],
                        onChanged: (value) =>
                            context.read<OnboardingCubit>().updateProfile(
                              (p) => p.copyWith(biologicalSex: value),
                            ),
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        label: 'RESTING HEART RATE (OPTIONAL)',
                        controller: _heartRateController,
                        keyboardType: TextInputType.number,
                        suffixUnit: 'bpm',
                        onChanged: (value) => context
                            .read<OnboardingCubit>()
                            .updateTrainingProfile(
                              (training) => training.copyWith(
                                restingHeartRateBpm: int.tryParse(value),
                              ),
                            ),
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
                              onChanged: (value) => _syncOptionalMeasurement(
                                context,
                                MeasurementType.neck,
                                value,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AppTextField(
                              label: 'WAIST',
                              controller: _waistController,
                              keyboardType: TextInputType.number,
                              suffixUnit: 'cm',
                              onChanged: (value) => _syncOptionalMeasurement(
                                context,
                                MeasurementType.waist,
                                value,
                              ),
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
                        onChanged: (value) => _syncOptionalMeasurement(
                          context,
                          MeasurementType.hip,
                          value,
                        ),
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
                                final weightKg = context
                                    .read<OnboardingCubit>()
                                    .state
                                    .trainingProfile
                                    .baselineWeightKg;
                                if (weightKg != null) {
                                  _weightController.text =
                                      UnitConverter.weightFromCanonical(
                                        weightKg,
                                        val,
                                      ).toStringAsFixed(1);
                                }
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
                                  label: 'IN',
                                ),
                              ],
                              onValueChanged: (val) {
                                final heightCm = context
                                    .read<OnboardingCubit>()
                                    .state
                                    .trainingProfile
                                    .baselineHeightCm;
                                if (heightCm != null) {
                                  _heightController.text = _heightForUnit(
                                    heightCm,
                                    val,
                                  ).toStringAsFixed(1);
                                }
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
