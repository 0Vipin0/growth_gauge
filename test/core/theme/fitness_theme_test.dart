import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/core/theme/fitness_theme.dart';

void main() {
  test('high contrast light and dark schemes meet WCAG AA for text pairs', () {
    for (final theme in [
      FitnessTheme.light(contrastLevel: 1),
      FitnessTheme.dark(contrastLevel: 1),
    ]) {
      final colors = theme.colorScheme;
      expect(
        _contrast(colors.onSurface, colors.surface),
        greaterThanOrEqualTo(4.5),
      );
      expect(
        _contrast(colors.onPrimary, colors.primary),
        greaterThanOrEqualTo(4.5),
      );
    }
  });
}

double _contrast(Color foreground, Color background) {
  final first = foreground.computeLuminance();
  final second = background.computeLuminance();
  final lighter = first > second ? first : second;
  final darker = first > second ? second : first;
  return (lighter + 0.05) / (darker + 0.05);
}
