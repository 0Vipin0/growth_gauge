# Responsive and Accessibility Manual Checks

Use these checks on Windows desktop and at least one supported mobile device.
They complement the automated viewport and semantics tests; they have not been
run automatically by `scripts/check.ps1`.

## Viewport checks

- Compact portrait: 390 × 844 logical pixels.
- Compact landscape: 844 × 390 logical pixels.
- Medium tablet/window: 800 × 900 logical pixels.
- Expanded desktop: 1440 × 1000 logical pixels.
- Resize a desktop window across 600 and 1024 logical pixels and confirm Home
  changes from a bottom bar to a collapsed rail, then an extended rail.
- Open the exercise catalog, template list/editor, analytics, profile,
  measurements, backup/restore, and an active workout at each width. Check that
  content remains readable, scrolls when needed, and has no clipped controls or
  horizontal overflow.
- Open dialogs and the equipment sheet in landscape with the software keyboard
  visible. Confirm actions remain reachable and the sheet does not cover them.

## Accessibility checks

- Set system text scaling to 200% and verify the home, profile unit selectors,
  measurement summary/list, session timer/actions, and forms remain usable.
- Use Tab/Shift+Tab and Enter/Space through Home destinations, search/filter
  controls, form inputs, and primary actions. Confirm focus remains visible and
  follows the visual order.
- With a screen reader, inspect Home destinations, session pause/resume and
  completion actions, workout timers, chart summaries, and daily workout
  frequency cells. Confirm labels describe purpose and current values.
- Verify both high-contrast themes and check reduced-motion behavior when the
  operating system requests reduced animation.
- Confirm touch targets remain reachable without relying on hover or drag.
