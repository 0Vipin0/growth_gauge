import 'package:flutter/material.dart';

import '../../../../core/units/unit_types.dart';
import '../../../common/presentation/widgets/responsive_layout.dart';
import '../../application/user_use_cases.dart';
import '../../domain/equipment_inventory.dart';
import '../../domain/training_profile.dart';
import '../../domain/user_enums.dart';
import '../../domain/user_profile.dart';
import '../../domain/workout_preferences.dart';
import '../widgets/equipment_inventory_sheet.dart';

class const ProfileScreen({
  super.key,
  required final UserUseCases useCases,
  final String userId = 'local-user',
}) extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState() extends State<ProfileScreen> {
  bool _isLoading = true;
  UserProfile? _profile;
  TrainingProfile? _trainingProfile;
  WorkoutPreferences? _preferences;
  EquipmentInventory? _equipment;

  // Controllers for Core & Detailed Body Metrics
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _neckController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _hipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _neckController.dispose();
    _waistController.dispose();
    _hipController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final pRes = await widget.useCases.getOrCreateProfile(widget.userId);
    final tRes = await widget.useCases.getOrCreateTrainingProfile(
      widget.userId,
    );
    final wRes = await widget.useCases.getOrCreatePreferences(widget.userId);
    final eRes = await widget.useCases.getOrCreateEquipmentInventory(
      widget.userId,
    );

    if (mounted) {
      setState(() {
        _profile = pRes.dataOrNull;
        _trainingProfile = tRes.dataOrNull;
        _preferences = wRes.dataOrNull;
        _equipment = eRes.dataOrNull;

        // Populate metrics if available
        if (_profile != null) {
          // Initialize sample defaults if empty
          _ageController.text = '28';
          _heightController.text = '178';
          _weightController.text = '75.5';
          _neckController.text = '38';
          _waistController.text = '82';
          _hipController.text = '96';
        }
        _isLoading = false;
      });
    }
  }

  Future<void> _saveProfile(UserProfile updated) async {
    setState(() => _profile = updated);
    await widget.useCases.updateProfile(updated);
  }

  Future<void> _saveTrainingProfile(TrainingProfile updated) async {
    setState(() => _trainingProfile = updated);
    await widget.useCases.updateTrainingProfile(updated);
  }

  Future<void> _savePreferences(WorkoutPreferences updated) async {
    setState(() => _preferences = updated);
    await widget.useCases.updatePreferences(updated);
  }

  Future<void> _openEquipmentSheet() async {
    if (_equipment == null) return;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        final media = MediaQuery.of(ctx);
        final availableHeight = media.size.height - media.viewInsets.bottom;
        return SafeArea(
          child: SizedBox(
            height: availableHeight.clamp(280, 680),
            child: ResponsiveContent(
              maxWidth: 720,
              child: EquipmentInventorySheet(
                initialSelection: _equipment!.ownedEquipment,
                onSaved: (selected) async {
                  await widget.useCases.updateEquipmentInventory(
                    widget.userId,
                    selected,
                  );
                  final updated = await widget.useCases
                      .getOrCreateEquipmentInventory(widget.userId);
                  if (mounted) setState(() => _equipment = updated.dataOrNull);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final profile = _profile!;
    final training = _trainingProfile!;
    final prefs = _preferences!;

    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 900;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & Preferences'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 32.0 : 20.0,
                vertical: 24.0,
              ),
              children: [
                // ── Header User Card ──────────────────────────────────────────
                Card(
                  elevation: 0,
                  color: colorScheme.surfaceContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: colorScheme.primaryContainer,
                          child: Icon(
                            Icons.person,
                            size: 38,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profile.displayName,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${training.trainingExperience.name.toUpperCase()} • ${training.primaryTrainingStyle}',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Responsive Layout Grid for Large vs Mobile screens
                if (isDesktop)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column: Body Metrics Inputs
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [_buildBodyMetricsSection(context)],
                        ),
                      ),
                      const SizedBox(width: 24),
                      // Right Column: Preferences & Training
                      Expanded(
                        flex: 6,
                        child: Column(
                          children: [
                            _buildUnitPreferencesSection(context, profile),
                            const SizedBox(height: 24),
                            _buildTrainingProfileSection(context, training),
                            const SizedBox(height: 24),
                            _buildPreferencesSection(context, prefs),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      _buildBodyMetricsSection(context),
                      const SizedBox(height: 24),
                      _buildUnitPreferencesSection(context, profile),
                      const SizedBox(height: 24),
                      _buildTrainingProfileSection(context, training),
                      const SizedBox(height: 24),
                      _buildPreferencesSection(context, prefs),
                    ],
                  ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── 1. Body Metrics Section ────────────────────────────────────────────────
  Widget _buildBodyMetricsSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Core & Body Measurements'),
        const SizedBox(height: 8),
        Card(
          elevation: 0,
          color: colorScheme.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Core Measurements',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
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
                  unit: 'kg',
                ),
                const Divider(height: 32),
                Text(
                  'Detailed Body Metrics',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Optional measurements for higher accuracy',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricField(
                        context,
                        label: 'NECK',
                        controller: _neckController,
                        unit: 'cm',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildMetricField(
                        context,
                        label: 'WAIST',
                        controller: _waistController,
                        unit: 'cm',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildMetricField(
                  context,
                  label: 'HIP',
                  controller: _hipController,
                  unit: 'cm',
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Body metrics updated successfully.'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.check_circle_outline, size: 18),
                    label: const Text('Save Body Metrics'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Helper Widget for Numeric Input Fields
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
            suffixStyle: TextStyle(color: colorScheme.onSurfaceVariant),
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

  // ── 2. Unit Preferences Section ───────────────────────────────────────────
  Widget _buildUnitPreferencesSection(
    BuildContext context,
    UserProfile profile,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Unit Preferences'),
        const SizedBox(height: 8),
        Card(
          elevation: 0,
          color: colorScheme.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              _buildUnitRow(
                context,
                title: 'Weight Unit',
                control: SegmentedButton<WeightUnit>(
                  segments: const [
                    ButtonSegment(
                      value: WeightUnit.kilograms,
                      label: Text('KG'),
                    ),
                    ButtonSegment(value: WeightUnit.pounds, label: Text('LB')),
                  ],
                  selected: {profile.weightUnit},
                  onSelectionChanged: (set) =>
                      _saveProfile(profile.copyWith(weightUnit: set.first)),
                ),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              _buildUnitRow(
                context,
                title: 'Distance Unit',
                control: SegmentedButton<DistanceUnit>(
                  segments: const [
                    ButtonSegment(
                      value: DistanceUnit.kilometers,
                      label: Text('KM'),
                    ),
                    ButtonSegment(value: DistanceUnit.miles, label: Text('MI')),
                  ],
                  selected: {profile.distanceUnit},
                  onSelectionChanged: (set) =>
                      _saveProfile(profile.copyWith(distanceUnit: set.first)),
                ),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              _buildUnitRow(
                context,
                title: 'Height Unit',
                control: SegmentedButton<HeightUnit>(
                  segments: const [
                    ButtonSegment(
                      value: HeightUnit.centimeters,
                      label: Text('CM'),
                    ),
                    ButtonSegment(
                      value: HeightUnit.feetAndInches,
                      label: Text('FT/IN'),
                    ),
                  ],
                  selected: {profile.heightUnit},
                  onSelectionChanged: (set) =>
                      _saveProfile(profile.copyWith(heightUnit: set.first)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUnitRow(
    BuildContext context, {
    required String title,
    required Widget control,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          control,
        ],
      ),
    );
  }

  // ── 3. Training Profile Section ───────────────────────────────────────────
  Widget _buildTrainingProfileSection(
    BuildContext context,
    TrainingProfile training,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Training Profile'),
        const SizedBox(height: 8),
        Card(
          elevation: 0,
          color: colorScheme.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              ListTile(
                title: const Text('Experience Level'),
                trailing: DropdownButton<TrainingExperience>(
                  value: training.trainingExperience,
                  underline: const SizedBox.shrink(),
                  items: TrainingExperience.values.map((exp) {
                    return DropdownMenuItem(
                      value: exp,
                      child: Text(exp.name.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      _saveTrainingProfile(
                        training.copyWith(trainingExperience: val),
                      );
                    }
                  },
                ),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              ListTile(
                title: const Text('Equipment Inventory'),
                subtitle: Text(
                  '${_equipment?.ownedEquipment.length ?? 0} equipment items available',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: _openEquipmentSheet,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── 4. Workout Preferences Section ────────────────────────────────────────
  Widget _buildPreferencesSection(
    BuildContext context,
    WorkoutPreferences prefs,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Workout Execution Preferences'),
        const SizedBox(height: 8),
        Card(
          elevation: 0,
          color: colorScheme.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Auto-start Rest Timer'),
                subtitle: const Text(
                  'Starts rest timer immediately on set log',
                ),
                value: prefs.autoStartRestTimer,
                onChanged: (val) =>
                    _savePreferences(prefs.copyWith(autoStartRestTimer: val)),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              ListTile(
                title: const Text('Default Rest Duration'),
                trailing: Text(
                  '${prefs.defaultRestSeconds}s',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                onTap: () async {
                  int seconds = prefs.defaultRestSeconds;
                  final res = await showDialog<int>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Default Rest (Seconds)'),
                      content: TextFormField(
                        initialValue: seconds.toString(),
                        keyboardType: TextInputType.number,
                        onChanged: (v) => seconds = int.tryParse(v) ?? seconds,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(seconds),
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  );
                  if (res != null) {
                    _savePreferences(prefs.copyWith(defaultRestSeconds: res));
                  }
                },
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              SwitchListTile(
                title: const Text('Sound Feedback'),
                value: prefs.soundEnabled,
                onChanged: (val) =>
                    _savePreferences(prefs.copyWith(soundEnabled: val)),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              SwitchListTile(
                title: const Text('Vibration Feedback'),
                value: prefs.vibrationEnabled,
                onChanged: (val) =>
                    _savePreferences(prefs.copyWith(vibrationEnabled: val)),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              SwitchListTile(
                title: const Text('Show RPE (Rate of Perceived Exertion)'),
                value: prefs.showRpe,
                onChanged: (val) =>
                    _savePreferences(prefs.copyWith(showRpe: val)),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              SwitchListTile(
                title: const Text('Show RIR (Reps in Reserve)'),
                value: prefs.showRir,
                onChanged: (val) =>
                    _savePreferences(prefs.copyWith(showRir: val)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
