import 'package:flutter/material.dart';

enum AppCardVariant() {
  standard,
  selected,
  dashed,
}

class AppCard extends StatelessWidget {
  final Widget child;
  final AppCardVariant variant;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  const new({
    super.key,
    required this.child,
    this.variant = AppCardVariant.standard,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
  });

  const new selected({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
  }) : variant = AppCardVariant.selected;

  const new dashed({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
  }) : variant = AppCardVariant.dashed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    BoxDecoration decoration;
    if (variant == AppCardVariant.dashed) {
      decoration = BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline, width: 1.5),
      );
    } else if (variant == AppCardVariant.selected) {
      decoration = BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.primary, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.15),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      );
    } else {
      decoration = BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(decoration: decoration, padding: padding, child: child),
      ),
    );
  }
}
