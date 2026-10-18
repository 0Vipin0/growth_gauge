import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/features/common/presentation/widgets/responsive_layout.dart';

void main() {
  test('classifies compact, medium, and expanded available widths', () {
    expect(AppWindowSizeClass.fromWidth(390), AppWindowSizeClass.compact);
    expect(AppWindowSizeClass.fromWidth(600), AppWindowSizeClass.compact);
    expect(AppWindowSizeClass.fromWidth(800), AppWindowSizeClass.medium);
    expect(AppWindowSizeClass.fromWidth(1024), AppWindowSizeClass.medium);
    expect(AppWindowSizeClass.fromWidth(1440), AppWindowSizeClass.expanded);
  });

  testWidgets('constrains expanded content and preserves narrow layouts', (
    tester,
  ) async {
    addTearDown(() => tester.binding.setSurfaceSize(null));
    double contentWidth = 0;

    for (final width in [390.0, 800.0, 1440.0]) {
      await tester.binding.setSurfaceSize(Size(width, 700));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ResponsiveContent(
              maxWidth: 720,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  contentWidth = constraints.maxWidth;
                  return const SingleChildScrollView(
                    child: Text('Responsive content'),
                  );
                },
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(contentWidth, closeTo(width < 720 ? width : 720, 1));
      expect(find.text('Responsive content'), findsOneWidget);
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('scaled content remains scrollable and controls work from keys', (
    tester,
  ) async {
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.binding.setSurfaceSize(const Size(360, 320));
    var activated = false;
    final semantics = tester.ensureSemantics();

    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(2)),
          child: Scaffold(
            body: ResponsiveContent(
              child: ListView(
                children: [
                  const Text('Large text stays available'),
                  FilledButton(
                    onPressed: () => activated = true,
                    child: const Text('Continue'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.bySemanticsLabel('Continue'), findsOneWidget);
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pump();

    expect(activated, isTrue);
    expect(tester.takeException(), isNull);
    semantics.dispose();
  });
}
