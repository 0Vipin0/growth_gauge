import 'package:flutter/material.dart';

class const AppSegmentedControlItem<T>({
  required final T value,
  required final String label,
  final IconData? icon,
});

class const AppSegmentedControl<T>({
  super.key,
  required final List<AppSegmentedControlItem<T>> items,
  required final T selectedValue,
  required final ValueChanged<T> onValueChanged,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: items.map((item) {
          final isSelected = item.value == selectedValue;
          return Expanded(
            child: GestureDetector(
              onTap: () => onValueChanged(item.value),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? colorScheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (item.icon != null) ...[
                      Icon(
                        item.icon,
                        size: 16,
                        color: isSelected
                            ? const Color(0xFF003913)
                            : colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 6),
                    ],
                    Text(
                      item.label,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: isSelected
                            ? const Color(0xFF003913)
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
