import 'package:flutter/material.dart';

import '../../../catalog/domain/exercise_enums.dart';

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
    return Container(
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
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  widget.onSaved(_selected.toList());
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Select the equipment you have access to. Exercises requiring unselected equipment will be flagged.',
            style: TextStyle(color: Colors.grey),
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
                      ? null // Bodyweight is always available
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
    );
  }
}
