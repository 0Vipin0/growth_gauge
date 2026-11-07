import 'package:flutter/material.dart';

import '../utils/responsive_layout.dart';

class const AppDropdownItem<T>({required final T value, required final String label, final IconData? icon});

class const AppDropdown<T>({
    super.key,
    required final String label,
    required final T? value,
    required final List<AppDropdownItem<T>> items,
    required final ValueChanged<T?> onChanged,
    final String? hintText,
    final IconData? prefixIcon,
  }) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final selectedItem = items.cast<AppDropdownItem<T>?>().firstWhere(
      (item) => item?.value == value,
      orElse: () => null,
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: InkWell(
        onTap: () => _showResponsiveDropdown(context),
        borderRadius: BorderRadius.circular(12),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: colorScheme.surfaceContainerLow,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20) : null,
            suffixIcon: const Icon(Icons.arrow_drop_down, size: 24),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: colorScheme.outlineVariant,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          child: Text(
            selectedItem?.label ?? hintText ?? 'Select...',
            style: textTheme.bodyLarge?.copyWith(
              color: selectedItem != null
                  ? colorScheme.onSurface
                  : colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }

  void _showResponsiveDropdown(BuildContext context) {
    final sizeClass = AppWindowSizeClass.of(context);

    if (sizeClass == AppWindowSizeClass.compact) {
      // Compact (<600dp): Modal bottom sheet for mobile touch targets
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => _DropdownSheetContent(
          label: label,
          items: items,
          selectedValue: value,
          onSelected: (val) {
            onChanged(val);
            Navigator.pop(context);
          },
        ),
      );
    } else {
      // Medium / Expanded (>=600dp): Desktop/Tablet dialog popover
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(label),
          content: SizedBox(
            width: 400,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: item.icon != null ? Icon(item.icon) : null,
                  title: Text(item.label),
                  selected: item.value == value,
                  onTap: () {
                    onChanged(item.value);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ),
      );
    }
  }
}

class const _DropdownSheetContent<T>({
    required final String label,
    required final List<AppDropdownItem<T>> items,
    required final T? selectedValue,
    required final ValueChanged<T> onSelected,
  }) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.6,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final isSelected = item.value == selectedValue;
                  return ListTile(
                    leading: item.icon != null ? Icon(item.icon) : null,
                    title: Text(item.label),
                    trailing: isSelected
                        ? Icon(Icons.check, color: theme.colorScheme.primary)
                        : null,
                    onTap: () => onSelected(item.value),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
