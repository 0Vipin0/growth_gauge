import 'package:flutter/material.dart';

class TimeControlWidget extends StatelessWidget {
  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  const TimeControlWidget({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              tooltip: 'Decrease',
              onPressed: () {
                onChanged(value > 0 ? value - 1 : 0);
              },
            ),
            SizedBox(
              width: 40,
              child: Center(
                child: Text(
                  '$value',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Increase',
              onPressed: () {
                onChanged(value + 1);
              },
            ),
          ],
        ),
      ],
    );
  }
}
