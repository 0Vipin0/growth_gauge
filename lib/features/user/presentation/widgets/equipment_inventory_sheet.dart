import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../catalog/domain/exercise_enums.dart';
import '../../../common/presentation/utils/responsive_layout.dart';
import '../../../common/presentation/widgets/widgets.dart';

/// Modal bottom sheet allowing users to toggle owned/accessible equipment.
class const EquipmentInventorySheet({
  super.key,
  required final List<EquipmentType> initialSelection,
  required final ValueChanged<List<EquipmentType>> onSaved,
}) extends StatefulWidget {
  @override
  State<EquipmentInventorySheet> createState() =>
      _EquipmentInventorySheetState();
}

class _EquipmentInventorySheetState() extends State<EquipmentInventorySheet> {
  late Set<EquipmentType> _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialSelection.toSet();
  }

  String _formatName(EquipmentType type) {
    switch (type) {
      case EquipmentType.barbell:
        return 'Barbell & Plates';
      case EquipmentType.dumbbell:
        return 'Dumbbells';
      case EquipmentType.kettlebell:
        return 'Kettlebell';
      case EquipmentType.cable:
        return 'Cable Machine';
      case EquipmentType.machine:
        return 'Weight Machines';
      case EquipmentType.bodyweight:
        return 'Bodyweight (Always Available)';
      case EquipmentType.smithMachine:
        return 'Smith Machine';
      case EquipmentType.resistanceBand:
        return 'Resistance Bands';
      case EquipmentType.pullUpBar:
        return 'Pull-Up Bar';
      case EquipmentType.bench:
        return 'Adjustable / Flat Bench';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ResponsiveContent(
      maxWidth: 600,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Available Equipment',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppButton.primary(
                  label: 'Save',
                  onPressed: () {
                    widget.onSaved(_selected.toList());
                    context.pop();
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Select the equipment you have access to. Exercises requiring unselected equipment will be flagged.',
              style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: EquipmentType.values.map((type) {
                  final isBodyweight = type == EquipmentType.bodyweight;
                  final isChecked = isBodyweight || _selected.contains(type);

                  return CheckboxListTile(
                    title: Text(_formatName(type)),
                    value: isChecked,
                    onChanged: isBodyweight
                        ? null
                        : (val) {
                            setState(() {
                              if (val == true) {
                                _selected.add(type);
                              } else {
                                _selected.remove(type);
                              }
                            });
                          },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
